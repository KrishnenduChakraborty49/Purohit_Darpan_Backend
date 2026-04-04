package com.purohitdarpan.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.beans.factory.annotation.Value;
import javax.sql.DataSource;
import java.nio.charset.StandardCharsets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
public class SeedDataRunner implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(SeedDataRunner.class);
    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

    @Value("${spring.profiles.active:dev}")
    private String activeProfile;

    public SeedDataRunner(JdbcTemplate jdbcTemplate, DataSource dataSource) {
        this.jdbcTemplate = jdbcTemplate;
        this.dataSource = dataSource;
    }

    @Override
    public void run(String... args) {
        // We now run this synchronously to guarantee database state before the app starts serving requests
        try {
            boolean isProd = activeProfile.contains("prod");
            logger.info("Database Seeding starting for profile: " + activeProfile);

            if (isProd) {
                // Render/PostgreSQL Production Seeding
                logger.info("Cleaning existing data for fresh seed...");
                jdbcTemplate.execute("TRUNCATE TABLE user_notification_preferences, hindu_festivals, resources, step_samagri, step_mantras, puja_steps, samagri, mantras, pujas, users RESTART IDENTITY CASCADE");

                logger.info("Executing data_postgres.sql script...");
                ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
                populator.addScript(new ClassPathResource("data_postgres.sql"));
                populator.setSqlScriptEncoding(StandardCharsets.UTF_8.name());
                populator.execute(dataSource);

                // FINAL SAFETY FIX: Force set is_active=true for all pujas
                logger.info("Applying final safety update: setting is_active=true for all pujas");
                jdbcTemplate.execute("UPDATE pujas SET is_active = true");

                logger.info("Render Seeding Complete!");
            } else {
                // Local MySQL logic (Simplified cleanup)
                jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 0");
                jdbcTemplate.execute("TRUNCATE TABLE users");
                jdbcTemplate.execute("TRUNCATE TABLE pujas");
                jdbcTemplate.execute("SET FOREIGN_KEY_CHECKS = 1");
                logger.info("Local MySQL cleanup complete.");
            }
        } catch (Exception e) {
            logger.error("Seeding Error: " + e.getMessage(), e);
        }
    }
}
