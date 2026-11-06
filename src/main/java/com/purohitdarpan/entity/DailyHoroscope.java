package com.purohitdarpan.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Entity
@Table(name = "daily_horoscopes", uniqueConstraints = {
    @UniqueConstraint(columnNames = {"date", "rashi_code"})
})
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DailyHoroscope {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDate date;

    @Column(name = "rashi_code", nullable = false, length = 50)
    private String rashiCode;

    @Column(name = "rashi_name_en", nullable = false, length = 50)
    private String rashiNameEn;

    @Column(name = "rashi_name_bn", nullable = false, length = 50)
    private String rashiNameBn;

    @Column(name = "symbol", length = 20)
    private String symbol;

    @Column(name = "prediction_bn", columnDefinition = "TEXT", nullable = false)
    private String predictionBn;

    @Column(name = "lucky_color_bn", length = 50)
    private String luckyColorBn;

    @Column(name = "lucky_number", length = 20)
    private String luckyNumber;

    @Column(name = "remedy_bn", length = 300)
    private String remedyBn;

    @CreationTimestamp
    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;
}
