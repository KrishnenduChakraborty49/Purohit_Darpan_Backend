package com.purohitdarpan.config;

import com.purohitdarpan.repository.PujaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Component;

import javax.sql.DataSource;

@Component
@Slf4j
@RequiredArgsConstructor
public class SeedDataRunner implements CommandLineRunner {

    private final DataSource dataSource;
    private final PujaRepository pujaRepository;

    @Override
    public void run(String... args) throws Exception {
        log.info("Checking database for seeding requirements...");

        // Only seed if the database is empty or missing the new Saraswati Puja (id=8)
        if (pujaRepository.count() < 8) {
            log.info("Seeding database with fresh Puja data from data_postgres.sql...");
            try {
                ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
                populator.addScript(new ClassPathResource("data_postgres.sql"));
                populator.execute(dataSource);
                log.info("PRODUCTION SEEDING COMPLETED SUCCESSFULLY!");
            } catch (Exception e) {
                log.error("Error during database seeding: {}", e.getMessage());
                // We don't throw the exception to allow the app to start even if seeding fails
            }
        } else {
            log.info("Database already contains full Puja records. Skipping seeding.");
        }
    }
}
