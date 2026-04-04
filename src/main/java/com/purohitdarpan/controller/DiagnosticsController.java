package com.purohitdarpan.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class DiagnosticsController {
    private final JdbcTemplate jdbcTemplate;

    public DiagnosticsController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/api/health")
    public String health() {
        return "BACKEND_OK";
    }

    /**
     * Diagnostic endpoint to check DB connectivity and data counts.
     * FIX: Uses try-with-resources to prevent database connection leaks.
     */
    @GetMapping("/api/diagnostics/db-status")
    public Map<String, Object> getDbStatus() {
        Map<String, Object> status = new HashMap<>();
        try {
            // Check puja counts
            status.put("pujas_count", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class));
            status.put("is_active_true", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas WHERE is_active = true", Long.class));

            // Safe connection check: get metadata and close immediately
            try (java.sql.Connection conn = jdbcTemplate.getDataSource().getConnection()) {
                status.put("connection_url", conn.getMetaData().getURL());
                status.put("database_product", conn.getMetaData().getDatabaseProductName());
            }

            status.put("status", "UP");
        } catch (Exception e) {
            status.put("status", "DOWN");
            status.put("error", e.getMessage());
        }
        return status;
    }
}
