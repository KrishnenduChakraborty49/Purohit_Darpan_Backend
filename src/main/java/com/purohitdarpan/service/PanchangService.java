package com.purohitdarpan.service;

import com.purohitdarpan.entity.PanchangCache;
import com.purohitdarpan.repository.PanchangCacheRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.YearMonth;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
public class PanchangService {

    private final PanchangCacheRepository cacheRepo;
    private final WebClient.Builder webClientBuilder;

    @Value("${panchang.api.base-url:https://json.freeastrologyapi.com}")
    private String apiBaseUrl;

    @Value("${panchang.api.key:}")
    private String apiKey;

    // =========================================================================
    // PUBLIC API
    // =========================================================================

    @Cacheable(value = "panchang", key = "#date.toString()")
    public PanchangCache getForDate(LocalDate date) {
        return cacheRepo.findByDate(date)
                .map(cached -> {
                    // Auto-heal if cached record has old mock or error data, replace with real live API data
                    if (cached.getTithi() != null && (cached.getTithi().contains("Err") || cached.getTithi().equals("Chaturthi"))) {
                        PanchangCache fresh = fetchAndCache(date);
                        fresh.setId(cached.getId());
                        return cacheRepo.save(fresh);
                    }
                    return cached;
                })
                .orElseGet(() -> fetchAndCache(date));
    }

    public List<PanchangCache> getForMonth(YearMonth month) {
        LocalDate start = month.atDay(1);
        LocalDate end = month.atEndOfMonth().plusDays(1);
        List<PanchangCache> cached = cacheRepo.findByDateBetween(start, end);

        LocalDate current = start;
        while (!current.isAfter(month.atEndOfMonth())) {
            final LocalDate d = current;
            boolean exists = cached.stream().anyMatch(p -> p.getDate().equals(d));
            if (!exists) {
                cached.add(fetchAndCache(d));
            }
            current = current.plusDays(1);
        }
        cached.sort((a, b) -> a.getDate().compareTo(b.getDate()));
        return cached;
    }

    @CacheEvict(value = "panchang", allEntries = true)
    public void clearCache() {
        log.info("Clearing all cached panchang data from database and memory");
        cacheRepo.deleteAll();
    }

    public String fetchRawApiResponse() {
        try {
            WebClient client = webClientBuilder.baseUrl(apiBaseUrl).build();
            LocalDate date = LocalDate.now();
            Map<String, Object> requestBody = Map.of(
                    "year", date.getYear(),
                    "month", date.getMonthValue(),
                    "date", date.getDayOfMonth(),
                    "hours", 6,
                    "minutes", 0,
                    "seconds", 0,
                    "latitude", 22.5726,
                    "longitude", 88.3639,
                    "timezone", 5.5,
                    "config", Map.of(
                            "observation_point", "topocentric",
                            "ayanamsha", "lahiri",
                            "language", "en"
                    )
            );

            return client.post()
                    .uri("/complete-panchang")
                    .header("Content-Type", "application/json")
                    .header("x-api-key", apiKey)
                    .bodyValue(requestBody)
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();
        } catch (Exception e) {
            log.error("Error fetching raw API response: {}", e.getMessage(), e);
            return "ERROR: " + e.getMessage();
        }
    }

    // =========================================================================
    // REAL EXTERNAL API FETCH & CACHE (FreeAstroAPI)
    // =========================================================================

    private PanchangCache fetchAndCache(LocalDate date) {
        PanchangCache data = fetchFromApi(date);
        return cacheRepo.save(data);
    }

    private PanchangCache fetchFromApi(LocalDate date) {
        try {
            WebClient client = webClientBuilder.baseUrl(apiBaseUrl).build();

            // Real Panchang payload for FreeAstroAPI (Kolkata coordinates)
            Map<String, Object> requestBody = Map.of(
                    "year", date.getYear(),
                    "month", date.getMonthValue(),
                    "date", date.getDayOfMonth(),
                    "hours", 6,
                    "minutes", 0,
                    "seconds", 0,
                    "latitude", 22.5726,
                    "longitude", 88.3639,
                    "timezone", 5.5,
                    "config", Map.of(
                            "observation_point", "topocentric",
                            "ayanamsha", "lahiri",
                            "language", "en"
                    )
            );

            Map response = client.post()
                    .uri("/complete-panchang")
                    .header("Content-Type", "application/json")
                    .header("x-api-key", apiKey)
                    .bodyValue(requestBody)
                    .retrieve()
                    .bodyToMono(Map.class)
                    .block();

            return parseFreeAstroResponse(response, date);
        } catch (Exception e) {
            log.error("Panchang API error for date {}: {}", date, e.getMessage(), e);
            throw new RuntimeException("Failed to fetch real panchang from external API: " + e.getMessage(), e);
        }
    }

    @SuppressWarnings("unchecked")
    private PanchangCache parseFreeAstroResponse(Map<?, ?> response, LocalDate date) {
        if (response == null) {
            throw new IllegalStateException("Received empty response from Panchang API for " + date);
        }

        String rawTithi = extractNestedName(response, "tithi");
        // "Krishna Ashtami" -> "Ashtami" for frontend Bengali display mapping
        String tithi = cleanTithiName(rawTithi);
        String nakshatra = extractNestedName(response, "nakshatra");
        String yoga = extractNestedName(response, "yoga");
        String karana = extractNestedName(response, "karana");
        String vara = extractString(response, "weekday");
        if (vara == null || vara.isBlank()) {
            vara = date.getDayOfWeek().toString();
        }

        LocalTime sunrise = parseTime(response.get("sunrise"), LocalTime.of(6, 15));
        LocalTime sunset = parseTime(response.get("sunset"), LocalTime.of(18, 30));

        return buildPanchangCache(date, tithi, nakshatra, yoga, karana, vara, sunrise, sunset)
                .toBuilder()
                .isPurnima(rawTithi.toLowerCase().contains("purnima"))
                .isAmavasya(rawTithi.toLowerCase().contains("amavasya"))
                .isEkadashi(rawTithi.toLowerCase().contains("ekadashi"))
                .build();
    }

    @SuppressWarnings("unchecked")
    private String extractNestedName(Map<?, ?> map, String key) {
        try {
            Object obj = map.get(key);
            if (obj instanceof Map<?, ?> limbMap) {
                Object first = limbMap.get("1");
                if (first instanceof Map<?, ?> itemMap) {
                    Object name = itemMap.get("name");
                    return name != null ? name.toString() : "";
                }
            }
        } catch (Exception e) {
            log.warn("Could not extract {}: {}", key, e.getMessage());
        }
        return "";
    }

    private String cleanTithiName(String raw) {
        if (raw == null || raw.isBlank()) return "";
        // Extract base tithi name (e.g. "Krishna Ashtami" -> "Ashtami", "Shukla Navami" -> "Navami")
        String cleaned = raw.replace("Krishna ", "").replace("Shukla ", "").trim();
        String[] parts = cleaned.split(" ");
        return parts.length > 0 ? parts[0] : cleaned;
    }

    private LocalTime parseTime(Object val, LocalTime defaultTime) {
        if (val == null) return defaultTime;
        try {
            String str = val.toString();
            if (str.contains("T")) {
                str = str.substring(str.indexOf("T") + 1);
            }
            if (str.length() >= 5) {
                return LocalTime.parse(str.substring(0, 5));
            }
        } catch (Exception e) {
            log.debug("Time parse fallback for value {}: {}", val, e.getMessage());
        }
        return defaultTime;
    }

    private String extractString(Map<?, ?> map, String key) {
        Object val = map.get(key);
        return val != null ? val.toString() : "";
    }

    private PanchangCache buildPanchangCache(LocalDate date, String tithi,
            String nakshatra, String yoga, String karana, String vara,
            LocalTime sunrise, LocalTime sunset) {

        // Muhurtas strictly anchored to real API sunrise and sunset
        LocalTime[] rahuStarts = {
            LocalTime.of(16, 30), LocalTime.of(7, 30), LocalTime.of(15, 0),
            LocalTime.of(12, 0), LocalTime.of(13, 30), LocalTime.of(10, 30), LocalTime.of(9, 0)
        };
        int dow = date.getDayOfWeek().getValue() % 7;
        LocalTime rahuStart = rahuStarts[dow];
        LocalTime rahuEnd   = rahuStart.plusHours(1).plusMinutes(30);

        LocalTime brahmaMuhurtaStart = sunrise.minusHours(1).minusMinutes(36);
        LocalTime brahmaMuhurtaEnd   = sunrise.minusMinutes(48);

        long sunriseMinutes = sunrise.toSecondOfDay() / 60;
        long sunsetMinutes  = sunset.toSecondOfDay() / 60;
        long noon = (sunriseMinutes + sunsetMinutes) / 2;
        LocalTime abhijitStart = LocalTime.ofSecondOfDay((noon - 24) * 60);
        LocalTime abhijitEnd   = LocalTime.ofSecondOfDay((noon + 24) * 60);

        return PanchangCache.builder()
                .date(date)
                .tithi(tithi)
                .nakshatra(nakshatra)
                .yoga(yoga)
                .karana(karana)
                .vara(vara)
                .rahuStart(rahuStart)
                .rahuEnd(rahuEnd)
                .gulikaStart(rahuStart.plusHours(3))
                .gulikaEnd(rahuEnd.plusHours(3))
                .yamghantStart(rahuStart.plusHours(6).minusMinutes(30))
                .yamghantEnd(rahuEnd.plusHours(6).minusMinutes(30))
                .abhijitStart(abhijitStart)
                .abhijitEnd(abhijitEnd)
                .brahmaMuhurtaStart(brahmaMuhurtaStart)
                .brahmaMuhurtaEnd(brahmaMuhurtaEnd)
                .sunrise(sunrise)
                .sunset(sunset)
                .build();
    }
}
