-- ============================================================
-- Purohit Darpan - Safe Seed Data (World-Class Aesthetic Master)
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
-- PUJAS (Safe with High-Quality Thumbnails)
-- -------------------------------------------------------
INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active) VALUES
(1, 'Ganesh Puja', 'गणेश पूजा', 'Foundational ritual for removing obstacles.', 60, 'BEGINNER', 'Vighnaharta', 'https://images.unsplash.com/photo-1567591414240-e09197063f25?auto=format&fit=crop&q=80&w=800', TRUE),
(2, 'Lakshmi Puja', 'लक्ष्मी पूजा', 'Worship for wealth and prosperity.', 90, 'BEGINNER', 'Wealth', 'https://images.unsplash.com/photo-1605030270566-bf966dd26781?auto=format&fit=crop&q=80&w=800', TRUE),
(3, 'Durga Puja', 'दुर्गा पूजा', 'Worship of the Divine Mother for victory.', 300, 'ADVANCED', 'Shakti', 'https://images.unsplash.com/photo-1590494056285-e369b76c703b?auto=format&fit=crop&q=80&w=800', TRUE),
(8, 'Saraswati Puja', 'सरस्वती पूजा', 'Worship of Knowledge and Arts.', 60, 'BEGINNER', 'Knowledge', 'https://images.unsplash.com/photo-1620641788421-7a1c342ea42e?auto=format&fit=crop&q=80&w=800', TRUE)
ON CONFLICT (id) DO UPDATE SET thumbnail_url = EXCLUDED.thumbnail_url;

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
