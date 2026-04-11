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
                populator.addScript(new ClassPathResource("data.sql"));
                populator.setSqlScriptEncoding(StandardCharsets.UTF_8.name());
                populator.execute(dataSource);

                // Explicitly link puja steps to their PDF resources via Java (reliable, not SQL file parsing)
                logger.info("Linking PDF resources to puja steps...");
                int linked = jdbcTemplate.update(
                    "UPDATE puja_steps ps SET pdf_resource_id = r.id " +
                    "FROM resources r " +
                    "WHERE r.puja_id = ps.puja_id AND r.resource_type = 'PDF'"
                );
                logger.info("PDF linking complete — {} steps linked to Paddhati PDFs", linked);

                logger.info("PRODUCTION SEEDING SUCCESS!");
            }
        } catch (Exception e) {
            logger.error("Seeder Error: " + e.getMessage());
        }
    }

}
