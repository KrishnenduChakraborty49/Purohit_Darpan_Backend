-- ============================================================
-- Purohit Darpan - Safe Seed Data (Idempotent Assets)
-- ============================================================

-- -------------------------------------------------------
-- ADMIN USER (Safe)
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, full_name, role, is_active, notifications_enabled)
SELECT 'admin', 'admin@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Platform Admin', 'ADMIN', TRUE, TRUE
WHERE NOT EXISTS (SELECT 1 FROM users WHERE username = 'admin');

INSERT INTO users (username, email, password_hash, full_name, role, is_active, notifications_enabled)
SELECT 'guru_sharma', 'guru@purohitdarpan.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2', 'Pt. Rajesh Sharma', 'MENTOR', TRUE, TRUE
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
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/ganesh.png', is_active = TRUE WHERE id = 1;
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/laxmi.png', is_active = TRUE WHERE id = 2;
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/durga.png', is_active = TRUE WHERE id = 3;
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/saraswati.png', is_active = TRUE WHERE id = 8;

-- Safely Insert if they do not exist
INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 1, 'Ganesh Puja', 'गणेश पूजा', 'Foundational ritual for removing obstacles.', 60, 'BEGINNER', 'Vighnaharta', 'https://purohit-darpan-backend-q7b6.onrender.com/images/ganesh.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 1);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 2, 'Lakshmi Puja', 'लक्ष्मी पूजा', 'Worship for wealth and prosperity.', 90, 'BEGINNER', 'Wealth', 'https://purohit-darpan-backend-q7b6.onrender.com/images/laxmi.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 2);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 3, 'Durga Puja', 'दुर्गा पूजा', 'Worship of the Divine Mother for victory.', 300, 'ADVANCED', 'Shakti', 'https://purohit-darpan-backend-q7b6.onrender.com/images/durga.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 3);

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 8, 'Saraswati Puja', 'सरस्वती पूजा', 'Worship of Knowledge and Arts.', 60, 'BEGINNER', 'Knowledge', 'https://purohit-darpan-backend-q7b6.onrender.com/images/saraswati.png', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 8);

-- Shiv Puja
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/shiv_closeup.jpg', is_active = TRUE WHERE id = 9;

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 9, 'Shiv Puja', 'शिव पूजा', 'Worship of Lord Mahadev — the destroyer and transformer. Attain blessings, peace and liberation.', 90, 'INTERMEDIATE', 'Shaivism', 'https://purohit-darpan-backend-q7b6.onrender.com/images/shiv_closeup.jpg', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 9);


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

-- Shiv Puja — 1 step
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 9, 1, 'Shiv Puja Mantra', 'शिव पूजा मंत्र', 'শিব পূজার মন্ত্র', 'Sacred mantras and complete Shiv Puja vidhi with Panchamrita abhishek.', 'https://www.youtube.com/watch?v=vDC-zR9X6mw'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 9 AND step_order = 1);



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

-- Shiv Puja Paddhati
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Shiv_Puja_Paddhati.pdf', is_downloadable = TRUE
WHERE puja_id = 9 AND title = 'Shiv Puja Paddhati';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 9, 'Shiv Puja Paddhati', 'PDF', 'https://purohit-darpan-backend-q7b6.onrender.com/pdfs/Shiv_Puja_Paddhati.pdf', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 9 AND title = 'Shiv Puja Paddhati');


-- -------------------------------------------------------
-- LINK PDF RESOURCES TO PUJA STEPS (Required for Study PDF tab)
-- PostgreSQL UPDATE...FROM join syntax to set pdf_resource_id on every step
-- -------------------------------------------------------
UPDATE puja_steps ps
SET pdf_resource_id = r.id
FROM resources r
WHERE r.puja_id = ps.puja_id
  AND r.resource_type = 'PDF';



-- -------------------------------------------------------
-- KALI PUJA (Shyama Puja - Safe Seed)
-- -------------------------------------------------------
UPDATE pujas SET thumbnail_url = 'https://purohit-darpan-backend-q7b6.onrender.com/images/kali_closeup.jpg', is_active = TRUE WHERE id = 10;

INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 10, 'Kali Puja', '???? ????', 'Complete ritual procedure for Kartik Amavasya Shyama Puja - invocation, shodashopachara worship, pushpanjali, and midnight arati.', 180, 'ADVANCED', 'Shakti', 'https://purohit-darpan-backend-q7b6.onrender.com/images/kali_closeup.jpg', TRUE

-- Kali Puja (ID: 10)
INSERT INTO pujas (id, name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, is_active)
SELECT 10, 'Kali Puja', 'শ্রীশ্রী দক্ষিণকালী পূজা', 'Complete ritual procedure for Kartik Amavasya Shyama Puja - Shodashopachara Puja and Tantrokto Home.', 180, 'ADVANCED', 'Shakti', '/images/kali_closeup.jpg', TRUE
WHERE NOT EXISTS (SELECT 1 FROM pujas WHERE id = 10 OR LOWER(name) LIKE '%kali%');

-- Remove any old steps with step_order > 2 for Kali Puja
DELETE FROM user_puja_progress WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM video_bookmarks WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM user_highlights WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM user_step_notes WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM step_mantras WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM step_samagri WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = 10 AND step_order > 2);
DELETE FROM puja_steps WHERE puja_id = 10 AND step_order > 2;

-- Step 1: Shodashopachara Puja
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 10, 1, 'Shodashopachara Puja', 'षोडशोपचार पूजा', 'ষোড়শোপচার পূজা', '<h3>ষোড়শোপচার পূজা (Shodashopachara Puja)</h3><p>মা দক্ষিণকালিকার উদ্দেশ্যে ষোড়শ উপাচারে যথাবিধি পূজা নিবেদন — আসন, স্বাগত, পদ্য, অর্ঘ্য, আচমনীয়, স্নানীয়, বসন, ভূষণ, গন্ধ, পুষ্প, ধূপ, দীপ, নৈবেদ্য, পানীয় ও তাম্বুল প্রদান।</p><div class="bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2"><p class="text-orange-300 font-semibold">পুষ্প ও চন্দন নিবেদন মন্ত্র:</p><p class="italic text-orange-200">ওঁ রক্তচন্দন সংমিশ্রং রক্তপুষ্পং মনোহরম্। কাল্যৈ দত্তং ময়া দেব্যৈ গৃহাণ পরমেশ্বরী॥</p></div>', 'https://youtu.be/N4wpFi0iyxw?si=ca12IbkVCK1B479I'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 10 AND step_order = 1);

UPDATE puja_steps
SET title = 'Shodashopachara Puja',
    title_devanagari = 'षोडशोपचार पूजा',
    title_bengali = 'ষোড়শোপচার পূজা',
    description = '<h3>ষোড়শোপচার পূজা (Shodashopachara Puja)</h3><p>মা দক্ষিণকালিকার উদ্দেশ্যে ষোড়শ উপাচারে যথাবিধি পূজা নিবেদন — আসন, স্বাগত, পদ্য, অর্ঘ্য, আচমনীয়, স্নানীয়, বসন, ভূষণ, গন্ধ, পুষ্প, ধূপ, দীপ, নৈবেদ্য, পানীয় ও তাম্বুল প্রদান।</p><div class="bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2"><p class="text-orange-300 font-semibold">পুষ্প ও চন্দন নিবেদন মন্ত্র:</p><p class="italic text-orange-200">ওঁ রক্তচন্দন সংমিশ্রং রক্তপুষ্পং মনোহরম্। কাল্যৈ দত্তং ময়া দেব্যৈ গৃহাণ পরমেশ্বরী॥</p></div>',
    video_url = 'https://youtu.be/N4wpFi0iyxw?si=ca12IbkVCK1B479I'
WHERE puja_id = 10 AND step_order = 1;

-- Step 2: Tantrokto Home
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, description, video_url)
SELECT 10, 2, 'Tantrokto Home', 'तन्त्रोक्त होम', 'তন্ত্রোক্ত হোম', '<h3>তন্ত্রোক্ত হোম (Tantrokto Home)</h3><p>দেবী কালীর প্রতি তান্ত্রিক বিধান অনুযায়ী হোম ও যজ্ঞবিধি — স্থণ্ডিল নির্মাণ, অগ্নিসংস্কার, বিশ্বামিত্র গোত্রীয় যজ্ঞভুক্ অগ্নি স্থাপন, কুশণ্ডিকা, আজ্যভাগাহুতি, দেবী কালীর সিদ্ধ মূলমন্ত্রে আহুতি এবং মহাব্যাহৃতি ও পূর্ণাহুতি প্রদান।</p><div class="bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2"><p class="text-orange-300 font-semibold">অগ্নি আবাহন মন্ত্র:</p><p class="italic text-orange-200">ওঁ অগ্নিং দূতং পুরোধায় হব্যবাহমুপব্রুবে। দেবাঁ আসাদয়াদিহ॥ ওঁ যজ্ঞভুগগ্নয়ে নমঃ।</p><p class="text-orange-300 font-semibold mt-2">দেবী কালীর হোম আহুতি মূলমন্ত্র:</p><p class="italic text-orange-200">ওঁ ক্রীঁ দক্ষিণকালিকায়ৈ স্বাহা (ॐ क्रीं काल्यै स्वाहा) — ১০৮ বার যথাবিধি ঘৃতাহুতি।</p></div>', 'https://youtu.be/62qCR6aaUbw?si=Nr_P-AZXnHcSkpRE'
WHERE NOT EXISTS (SELECT 1 FROM puja_steps WHERE puja_id = 10 AND step_order = 2);

UPDATE puja_steps
SET title = 'Tantrokto Home',
    title_devanagari = 'तन्त्रोक्त होम',
    title_bengali = 'তন্ত্রোক্ত হোম',
    description = '<h3>তন্ত্রোক্ত হোম (Tantrokto Home)</h3><p>দেবী কালীর প্রতি তান্ত্রিক বিধান অনুযায়ী হোম ও যজ্ঞবিধি — স্থণ্ডিল নির্মাণ, অগ্নিসংস্কার, বিশ্বামিত্র গোত্রীয় যজ্ঞভুক্ অগ্নি স্থাপন, কুশণ্ডিকা, আজ্যভাগাহুতি, দেবী কালীর সিদ্ধ মূলমন্ত্রে আহুতি এবং মহাব্যাহৃতি ও পূর্ণাহুতি প্রদান।</p><div class="bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2"><p class="text-orange-300 font-semibold">অগ্নি আবাহন মন্ত্র:</p><p class="italic text-orange-200">ওঁ অগ্নিং দূতং পুরোধায় হব্যবাহমুপব্রুবে। দেবাঁ আসাদয়াদিহ॥ ওঁ যজ্ঞভুগগ্নয়ে নমঃ।</p><p class="text-orange-300 font-semibold mt-2">দেবী কালীর হোম আহুতি মূলমন্ত্র:</p><p class="italic text-orange-200">ওঁ ক্রীঁ দক্ষিণকালিকায়ৈ স্বাহা (ॐ क्रीं काल्यै स्वाहा) — ১০৮ বার যথাবিধি ঘৃতাহুতি।</p></div>',
    video_url = 'https://youtu.be/62qCR6aaUbw?si=Nr_P-AZXnHcSkpRE'
WHERE puja_id = 10 AND step_order = 2;

-- Kali Puja Paddhati Interactive Guide
UPDATE resources SET file_url = 'https://purohit-darpan-backend-q7b6.onrender.com/docs/kali_puja_guide.html', is_downloadable = TRUE
WHERE puja_id = 10 AND title LIKE '%কালী%';

INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable)
SELECT 10, 'শ্রীশ্রীদক্ষিণকালী পূজা পদ্ধতি সম্পূর্ণ গাইড', 'DOCX', 'https://purohit-darpan-backend-q7b6.onrender.com/docs/kali_puja_guide.html', TRUE
WHERE NOT EXISTS (SELECT 1 FROM resources WHERE puja_id = 10);

-- Link Kali Guide Resource to Steps
UPDATE puja_steps ps
SET pdf_resource_id = r.id
FROM resources r
WHERE r.puja_id = 10
  AND ps.puja_id = 10;
