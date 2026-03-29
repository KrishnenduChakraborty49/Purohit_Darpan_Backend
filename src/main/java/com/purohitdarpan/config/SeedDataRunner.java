package com.purohitdarpan.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;
import org.springframework.context.annotation.Lazy;
import org.springframework.core.io.ClassPathResource;
import org.springframework.util.FileCopyUtils;
import org.springframework.jdbc.core.JdbcTemplate;
import java.nio.charset.StandardCharsets;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Component
@Lazy(false)
public class SeedDataRunner implements CommandLineRunner {
    private static final Logger logger = LoggerFactory.getLogger(SeedDataRunner.class);
    private final JdbcTemplate jdbcTemplate;

    public SeedDataRunner(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void run(String... args) {
        new Thread(() -> {
        try { jdbcTemplate.execute("ALTER TABLE pujas ALTER COLUMN difficulty TYPE varchar(20) USING difficulty::varchar"); } catch(Exception e) {}
                try {
                    jdbcTemplate.execute("UPDATE pujas SET is_active = true WHERE is_active IS NULL");
            Long count = jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class);
            if (true) { // Force fresh seeding
                logger.info("Database is empty. Seeding initial data...");
                
                try {
                    jdbcTemplate.execute("TRUNCATE TABLE users, samagri, pujas, mantras, puja_steps, step_mantras, step_samagri, resources, hindu_festivals, user_notification_preferences CASCADE");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS pujas_id_seq RESTART WITH 1");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS samagri_id_seq RESTART WITH 1");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS mantras_id_seq RESTART WITH 1");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS puja_steps_id_seq RESTART WITH 1");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS resources_id_seq RESTART WITH 1");
                    jdbcTemplate.execute("ALTER SEQUENCE IF EXISTS users_id_seq RESTART WITH 1");
                } catch (Exception e) {
                    logger.warn("Could not truncate tables or reset sequences, they might be empty already. Proceeding to insert...");
                }

                String sql = new String(FileCopyUtils.copyToByteArray(new ClassPathResource("data.sql").getInputStream()), StandardCharsets.UTF_8);
                String[] statements = sql.split(";");
                for (String stmt : statements) {
                    if (!stmt.trim().isEmpty()) {
                        jdbcTemplate.execute(stmt);
                    }
                }
                logger.info("Database seeded successfully!");
            } else {
                logger.info("Database already seeded with {} pujas. Skipping data.sql.", count);
            }
        } catch (Exception e) {
            logger.error("Error running SeedDataRunner: ", e);
        }
    }).start();
    }
}