-- ============================================================
-- Purohit Darpan - Seed Data (Verified Master)
-- ============================================================

-- -------------------------------------------------------
-- ADMIN USER
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, full_name, role, is_active) VALUES
('admin', 'admin@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Platform Admin', 'ADMIN', TRUE),
('guru_sharma', 'guru@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Pt. Rajesh Sharma', 'MENTOR', TRUE);

-- -------------------------------------------------------
-- SAMAGRI
-- -------------------------------------------------------
INSERT INTO samagri (name, name_devanagari, description) VALUES
('Kalash', 'कलश', 'Sacred water pot'),
('Mango Leaves', 'आम के पत्ते', 'Fresh mango leaves'),
('Coconut', 'नारियल', 'Sacred coconut'),
('Roli', 'रोली', 'Red vermillion'),
('Akshat', 'अक्षत', 'Unbroken rice'),
('Incense', 'अगरबत्ती', 'Purifying sticks'),
('Ghee Diya', 'घी दीया', 'Sacred lamp'),
('Flowers', 'पुष्प', 'Fresh offerings'),
('Gangajal', 'गंगाजल', 'Holy water');

-- -------------------------------------------------------
-- PUJAS
-- -------------------------------------------------------
INSERT INTO pujas (name, name_devanagari, description, duration_minutes, difficulty, category, is_active) VALUES
('Ganesh Puja', 'गणेश पूजा', 'Foundational ritual for removing obstacles.', 60, 'BEGINNER', 'Vighnaharta', TRUE),
('Lakshmi Puja', 'लक्ष्मी पूजा', 'Worship for wealth and prosperity.', 90, 'BEGINNER', 'Wealth', TRUE),
('Durga Puja', 'दुर्गा पूजा', 'Worship of the Divine Mother for victory.', 300, 'ADVANCED', 'Shakti', TRUE),
('Saraswati Puja', 'सरस्वती पूजा', 'Worship of Knowledge and Arts.', 60, 'BEGINNER', 'Knowledge', TRUE);

-- -------------------------------------------------------
-- PUJA STEPS (Real Videos)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url) VALUES
(1, 1, 'Achamana', 'आचमन', 'Ritual purification.', 'https://www.youtube.com/watch?v=W0SclE-69S8'),
(1, 2, 'Sankalpa', 'संकल्प', 'Sacred vow.', 'https://www.youtube.com/watch?v=W0SclE-69S8'),
(3, 1, 'Invocation', 'आवाह্ন', 'Awakening Durga.', 'https://www.youtube.com/watch?v=FjIuK75Noyk'),
(4, 1, 'Invocation', 'आवाह্ন', 'Awakening Saraswati.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'),
(4, 2, 'Pushpanjali', 'पुष्पांजलि', 'Flower offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'),
(4, 3, 'Aarti', 'आरती', 'Light offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w');

-- -------------------------------------------------------
-- RESOURCES (Real PDFs & Books)
-- -------------------------------------------------------
INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable) VALUES
(1, 'Ganesh Puja Manual (PDF)', 'PDF', 'https://archive.org/details/dli.ministry.04644/page/n5/mode/2up', TRUE),
(3, 'Durga Puja Manual (PDF)', 'PDF', 'https://archive.org/details/DurgapujaPaddhati/page/n1/mode/2up', TRUE),
(4, 'Saraswati Puja Manual (PDF)', 'PDF', 'https://archive.org/details/saraswati-puja-paddhati-2020/page/n1/mode/2up', TRUE);

-- -------------------------------------------------------
-- HINDU FESTIVALS 2025 - 2026
-- -------------------------------------------------------
INSERT INTO hindu_festivals (name, name_devanagari, description, puja_id, event_date, days_duration, notification_days_before) VALUES
('Makar Sankranti', 'मकर संक्रांति', 'Transition of sun into Capricorn.', NULL, '2025-01-14', 1, 10),
('Basant Panchami', 'बसंत Panchami', 'Celebration of Spring and Knowledge.', 4, '2025-02-02', 1, 15),
('Durga Puja', 'दुर्गा पूजा', 'Victory of Shakti.', 3, '2025-10-02', 5, 20),
('Diwali', 'दीपावली', 'Festival of Lights.', 2, '2025-10-20', 5, 20);

-- -------------------------------------------------------
-- NOTIFICATION PREFERENCES
-- -------------------------------------------------------
INSERT INTO user_notification_preferences (user_id, festival_reminders, panchang_alerts, learning_reminders) VALUES
(1, TRUE, TRUE, TRUE),
(2, TRUE, TRUE, TRUE);