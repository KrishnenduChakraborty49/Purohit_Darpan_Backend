-- ============================================================
-- Purohit Darpan - Safe Seed Data (Idempotent Assets)
-- ============================================================

-- -------------------------------------------------------
-- ADMIN USER (Safe)
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, full_name, role, is_active)
SELECT 'admin', 'admin@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Platform Admin', 'ADMIN', TRUE
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');

INSERT INTO users (username, email, password_hash, full_name, role, is_active)
SELECT 'guru_sharma', 'guru@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Pt. Rajesh Sharma', 'MENTOR', TRUE
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'guru_sharma');


-- -------------------------------------------------------
-- SAMAGRI (Safe)
-- -------------------------------------------------------
INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Kalash', 'कलश', 'Sacred water pot'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Kalash');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Mango Leaves', 'आम के पत्ते', 'Fresh mango leaves'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Mango Leaves');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Coconut', 'नारियल', 'Sacred coconut'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Coconut');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Roli', 'रोली', 'Red vermillion'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Roli');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Akshat', 'अक्षत', 'Unbroken rice'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Akshat');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Incense', 'अगरबत्ती', 'Purifying sticks'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Incense');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Ghee Diya', 'घी दीया', 'Sacred lamp'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Ghee Diya');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Flowers', 'पुष्प', 'Fresh offerings'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Flowers');

INSERT INTO samagri (name, name_devanagari, description)
SELECT 'Gangajal', 'गंगाजल', 'Holy water'
WHERE NOT EXISTS (SELECT 1 FROM samagri WHERE name = 'Gangajal');


-- -------------------------------------------------------
-- PUJAS (Custom User-Provided Thumbnails)
-- -------------------------------------------------------
-- Safely Update existing if they exist
UPDATE pujas SET thumbnail_url = '/images/ganesh.png', is_active = TRUE WHERE id = 1;
UPDATE pujas SET thumbnail_url = '/images/laxmi.png', is_active = TRUE WHERE id = 2;
UPDATE pujas SET thumbnail_url = '/images/durga.png', is_active = TRUE WHERE id = 3;
UPDATE pujas SET thumbnail_url = '/images/saraswati.png', is_active = TRUE WHERE id = 8;

-- Safely Insert if they do not exist
INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 1, 'Ganesh Puja', 'गणेश पूजा', 'Foundational ritual for removing obstacles.', 60, 'BEGINNER', 'Vighnaharta', '/images/ganesh.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 1);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 2, 'Lakshmi Puja', 'लक्ष्मी पूजा', 'Worship for wealth and prosperity.', 90, 'BEGINNER', 'Wealth', '/images/laxmi.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 2);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 3, 'Durga Puja', 'दुर्गा पूजा', 'Worship of the Divine Mother for victory.', 300, 'ADVANCED', 'Shakti', '/images/durga.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 3);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 8, 'Saraswati Puja', 'सरस्वती पूजा', 'Worship of Knowledge and Arts.', 60, 'BEGINNER', 'Knowledge', '/images/saraswati.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 8);


-- -------------------------------------------------------
-- PUJA STEPS (Safe)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url)
SELECT 1, 1, 'Achamana', 'आचमन', 'Ritual purification.', 'https://www.youtube.com/watch?v=W0SclE-69S8'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 1 AND step_order = 1);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url)
SELECT 3, 1, 'Invocation', 'आवाह्न', 'Awakening Durga.', 'https://www.youtube.com/watch?v=FjIuK75Noyk'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 1);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url)
SELECT 8, 1, 'Invocation', 'आवाह्न', 'Awakening Saraswati.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 8 AND step_order = 1);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url)
SELECT 8, 2, 'Pushpanjali', 'पुष्पांजलि', 'Flower offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 8 AND step_order = 2);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url)
SELECT 8, 3, 'Aarti', 'आरती', 'Light offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 8 AND step_order = 3);


-- -------------------------------------------------------
-- RESOURCES (Safe)
-- -------------------------------------------------------
INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 1, 'Ganesh Puja Manual (PDF)', 'PDF', 'https://archive.org/details/dli.ministry.04644/page/n5/mode/2up', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 1 AND title = 'Ganesh Puja Manual (PDF)');

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 3, 'Durga Puja Manual (PDF)', 'PDF', 'https://archive.org/details/DurgapujaPaddhati/page/n1/mode/2up', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 3 AND title = 'Durga Puja Manual (PDF)');

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 8, 'Saraswati Puja Manual (PDF)', 'PDF', 'https://archive.org/details/saraswati-puja-paddhati-2020/page/n1/mode/2up', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 8 AND title = 'Saraswati Puja Manual (PDF)');
