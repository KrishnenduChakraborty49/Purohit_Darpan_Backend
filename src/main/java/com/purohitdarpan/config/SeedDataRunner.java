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
    public void run(String... args) { // Fixed: method name must be 'run'
        try {
            boolean isProd = activeProfile.contains("prod");
            logger.info("Initializing seeder for profile: " + activeProfile);

            if (isProd) {
                try {
                    logger.info("Wiping database for fresh start...");
                    jdbcTemplate.execute("TRUNCATE TABLE user_notification_preferences, hindu_festivals, resources, step_samagri, step_mantras, puja_steps, samagri, mantras, pujas, users RESTART IDENTITY CASCADE");

                    logger.info("Running script: data_postgres.sql...");
                    ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
                    populator.addScript(new ClassPathResource("data_postgres.sql"));
                    populator.setSqlScriptEncoding(StandardCharsets.UTF_8.name());
                    populator.execute(dataSource);

                    jdbcTemplate.execute("UPDATE pujas SET is_active = true");
                    logger.info("PRODUCTION SEEDING SUCCESS!");
                } catch (Exception se) {
                    logger.warn("Seeding Warning (skipped): " + se.getMessage());
                }
            } else {
                logger.info("Dev profile detected. Skipping production truncate.");
            }
        } catch (Exception e) {
            logger.error("Critical Seeder Crash: " + e.getMessage());
        }
    }
}
