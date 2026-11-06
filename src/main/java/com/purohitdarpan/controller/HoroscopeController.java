package com.purohitdarpan.controller;

import com.purohitdarpan.entity.DailyHoroscope;
import com.purohitdarpan.service.HoroscopeService;
import lombok.RequiredArgsConstructor;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/horoscope")
@RequiredArgsConstructor
public class HoroscopeController {

    private final HoroscopeService horoscopeService;

    @GetMapping("/today")
    public ResponseEntity<List<DailyHoroscope>> getTodayHoroscope() {
        return ResponseEntity.ok(horoscopeService.getDailyHoroscope(LocalDate.now()));
    }

    @GetMapping("/date/{date}")
    public ResponseEntity<List<DailyHoroscope>> getHoroscopeForDate(
            @PathVariable @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date) {
        return ResponseEntity.ok(horoscopeService.getDailyHoroscope(date));
    }

    @GetMapping("/today/{rashi}")
    public ResponseEntity<DailyHoroscope> getTodaySingleRashi(@PathVariable String rashi) {
        return horoscopeService.getHoroscopeForRashi(LocalDate.now(), rashi)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/date/{date}/{rashi}")
    public ResponseEntity<DailyHoroscope> getSingleRashiForDate(
            @PathVariable @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
            @PathVariable String rashi) {
        return horoscopeService.getHoroscopeForRashi(date, rashi)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
}
