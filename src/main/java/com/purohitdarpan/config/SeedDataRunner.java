package com.purohitdarpan.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.jdbc.core.JdbcTemplate;
import javax.sql.DataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
@Lazy(false)
public class SeedDataRunner implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(SeedDataRunner.class);
    private final JdbcTemplate jdbcTemplate;
    private final DataSource dataSource;

    public SeedDataRunner(JdbcTemplate jdbcTemplate, DataSource dataSource) {
        this.jdbcTemplate = jdbcTemplate;
        this.dataSource = dataSource;
    }

    @Override
    public void run(String... args) {
        try {
            logger.info("Initializing database with robust seeding...");
            
            // Clean up old data to ensure a fresh, consistent state
            try {
                jdbcTemplate.execute("TRUNCATE TABLE users, samagri, pujas, mantras, puja_steps, step_mantras, step_samagri, resources, hindu_festivals, user_notification_preferences CASCADE");
                jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS pujas_id_seq RESTART WITH 1");
                jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS samagri_id_seq RESTART WITH 1");
                jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS mantras_id_seq RESTART WITH 1");
                jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS puja_steps_id_seq RESTART WITH 1");
            } catch (Exception e) {
                logger.warn("Seeding cleanup: Tables might already be empty.");
            }

            ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
            populator.addScript(new ClassPathResource("data.sql"));
            populator.setContinueOnError(true);
            populator.setIgnoreFailedDrops(true);
            populator.execute(dataSource);
            
            logger.info("Database seeding completed successfully!");
        } catch (Exception e) {
            logger.error("FATAL: Database seeding failed: ", e);
        }
    }
}