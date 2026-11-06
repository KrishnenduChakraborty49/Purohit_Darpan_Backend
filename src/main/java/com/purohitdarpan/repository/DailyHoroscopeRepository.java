package com.purohitdarpan.repository;

import com.purohitdarpan.entity.DailyHoroscope;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface DailyHoroscopeRepository extends JpaRepository<DailyHoroscope, Long> {
    List<DailyHoroscope> findByDate(LocalDate date);
    Optional<DailyHoroscope> findByDateAndRashiCodeIgnoreCase(LocalDate date, String rashiCode);
    Optional<DailyHoroscope> findByDateAndRashiNameBn(LocalDate date, String rashiNameBn);
}
