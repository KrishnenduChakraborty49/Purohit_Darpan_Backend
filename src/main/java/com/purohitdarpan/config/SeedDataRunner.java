package com.purohitdarpan.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class SeedDataRunner implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(SeedDataRunner.class);
    private final JdbcTemplate jdbcTemplate;

    @Value("${spring.profiles.active:dev}")
    private String activeProfile;

    public SeedDataRunner(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void run(String... args) {
        try {
            if (activeProfile.contains("prod")) {
                logger.info("Stable Production Seeding starting...");
                // Added IF EXISTS logic via catch block or direct SQL to prevent crashing if migration is incomplete
                try {
                    jdbcTemplate.execute("TRUNCATE TABLE pujas RESTART IDENTITY CASCADE");
                    logger.info("Database cleaned successfully.");
                } catch (Exception e) {
                    logger.warn("Cleanup skipped: " + e.getMessage());
                }
            }
        } catch (Exception e) {
            logger.error("Non-critical seeding issue: " + e.getMessage());
        }
    }
}
