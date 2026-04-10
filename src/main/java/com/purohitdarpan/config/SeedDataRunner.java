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
        try {
            if (activeProfile.contains("prod")) {
                logger.info("FORCING DATABASE RELOAD...");
                jdbcTemplate.execute("TRUNCATE TABLE hindu_festivals, resources, step_samagri, step_mantras, puja_steps, samagri, mantras, pujas RESTART IDENTITY CASCADE");

                ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
                populator.addScript(new ClassPathResource("data_postgres.sql"));
                populator.setSqlScriptEncoding(StandardCharsets.UTF_8.name());
                populator.execute(dataSource);

                logger.info("PRODUCTION SEEDING SUCCESS!");
            }
        } catch (Exception e) {
            logger.error("Seeder Error: " + e.getMessage());
        }
    }

}
