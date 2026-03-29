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
('Kalash', 'Ã Â¤â€¢Ã Â¤Â²Ã Â¤Â¶', 'Sacred water pot, symbolizes deity residence'),
('Mango Leaves', 'Ã Â¤â€ Ã Â¤Â® Ã Â¤â€¢Ã Â¥â€¡ Ã Â¤ÂªÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â¤Ã Â¥â€¡', 'Fresh mango leaves placed on Kalash'),
('Coconut', 'Ã Â¤Â¨Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¿Ã Â¤Â¯Ã Â¤Â²', 'Placed on top of Kalash, symbolizes Lord Shiva'),
('Roli (Kumkum)', 'Ã Â¤Â°Ã Â¥â€¹Ã Â¤Â²Ã Â¥â‚¬ / Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â®Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â®', 'Red vermillion powder for tilak'),
('Akshat (Rice)', 'Ã Â¤â€¦Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¤Â¤', 'Unbroken rice grains offered during puja'),
('Incense Sticks (Agarbatti)', 'Ã Â¤â€¦Ã Â¤â€”Ã Â¤Â°Ã Â¤Â¬Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¤Ã Â¥â‚¬', 'Used to purify the atmosphere'),
('Ghee Diya', 'Ã Â¤ËœÃ Â¥â‚¬ Ã Â¤Â¦Ã Â¥â‚¬Ã Â¤Â¯Ã Â¤Â¾', 'Earthen lamp with pure ghee wick'),
('Flowers (Pushpa)', 'Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â·Ã Â¥ÂÃ Â¤Âª', 'Fresh flowers for deity offering'),
('Dhoti (White Cloth)', 'Ã Â¤Â§Ã Â¥â€¹Ã Â¤Â¤Ã Â¥â‚¬', 'White cotton cloth for pandit to wear'),
('Paan Patta', 'Ã Â¤ÂªÃ Â¤Â¾Ã Â¤Â¨ Ã Â¤ÂªÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¾', 'Betel leaf for offering'),
('Supari', 'Ã Â¤Â¸Ã Â¥ÂÃ Â¤ÂªÃ Â¤Â¾Ã Â¤Â°Ã Â¥â‚¬', 'Areca nut, auspicious offering'),
('Camphor (Kapoor)', 'Ã Â¤â€¢Ã Â¤ÂªÃ Â¥â€šÃ Â¤Â°', 'Used in aarti for illumination'),
('Gangajal', 'Ã Â¤â€”Ã Â¤â€šÃ Â¤â€”Ã Â¤Â¾Ã Â¤Å“Ã Â¤Â²', 'Holy water from River Ganga'),
('Chandan (Sandalwood)', 'Ã Â¤Å¡Ã Â¤â€šÃ Â¤Â¦Ã Â¤Â¨', 'Sandalwood paste for tilak and fragrance'),
('Turmeric (Haldi)', 'Ã Â¤Â¹Ã Â¤Â²Ã Â¥ÂÃ Â¤Â¦Ã Â¥â‚¬', 'Auspicious yellow powder'),
('Panchamrit', 'Ã Â¤ÂªÃ Â¤â€šÃ Â¤Å¡Ã Â¤Â¾Ã Â¤Â®Ã Â¥Æ’Ã Â¤Â¤', 'Mixture of milk, curd, honey, sugar, ghee'),
('Tulsi Leaves', 'Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â²Ã Â¤Â¸Ã Â¥â‚¬ Ã Â¤ÂªÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â¤Ã Â¥â€¡', 'Sacred basil leaves, especially for Vishnu puja'),
('Lotus Flower', 'Ã Â¤â€¢Ã Â¤Â®Ã Â¤Â²', 'Sacred flower of Lakshmi and Vishnu'),
('Sindoor', 'Ã Â¤Â¸Ã Â¤Â¿Ã Â¤â€šÃ Â¤Â¦Ã Â¥â€šÃ Â¤Â°', 'Vermillion for married women during puja'),
('Dhoop', 'Ã Â¤Â§Ã Â¥â€šÃ Â¤Âª', 'Resin incense for purification');

-- -------------------------------------------------------
-- PUJAS
-- -------------------------------------------------------
INSERT INTO pujas (name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, created_by) VALUES
('Ganesh Puja', 'Ã Â¤â€”Ã Â¤Â£Ã Â¥â€¡Ã Â¤Â¶ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'The foundational puja performed at the beginning of every ritual. Lord Ganesha is the remover of obstacles and is invoked first to bless any endeavor.',
 60, 'BEGINNER', 'Vighnaharta', '/images/ganesh-puja.jpg', 1),

('Lakshmi Puja', 'Ã Â¤Â²Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¥ÂÃ Â¤Â®Ã Â¥â‚¬ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'Worship of Goddess Lakshmi, the deity of wealth and prosperity. Performed especially on Diwali and Fridays.',
 90, 'BEGINNER', 'Wealth', '/images/lakshmi-puja.jpg', 1),

('Satyanarayan Katha', 'Ã Â¤Â¸Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¯Ã Â¤Â¨Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â¯Ã Â¤Â£ Ã Â¤â€¢Ã Â¤Â¥Ã Â¤Â¾',
 'A complete Vishnu puja with the reading of Satyanarayan Vrat Katha. Performed on Purnima and for special occasions.',
 180, 'INTERMEDIATE', 'Vrat', '/images/satyanarayan.jpg', 1),

('Durga Puja', 'Ã Â¤Â¦Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤â€”Ã Â¤Â¾ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Worship of the Divine Mother for strength, intellect, and prosperity.',
 300, 'ADVANCED', 'Shakti', '/images/durga-puja.jpg', 1),

('Saraswati Puja', 'Ã Â¤Â¸Ã Â¤Â°Ã Â¤Â¸Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¤Ã Â¥â‚¬ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'Worship of the Goddess of Knowledge, Music, Art, and Wisdom. Especially performed by students and artists on Vasant Panchami.',
 60, 'BEGINNER', 'Wisdom', '/images/saraswati-puja.jpg', 1);

-- -------------------------------------------------------
-- MANTRAS (Devanagari)
-- -------------------------------------------------------
INSERT INTO mantras (shlok_text, transliteration, word_meanings, source_text) VALUES

-- Ganesh Vandana
('Ã Â¤ÂµÃ Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â£Ã Â¥ÂÃ Â¤Â¡ Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤â€¢Ã Â¤Â¾Ã Â¤Â¯ Ã Â¤Â¸Ã Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â¯Ã Â¤â€¢Ã Â¥â€¹Ã Â¤Å¸Ã Â¤Â¿ Ã Â¤Â¸Ã Â¤Â®Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Â­Ã Â¥Â¤\nÃ Â¤Â¨Ã Â¤Â¿Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¿Ã Â¤ËœÃ Â¥ÂÃ Â¤Â¨Ã Â¤â€š Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¥Â Ã Â¤Â®Ã Â¥â€¡ Ã Â¤Â¦Ã Â¥â€¡Ã Â¤Âµ Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤â€¢Ã Â¤Â¾Ã Â¤Â°Ã Â¥ÂÃ Â¤Â¯Ã Â¥â€¡Ã Â¤Â·Ã Â¥Â Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¦Ã Â¤Â¾Ã Â¥Â¥',
 'Vakratunda Mahakaya Suryakoti Samaprabha\nNirvighnam Kuru Me Deva Sarvakaryeshu Sarvada',
 '[{"word":"Ã Â¤ÂµÃ Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â£Ã Â¥ÂÃ Â¤Â¡","meaning":"One with curved trunk","role":"Nominative"},{"word":"Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤â€¢Ã Â¤Â¾Ã Â¤Â¯","meaning":"Mighty-bodied","role":"Nominative"},{"word":"Ã Â¤Â¸Ã Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â¯Ã Â¤â€¢Ã Â¥â€¹Ã Â¤Å¸Ã Â¤Â¿","meaning":"Crores of suns","role":"Nominative"},{"word":"Ã Â¤Â¸Ã Â¤Â®Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Â­","meaning":"Equal in radiance","role":"Nominative"},{"word":"Ã Â¤Â¨Ã Â¤Â¿Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¿Ã Â¤ËœÃ Â¥ÂÃ Â¤Â¨Ã Â¤Â®Ã Â¥Â","meaning":"Without obstacles","role":"Accusative"},{"word":"Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¥Â","meaning":"Make / grant","role":"Verb, Imperative"},{"word":"Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤â€¢Ã Â¤Â¾Ã Â¤Â°Ã Â¥ÂÃ Â¤Â¯Ã Â¥â€¡Ã Â¤Â·Ã Â¥Â","meaning":"In all works/tasks","role":"Locative plural"},{"word":"Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¦Ã Â¤Â¾","meaning":"Always","role":"Indeclinable"}]',
 'Traditional Ganesh Vandana'),

-- Lakshmi Mantra
('Ã Â¥Â Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¤Â¹Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¤â€¢Ã Â¤Â®Ã Â¤Â²Ã Â¥â€¡ Ã Â¤â€¢Ã Â¤Â®Ã Â¤Â²Ã Â¤Â¾Ã Â¤Â²Ã Â¤Â¯Ã Â¥â€¡ Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Â¸Ã Â¥â‚¬Ã Â¤Â¦ Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Â¸Ã Â¥â‚¬Ã Â¤Â¦Ã Â¥Â¤\nÃ Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¤Â¹Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š Ã Â¥Â Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤Â²Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¥ÂÃ Â¤Â®Ã Â¥ÂÃ Â¤Â¯Ã Â¥Ë† Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’Ã Â¥Â¥',
 'Om Shrim Hrim Shrim Kamale Kamalaalaye Prasida Prasida\nShrim Hrim Shrim Om Mahalakshmyai Namah',
 '[{"word":"Ã Â¥Â","meaning":"Primordial sacred syllable","role":"Invocation"},{"word":"Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š","meaning":"Bija mantra of Lakshmi","role":"Bija"},{"word":"Ã Â¤Â¹Ã Â¥ÂÃ Â¤Â°Ã Â¥â‚¬Ã Â¤â€š","meaning":"Bija of Maya/Shakti","role":"Bija"},{"word":"Ã Â¤â€¢Ã Â¤Â®Ã Â¤Â²Ã Â¥â€¡","meaning":"O Lotus-seated one","role":"Vocative"},{"word":"Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Â¸Ã Â¥â‚¬Ã Â¤Â¦","meaning":"Be pleased, grace us","role":"Verb, Imperative"},{"word":"Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤Â²Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¥ÂÃ Â¤Â®Ã Â¥ÂÃ Â¤Â¯Ã Â¥Ë†","meaning":"To Maha Lakshmi","role":"Dative"},{"word":"Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’","meaning":"I bow / Salutation","role":"Indeclinable"}]',
 'Sri Sukta, Rigveda Khila'),

-- Satyanarayan Mantra
('Ã Â¥Â Ã Â¤Â¨Ã Â¤Â®Ã Â¥â€¹ Ã Â¤Â­Ã Â¤â€”Ã Â¤ÂµÃ Â¤Â¤Ã Â¥â€¡ Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¯Ã Â¥Â¤',
 'Om Namo Bhagavate Vasudevaya',
 '[{"word":"Ã Â¥Â","meaning":"Sacred syllable, the absolute","role":"Invocation"},{"word":"Ã Â¤Â¨Ã Â¤Â®Ã Â¥â€¹","meaning":"Salutation","role":"Indeclinable"},{"word":"Ã Â¤Â­Ã Â¤â€”Ã Â¤ÂµÃ Â¤Â¤Ã Â¥â€¡","meaning":"To the Divine Lord","role":"Dative"},{"word":"Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¯","meaning":"To Vasudeva (Krishna/Vishnu)","role":"Dative"}]',
 'Vishnu Purana, Dwadashakshari Mantra'),

-- Shiva Mantra (Panchakshara)
('Ã Â¥Â Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’ Ã Â¤Â¶Ã Â¤Â¿Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¯Ã Â¥Â¤',
 'Om Namah Shivaya',
 '[{"word":"Ã Â¥Â","meaning":"Primordial sound, the absolute truth","role":"Invocation"},{"word":"Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’","meaning":"Salutation, I bow","role":"Indeclinable"},{"word":"Ã Â¤Â¶Ã Â¤Â¿Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¯","meaning":"To Shiva, the auspicious one","role":"Dative"}]',
 'Krishna Yajurveda, Taittiriya Samhita 4.5.1'),

-- Gayatri Mantra
('Ã Â¥Â Ã Â¤Â­Ã Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â­Ã Â¥ÂÃ Â¤ÂµÃ Â¤Æ’ Ã Â¤Â¸Ã Â¥ÂÃ Â¤ÂµÃ Â¤Æ’Ã Â¥Â¤\nÃ Â¤Â¤Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¸Ã Â¤ÂµÃ Â¤Â¿Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â°Ã Â¥â€¡Ã Â¤Â£Ã Â¥ÂÃ Â¤Â¯Ã Â¤â€š Ã Â¤Â­Ã Â¤Â°Ã Â¥ÂÃ Â¤â€”Ã Â¥â€¹ Ã Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¤Â¸Ã Â¥ÂÃ Â¤Â¯ Ã Â¤Â§Ã Â¥â‚¬Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¿Ã Â¥Â¤\nÃ Â¤Â§Ã Â¤Â¿Ã Â¤Â¯Ã Â¥â€¹ Ã Â¤Â¯Ã Â¥â€¹ Ã Â¤Â¨Ã Â¤Æ’ Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Å¡Ã Â¥â€¹Ã Â¤Â¦Ã Â¤Â¯Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¥Â¥',
 'Om Bhur Bhuvah Svah\nTat Savitur Varenyam Bhargo Devasya Dhimahi\nDhiyo Yo Nah Prachodayat',
 '[{"word":"Ã Â¥Â","meaning":"Pranava, the primordial sound","role":"Invocation"},{"word":"Ã Â¤Â­Ã Â¥â€šÃ Â¤Æ’","meaning":"Earth","role":"Vyahrti"},{"word":"Ã Â¤Â­Ã Â¥ÂÃ Â¤ÂµÃ Â¤Æ’","meaning":"Atmosphere","role":"Vyahrti"},{"word":"Ã Â¤Â¸Ã Â¥ÂÃ Â¤ÂµÃ Â¤Æ’","meaning":"Heaven / Upper realms","role":"Vyahrti"},{"word":"Ã Â¤Â¤Ã Â¤Â¤Ã Â¥Â","meaning":"That (transcendent)","role":"Pronoun"},{"word":"Ã Â¤Â¸Ã Â¤ÂµÃ Â¤Â¿Ã Â¤Â¤Ã Â¥ÂÃ Â¤Æ’","meaning":"Of the Sun / Divine illuminator","role":"Genitive"},{"word":"Ã Â¤ÂµÃ Â¤Â°Ã Â¥â€¡Ã Â¤Â£Ã Â¥ÂÃ Â¤Â¯Ã Â¤Â®Ã Â¥Â","meaning":"Most excellent, most worshipful","role":"Accusative"},{"word":"Ã Â¤Â­Ã Â¤Â°Ã Â¥ÂÃ Â¤â€”Ã Â¤Æ’","meaning":"Radiance, purifying light","role":"Accusative"},{"word":"Ã Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¤Â¸Ã Â¥ÂÃ Â¤Â¯","meaning":"Of the deity","role":"Genitive"},{"word":"Ã Â¤Â§Ã Â¥â‚¬Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¿","meaning":"Let us meditate","role":"Verb, Optative"},{"word":"Ã Â¤Â§Ã Â¤Â¿Ã Â¤Â¯Ã Â¤Æ’","meaning":"Intellects, faculties of understanding","role":"Accusative"},{"word":"Ã Â¤Â¯Ã Â¤Æ’","meaning":"Who","role":"Relative pronoun"},{"word":"Ã Â¤Â¨Ã Â¤Æ’","meaning":"Our","role":"Genitive"},{"word":"Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â°Ã Â¤Å¡Ã Â¥â€¹Ã Â¤Â¦Ã Â¤Â¯Ã Â¤Â¾Ã Â¤Â¤Ã Â¥Â","meaning":"May he inspire/guide","role":"Verb, Optative"}]',
 'Rigveda 3.62.10'),

-- Durga Mantra
('Ã Â¤Â¯Ã Â¤Â¾ Ã Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¥â‚¬ Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â­Ã Â¥â€šÃ Â¤Â¤Ã Â¥â€¡Ã Â¤Â·Ã Â¥Â Ã Â¤Â¶Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¿Ã Â¤Â°Ã Â¥â€šÃ Â¤ÂªÃ Â¥â€¡Ã Â¤Â£ Ã Â¤Â¸Ã Â¤â€šÃ Â¤Â¸Ã Â¥ÂÃ Â¤Â¥Ã Â¤Â¿Ã Â¤Â¤Ã Â¤Â¾Ã Â¥Â¤\nÃ Â¤Â¨Ã Â¤Â®Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¯Ã Â¥Ë† Ã Â¤Â¨Ã Â¤Â®Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¯Ã Â¥Ë† Ã Â¤Â¨Ã Â¤Â®Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¯Ã Â¥Ë† Ã Â¤Â¨Ã Â¤Â®Ã Â¥â€¹ Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’Ã Â¥Â¥',
 'Ya Devi Sarvabhuteshu ShaktirÃƒÂºpena Samsthita\nNamastasyai Namastasyai Namastasyai Namo Namah',
 '[{"word":"Ã Â¤Â¯Ã Â¤Â¾","meaning":"Who (she who)","role":"Relative pronoun, feminine"},{"word":"Ã Â¤Â¦Ã Â¥â€¡Ã Â¤ÂµÃ Â¥â‚¬","meaning":"The Goddess","role":"Nominative"},{"word":"Ã Â¤Â¸Ã Â¤Â°Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â­Ã Â¥â€šÃ Â¤Â¤Ã Â¥â€¡Ã Â¤Â·Ã Â¥Â","meaning":"In all beings","role":"Locative plural"},{"word":"Ã Â¤Â¶Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¿Ã Â¤Â°Ã Â¥â€šÃ Â¤ÂªÃ Â¥â€¡Ã Â¤Â£","meaning":"In the form of Shakti/power","role":"Instrumental"},{"word":"Ã Â¤Â¸Ã Â¤â€šÃ Â¤Â¸Ã Â¥ÂÃ Â¤Â¥Ã Â¤Â¿Ã Â¤Â¤Ã Â¤Â¾","meaning":"Abiding, established","role":"Past participle"},{"word":"Ã Â¤Â¨Ã Â¤Â®Ã Â¤Æ’","meaning":"Salutation","role":"Indeclinable"}]',
 'Durgasaptashati, Markandeya Purana'),

-- Kalash Sthapana Mantra
('Ã Â¤â€¢Ã Â¤Â²Ã Â¤Â¶Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¯ Ã Â¤Â®Ã Â¥ÂÃ Â¤â€“Ã Â¥â€¡ Ã Â¤ÂµÃ Â¤Â¿Ã Â¤Â·Ã Â¥ÂÃ Â¤Â£Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤â€¢Ã Â¤Â£Ã Â¥ÂÃ Â¤Â Ã Â¥â€¡ Ã Â¤Â°Ã Â¥ÂÃ Â¤Â¦Ã Â¥ÂÃ Â¤Â°Ã Â¤Æ’ Ã Â¤Â¸Ã Â¤Â®Ã Â¤Â¾Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿Ã Â¤Â¤Ã Â¤Æ’Ã Â¥Â¤\nÃ Â¤Â®Ã Â¥â€šÃ Â¤Â²Ã Â¥â€¡ Ã Â¤Â¤Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â° Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¥Ã Â¤Â¿Ã Â¤Â¤Ã Â¥â€¹ Ã Â¤Â¬Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¹Ã Â¥ÂÃ Â¤Â®Ã Â¤Â¾ Ã Â¤Â®Ã Â¤Â§Ã Â¥ÂÃ Â¤Â¯Ã Â¥â€¡ Ã Â¤Â®Ã Â¤Â¾Ã Â¤Â¤Ã Â¥Æ’Ã Â¤â€”Ã Â¤Â£Ã Â¤Â¾Ã Â¤Æ’ Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â®Ã Â¥Æ’Ã Â¤Â¤Ã Â¤Â¾Ã Â¤Æ’Ã Â¥Â¥',
 'Kalashasya Mukhe Vishnur Kanthe Rudrah Samashritah\nMule Tatra Sthito Brahma Madhye Matriganah Smritah',
 '[{"word":"Ã Â¤â€¢Ã Â¤Â²Ã Â¤Â¶Ã Â¤Â¸Ã Â¥ÂÃ Â¤Â¯","meaning":"Of the Kalash","role":"Genitive"},{"word":"Ã Â¤Â®Ã Â¥ÂÃ Â¤â€“Ã Â¥â€¡","meaning":"In the mouth/opening","role":"Locative"},{"word":"Ã Â¤ÂµÃ Â¤Â¿Ã Â¤Â·Ã Â¥ÂÃ Â¤Â£Ã Â¥ÂÃ Â¤Æ’","meaning":"Lord Vishnu","role":"Nominative"},{"word":"Ã Â¤â€¢Ã Â¤Â£Ã Â¥ÂÃ Â¤Â Ã Â¥â€¡","meaning":"In the neck","role":"Locative"},{"word":"Ã Â¤Â°Ã Â¥ÂÃ Â¤Â¦Ã Â¥ÂÃ Â¤Â°Ã Â¤Æ’","meaning":"Lord Rudra/Shiva","role":"Nominative"},{"word":"Ã Â¤Â¸Ã Â¤Â®Ã Â¤Â¾Ã Â¤Â¶Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿Ã Â¤Â¤Ã Â¤Æ’","meaning":"Has taken residence","role":"Past participle"},{"word":"Ã Â¤Â®Ã Â¥â€šÃ Â¤Â²Ã Â¥â€¡","meaning":"At the base","role":"Locative"},{"word":"Ã Â¤Â¬Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¹Ã Â¥ÂÃ Â¤Â®Ã Â¤Â¾","meaning":"Lord Brahma","role":"Nominative"},{"word":"Ã Â¤Â®Ã Â¤Â§Ã Â¥ÂÃ Â¤Â¯Ã Â¥â€¡","meaning":"In the middle","role":"Locative"},{"word":"Ã Â¤Â®Ã Â¤Â¾Ã Â¤Â¤Ã Â¥Æ’Ã Â¤â€”Ã Â¤Â£Ã Â¤Â¾Ã Â¤Æ’","meaning":"The Divine Mothers","role":"Nominative"}]',
 'Traditional Kalash Sthapana Mantra');

-- -------------------------------------------------------
-- PUJA STEPS - Ganesh Puja (puja_id = 1)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(1, 1, 'Ganesh Puja Mantra', 'Ã Â¤â€”Ã Â¤Â£Ã Â¥â€¡Ã Â¤Â¶ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ Ã Â¤Â®Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â°',
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

(2, 1, 'Puja Mantra', 'Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ Ã Â¤Â®Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â°',
 '<h3>Puja Mantra - Invoking Goddess Lakshmi</h3><p>Chant the sacred mantras to invoke Goddess Lakshmi for wealth and prosperity.</p>',
 'https://www.youtube.com/embed/knY4cUlCNXc',
 'In this step we chant the sacred Lakshmi Puja mantras...'),

(2, 2, 'Panchali', 'Ã Â¤ÂªÃ Â¤Â¾Ã Â¤â€šÃ Â¤Å¡Ã Â¤Â¾Ã Â¤Â²Ã Â¥â‚¬',
 '<h3>Panchali - The Sacred Story</h3><p>Recite or listen to the Kojagari Lakshmi Vrat Katha (Panchali) which details the glory of the Goddess.</p>',
 'https://www.youtube.com/embed/dsWdH8-U8u8',
 'The Panchali describes the divine blessings of Goddess Lakshmi...');

-- -------------------------------------------------------
-- PUJA STEPS - Satyanarayan Puja (puja_id = 3)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(3, 1, 'Satyanarayan Puja Mantra Part 1', 'Ã Â¤Â¸Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¯Ã Â¤Â¨Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â¯Ã Â¤Â£ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ Ã Â¤Â®Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â° Ã Â¤Â­Ã Â¤Â¾Ã Â¤â€” Ã Â¥Â§',
 '<h3>Satyanarayan Puja Mantra (Part 1)</h3><p>Begin the worship of Lord Shri Hari Vishnu with the foundational mantras and offerings.</p>',
 'https://www.youtube.com/embed/WKxIK_IMT98',
 'In the first part of the Satyanarayan Puja, we start with the purification and foundational mantras...'),

(3, 2, 'Satyanarayan Puja Mantra Part 2', 'Ã Â¤Â¸Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¯Ã Â¤Â¨Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â¯Ã Â¤Â£ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ Ã Â¤Â®Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â¤Ã Â¥ÂÃ Â¤Â° Ã Â¤Â­Ã Â¤Â¾Ã Â¤â€” Ã Â¥Â¨',
 '<h3>Satyanarayan Puja Mantra (Part 2)</h3><p>Continue the profound worship and offerings to the Lord of Truth.</p>',
 'https://www.youtube.com/embed/uyEsWHJEjsQ',
 'Moving forward in the puja, we continue the sacred offerings to Lord Vishnu...'),

(3, 3, 'Satyanarayan Broto Kotha', 'Ã Â¤Â¸Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â¯Ã Â¤Â¨Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â¯Ã Â¤Â£ Ã Â¤ÂµÃ Â¥ÂÃ Â¤Â°Ã Â¤Â¤ Ã Â¤â€¢Ã Â¤Â¥Ã Â¤Â¾',
 '<h3>Satyanarayan Broto Kotha</h3><p>Listen to the divine stories detailing the glory and blessings of observing the Satyanarayan Vrat.</p>',
 'https://www.youtube.com/embed/JikutyOWrZs',
 'The Satyanarayan Katha narrates the divine grace of Lord Vishnu...');

-- -------------------------------------------------------
-- PUJA STEPS - Durga Puja (puja_id = 4) Multi-Lingual
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, title_sanskrit, description, video_url, video_transcript) VALUES

(4, 1, 'Sasthi', 'Ã Â¤Â·Ã Â¤Â·Ã Â¥ÂÃ Â¤Â Ã Â¥â‚¬', 'Ã Â¦Â·Ã Â¦Â·Ã Â§ÂÃ Â¦Â Ã Â§â‚¬', 'Ã Â¤Â·Ã Â¤Â·Ã Â¥ÂÃ Â¤Â Ã Â¥â‚¬',
 '<h3>Ã Â¤Â·Ã Â¤Â·Ã Â¥ÂÃ Â¤Â Ã Â¥â‚¬ - Sasthi</h3><p>The commencement of Durga Puja with Kalparambha, Bodhon, Amantran, and Adhivas. Goddess Durga is awakened under a Bilva (Bael) tree.</p>',
 'https://www.youtube.com/embed/JAl7pjMa2q8',
 'We begin Durga Puja with Bodhon on Shashthi tithi...'),

(4, 2, 'Saptami', 'Ã Â¤Â¸Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â¤Ã Â¤Â®Ã Â¥â‚¬', 'Ã Â¦Â¸Ã Â¦ÂªÃ Â§ÂÃ Â¦Â¤Ã Â¦Â®Ã Â§â‚¬', 'Ã Â¤Â¸Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â¤Ã Â¤Â®Ã Â¥â‚¬',
 '<h3>Ã Â¤Â¸Ã Â¤ÂªÃ Â¥ÂÃ Â¤Â¤Ã Â¤Â®Ã Â¥â‚¬ - Saptami</h3><p>Installation of Navapatrika (nine plants) representing nine forms of Goddess Durga, followed by the morning Prana Pratishtha and main puja.</p>',
 'https://www.youtube.com/embed/5u-uulot9X4',
 'Navapatrika represents the presence of Durga in nature...'),

(4, 3, 'Aastami', 'Ã Â¤â€¦Ã Â¤Â·Ã Â¥ÂÃ Â¤Å¸Ã Â¤Â®Ã Â¥â‚¬', 'Ã Â¦â€¦Ã Â¦Â·Ã Â§ÂÃ Â¦Å¸Ã Â¦Â®Ã Â§â‚¬', 'Ã Â¤â€¦Ã Â¤Â·Ã Â¥ÂÃ Â¤Å¸Ã Â¤Â®Ã Â¥â‚¬',
 '<h3>Ã Â¤â€¦Ã Â¤Â·Ã Â¥ÂÃ Â¤Å¸Ã Â¤Â®Ã Â¥â‚¬ - Maha Ashtami</h3><p>The most important day of worship. Devotees offer flowers (Pushpanjali) while fasting, and Kumari Puja is performed to honor the divine feminine.</p>',
 'https://www.youtube.com/embed/yQt_GhyWOXc',
 'The Ashtami Pushpanjali is offered with complete devotion...'),

(4, 4, 'Sandhi Puja', 'Ã Â¤Â¸Ã Â¤â€šÃ Â¤Â§Ã Â¤Â¿ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾', 'Ã Â¦Â¸Ã Â¦Â¨Ã Â§ÂÃ Â¦Â§Ã Â¦Â¿ Ã Â¦ÂªÃ Â§â€šÃ Â¦Å“Ã Â¦Â¾', 'Ã Â¤Â¸Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â§Ã Â¤Â¿Ã Â¤â€¢Ã Â¤Â¾Ã Â¤Â²Ã Â¤Â¾Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 '<h3>Ã Â¤Â¸Ã Â¤â€šÃ Â¤Â§Ã Â¤Â¿ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ - Sandhi Puja</h3><p>Performed at the exact juncture when Ashtami ends and Navami begins. 108 lamps are lit and 108 lotuses are offered to Goddess Chamunda.</p>',
 'https://www.youtube.com/embed/Ke7NDOzGSXM',
 'Sandhi Puja requires precise timing and 108 lamps...'),

(4, 5, 'Navami', 'Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â®Ã Â¥â‚¬', 'Ã Â¦Â¨Ã Â¦Â¬Ã Â¦Â®Ã Â§â‚¬', 'Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â®Ã Â¥â‚¬',
 '<h3>Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â®Ã Â¥â‚¬ - Maha Navami</h3><p>The concluding day of formal worship. Maha Aarti is performed, and the grand Homam (fire sacrifice) seals the ritual energy.</p>',
 'https://www.youtube.com/embed/roS3QBV_xyU',
 'Maha Navami brings the culmination of the grand puja...'),

(4, 6, 'Dashami', 'Ã Â¤Â¦Ã Â¤Â¶Ã Â¤Â®Ã Â¥â‚¬', 'Ã Â¦Â¦Ã Â¦Â¶Ã Â¦Â®Ã Â§â‚¬', 'Ã Â¤Â¦Ã Â¤Â¶Ã Â¤Â®Ã Â¥â‚¬',
 '<h3>Ã Â¤Â¦Ã Â¤Â¶Ã Â¤Â®Ã Â¥â‚¬ - Vijaya Dashami</h3><p>The farewell journey of the Goddess. Sindoor Khela is celebrated by women, followed by the immersion (Visarjan) of the idol in water.</p>',
 'https://www.youtube.com/embed/uBr9f0tMrGs',
 'As we bid farewell to Maa Durga, we chant "Asche bochor abar hobe"...');

-- -------------------------------------------------------
-- PUJA STEPS - Saraswati Puja (puja_id = 5)
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(5, 1, 'Saraswati Vandana', 'Ã Â¤Â¸Ã Â¤Â°Ã Â¤Â¸Ã Â¥ÂÃ Â¤ÂµÃ Â¤Â¤Ã Â¥â‚¬ Ã Â¤ÂµÃ Â¤Â¨Ã Â¥ÂÃ Â¤Â¦Ã Â¤Â¨Ã Â¤Â¾',
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

('Makar Sankranti', 'Ã Â¤Â®Ã Â¤â€¢Ã Â¤Â° Ã Â¤Â¸Ã Â¤â€šÃ Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¾Ã Â¤â€šÃ Â¤Â¤Ã Â¤Â¿',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying. Begins the auspicious Uttarayan period.',
 NULL, '2025-01-14', 1, 20),

('Maha Shivratri', 'Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤Â¶Ã Â¤Â¿Ã Â¤ÂµÃ Â¤Â°Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya. Most sacred night for Shaivites.',
 NULL, '2025-02-26', 1, 20),

('Holi', 'Ã Â¤Â¹Ã Â¥â€¹Ã Â¤Â²Ã Â¥â‚¬',
 'Festival of colors celebrating the victory of Prahlada (devotion) over Hiranyakashipu (ego) and the burning of Holika. Rang Panchami follows five days later.',
 NULL, '2025-03-14', 2, 20),

('Ram Navami', 'Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â® Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â®Ã Â¥â‚¬',
 'Celebration of the birth of Lord Rama, the seventh avatar of Vishnu. Ramayana recitation and Puja of Rama Parivar are central activities.',
 NULL, '2025-04-06', 1, 20),

('Hanuman Jayanti', 'Ã Â¤Â¹Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â®Ã Â¤Â¾Ã Â¤Â¨ Ã Â¤Å“Ã Â¤Â¯Ã Â¤â€šÃ Â¤Â¤Ã Â¥â‚¬',
 'Birthday of Lord Hanuman. Recitation of Hanuman Chalisa, Sundar Kanda, and distribution of prasad of sindoor and oil.',
 NULL, '2025-04-12', 1, 20),

('Akshaya Tritiya', 'Ã Â¤â€¦Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¤Â¯ Ã Â¤Â¤Ã Â¥Æ’Ã Â¤Â¤Ã Â¥â‚¬Ã Â¤Â¯Ã Â¤Â¾',
 'One of the most auspicious days in the Hindu calendar. Any charitable act or purchase done on this day is believed to grow manifold.',
 1, '2025-04-30', 1, 20),

('Nirjala Ekadashi', 'Ã Â¤Â¨Ã Â¤Â¿Ã Â¤Â°Ã Â¥ÂÃ Â¤Å“Ã Â¤Â²Ã Â¤Â¾ Ã Â¤ÂÃ Â¤â€¢Ã Â¤Â¾Ã Â¤Â¦Ã Â¤Â¶Ã Â¥â‚¬',
 'The toughest of all Ekadashis - a waterless fast. Observed in the scorching summer heat. Dedicated to Lord Vishnu. Said to be equivalent to all 24 Ekadashi fasts.',
 NULL, '2025-06-07', 1, 20),

('Guru Purnima', 'Ã Â¤â€”Ã Â¥ÂÃ Â¤Â°Ã Â¥Â Ã Â¤ÂªÃ Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â£Ã Â¤Â¿Ã Â¤Â®Ã Â¤Â¾',
 'Full moon day dedicated to the Guru-disciple relationship. Offerings made to one''s spiritual teacher and to Veda Vyasa, compiler of the Vedas.',
 NULL, '2025-07-10', 1, 20),

('Nag Panchami', 'Ã Â¤Â¨Ã Â¤Â¾Ã Â¤â€” Ã Â¤ÂªÃ Â¤â€šÃ Â¤Å¡Ã Â¤Â®Ã Â¥â‚¬',
 'Worship of the Naga (serpent) deities. Milk offered at snake shrines. Part of the Shravan month sacred to Lord Shiva.',
 NULL, '2025-07-29', 1, 20),

('Raksha Bandhan', 'Ã Â¤Â°Ã Â¤â€¢Ã Â¥ÂÃ Â¤Â·Ã Â¤Â¾Ã Â¤Â¬Ã Â¤â€šÃ Â¤Â§Ã Â¤Â¨',
 'Sacred bond between siblings. Sisters tie Rakhi on brothers'' wrists, brothers vow their protection. Celebrated on Shravan Purnima.',
 NULL, '2025-08-09', 1, 20),

('Janmashtami', 'Ã Â¤Å“Ã Â¤Â¨Ã Â¥ÂÃ Â¤Â®Ã Â¤Â¾Ã Â¤Â·Ã Â¥ÂÃ Â¤Å¸Ã Â¤Â®Ã Â¥â‚¬',
 'Birth of Lord Krishna, the eighth avatar of Vishnu. Midnight celebrations, Dahi Handi, and Bhagavat recitation. One of the most joyful festivals.',
 NULL, '2025-08-16', 2, 20),

('Ganesh Chaturthi', 'Ã Â¤â€”Ã Â¤Â£Ã Â¥â€¡Ã Â¤Â¶ Ã Â¤Å¡Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤Â¥Ã Â¥â‚¬',
 'Ten-day festival celebrating the birth of Lord Ganesha. Elaborately decorated Ganesha idols installed in homes and public pandals, culminating in Visarjan.',
 1, '2025-08-27', 10, 20),

('Navratri (Sharad)', 'Ã Â¤Â¶Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¦Ã Â¥â‚¬Ã Â¤Â¯ Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â°Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿',
 'Nine nights dedicated to the nine forms of Goddess Durga. Garba and Dandiya dances in Gujarat, Durga Puja in Bengal, Golu display in South India.',
 NULL, '2025-10-02', 9, 20),

('Durga Puja', 'Ã Â¤Â¦Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤â€”Ã Â¤Â¾ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Enormous pandals, cultural programs, and processions mark this 5-day festival in Bengal.',
 4, '2025-10-02', 5, 25),

('Dussehra (Vijayadashami)', 'Ã Â¤Â¦Ã Â¤Â¶Ã Â¤Â¹Ã Â¤Â°Ã Â¤Â¾ / Ã Â¤ÂµÃ Â¤Â¿Ã Â¤Å“Ã Â¤Â¯Ã Â¤Â¾Ã Â¤Â¦Ã Â¤Â¶Ã Â¤Â®Ã Â¥â‚¬',
 'Victory of Lord Rama over Ravana, celebrated on the tenth day after Navratri. Ravana effigies burned. Also marks Goddess Durga''s departure.',
 NULL, '2025-10-02', 1, 20),

('Kojagari Purnima', 'Ã Â¤â€¢Ã Â¥â€¹Ã Â¤Å“Ã Â¤Â¾Ã Â¤â€”Ã Â¤Â°Ã Â¥â‚¬ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â£Ã Â¤Â¿Ã Â¤Â®Ã Â¤Â¾',
 'Lakshmi Puja on the full moon of Ashwin. Goddess Lakshmi is said to descend and bless those who are awake at night.',
 2, '2025-10-07', 1, 20),

('Dhanteras', 'Ã Â¤Â§Ã Â¤Â¨Ã Â¤Â¤Ã Â¥â€¡Ã Â¤Â°Ã Â¤Â¸',
 'Two days before Diwali. Lord Dhanvantari, the physician of gods, is worshipped. Gold and silver purchases are considered auspicious.',
 NULL, '2025-10-20', 1, 20),

('Diwali (Deepavali)', 'Ã Â¤Â¦Ã Â¥â‚¬Ã Â¤ÂªÃ Â¤Â¾Ã Â¤ÂµÃ Â¤Â²Ã Â¥â‚¬',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas. Lord Rama''s return to Ayodhya is celebrated. Five-day festival culminating in Bhai Dooj.',
 2, '2025-10-20', 5, 25),

('Govardhan Puja', 'Ã Â¤â€”Ã Â¥â€¹Ã Â¤ÂµÃ Â¤Â°Ã Â¥ÂÃ Â¤Â§Ã Â¤Â¨ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'One day after Diwali. Celebrates Krishna''s lifting of Govardhan mountain to protect the villagers. Annakut (mountain of food) offering made to Lord.',
 NULL, '2025-10-22', 1, 20),

('Chhath Puja', 'Ã Â¤â€ºÃ Â¤Â  Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾',
 'Sun worship festival observed in Bihar, Jharkhand, and UP. Devotees stand in water at sunrise and sunset offering arghya to Surya Dev and Chhathi Maiya.',
 NULL, '2025-10-28', 4, 20),

('Kartik Purnima', 'Ã Â¤â€¢Ã Â¤Â¾Ã Â¤Â°Ã Â¥ÂÃ Â¤Â¤Ã Â¤Â¿Ã Â¤â€¢ Ã Â¤ÂªÃ Â¥â€šÃ Â¤Â°Ã Â¥ÂÃ Â¤Â£Ã Â¤Â¿Ã Â¤Â®Ã Â¤Â¾',
 'The most sacred full moon of the year. Holy dip at river ghats. Guru Nanak Jayanti is also celebrated on this day.',
 NULL, '2025-11-05', 1, 20),

('Vivah Panchami', 'Ã Â¤ÂµÃ Â¤Â¿Ã Â¤ÂµÃ Â¤Â¾Ã Â¤Â¹ Ã Â¤ÂªÃ Â¤â€šÃ Â¤Å¡Ã Â¤Â®Ã Â¥â‚¬',
 'The divine marriage of Lord Rama and Sita Mata. Celebrated with Ram-Sita wedding enactments in temples especially in Nepal and Janakpur.',
 NULL, '2025-11-27', 1, 20),

('Makar Sankranti 2026', 'Ã Â¤Â®Ã Â¤â€¢Ã Â¤Â° Ã Â¤Â¸Ã Â¤â€šÃ Â¤â€¢Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¾Ã Â¤â€šÃ Â¤Â¤Ã Â¤Â¿ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying.',
 NULL, '2026-01-14', 1, 20),

('Basant Panchami', 'Ã Â¤Â¬Ã Â¤Â¸Ã Â¤â€šÃ Â¤Â¤ Ã Â¤ÂªÃ Â¤â€šÃ Â¤Å¡Ã Â¤Â®Ã Â¥â‚¬',
 'Worship of Goddess Saraswati on the fifth day of spring. Students worship their books and musical instruments. Yellow clothing worn to honor the season.',
 NULL, '2026-01-26', 1, 20),

('Maha Shivratri 2026', 'Ã Â¤Â®Ã Â¤Â¹Ã Â¤Â¾Ã Â¤Â¶Ã Â¤Â¿Ã Â¤ÂµÃ Â¤Â°Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya.',
 NULL, '2026-02-15', 1, 20),

('Holi 2026', 'Ã Â¤Â¹Ã Â¥â€¹Ã Â¤Â²Ã Â¥â‚¬ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Festival of colors celebrating the victory of devotion over ego. Holika Dahan the night before.',
 NULL, '2026-03-03', 2, 20),

('Navratri (Chaitra) 2026', 'Ã Â¤Å¡Ã Â¥Ë†Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â° Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â°Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Nine-night Navratri in the spring month of Chaitra. Ram Navami falls on the ninth day.',
 NULL, '2026-03-29', 9, 20),

('Ram Navami 2026', 'Ã Â¤Â°Ã Â¤Â¾Ã Â¤Â® Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â®Ã Â¥â‚¬ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Celebration of the birth of Lord Rama.',
 NULL, '2026-03-27', 1, 20),

('Ganesh Chaturthi 2026', 'Ã Â¤â€”Ã Â¤Â£Ã Â¥â€¡Ã Â¤Â¶ Ã Â¤Å¡Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¥ÂÃ Â¤Â¥Ã Â¥â‚¬ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Ten-day festival celebrating the birth of Lord Ganesha.',
 1, '2026-08-17', 10, 20),

('Navratri (Sharad) 2026', 'Ã Â¤Â¶Ã Â¤Â¾Ã Â¤Â°Ã Â¤Â¦Ã Â¥â‚¬Ã Â¤Â¯ Ã Â¤Â¨Ã Â¤ÂµÃ Â¤Â°Ã Â¤Â¾Ã Â¤Â¤Ã Â¥ÂÃ Â¤Â°Ã Â¤Â¿ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Nine nights dedicated to the nine forms of Goddess Durga.',
 NULL, '2026-09-22', 9, 20),

('Diwali 2026', 'Ã Â¤Â¦Ã Â¥â‚¬Ã Â¤ÂªÃ Â¤Â¾Ã Â¤ÂµÃ Â¤Â²Ã Â¥â‚¬ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas.',
 2, '2026-10-09', 5, 25),

('Chhath Puja 2026', 'Ã Â¤â€ºÃ Â¤Â  Ã Â¤ÂªÃ Â¥â€šÃ Â¤Å“Ã Â¤Â¾ Ã Â¥Â¨Ã Â¥Â¦Ã Â¥Â¨Ã Â¥Â¬',
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

