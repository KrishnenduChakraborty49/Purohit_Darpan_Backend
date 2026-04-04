package com.purohitdarpan.controller;

import com.purohitdarpan.exception.GlobalExceptionHandler;
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

    /**
     * Diagnostic endpoint to check DB connectivity and reveal internal errors.
     * FIX: Includes the system-wide 'lastError' tracked by GlobalExceptionHandler.
     */
    @GetMapping("/api/diagnostics/db-status")
    public Map<String, Object> getDbStatus() {
        Map<String, Object> status = new HashMap<>();
        try {
            // Count total and active pujas
            status.put("pujas_count", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class));
            status.put("is_active_true", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas WHERE is_active = true", Long.class));

            // Safe connection check using try-with-resources (no leak)
            try (java.sql.Connection conn = jdbcTemplate.getDataSource().getConnection()) {
                status.put("connection_url", conn.getMetaData().getURL());
                status.put("database_name", conn.getMetaData().getDatabaseProductName());
            }
            status.put("status", "UP");
        } catch (Exception e) {
            status.put("status", "ERROR");
            status.put("error", e.getMessage());
        }

        // REVEAL INTERNAL SYSTEM ERROR (This is the key to fixing the 500 crashes!)
        status.put("last_system_error", GlobalExceptionHandler.lastError);
        status.put("last_error_stack_trace", GlobalExceptionHandler.lastErrorTrace);

        return status;
    }
}
