-- ============================================================
-- Purohit Darpan - Seed Data
-- Festivals 2025-2026, Sample Pujas, Mantras, Samagri
-- ============================================================

-- -------------------------------------------------------
-- ADMIN USER
-- password: Admin@123 (BCrypt hash)
-- -------------------------------------------------------
INSERT INTO users (username, email, password_hash, full_name, role, is_active)
VALUES
('admin', 'admin@purohitdarpan.com',
 '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2',
 'Platform Admin', 'ADMIN', TRUE),
('guru_sharma', 'guru@purohitdarpan.com',
 '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2',
 'Pt. Rajesh Sharma', 'MENTOR', TRUE),
('arjun_student', 'arjun@example.com',
 '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMlLLIezHSmVBYGVa5RkBHG0q2',
 'Arjun Mishra', 'STUDENT', TRUE);

-- -------------------------------------------------------
-- SAMAGRI (ritual items)
-- -------------------------------------------------------
INSERT INTO samagri (name, name_devanagari, description) VALUES
('Kalash', 'à¤•à¤²à¤¶', 'Sacred water pot, symbolizes deity residence'),
('Mango Leaves', 'à¤†à¤® à¤•à¥‡ à¤ªà¤¤à¥à¤¤à¥‡', 'Fresh mango leaves placed on Kalash'),
('Coconut', 'à¤¨à¤¾à¤°à¤¿à¤¯à¤²', 'Placed on top of Kalash, symbolizes Lord Shiva'),
('Roli (Kumkum)', 'à¤°à¥‹à¤²à¥€ / à¤•à¥à¤®à¤•à¥à¤®', 'Red vermillion powder for tilak'),
('Akshat (Rice)', 'à¤…à¤•à¥à¤·à¤¤', 'Unbroken rice grains offered during puja'),
('Incense Sticks (Agarbatti)', 'à¤…à¤—à¤°à¤¬à¤¤à¥à¤¤à¥€', 'Used to purify the atmosphere'),
('Ghee Diya', 'à¤˜à¥€ à¤¦à¥€à¤¯à¤¾', 'Earthen lamp with pure ghee wick'),
('Flowers (Pushpa)', 'à¤ªà¥à¤·à¥à¤ª', 'Fresh flowers for deity offering'),
('Dhoti (White Cloth)', 'à¤§à¥‹à¤¤à¥€', 'White cotton cloth for pandit to wear'),
('Paan Patta', 'à¤ªà¤¾à¤¨ à¤ªà¤¤à¥à¤¤à¤¾', 'Betel leaf for offering'),
('Supari', 'à¤¸à¥à¤ªà¤¾à¤°à¥€', 'Areca nut, auspicious offering'),
('Camphor (Kapoor)', 'à¤•à¤ªà¥‚à¤°', 'Used in aarti for illumination'),
('Gangajal', 'à¤—à¤‚à¤—à¤¾à¤œà¤²', 'Holy water from River Ganga'),
('Chandan (Sandalwood)', 'à¤šà¤‚à¤¦à¤¨', 'Sandalwood paste for tilak and fragrance'),
('Turmeric (Haldi)', 'à¤¹à¤²à¥à¤¦à¥€', 'Auspicious yellow powder'),
('Panchamrit', 'à¤ªà¤‚à¤šà¤¾à¤®à¥ƒà¤¤', 'Mixture of milk, curd, honey, sugar, ghee'),
('Tulsi Leaves', 'à¤¤à¥à¤²à¤¸à¥€ à¤ªà¤¤à¥à¤¤à¥‡', 'Sacred basil leaves, especially for Vishnu puja'),
('Lotus Flower', 'à¤•à¤®à¤²', 'Sacred flower of Lakshmi and Vishnu'),
('Sindoor', 'à¤¸à¤¿à¤‚à¤¦à¥‚à¤°', 'Vermillion for married women during puja'),
('Dhoop', 'à¤§à¥‚à¤ª', 'Resin incense for purification');

-- -------------------------------------------------------
-- PUJAS
-- -------------------------------------------------------
INSERT INTO pujas (name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, created_by) VALUES
('Ganesh Puja', 'à¤—à¤£à¥‡à¤¶ à¤ªà¥‚à¤œà¤¾',
 'The foundational puja performed at the beginning of every ritual. Lord Ganesha is the remover of obstacles and is invoked first to bless any endeavor.',
 60, 'BEGINNER', 'Vighnaharta', '/images/ganesh-puja.jpg', 1),

('Lakshmi Puja', 'à¤²à¤•à¥à¤·à¥à¤®à¥€ à¤ªà¥‚à¤œà¤¾',
 'Worship of Goddess Lakshmi, the deity of wealth and prosperity. Performed especially on Diwali and Fridays.',
 90, 'BEGINNER', 'Wealth', '/images/lakshmi-puja.jpg', 1),

('Satyanarayan Katha', 'à¤¸à¤¤à¥à¤¯à¤¨à¤¾à¤°à¤¾à¤¯à¤£ à¤•à¤¥à¤¾',
 'A complete Vishnu puja with the reading of Satyanarayan Vrat Katha. Performed on Purnima and for special occasions.',
 180, 'INTERMEDIATE', 'Vrat', '/images/satyanarayan.jpg', 1),

('Durga Puja', 'à¤¦à¥à¤°à¥à¤—à¤¾ à¤ªà¥‚à¤œà¤¾',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Worship of the Divine Mother for strength, intellect, and prosperity.',
 300, 'ADVANCED', 'Shakti', '/images/durga-puja.jpg', 1),

('Saraswati Puja', 'à¤¸à¤°à¤¸à¥à¤µà¤¤à¥€ à¤ªà¥‚à¤œà¤¾',
 'Worship of the Goddess of Knowledge, Music, Art, and Wisdom. Especially performed by students and artists on Vasant Panchami.',
 60, 'BEGINNER', 'Wisdom', '/images/saraswati-puja.jpg', 1);

-- -------------------------------------------------------
-- MANTRAS (Devanagari)
-- -------------------------------------------------------
INSERT INTO mantras (shlok_text, transliteration, word_meanings, source_text) VALUES

-- Ganesh Vandana
('à¤µà¤•à¥à¤°à¤¤à¥à¤£à¥à¤¡ à¤®à¤¹à¤¾à¤•à¤¾à¤¯ à¤¸à¥‚à¤°à¥à¤¯à¤•à¥‹à¤Ÿà¤¿ à¤¸à¤®à¤ªà¥à¤°à¤­à¥¤\nà¤¨à¤¿à¤°à¥à¤µà¤¿à¤˜à¥à¤¨à¤‚ à¤•à¥à¤°à¥ à¤®à¥‡ à¤¦à¥‡à¤µ à¤¸à¤°à¥à¤µà¤•à¤¾à¤°à¥à¤¯à¥‡à¤·à¥ à¤¸à¤°à¥à¤µà¤¦à¤¾à¥¥',
 'Vakratunda Mahakaya Suryakoti Samaprabha\nNirvighnam Kuru Me Deva Sarvakaryeshu Sarvada',
 '[{"word":"à¤µà¤•à¥à¤°à¤¤à¥à¤£à¥à¤¡","meaning":"One with curved trunk","role":"Nominative"},{"word":"à¤®à¤¹à¤¾à¤•à¤¾à¤¯","meaning":"Mighty-bodied","role":"Nominative"},{"word":"à¤¸à¥‚à¤°à¥à¤¯à¤•à¥‹à¤Ÿà¤¿","meaning":"Crores of suns","role":"Nominative"},{"word":"à¤¸à¤®à¤ªà¥à¤°à¤­","meaning":"Equal in radiance","role":"Nominative"},{"word":"à¤¨à¤¿à¤°à¥à¤µà¤¿à¤˜à¥à¤¨à¤®à¥","meaning":"Without obstacles","role":"Accusative"},{"word":"à¤•à¥à¤°à¥","meaning":"Make / grant","role":"Verb, Imperative"},{"word":"à¤¸à¤°à¥à¤µà¤•à¤¾à¤°à¥à¤¯à¥‡à¤·à¥","meaning":"In all works/tasks","role":"Locative plural"},{"word":"à¤¸à¤°à¥à¤µà¤¦à¤¾","meaning":"Always","role":"Indeclinable"}]',
 'Traditional Ganesh Vandana'),

-- Lakshmi Mantra
('à¥ à¤¶à¥à¤°à¥€à¤‚ à¤¹à¥à¤°à¥€à¤‚ à¤¶à¥à¤°à¥€à¤‚ à¤•à¤®à¤²à¥‡ à¤•à¤®à¤²à¤¾à¤²à¤¯à¥‡ à¤ªà¥à¤°à¤¸à¥€à¤¦ à¤ªà¥à¤°à¤¸à¥€à¤¦à¥¤\nà¤¶à¥à¤°à¥€à¤‚ à¤¹à¥à¤°à¥€à¤‚ à¤¶à¥à¤°à¥€à¤‚ à¥ à¤®à¤¹à¤¾à¤²à¤•à¥à¤·à¥à¤®à¥à¤¯à¥ˆ à¤¨à¤®à¤ƒà¥¥',
 'Om Shrim Hrim Shrim Kamale Kamalaalaye Prasida Prasida\nShrim Hrim Shrim Om Mahalakshmyai Namah',
 '[{"word":"à¥","meaning":"Primordial sacred syllable","role":"Invocation"},{"word":"à¤¶à¥à¤°à¥€à¤‚","meaning":"Bija mantra of Lakshmi","role":"Bija"},{"word":"à¤¹à¥à¤°à¥€à¤‚","meaning":"Bija of Maya/Shakti","role":"Bija"},{"word":"à¤•à¤®à¤²à¥‡","meaning":"O Lotus-seated one","role":"Vocative"},{"word":"à¤ªà¥à¤°à¤¸à¥€à¤¦","meaning":"Be pleased, grace us","role":"Verb, Imperative"},{"word":"à¤®à¤¹à¤¾à¤²à¤•à¥à¤·à¥à¤®à¥à¤¯à¥ˆ","meaning":"To Maha Lakshmi","role":"Dative"},{"word":"à¤¨à¤®à¤ƒ","meaning":"I bow / Salutation","role":"Indeclinable"}]',
 'Sri Sukta, Rigveda Khila'),

-- Satyanarayan Mantra
('à¥ à¤¨à¤®à¥‹ à¤­à¤—à¤µà¤¤à¥‡ à¤µà¤¾à¤¸à¥à¤¦à¥‡à¤µà¤¾à¤¯à¥¤',
 'Om Namo Bhagavate Vasudevaya',
 '[{"word":"à¥","meaning":"Sacred syllable, the absolute","role":"Invocation"},{"word":"à¤¨à¤®à¥‹","meaning":"Salutation","role":"Indeclinable"},{"word":"à¤­à¤—à¤µà¤¤à¥‡","meaning":"To the Divine Lord","role":"Dative"},{"word":"à¤µà¤¾à¤¸à¥à¤¦à¥‡à¤µà¤¾à¤¯","meaning":"To Vasudeva (Krishna/Vishnu)","role":"Dative"}]',
 'Vishnu Purana, Dwadashakshari Mantra'),

-- Shiva Mantra (Panchakshara)
('à¥ à¤¨à¤®à¤ƒ à¤¶à¤¿à¤µà¤¾à¤¯à¥¤',
 'Om Namah Shivaya',
 '[{"word":"à¥","meaning":"Primordial sound, the absolute truth","role":"Invocation"},{"word":"à¤¨à¤®à¤ƒ","meaning":"Salutation, I bow","role":"Indeclinable"},{"word":"à¤¶à¤¿à¤µà¤¾à¤¯","meaning":"To Shiva, the auspicious one","role":"Dative"}]',
 'Krishna Yajurveda, Taittiriya Samhita 4.5.1'),

-- Gayatri Mantra
('à¥ à¤­à¥‚à¤°à¥à¤­à¥à¤µà¤ƒ à¤¸à¥à¤µà¤ƒà¥¤\nà¤¤à¤¤à¥à¤¸à¤µà¤¿à¤¤à¥à¤°à¥à¤µà¤°à¥‡à¤£à¥à¤¯à¤‚ à¤­à¤°à¥à¤—à¥‹ à¤¦à¥‡à¤µà¤¸à¥à¤¯ à¤§à¥€à¤®à¤¹à¤¿à¥¤\nà¤§à¤¿à¤¯à¥‹ à¤¯à¥‹ à¤¨à¤ƒ à¤ªà¥à¤°à¤šà¥‹à¤¦à¤¯à¤¾à¤¤à¥à¥¥',
 'Om Bhur Bhuvah Svah\nTat Savitur Varenyam Bhargo Devasya Dhimahi\nDhiyo Yo Nah Prachodayat',
 '[{"word":"à¥","meaning":"Pranava, the primordial sound","role":"Invocation"},{"word":"à¤­à¥‚à¤ƒ","meaning":"Earth","role":"Vyahrti"},{"word":"à¤­à¥à¤µà¤ƒ","meaning":"Atmosphere","role":"Vyahrti"},{"word":"à¤¸à¥à¤µà¤ƒ","meaning":"Heaven / Upper realms","role":"Vyahrti"},{"word":"à¤¤à¤¤à¥","meaning":"That (transcendent)","role":"Pronoun"},{"word":"à¤¸à¤µà¤¿à¤¤à¥à¤ƒ","meaning":"Of the Sun / Divine illuminator","role":"Genitive"},{"word":"à¤µà¤°à¥‡à¤£à¥à¤¯à¤®à¥","meaning":"Most excellent, most worshipful","role":"Accusative"},{"word":"à¤­à¤°à¥à¤—à¤ƒ","meaning":"Radiance, purifying light","role":"Accusative"},{"word":"à¤¦à¥‡à¤µà¤¸à¥à¤¯","meaning":"Of the deity","role":"Genitive"},{"word":"à¤§à¥€à¤®à¤¹à¤¿","meaning":"Let us meditate","role":"Verb, Optative"},{"word":"à¤§à¤¿à¤¯à¤ƒ","meaning":"Intellects, faculties of understanding","role":"Accusative"},{"word":"à¤¯à¤ƒ","meaning":"Who","role":"Relative pronoun"},{"word":"à¤¨à¤ƒ","meaning":"Our","role":"Genitive"},{"word":"à¤ªà¥à¤°à¤šà¥‹à¤¦à¤¯à¤¾à¤¤à¥","meaning":"May he inspire/guide","role":"Verb, Optative"}]',
 'Rigveda 3.62.10'),

-- Durga Mantra
('à¤¯à¤¾ à¤¦à¥‡à¤µà¥€ à¤¸à¤°à¥à¤µà¤­à¥‚à¤¤à¥‡à¤·à¥ à¤¶à¤•à¥à¤¤à¤¿à¤°à¥‚à¤ªà¥‡à¤£ à¤¸à¤‚à¤¸à¥à¤¥à¤¿à¤¤à¤¾à¥¤\nà¤¨à¤®à¤¸à¥à¤¤à¤¸à¥à¤¯à¥ˆ à¤¨à¤®à¤¸à¥à¤¤à¤¸à¥à¤¯à¥ˆ à¤¨à¤®à¤¸à¥à¤¤à¤¸à¥à¤¯à¥ˆ à¤¨à¤®à¥‹ à¤¨à¤®à¤ƒà¥¥',
 'Ya Devi Sarvabhuteshu ShaktirÃºpena Samsthita\nNamastasyai Namastasyai Namastasyai Namo Namah',
 '[{"word":"à¤¯à¤¾","meaning":"Who (she who)","role":"Relative pronoun, feminine"},{"word":"à¤¦à¥‡à¤µà¥€","meaning":"The Goddess","role":"Nominative"},{"word":"à¤¸à¤°à¥à¤µà¤­à¥‚à¤¤à¥‡à¤·à¥","meaning":"In all beings","role":"Locative plural"},{"word":"à¤¶à¤•à¥à¤¤à¤¿à¤°à¥‚à¤ªà¥‡à¤£","meaning":"In the form of Shakti/power","role":"Instrumental"},{"word":"à¤¸à¤‚à¤¸à¥à¤¥à¤¿à¤¤à¤¾","meaning":"Abiding, established","role":"Past participle"},{"word":"à¤¨à¤®à¤ƒ","meaning":"Salutation","role":"Indeclinable"}]',
 'Durgasaptashati, Markandeya Purana'),

-- Kalash Sthapana Mantra
('à¤•à¤²à¤¶à¤¸à¥à¤¯ à¤®à¥à¤–à¥‡ à¤µà¤¿à¤·à¥à¤£à¥à¤°à¥à¤•à¤£à¥à¤ à¥‡ à¤°à¥à¤¦à¥à¤°à¤ƒ à¤¸à¤®à¤¾à¤¶à¥à¤°à¤¿à¤¤à¤ƒà¥¤\nà¤®à¥‚à¤²à¥‡ à¤¤à¤¤à¥à¤° à¤¸à¥à¤¥à¤¿à¤¤à¥‹ à¤¬à¥à¤°à¤¹à¥à¤®à¤¾ à¤®à¤§à¥à¤¯à¥‡ à¤®à¤¾à¤¤à¥ƒà¤—à¤£à¤¾à¤ƒ à¤¸à¥à¤®à¥ƒà¤¤à¤¾à¤ƒà¥¥',
 'Kalashasya Mukhe Vishnur Kanthe Rudrah Samashritah\nMule Tatra Sthito Brahma Madhye Matriganah Smritah',
 '[{"word":"à¤•à¤²à¤¶à¤¸à¥à¤¯","meaning":"Of the Kalash","role":"Genitive"},{"word":"à¤®à¥à¤–à¥‡","meaning":"In the mouth/opening","role":"Locative"},{"word":"à¤µà¤¿à¤·à¥à¤£à¥à¤ƒ","meaning":"Lord Vishnu","role":"Nominative"},{"word":"à¤•à¤£à¥à¤ à¥‡","meaning":"In the neck","role":"Locative"},{"word":"à¤°à¥à¤¦à¥à¤°à¤ƒ","meaning":"Lord Rudra/Shiva","role":"Nominative"},{"word":"à¤¸à¤®à¤¾à¤¶à¥à¤°à¤¿à¤¤à¤ƒ","meaning":"Has taken residence","role":"Past participle"},{"word":"à¤®à¥‚à¤²à¥‡","meaning":"At the base","role":"Locative"},{"word":"à¤¬à¥à¤°à¤¹à¥à¤®à¤¾","meaning":"Lord Brahma","role":"Nominative"},{"word":"à¤®à¤§à¥à¤¯à¥‡","meaning":"In the middle","role":"Locative"},{"word":"à¤®à¤¾à¤¤à¥ƒà¤—à¤£à¤¾à¤ƒ","meaning":"The Divine Mothers","role":"Nominative"}]',
 'Traditional Kalash Sthapana Mantra');

-- -------------------------------------------------------
-- PUJA STEPS - Ganesh Puja (puja_id = 1)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(1, 1, 'Ganesh Puja Mantra', 'à¤—à¤£à¥‡à¤¶ à¤ªà¥‚à¤œà¤¾ à¤®à¤¨à¥à¤¤à¥à¤°',
 '<h3>Ganesh Puja Mantra</h3>
<p>Begin by invoking the blessings of Lord Ganesha to remove all obstacles from your path.</p>
<ol>
  <li>Offer unbroken rice (akshat) and red flowers.</li>
  <li>Chant the traditional Ganesh mantra with pure devotion.</li>
</ol>',
 'https://www.youtube.com/embed/DUIrds34eeg',
 'We begin the puja by chanting the sacred Ganesh Puja mantra and offering flowers...');

-- -------------------------------------------------------
-- PUJA STEPS - Lakshmi Puja (puja_id = 2)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(2, 1, 'Puja Mantra', 'à¤ªà¥‚à¤œà¤¾ à¤®à¤¨à¥à¤¤à¥à¤°',
 '<h3>Puja Mantra - Invoking Goddess Lakshmi</h3><p>Chant the sacred mantras to invoke Goddess Lakshmi for wealth and prosperity.</p>',
 'https://www.youtube.com/embed/knY4cUlCNXc',
 'In this step we chant the sacred Lakshmi Puja mantras...'),

(2, 2, 'Panchali', 'à¤ªà¤¾à¤‚à¤šà¤¾à¤²à¥€',
 '<h3>Panchali - The Sacred Story</h3><p>Recite or listen to the Kojagari Lakshmi Vrat Katha (Panchali) which details the glory of the Goddess.</p>',
 'https://www.youtube.com/embed/dsWdH8-U8u8',
 'The Panchali describes the divine blessings of Goddess Lakshmi...');

-- -------------------------------------------------------
-- PUJA STEPS - Satyanarayan Puja (puja_id = 3)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(3, 1, 'Satyanarayan Puja Mantra Part 1', 'à¤¸à¤¤à¥à¤¯à¤¨à¤¾à¤°à¤¾à¤¯à¤£ à¤ªà¥‚à¤œà¤¾ à¤®à¤¨à¥à¤¤à¥à¤° à¤­à¤¾à¤— à¥§',
 '<h3>Satyanarayan Puja Mantra (Part 1)</h3><p>Begin the worship of Lord Shri Hari Vishnu with the foundational mantras and offerings.</p>',
 'https://www.youtube.com/embed/WKxIK_IMT98',
 'In the first part of the Satyanarayan Puja, we start with the purification and foundational mantras...'),

(3, 2, 'Satyanarayan Puja Mantra Part 2', 'à¤¸à¤¤à¥à¤¯à¤¨à¤¾à¤°à¤¾à¤¯à¤£ à¤ªà¥‚à¤œà¤¾ à¤®à¤¨à¥à¤¤à¥à¤° à¤­à¤¾à¤— à¥¨',
 '<h3>Satyanarayan Puja Mantra (Part 2)</h3><p>Continue the profound worship and offerings to the Lord of Truth.</p>',
 'https://www.youtube.com/embed/uyEsWHJEjsQ',
 'Moving forward in the puja, we continue the sacred offerings to Lord Vishnu...'),

(3, 3, 'Satyanarayan Broto Kotha', 'à¤¸à¤¤à¥à¤¯à¤¨à¤¾à¤°à¤¾à¤¯à¤£ à¤µà¥à¤°à¤¤ à¤•à¤¥à¤¾',
 '<h3>Satyanarayan Broto Kotha</h3><p>Listen to the divine stories detailing the glory and blessings of observing the Satyanarayan Vrat.</p>',
 'https://www.youtube.com/embed/JikutyOWrZs',
 'The Satyanarayan Katha narrates the divine grace of Lord Vishnu...');

-- -------------------------------------------------------
-- PUJA STEPS - Durga Puja (puja_id = 4) Multi-Lingual
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, title_sanskrit, description, video_url, video_transcript) VALUES

(4, 1, 'Sasthi', 'à¤·à¤·à¥à¤ à¥€', 'à¦·à¦·à§à¦ à§€', 'à¤·à¤·à¥à¤ à¥€',
 '<h3>à¤·à¤·à¥à¤ à¥€ - Sasthi</h3><p>The commencement of Durga Puja with Kalparambha, Bodhon, Amantran, and Adhivas. Goddess Durga is awakened under a Bilva (Bael) tree.</p>',
 'https://www.youtube.com/embed/JAl7pjMa2q8',
 'We begin Durga Puja with Bodhon on Shashthi tithi...'),

(4, 2, 'Saptami', 'à¤¸à¤ªà¥à¤¤à¤®à¥€', 'à¦¸à¦ªà§à¦¤à¦®à§€', 'à¤¸à¤ªà¥à¤¤à¤®à¥€',
 '<h3>à¤¸à¤ªà¥à¤¤à¤®à¥€ - Saptami</h3><p>Installation of Navapatrika (nine plants) representing nine forms of Goddess Durga, followed by the morning Prana Pratishtha and main puja.</p>',
 'https://www.youtube.com/embed/5u-uulot9X4',
 'Navapatrika represents the presence of Durga in nature...'),

(4, 3, 'Aastami', 'à¤…à¤·à¥à¤Ÿà¤®à¥€', 'à¦…à¦·à§à¦Ÿà¦®à§€', 'à¤…à¤·à¥à¤Ÿà¤®à¥€',
 '<h3>à¤…à¤·à¥à¤Ÿà¤®à¥€ - Maha Ashtami</h3><p>The most important day of worship. Devotees offer flowers (Pushpanjali) while fasting, and Kumari Puja is performed to honor the divine feminine.</p>',
 'https://www.youtube.com/embed/yQt_GhyWOXc',
 'The Ashtami Pushpanjali is offered with complete devotion...'),

(4, 4, 'Sandhi Puja', 'à¤¸à¤‚à¤§à¤¿ à¤ªà¥‚à¤œà¤¾', 'à¦¸à¦¨à§à¦§à¦¿ à¦ªà§‚à¦œà¦¾', 'à¤¸à¤¨à¥à¤§à¤¿à¤•à¤¾à¤²à¤¾à¤ªà¥‚à¤œà¤¾',
 '<h3>à¤¸à¤‚à¤§à¤¿ à¤ªà¥‚à¤œà¤¾ - Sandhi Puja</h3><p>Performed at the exact juncture when Ashtami ends and Navami begins. 108 lamps are lit and 108 lotuses are offered to Goddess Chamunda.</p>',
 'https://www.youtube.com/embed/Ke7NDOzGSXM',
 'Sandhi Puja requires precise timing and 108 lamps...'),

(4, 5, 'Navami', 'à¤¨à¤µà¤®à¥€', 'à¦¨à¦¬à¦®à§€', 'à¤¨à¤µà¤®à¥€',
 '<h3>à¤¨à¤µà¤®à¥€ - Maha Navami</h3><p>The concluding day of formal worship. Maha Aarti is performed, and the grand Homam (fire sacrifice) seals the ritual energy.</p>',
 'https://www.youtube.com/embed/roS3QBV_xyU',
 'Maha Navami brings the culmination of the grand puja...'),

(4, 6, 'Dashami', 'à¤¦à¤¶à¤®à¥€', 'à¦¦à¦¶à¦®à§€', 'à¤¦à¤¶à¤®à¥€',
 '<h3>à¤¦à¤¶à¤®à¥€ - Vijaya Dashami</h3><p>The farewell journey of the Goddess. Sindoor Khela is celebrated by women, followed by the immersion (Visarjan) of the idol in water.</p>',
 'https://www.youtube.com/embed/uBr9f0tMrGs',
 'As we bid farewell to Maa Durga, we chant "Asche bochor abar hobe"...');

-- -------------------------------------------------------
-- PUJA STEPS - Saraswati Puja (puja_id = 5)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(5, 1, 'Saraswati Vandana', 'à¤¸à¤°à¤¸à¥à¤µà¤¤à¥€ à¤µà¤¨à¥à¤¦à¤¨à¤¾',
 '<h3>Saraswati Vandana</h3><p>Chant the Ya Kundendu tushara hara dhavala mantra to invoke the Goddess of Learning and seek blessings for intellect and creativity.</p>',
 'https://www.youtube.com/embed/8aN-DCABQcc',
 'We begin the puja by offering white flowers and chanting the Saraswati Vandana...');

-- -------------------------------------------------------
-- STEP_MANTRAS - map mantras to steps
-- -------------------------------------------------------
INSERT INTO step_mantras (puja_step_id, mantra_id, sequence_order) VALUES
(1, 1, 1);

-- -------------------------------------------------------
-- STEP SAMAGRI REQUIREMENTS
-- -------------------------------------------------------
INSERT INTO step_samagri (step_id, samagri_id, quantity, notes) VALUES
(1, 13, '3 sips', 'Use copper spoon for sipping');

-- -------------------------------------------------------
-- RESOURCES (PDF books)
-- -------------------------------------------------------
INSERT INTO resources (puja_id, title, resource_type, file_url, page_count, is_downloadable) VALUES
(1, 'Ganesh Puja Paddhati', 'PDF', 'http://localhost:8080/pdfs/Ganesh_Puja_Paddhati.pdf', 45, TRUE),
(1, 'Ganesh Puja Complete Guide', 'VIDEO', 'https://youtu.be/DUIrds34eeg?si=h9VZj8_6ctWhq8RO', NULL, FALSE),
(2, 'Lakshmi Puja Manual', 'PDF', '/pdfs/lakshmi-paddhati.pdf', 60, FALSE),
(3, 'Satyanarayan Vrat Katha', 'PDF', '/pdfs/satyanarayan-katha.pdf', 80, TRUE),
(4, 'Durga Puja Paddhati', 'PDF', '/pdfs/durga-puja-paddhati.pdf', 85, TRUE),
(4, 'Purohit Darpan Durga Puja Paddhati', 'PDF', 'http://localhost:8080/pdfs/Purohit_Darpan_Durgapuja_Paddhati.pdf', NULL, TRUE);

-- -------------------------------------------------------
-- HINDU FESTIVALS 2025 - 2026
-- -------------------------------------------------------
INSERT INTO hindu_festivals (name, name_devanagari, description, puja_id, event_date, days_duration, notification_days_before) VALUES

('Makar Sankranti', 'à¤®à¤•à¤° à¤¸à¤‚à¤•à¥à¤°à¤¾à¤‚à¤¤à¤¿',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying. Begins the auspicious Uttarayan period.',
 NULL, '2025-01-14', 1, 20),

('Maha Shivratri', 'à¤®à¤¹à¤¾à¤¶à¤¿à¤µà¤°à¤¾à¤¤à¥à¤°à¤¿',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya. Most sacred night for Shaivites.',
 NULL, '2025-02-26', 1, 20),

('Holi', 'à¤¹à¥‹à¤²à¥€',
 'Festival of colors celebrating the victory of Prahlada (devotion) over Hiranyakashipu (ego) and the burning of Holika. Rang Panchami follows five days later.',
 NULL, '2025-03-14', 2, 20),

('Ram Navami', 'à¤°à¤¾à¤® à¤¨à¤µà¤®à¥€',
 'Celebration of the birth of Lord Rama, the seventh avatar of Vishnu. Ramayana recitation and Puja of Rama Parivar are central activities.',
 NULL, '2025-04-06', 1, 20),

('Hanuman Jayanti', 'à¤¹à¤¨à¥à¤®à¤¾à¤¨ à¤œà¤¯à¤‚à¤¤à¥€',
 'Birthday of Lord Hanuman. Recitation of Hanuman Chalisa, Sundar Kanda, and distribution of prasad of sindoor and oil.',
 NULL, '2025-04-12', 1, 20),

('Akshaya Tritiya', 'à¤…à¤•à¥à¤·à¤¯ à¤¤à¥ƒà¤¤à¥€à¤¯à¤¾',
 'One of the most auspicious days in the Hindu calendar. Any charitable act or purchase done on this day is believed to grow manifold.',
 1, '2025-04-30', 1, 20),

('Nirjala Ekadashi', 'à¤¨à¤¿à¤°à¥à¤œà¤²à¤¾ à¤à¤•à¤¾à¤¦à¤¶à¥€',
 'The toughest of all Ekadashis - a waterless fast. Observed in the scorching summer heat. Dedicated to Lord Vishnu. Said to be equivalent to all 24 Ekadashi fasts.',
 NULL, '2025-06-07', 1, 20),

('Guru Purnima', 'à¤—à¥à¤°à¥ à¤ªà¥‚à¤°à¥à¤£à¤¿à¤®à¤¾',
 'Full moon day dedicated to the Guru-disciple relationship. Offerings made to one''s spiritual teacher and to Veda Vyasa, compiler of the Vedas.',
 NULL, '2025-07-10', 1, 20),

('Nag Panchami', 'à¤¨à¤¾à¤— à¤ªà¤‚à¤šà¤®à¥€',
 'Worship of the Naga (serpent) deities. Milk offered at snake shrines. Part of the Shravan month sacred to Lord Shiva.',
 NULL, '2025-07-29', 1, 20),

('Raksha Bandhan', 'à¤°à¤•à¥à¤·à¤¾à¤¬à¤‚à¤§à¤¨',
 'Sacred bond between siblings. Sisters tie Rakhi on brothers'' wrists, brothers vow their protection. Celebrated on Shravan Purnima.',
 NULL, '2025-08-09', 1, 20),

('Janmashtami', 'à¤œà¤¨à¥à¤®à¤¾à¤·à¥à¤Ÿà¤®à¥€',
 'Birth of Lord Krishna, the eighth avatar of Vishnu. Midnight celebrations, Dahi Handi, and Bhagavat recitation. One of the most joyful festivals.',
 NULL, '2025-08-16', 2, 20),

('Ganesh Chaturthi', 'à¤—à¤£à¥‡à¤¶ à¤šà¤¤à¥à¤°à¥à¤¥à¥€',
 'Ten-day festival celebrating the birth of Lord Ganesha. Elaborately decorated Ganesha idols installed in homes and public pandals, culminating in Visarjan.',
 1, '2025-08-27', 10, 20),

('Navratri (Sharad)', 'à¤¶à¤¾à¤°à¤¦à¥€à¤¯ à¤¨à¤µà¤°à¤¾à¤¤à¥à¤°à¤¿',
 'Nine nights dedicated to the nine forms of Goddess Durga. Garba and Dandiya dances in Gujarat, Durga Puja in Bengal, Golu display in South India.',
 NULL, '2025-10-02', 9, 20),

('Durga Puja', 'à¤¦à¥à¤°à¥à¤—à¤¾ à¤ªà¥‚à¤œà¤¾',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Enormous pandals, cultural programs, and processions mark this 5-day festival in Bengal.',
 4, '2025-10-02', 5, 25),

('Dussehra (Vijayadashami)', 'à¤¦à¤¶à¤¹à¤°à¤¾ / à¤µà¤¿à¤œà¤¯à¤¾à¤¦à¤¶à¤®à¥€',
 'Victory of Lord Rama over Ravana, celebrated on the tenth day after Navratri. Ravana effigies burned. Also marks Goddess Durga''s departure.',
 NULL, '2025-10-02', 1, 20),

('Kojagari Purnima', 'à¤•à¥‹à¤œà¤¾à¤—à¤°à¥€ à¤ªà¥‚à¤°à¥à¤£à¤¿à¤®à¤¾',
 'Lakshmi Puja on the full moon of Ashwin. Goddess Lakshmi is said to descend and bless those who are awake at night.',
 2, '2025-10-07', 1, 20),

('Dhanteras', 'à¤§à¤¨à¤¤à¥‡à¤°à¤¸',
 'Two days before Diwali. Lord Dhanvantari, the physician of gods, is worshipped. Gold and silver purchases are considered auspicious.',
 NULL, '2025-10-20', 1, 20),

('Diwali (Deepavali)', 'à¤¦à¥€à¤ªà¤¾à¤µà¤²à¥€',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas. Lord Rama''s return to Ayodhya is celebrated. Five-day festival culminating in Bhai Dooj.',
 2, '2025-10-20', 5, 25),

('Govardhan Puja', 'à¤—à¥‹à¤µà¤°à¥à¤§à¤¨ à¤ªà¥‚à¤œà¤¾',
 'One day after Diwali. Celebrates Krishna''s lifting of Govardhan mountain to protect the villagers. Annakut (mountain of food) offering made to Lord.',
 NULL, '2025-10-22', 1, 20),

('Chhath Puja', 'à¤›à¤  à¤ªà¥‚à¤œà¤¾',
 'Sun worship festival observed in Bihar, Jharkhand, and UP. Devotees stand in water at sunrise and sunset offering arghya to Surya Dev and Chhathi Maiya.',
 NULL, '2025-10-28', 4, 20),

('Kartik Purnima', 'à¤•à¤¾à¤°à¥à¤¤à¤¿à¤• à¤ªà¥‚à¤°à¥à¤£à¤¿à¤®à¤¾',
 'The most sacred full moon of the year. Holy dip at river ghats. Guru Nanak Jayanti is also celebrated on this day.',
 NULL, '2025-11-05', 1, 20),

('Vivah Panchami', 'à¤µà¤¿à¤µà¤¾à¤¹ à¤ªà¤‚à¤šà¤®à¥€',
 'The divine marriage of Lord Rama and Sita Mata. Celebrated with Ram-Sita wedding enactments in temples especially in Nepal and Janakpur.',
 NULL, '2025-11-27', 1, 20),

('Makar Sankranti 2026', 'à¤®à¤•à¤° à¤¸à¤‚à¤•à¥à¤°à¤¾à¤‚à¤¤à¤¿ à¥¨à¥¦à¥¨à¥¬',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying.',
 NULL, '2026-01-14', 1, 20),

('Basant Panchami', 'à¤¬à¤¸à¤‚à¤¤ à¤ªà¤‚à¤šà¤®à¥€',
 'Worship of Goddess Saraswati on the fifth day of spring. Students worship their books and musical instruments. Yellow clothing worn to honor the season.',
 NULL, '2026-01-26', 1, 20),

('Maha Shivratri 2026', 'à¤®à¤¹à¤¾à¤¶à¤¿à¤µà¤°à¤¾à¤¤à¥à¤°à¤¿ à¥¨à¥¦à¥¨à¥¬',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya.',
 NULL, '2026-02-15', 1, 20),

('Holi 2026', 'à¤¹à¥‹à¤²à¥€ à¥¨à¥¦à¥¨à¥¬',
 'Festival of colors celebrating the victory of devotion over ego. Holika Dahan the night before.',
 NULL, '2026-03-03', 2, 20),

('Navratri (Chaitra) 2026', 'à¤šà¥ˆà¤¤à¥à¤° à¤¨à¤µà¤°à¤¾à¤¤à¥à¤°à¤¿ à¥¨à¥¦à¥¨à¥¬',
 'Nine-night Navratri in the spring month of Chaitra. Ram Navami falls on the ninth day.',
 NULL, '2026-03-29', 9, 20),

('Ram Navami 2026', 'à¤°à¤¾à¤® à¤¨à¤µà¤®à¥€ à¥¨à¥¦à¥¨à¥¬',
 'Celebration of the birth of Lord Rama.',
 NULL, '2026-03-27', 1, 20),

('Ganesh Chaturthi 2026', 'à¤—à¤£à¥‡à¤¶ à¤šà¤¤à¥à¤°à¥à¤¥à¥€ à¥¨à¥¦à¥¨à¥¬',
 'Ten-day festival celebrating the birth of Lord Ganesha.',
 1, '2026-08-17', 10, 20),

('Navratri (Sharad) 2026', 'à¤¶à¤¾à¤°à¤¦à¥€à¤¯ à¤¨à¤µà¤°à¤¾à¤¤à¥à¤°à¤¿ à¥¨à¥¦à¥¨à¥¬',
 'Nine nights dedicated to the nine forms of Goddess Durga.',
 NULL, '2026-09-22', 9, 20),

('Diwali 2026', 'à¤¦à¥€à¤ªà¤¾à¤µà¤²à¥€ à¥¨à¥¦à¥¨à¥¬',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas.',
 2, '2026-10-09', 5, 25),

('Chhath Puja 2026', 'à¤›à¤  à¤ªà¥‚à¤œà¤¾ à¥¨à¥¦à¥¨à¥¬',
 'Sun worship festival observed in Bihar, Jharkhand, and UP.',
 NULL, '2026-10-17', 4, 20);

-- -------------------------------------------------------
-- USER NOTIFICATION PREFERENCES
-- -------------------------------------------------------
INSERT INTO user_notification_preferences
    (user_id, festival_reminders, panchang_alerts, learning_reminders, puja_practice, reminder_days_before)
VALUES
(1, TRUE, TRUE, TRUE, TRUE, 20),
(2, TRUE, TRUE, TRUE, TRUE, 20),
(3, TRUE, TRUE, TRUE, TRUE, 20);

-- -------------------------------------------------------
-- MAP RESOURCES TO DURGA PUJA STEPS
-- -------------------------------------------------------
UPDATE puja_steps SET pdf_resource_id = 6 WHERE puja_id = 4;

