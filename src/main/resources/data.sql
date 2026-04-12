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

-- Ganesh Puja — 1 step
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 1, 1, 'Ganesh Puja Procedure', 'गणेश पूजा विधि', 'গণেশ পূজা বিধি', 'Complete procedure of Ganesh Puja — invocation, mantras, offerings and aarti.', 'https://www.youtube.com/watch?v=DUIrds34eeg'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 1 AND step_order = 1);

-- Lakshmi Puja — 2 steps
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 2, 1, 'Laxmi Puja Mantra', 'लक्ष्मी पूजा मंत्र', 'লক্ষ্মী পূজার মন্ত্র', 'Sacred mantras chanted during Laxmi Puja for invoking the goddess of wealth.', 'https://www.youtube.com/watch?v=knY4cUlCNXc'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 2 AND step_order = 1);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 2, 2, 'Laxmi Panchali', 'लक्ष्मी पांचाली', 'লক্ষ্মীর পাঁচালি', 'Recitation of Laxmi Panchali — devotional hymns in praise of Goddess Laxmi.', 'https://www.youtube.com/watch?v=dsWdH8-U8u8'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 2 AND step_order = 2);

-- Durga Puja — 6 steps (Sasthi to Dashami)
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 1, 'Sasthi', 'षष्ठी', 'ষষ্ঠী', 'Sasthi Puja — Invocation and welcome of Goddess Durga on the sixth day.', 'https://www.youtube.com/watch?v=JAl7pjMa2q8'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 1);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 2, 'Saptami', 'सप्तमी', 'সপ্তমী', 'Saptami Puja — Worship of Goddess Durga on the seventh day with Nabapatrika snan.', 'https://www.youtube.com/watch?v=5u-uulot9X4'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 2);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 3, 'Aastami', 'अष्टमी', 'অষ্টমী', 'Aastami Puja — The most auspicious day, Pushpanjali and Kumari Puja performed.', 'https://www.youtube.com/watch?v=yQt_GhyWOXc'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 3);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 4, 'Sandhi Puja', 'सन्धि पूजा', 'সন্ধি পূজা', 'Sandhi Puja — The junction between Aastami and Navami, most sacred 48-minute window.', 'https://www.youtube.com/watch?v=Ke7NDOzGSXM'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 4);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 5, 'Navami', 'नवमी', 'নবমী', 'Navami Puja — Homa and hawan offered to Goddess Durga on the ninth day.', 'https://www.youtube.com/watch?v=roS3QBV_xyU'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 5);

INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 3, 6, 'Dashami', 'दशमी', 'দশমী', 'Dashami — Visarjan of Goddess Durga, bidding farewell on the tenth day.', 'https://www.youtube.com/watch?v=uBr9f0tMrGs'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 3 AND step_order = 6);

-- Saraswati Puja — 1 step
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 8, 1, 'Saraswati Puja Mantra', 'सरस्वती पूजा मंत्र', 'সরস্বতী পূজার মন্ত্র', 'Sacred mantras and complete procedure of Saraswati Puja — worship of the goddess of knowledge.', 'https://www.youtube.com/watch?v=8aN-DCABQcc'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 8 AND step_order = 1);



-- -------------------------------------------------------
-- RESOURCES — Paddhati PDFs (Self-Hosted on Render Backend)
-- -------------------------------------------------------
-- Ganesh Puja Paddhati
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Ganesh_Puja_Paddhati.pdf', is_downloadable = TRUE
WHERE puja_id = 1 AND title = 'Ganesh Puja Paddhati';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 1, 'Ganesh Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Ganesh_Puja_Paddhati.pdf', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 1 AND title = 'Ganesh Puja Paddhati');

-- Lakshmi Puja Paddhati
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Laxmi_Puja_Paddhati.pdf', is_downloadable = TRUE
WHERE puja_id = 2 AND title = 'Lakshmi Puja Paddhati';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 2, 'Lakshmi Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Laxmi_Puja_Paddhati.pdf', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 2 AND title = 'Lakshmi Puja Paddhati');

-- Durga Puja Paddhati
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Purohit_Darpan_Durgapuja_Paddhati.pdf', is_downloadable = TRUE
WHERE puja_id = 3 AND title = 'Durga Puja Paddhati';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 3, 'Durga Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Purohit_Darpan_Durgapuja_Paddhati.pdf', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 3 AND title = 'Durga Puja Paddhati');

-- Saraswati Puja Paddhati
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Saraswati_Puja_Paddhati.pdf', is_downloadable = TRUE
WHERE puja_id = 8 AND title = 'Saraswati Puja Paddhati';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 8, 'Saraswati Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Saraswati_Puja_Paddhati.pdf', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 8 AND title = 'Saraswati Puja Paddhati');


-- -------------------------------------------------------
-- LINK PDF RESOURCES TO PUJA STEPS (Required for Study PDF tab)
-- PostgreSQL UPDATE...FROM join syntax to set pdf_resource_id on every step
-- -------------------------------------------------------
UPDATE puja_steps ps
SET pdf_resource_id = r.id
FROM resources r
WHERE r.puja_id = ps.puja_id
  AND r.resource_type = 'PDF';

