-- ============================================================
-- Purohit Darpan - Safe Seed Data (Verified Master)
-- ============================================================

-- -------------------------------------------------------
-- ADMIN USER (Safe)
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, full_name, role, is_active) VALUES
('admin', 'admin@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Platform Admin', 'ADMIN', TRUE),
('guru_sharma', 'guru@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Pt. Rajesh Sharma', 'MENTOR', TRUE)
ON CONFLICT (username) DO NOTHING;

-- -------------------------------------------------------
-- SAMAGRI (Safe)
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
('Gangajal', 'गंगाजल', 'Holy water')
ON CONFLICT (name) DO NOTHING;

-- -------------------------------------------------------
-- PUJAS (Safe)
-- -------------------------------------------------------
INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, is_active) VALUES
(1, 'Ganesh Puja', 'गणेश पूजा', 'Foundational ritual for removing obstacles.', 60, 'BEGINNER', 'Vighnaharta', TRUE),
(2, 'Lakshmi Puja', 'लक्ष्मी पूजा', 'Worship for wealth and prosperity.', 90, 'BEGINNER', 'Wealth', TRUE),
(3, 'Durga Puja', 'दुर्गा पूजा', 'Worship of the Divine Mother for victory.', 300, 'ADVANCED', 'Shakti', TRUE),
(8, 'Saraswati Puja', 'सरस्वती पूजा', 'Worship of Knowledge and Arts.', 60, 'BEGINNER', 'Knowledge', TRUE)
ON CONFLICT (id) DO NOTHING;

-- -------------------------------------------------------
-- PUJA STEPS (Safe)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url) VALUES
(1, 1, 'Achamana', 'आचमन', 'Ritual purification.', 'https://www.youtube.com/watch?v=W0SclE-69S8'),
(3, 1, 'Invocation', 'आवाह्न', 'Awakening Durga.', 'https://www.youtube.com/watch?v=FjIuK75Noyk'),
(8, 1, 'Invocation', 'आवाह्न', 'Awakening Saraswati.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'),
(8, 2, 'Pushpanjali', 'पुष्पांजलि', 'Flower offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'),
(8, 3, 'Aarti', 'आरती', 'Light offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w')
ON CONFLICT (puja_id, step_order) DO NOTHING;

-- -------------------------------------------------------
-- RESOURCES (Safe)
-- -------------------------------------------------------
INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable) VALUES
(1, 'Ganesh Puja Manual (PDF)', 'PDF', 'https://archive.org/details/dli.ministry.04644/page/n5/mode/2up', TRUE),
(3, 'Durga Puja Manual (PDF)', 'PDF', 'https://archive.org/details/DurgapujaPaddhati/page/n1/mode/2up', TRUE),
(8, 'Saraswati Puja Manual (PDF)', 'PDF', 'https://archive.org/details/saraswati-puja-paddhati-2020/page/n1/mode/2up', TRUE)
ON CONFLICT (puja_id, title) DO NOTHING;
