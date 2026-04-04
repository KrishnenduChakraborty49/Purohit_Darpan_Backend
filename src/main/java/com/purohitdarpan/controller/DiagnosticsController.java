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

    @GetMapping("/api/diagnostics/db-status")
    public Map<String, Object> getDbStatus() {
        Map<String, Object> status = new HashMap<>();
        try {
            status.put("pujas_count", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class));
            status.put("is_active_true", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas WHERE is_active = true", Long.class));

            try (java.sql.Connection conn = jdbcTemplate.getDataSource().getConnection()) {
                status.put("connection_url", conn.getMetaData().getURL());
            }
            status.put("status", "UP");
        } catch (Exception e) {
            status.put("status", "ISSUE");
            status.put("error", e.getMessage());
        }

        // Reveal the last system-wide 500 error here!
        status.put("last_system_error", GlobalExceptionHandler.lastError);
        return status;
    }
}
