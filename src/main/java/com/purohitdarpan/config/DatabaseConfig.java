package com.purohitdarpan.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.boot.jdbc.DataSourceBuilder;
import javax.sql.DataSource;
import java.net.URI;
import java.net.URISyntaxException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Configuration
public class DatabaseConfig {
    private static final Logger logger = LoggerFactory.getLogger(DatabaseConfig.class);

    @Bean
    @Primary
    public DataSource dataSource() throws URISyntaxException {
        // Render provides DATABASE_URL in postgres:// format
        String databaseUrl = System.getenv("DATABASE_URL");

        if (databaseUrl == null || !databaseUrl.startsWith("postgres://")) {
            // Local dev (MySQL) will use application.properties instead
            return null;
        }

        logger.info("Detected Render Database URL. Converting to JDBC...");
        URI dbUri = new URI(databaseUrl);

        String userInfo = dbUri.getUserInfo();
        String username = userInfo.split(":")[0];
        String password = userInfo.split(":")[1];

        // CRITICAL FIX: Render internal URIs often omit the port,
        // causing Java's URI parser to return -1. We must force 5432.
        int port = dbUri.getPort();
        if (port == -1) port = 5432;

        String dbUrl = "jdbc:postgresql://" + dbUri.getHost() + ":" + port + dbUri.getPath() + "?sslmode=require";

        logger.info("Generated JDBC URL: {}", dbUrl);

        return DataSourceBuilder.create()
                .url(dbUrl)
                .username(username)
                .password(password)
                .driverClassName("org.postgresql.Driver")
                .build();
    }
}
