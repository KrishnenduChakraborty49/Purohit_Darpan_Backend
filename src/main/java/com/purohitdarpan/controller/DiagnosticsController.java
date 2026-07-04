package com.purohitdarpan.controller;

import com.purohitdarpan.exception.GlobalExceptionHandler;
import com.purohitdarpan.scheduler.NotificationScheduler;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;
import org.springframework.http.ResponseEntity;

@RestController
public class DiagnosticsController {
    private final JdbcTemplate jdbcTemplate;
    private final NotificationScheduler notificationScheduler;

    public DiagnosticsController(JdbcTemplate jdbcTemplate, NotificationScheduler notificationScheduler) {
        this.jdbcTemplate = jdbcTemplate;
        this.notificationScheduler = notificationScheduler;
    }

    /**
     * Manual trigger for notification scheduler.
     */
    @GetMapping("/api/diagnostics/trigger-notifications")
    public Map<String, Object> triggerNotifications() {
        Map<String, Object> result = new HashMap<>();
        try {
            notificationScheduler.sendFestivalReminders();
            result.put("status", "SUCCESS");
            result.put("message", "Festival reminders triggered manually.");
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
        }
        return result;
    }

    /**
     * Diagnostic endpoint to check DB connectivity and reveal internal errors.
     * FIX: Includes the system-wide 'lastError' tracked by GlobalExceptionHandler.
     */
    @GetMapping("/test-festivals")
    public ResponseEntity<?> testFestivals() {
        try {
            return ResponseEntity.ok(jdbcTemplate.queryForList("SELECT id, name, event_date, is_active FROM hindu_festivals"));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(java.util.Map.of("error", e.getMessage(), "type", e.getClass().getName()));
        }
    }

    @GetMapping("/api/diagnostics/db-status")
    public Map<String, Object> getDbStatus() {
        Map<String, Object> status = new HashMap<>();
        try {
            // Count total and active pujas
            status.put("pujas_count", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas", Long.class));
            status.put("is_active_true", jdbcTemplate.queryForObject("SELECT count(*) FROM pujas WHERE is_active = true", Long.class));
            status.put("notifications_sent", jdbcTemplate.queryForObject("SELECT count(*) FROM notification_logs WHERE delivery_status = 'SENT'", Long.class));
            status.put("notifications_failed", jdbcTemplate.queryForObject("SELECT count(*) FROM notification_logs WHERE delivery_status = 'FAILED'", Long.class));
            
            // New Diagnostics
            status.put("total_notifications", jdbcTemplate.queryForObject("SELECT count(*) FROM notification_logs", Long.class));
            status.put("eligible_users", jdbcTemplate.queryForObject("SELECT count(*) FROM users WHERE notifications_enabled = true", Long.class));
            status.put("active_festivals", jdbcTemplate.queryForObject("SELECT count(*) FROM hindu_festivals WHERE is_active = true", Long.class));
            status.put("total_users", jdbcTemplate.queryForObject("SELECT count(*) FROM users", Long.class));

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

    /**
     * One-time endpoint to insert Shiv Puja directly into the live database.
     */
    @GetMapping("/api/diagnostics/seed-shiv-puja")
    public Map<String, Object> seedShivPuja() {
        Map<String, Object> result = new HashMap<>();
        try {
            jdbcTemplate.update(
                "INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active) " +
                "SELECT 9, 'Shiv Puja', '\u0936\u093f\u0935 \u092a\u0942\u091c\u093e', 'Worship of Lord Mahadev \u2014 the destroyer and transformer. Attain blessings, peace and liberation.', 90, 'INTERMEDIATE', 'Shaivism', " +
                "'https://purohit-darpan-backend-q7b6.onrender.com/images/shiv_closeup.jpg', TRUE " +
                "WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 9)"
            );
            jdbcTemplate.update(
                "INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url) " +
                "SELECT 9, 1, 'Shiv Puja Mantra', '\u0936\u093f\u0935 \u092a\u0942\u091c\u093e \u092e\u0902\u0924\u094d\u0930', '\u09b6\u09bf\u09ac \u09aa\u09c2\u099c\u09be\u09b0 \u09ae\u09a8\u09cd\u09a4\u09cd\u09b0', " +
                "'Sacred mantras and complete Shiv Puja vidhi with Panchamrita abhishek.', 'https://www.youtube.com/watch?v=vDC-zR9X6mw' " +
                "WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 9 AND step_order = 1)"
            );
            jdbcTemplate.update(
                "INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable) " +
                "SELECT 9, 'Shiv Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Shiv_Puja_Paddhati.pdf', TRUE " +
                "WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 9 AND title = 'Shiv Puja Paddhati')"
            );
            result.put("status", "SUCCESS");
            result.put("message", "Shiv Puja seeded successfully into the live database!");
        } catch (Exception e) {
            result.put("status", "ERROR");
            result.put("error", e.getMessage());
        }
        return result;
    }
}
