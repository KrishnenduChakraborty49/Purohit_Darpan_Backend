package com.purohitdarpan.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/diagnostics")
@RequiredArgsConstructor
public class DiagnosticsController {
    private final JdbcTemplate jdbcTemplate;

    @GetMapping("/db-status")
    public Map<String, Object> getDbStatus() {
        Map<String, Object> status = new HashMap<>();
        try {
            status.put("pujas_count", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class));
            status.put("is_active_true", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas WHERE is_active = true", Long.class));
            status.put("connection_url", jdbcTemplate.getDataSource().getConnection().getMetaData().getURL());
        } catch (Exception e) {
            status.put("error", e.getMessage());
        }
        return status;
    }
}