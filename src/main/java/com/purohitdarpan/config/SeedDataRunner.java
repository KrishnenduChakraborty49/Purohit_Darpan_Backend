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

                // ── Explicitly patch step titles, Bengali names & videos via JdbcTemplate ──
                logger.info("Patching puja step details...");

                // Ganesh Puja — Step 1
                upsertStep(1, 1,
                    "Ganesh Puja Procedure", "\u0917\u0923\u0947\u0936 \u092a\u0942\u091c\u093e \u0935\u093f\u0927\u093f",
                    "\u0997\u09a3\u09c7\u09b6 \u09aa\u09c2\u099c\u09be \u09ac\u09bf\u09a7\u09bf",
                    "Complete procedure of Ganesh Puja \u2014 invocation, mantras, offerings and aarti.",
                    "https://www.youtube.com/watch?v=DUIrds34eeg");

                // Lakshmi Puja — Step 1
                upsertStep(2, 1,
                    "Laxmi Puja Mantra", "\u0932\u0915\u094d\u0937\u094d\u092e\u0940 \u092a\u0942\u091c\u093e \u092e\u0902\u0924\u094d\u0930",
                    "\u09b2\u0995\u09cd\u09b7\u09cd\u09ae\u09c0 \u09aa\u09c2\u099c\u09be\u09b0 \u09ae\u09a8\u09cd\u09a4\u09cd\u09b0",
                    "Sacred mantras chanted during Laxmi Puja for invoking the goddess of wealth.",
                    "https://www.youtube.com/watch?v=knY4cUlCNXc");

                // Lakshmi Puja — Step 2 (Panchali)
                upsertStep(2, 2,
                    "Laxmi Panchali", "\u0932\u0915\u094d\u0937\u094d\u092e\u0940 \u092a\u093e\u0902\u091a\u093e\u0932\u0940",
                    "\u09b2\u0995\u09cd\u09b7\u09cd\u09ae\u09c0\u09b0 \u09aa\u09be\u0981\u099a\u09be\u09b2\u09bf",
                    "Recitation of Laxmi Panchali \u2014 devotional hymns in praise of Goddess Laxmi.",
                    "https://www.youtube.com/watch?v=dsWdH8-U8u8");

                // Saraswati Puja — Step 1
                upsertStep(8, 1,
                    "Saraswati Puja Mantra", "\u0938\u0930\u0938\u094d\u0935\u0924\u0940 \u092a\u0942\u091c\u093e \u092e\u0902\u0924\u094d\u0930",
                    "\u09b8\u09b0\u09b8\u09cd\u09ac\u09a4\u09c0 \u09aa\u09c2\u099c\u09be\u09b0 \u09ae\u09a8\u09cd\u09a4\u09cd\u09b0",
                    "Sacred mantras and complete procedure of Saraswati Puja \u2014 worship of the goddess of knowledge.",
                    "https://www.youtube.com/watch?v=8aN-DCABQcc");

                logger.info("Puja step details patched successfully!");

                logger.info("PRODUCTION SEEDING SUCCESS!");
            }
        } catch (Exception e) {
            logger.error("Seeder Error: " + e.getMessage());
        }
    }

    private void upsertStep(long pujaId, int stepOrder,
                            String title, String titleDevanagari, String titleBengali,
                            String description, String videoUrl) {
        int updated = jdbcTemplate.update(
            "UPDATE puja_steps SET title=?, title_devanagari=?, title_bengali=?, description=?, video_url=? " +
            "WHERE puja_id=? AND step_order=?",
            title, titleDevanagari, titleBengali, description, videoUrl, pujaId, stepOrder);
        if (updated == 0) {
            jdbcTemplate.update(
                "INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url) " +
                "VALUES (?,?,?,?,?,?,?)",
                pujaId, stepOrder, title, titleDevanagari, titleBengali, description, videoUrl);
            logger.info("Inserted step puja_id={} step_order={}: {}", pujaId, stepOrder, title);
        } else {
            logger.info("Updated step puja_id={} step_order={}: {}", pujaId, stepOrder, title);
        }
    }

}
