package com.purohitdarpan.service;

import com.purohitdarpan.entity.DailyHoroscope;
import com.purohitdarpan.repository.DailyHoroscopeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.util.*;

@Service
@RequiredArgsConstructor
@Slf4j
public class HoroscopeService {

    private final DailyHoroscopeRepository horoscopeRepo;
    private final ChatClient chatClient;

    public record RashiMeta(String code, String nameEn, String nameBn, String symbol, String luckyColor, String luckyNumber, String remedy) {}

    private static final List<RashiMeta> ALL_RASHIS = List.of(
            new RashiMeta("aries", "Aries", "মেষ", "♈", "লাল", "৯", "শ্রী হনুমান চালিসা পাঠ করুন।"),
            new RashiMeta("taurus", "Taurus", "বৃষ", "♉", "সাদা", "৬", "মা লক্ষ্মীকে সাদা ফুল অর্পণ করুন।"),
            new RashiMeta("gemini", "Gemini", "মিথুন", "♊", "সবুজ", "৫", "তুলসী গাছে জল দান করুন।"),
            new RashiMeta("cancer", "Cancer", "কর্কট", "♋", "রুপালি বা সাদা", "২", "ভগবান শিবের জলাভিষেক করুন।"),
            new RashiMeta("leo", "Leo", "সিংহ", "♌", "কমলা বা সোনালি", "১", "সূর্যদেবকে অর্ঘ্য নিবেদন করুন।"),
            new RashiMeta("virgo", "Virgo", "কন্যা", "♍", "গাঢ় সবুজ", "৫", "গণেশ স্তোত্র পাঠ করুন ও লাড্ডু নিবেদন করুন।"),
            new RashiMeta("libra", "Libra", "তুলা", "♎", "গোলাপি বা সাদা", "৬", "দরিদ্র ব্যক্তিকে মিষ্টি দান করুন।"),
            new RashiMeta("scorpio", "Scorpio", "বৃশ্চিক", "♏", "মেরুন বা লাল", "৯", "ওঁ নমঃ শিবায় মন্ত্র জপ করুন।"),
            new RashiMeta("sagittarius", "Sagittarius", "ধনু", "♐", "হলুদ", "৩", "বিষ্ণু সহস্রনাম শ্রবণ বা পাঠ করুন।"),
            new RashiMeta("capricorn", "Capricorn", "মকর", "♑", "নীল", "৮", "শনিবার বা সন্ধ্যায় প্রদীপ প্রজ্জ্বলন করুন।"),
            new RashiMeta("aquarius", "Aquarius", "কুম্ভ", "♒", "আসমানি বা নীল", "৮", "অসহায় কাউকে সাহায্য করুন।"),
            new RashiMeta("pisces", "Pisces", "মীন", "♓", "হলুদ বা সোনালি", "৩", "গায়ত্রী মন্ত্র ১০৮ বার জপ করুন।")
    );

    @Cacheable(value = "horoscopes", key = "#date.toString()")
    @Transactional
    public List<DailyHoroscope> getDailyHoroscope(LocalDate date) {
        List<DailyHoroscope> cached = horoscopeRepo.findByDate(date);
        if (cached != null && cached.size() >= 12) {
            return cached;
        }

        List<DailyHoroscope> generated = generateAllRashis(date);
        return horoscopeRepo.saveAll(generated);
    }

    public Optional<DailyHoroscope> getHoroscopeForRashi(LocalDate date, String rashiQuery) {
        List<DailyHoroscope> list = getDailyHoroscope(date);
        String query = rashiQuery.trim().toLowerCase();

        return list.stream()
                .filter(h -> h.getRashiCode().equalsIgnoreCase(query)
                        || h.getRashiNameEn().equalsIgnoreCase(query)
                        || h.getRashiNameBn().equals(rashiQuery.trim()))
                .findFirst();
    }

    private List<DailyHoroscope> generateAllRashis(LocalDate date) {
        List<DailyHoroscope> result = new ArrayList<>();
        Map<String, String> aiPredictions = fetchAiPredictions(date);

        for (RashiMeta meta : ALL_RASHIS) {
            String prediction = aiPredictions.getOrDefault(meta.code(), getDefaultVedicPrediction(meta, date));

            DailyHoroscope horoscope = DailyHoroscope.builder()
                    .date(date)
                    .rashiCode(meta.code())
                    .rashiNameEn(meta.nameEn())
                    .rashiNameBn(meta.nameBn())
                    .symbol(meta.symbol())
                    .predictionBn(prediction)
                    .luckyColorBn(meta.luckyColor())
                    .luckyNumber(meta.luckyNumber())
                    .remedyBn(meta.remedy())
                    .build();

            result.add(horoscope);
        }
        return result;
    }

    private Map<String, String> fetchAiPredictions(LocalDate date) {
        Map<String, String> map = new HashMap<>();
        try {
            String prompt = """
                    আজকের তারিখ: %s।
                    বৈদিক জ্যোতিষশাস্ত্রের নিয়ম অনুযায়ী ১২টি রাশির আজকের সংক্ষিপ্ত অথচ প্রাঞ্জল বাংলা রাশিফল (১-২ বাক্য প্রতি রাশিতে) তৈরি করুন।
                    ফরম্যাট ঠিক এইরকম রাখুন:
                    [aries]: মেষ রাশির পূর্বাভাস
                    [taurus]: বৃষ রাশির পূর্বাভাস
                    [gemini]: মিথুন রাশির পূর্বাভাস
                    [cancer]: কর্কট রাশির পূর্বাভাস
                    [leo]: সিংহ রাশির পূর্বাভাস
                    [virgo]: কন্যা রাশির পূর্বাভাস
                    [libra]: তুলা রাশির পূর্বাভাস
                    [scorpio]: বৃশ্চিক রাশির পূর্বাভাস
                    [sagittarius]: ধনু রাশির পূর্বাভাস
                    [capricorn]: মকর রাশির পূর্বাভাস
                    [aquarius]: কুম্ভ রাশির পূর্বাভাস
                    [pisces]: মীন রাশির পূর্বাভাস
                    """.formatted(date);

            String response = chatClient.prompt()
                    .system("আপনি পুরোহিত দর্পণ অ্যাপের অভিজ্ঞ জ্যোতিষাচার্য। ১২টি রাশির সঠিক বাংলা রাশিফল দিন।")
                    .user(prompt)
                    .call()
                    .content();

            if (response != null && !response.isBlank()) {
                String[] lines = response.split("\n");
                for (String line : lines) {
                    line = line.trim();
                    if (line.startsWith("[") && line.contains("]:")) {
                        int closeIdx = line.indexOf("]:");
                        String code = line.substring(1, closeIdx).trim().toLowerCase();
                        String pred = line.substring(closeIdx + 2).trim();
                        if (!pred.isBlank()) {
                            map.put(code, pred);
                        }
                    }
                }
            }
        } catch (Exception e) {
            log.warn("AI Horoscope generation failed, using authentic Vedic template: {}", e.getMessage());
        }
        return map;
    }

    private String getDefaultVedicPrediction(RashiMeta meta, LocalDate date) {
        int dayOfWeek = date.getDayOfWeek().getValue(); // 1=Mon .. 7=Sun
        return switch (meta.code()) {
            case "aries" -> "আজ আপনার কর্মক্ষেত্রে নতুন উদ্দীপনা ও সাফল্য দেখা যাবে। আর্থিক লেনদেনে সতর্কতা অবলম্বন করুন। পারিবারিক শান্তি বজায় থাকবে।";
            case "taurus" -> "আর্থিক দিক শুভ এবং আটকে থাকা অর্থ প্রাপ্তির সম্ভাবনা রয়েছে। প্রিয়জনের সাথে সুন্দর সময় কাটবে। স্বাস্থ্যের যত্ন নিন।";
            case "gemini" -> "কর্মক্ষেত্রে আপনার বুদ্ধিমত্তা ও দূরদর্শিতার প্রশংসা হবে। সামাজিক যোগাযোগে শুভ ফল পাবেন। মানসিক প্রফুল্লতা বজায় থাকবে।";
            case "cancer" -> "পারিবারিক বিষয়ে শুভ সিদ্ধান্ত নিতে পারবেন। ব্যবসায়ীদের জন্য লাভজনক দিন। ঈশ্বরের প্রার্থনায় মানসিক শান্তি পাবেন।";
            case "leo" -> "নেতৃত্ব ও আত্মবিশ্বাস বৃদ্ধি পাবে। নতুন কোনো কর্মপরিকল্পনা সফল হতে পারে। অহংকার পরিহার করে চলুন।";
            case "virgo" -> "বিশ্লেষণাত্মক কাজের জন্য অত্যন্ত উপযুক্ত দিন। শিক্ষার্থীদের জন্য শুভ সংবাদ আসতে পারে। পরিমিত খাদ্য গ্রহণ করুন।";
            case "libra" -> "সম্পর্কের মাধুর্য বৃদ্ধি পাবে এবং অংশীদারি ব্যবসায় লাভ হবে। ব্যয় কিছুটা নিয়ন্ত্রণের মধ্যে রাখা প্রয়োজন।";
            case "scorpio" -> "গোপন কোনো সমস্যার সুরাহা হবে। পরিশ্রমের পূর্ণ মর্যাদা পাবেন। ধৈর্য ধরে পরিস্থিতি সামলান।";
            case "sagittarius" -> "দূর ভ্রমণের সুযোগ আসতে পারে অথবা আধ্যাত্মিক কাজে আগ্রহ বাড়বে। ভাগ্যের পূর্ণ সঙ্গ পাবেন।";
            case "capricorn" -> "কঠোর পরিশ্রমের সুফল পাবেন। কর্মক্ষেত্রে পদোন্নতি বা ঊর্ধ্বতনদের সহযোগিতা মিলবে। অলসতা ত্যাগ করুন।";
            case "aquarius" -> "নতুন বন্ধু বা হিতৈষী ব্যক্তির সান্নিধ্য পাবেন। উদ্ভাবনী চিন্তাভাবনায় সফলতা আসবে। সামাজিক সম্মান বৃদ্ধি পাবে।";
            case "pisces" -> "মানসিক শান্তি ও আধ্যাত্মিক উন্নতি হবে। সৃজনশীল কাজে বিশেষ সাফল্য আসবে। আর্থিক বিনিয়োগে অভিজ্ঞদের পরামর্শ নিন।";
            default -> "আজকের দিনটি আপনার জন্য সাধারণ এবং শুভপ্রদ হবে। নিজের লক্ষ্যের দিকে অবিচল থাকুন।";
        };
    }
}
