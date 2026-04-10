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
('Kalash', 'कलश', 'Sacred water pot, symbolizes deity residence'),
('Mango Leaves', 'आम के पत्ते', 'Fresh mango leaves placed on Kalash'),
('Coconut', 'नारियल', 'Placed on top of Kalash, symbolizes Lord Shiva'),
('Roli (Kumkum)', 'रोली / कुमकुम', 'Red vermillion powder for tilak'),
('Akshat (Rice)', 'अक्षत', 'Unbroken rice grains offered during puja'),
('Incense Sticks (Agarbatti)', 'अगरबत्ती', 'Used to purify the atmosphere'),
('Ghee Diya', 'घी दीया', 'Earthen lamp with pure ghee wick'),
('Flowers (Pushpa)', 'पुष्प', 'Fresh flowers for deity offering'),
('Dhoti (White Cloth)', 'धोती', 'White cotton cloth for pandit to wear'),
('Paan Patta', 'पान पत्ता', 'Betel leaf for offering'),
('Supari', 'सुपारी', 'Areca nut, auspicious offering'),
('Camphor (Kapoor)', 'कपूर', 'Used in aarti for illumination'),
('Gangajal', 'गंगाजल', 'Holy water from River Ganga'),
('Chandan (Sandalwood)', 'चंदन', 'Sandalwood paste for tilak and fragrance'),
('Turmeric (Haldi)', 'हल्दी', 'Auspicious yellow powder'),
('Panchamrit', 'पंचामृत', 'Mixture of milk, curd, honey, sugar, ghee'),
('Tulsi Leaves', 'तुलसी पत्ते', 'Sacred basil leaves, especially for Vishnu puja'),
('Lotus Flower', 'कमल', 'Sacred flower of Lakshmi and Vishnu'),
('Sindoor', 'सिंदूर', 'Vermillion for married women during puja'),
('Dhoop', 'धूप', 'Resin incense for purification');

-- -------------------------------------------------------
-- PUJAS
-- -------------------------------------------------------
INSERT INTO pujas (name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, created_by, is_active) VALUES

('Ganesh Puja', 'गणेश पूजा',
 'The foundational puja performed at the beginning of every ritual. Lord Ganesha is the remover of obstacles and is invoked first to bless any endeavor.',
 60, 'BEGINNER', 'Vighnaharta', '/images/ganesh-puja.jpg', 1, TRUE),

('Lakshmi Puja', 'लक्ष्मी पूजा',
 'Worship of Goddess Lakshmi, the deity of wealth and prosperity. Performed especially on Diwali and Fridays.',
 90, 'BEGINNER', 'Wealth', '/images/lakshmi-puja.jpg', 1, TRUE),

('Satyanarayan Katha', 'सत्यनारायण कथा',
 'A complete Vishnu puja with the reading of Satyanarayan Vrat Katha. Performed on Purnima and for special occasions.',
 180, 'INTERMEDIATE', 'Vrat', '/images/satyanarayan.jpg', 1, TRUE),

('Rudrabhishek', 'रुद्राभिषेक',
 'Sacred ritual bathing of Shiva Linga with Panchamrit and Gangajal while chanting the Sri Rudram.',
 120, 'ADVANCED', 'Shaivite', '/images/rudrabhishek.jpg', 1, TRUE),

('Navratri Devi Puja', 'नवरात्रि देवी पूजा',
 'Nine-day worship of the nine forms of Goddess Durga during Navratri. Includes Durga Saptashati recitation.',
 150, 'INTERMEDIATE', 'Shakti', '/images/navratri.jpg', 1, TRUE),

('Griha Pravesh', 'गृह प्रवेश',
 'Housewarming ceremony invoking Vastu Purusha and Panchdeva for blessing the new home.',
 240, 'ADVANCED', 'Samskara', '/images/griha-pravesh.jpg', 1, TRUE),

-- 1. ADD TO PUJAS SECTION (Around Line 77)
('Durga Puja', 'दुर्गा पूजा',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Worship of the Divine Mother for strength, intellect, and prosperity.',
 300, 'ADVANCED', 'Shakti', '/images/durga-puja.jpg', 1, TRUE),

('Saraswati Puja', 'सरस्वती पूजा',
 'Worship of Goddess Saraswati, the deity of knowledge, music, arts, and wisdom. Celebrated with great devotion on Basant Panchami.',
 60, 'BEGINNER', 'Knowledge', '/images/saraswati-puja.jpg', 1, TRUE);



-- -------------------------------------------------------
-- MANTRAS (Devanagari)
-- -------------------------------------------------------
INSERT INTO mantras (shlok_text, transliteration, word_meanings, source_text) VALUES

-- Ganesh Vandana
('वक्रतुण्ड महाकाय सूर्यकोटि समप्रभ।\nनिर्विघ्नं कुरु मे देव सर्वकार्येषु सर्वदा॥',
 'Vakratunda Mahakaya Suryakoti Samaprabha\nNirvighnam Kuru Me Deva Sarvakaryeshu Sarvada',
 '[{"word":"वक्रतुण्ड","meaning":"One with curved trunk","role":"Nominative"},{"word":"महाकाय","meaning":"Mighty-bodied","role":"Nominative"},{"word":"सूर्यकोटि","meaning":"Crores of suns","role":"Nominative"},{"word":"समप्रभ","meaning":"Equal in radiance","role":"Nominative"},{"word":"निर्विघ्नम्","meaning":"Without obstacles","role":"Accusative"},{"word":"कुरु","meaning":"Make / grant","role":"Verb, Imperative"},{"word":"सर्वकार्येषु","meaning":"In all works/tasks","role":"Locative plural"},{"word":"सर्वदा","meaning":"Always","role":"Indeclinable"}]',
 'Traditional Ganesh Vandana'),

-- Lakshmi Mantra
('ॐ श्रीं ह्रीं श्रीं कमले कमलालये प्रसीद प्रसीद।\nश्रीं ह्रीं श्रीं ॐ महालक्ष्म्यै नमः॥',
 'Om Shrim Hrim Shrim Kamale Kamalaalaye Prasida Prasida\nShrim Hrim Shrim Om Mahalakshmyai Namah',
 '[{"word":"ॐ","meaning":"Primordial sacred syllable","role":"Invocation"},{"word":"श्रीं","meaning":"Bija mantra of Lakshmi","role":"Bija"},{"word":"ह्रीं","meaning":"Bija of Maya/Shakti","role":"Bija"},{"word":"कमले","meaning":"O Lotus-seated one","role":"Vocative"},{"word":"प्रसीद","meaning":"Be pleased, grace us","role":"Verb, Imperative"},{"word":"महालक्ष्म्यै","meaning":"To Maha Lakshmi","role":"Dative"},{"word":"नमः","meaning":"I bow / Salutation","role":"Indeclinable"}]',
 'Sri Sukta, Rigveda Khila'),

-- Satyanarayan Mantra
('ॐ नमो भगवते वासुदेवाय।',
 'Om Namo Bhagavate Vasudevaya',
 '[{"word":"ॐ","meaning":"Sacred syllable, the absolute","role":"Invocation"},{"word":"नमो","meaning":"Salutation","role":"Indeclinable"},{"word":"भगवते","meaning":"To the Divine Lord","role":"Dative"},{"word":"वासुदेवाय","meaning":"To Vasudeva (Krishna/Vishnu)","role":"Dative"}]',
 'Vishnu Purana, Dwadashakshari Mantra'),

-- Shiva Mantra (Panchakshara)
('ॐ नमः शिवाय।',
 'Om Namah Shivaya',
 '[{"word":"ॐ","meaning":"Primordial sound, the absolute truth","role":"Invocation"},{"word":"नमः","meaning":"Salutation, I bow","role":"Indeclinable"},{"word":"शिवाय","meaning":"To Shiva, the auspicious one","role":"Dative"}]',
 'Krishna Yajurveda, Taittiriya Samhita 4.5.1'),

-- Gayatri Mantra
('ॐ भूर्भुवः स्वः।\nतत्सवितुर्वरेण्यं भर्गो देवस्य धीमहि।\nधियो यो नः प्रचोदयात्॥',
 'Om Bhur Bhuvah Svah\nTat Savitur Varenyam Bhargo Devasya Dhimahi\nDhiyo Yo Nah Prachodayat',
 '[{"word":"ॐ","meaning":"Pranava, the primordial sound","role":"Invocation"},{"word":"भूः","meaning":"Earth","role":"Vyahrti"},{"word":"भुवः","meaning":"Atmosphere","role":"Vyahrti"},{"word":"स्वः","meaning":"Heaven / Upper realms","role":"Vyahrti"},{"word":"तत्","meaning":"That (transcendent)","role":"Pronoun"},{"word":"सवิตুঃ","meaning":"Of the Sun / Divine illuminator","role":"Genitive"},{"word":"वरेण्यम्","meaning":"Most excellent, most worshipful","role":"Accusative"},{"word":"भर्गः","meaning":"Radiance, purifying light","role":"Accusative"},{"word":"দেবস্য","meaning":"Of the deity","role":"Genitive"},{"word":"ধীমহি","meaning":"Let us meditate","role":"Verb, Optative"},{"word":"ধিয়ঃ","meaning":"Intellects, faculties of understanding","role":"Accusative"},{"word":"যঃ","meaning":"Who","role":"Relative pronoun"},{"word":"নঃ","meaning":"Our","role":"Genitive"},{"word":"প্রচোদয়াৎ","meaning":"May he inspire/guide","role":"Verb, Optative"}]',
 'Rigveda 3.62.10'),

-- Durga Mantra
('या देवी সর্বভূতেষু শক্তিরূপেণ সংস্থিতা।\nনমস্তসৈ্য নমস্তসৈ্য নমস্তসৈ্য নমো নমঃ॥',
 'Ya Devi Sarvabhuteshu Shaktirúpena Samsthita\nNamastasyai Namastasyai Namastasyai Namo Namah',
 '[{"word":"या","meaning":"Who (she who)","role":"Relative pronoun, feminine"},{"word":"देवी","meaning":"The Goddess","role":"Nominative"},{"word":"सर्वভূতেষু","meaning":"In all beings","role":"Locative plural"},{"word":"শক্তিরূপেণ","meaning":"In the form of Shakti/power","role":"Instrumental"},{"word":"সংসংস্থিতা","meaning":"Abiding, established","role":"Past participle"},{"word":"নমঃ","meaning":"Salutation","role":"Indeclinable"}]',
 'Durgasaptashati, Markandeya Purana'),

-- Kalash Sthapana Mantra
('কলশস্য মুখে বিষ্ণুর্কণ্ঠে রুদ্রঃ সমাশ্রিতঃ।\nমূলে তত্র স্থিতো ব্রহ্মা মধ্যে মাতৃগণাঃ স্মৃতাঃ॥',
 'Kalashasya Mukhe Vishnur Kanthe Rudrah Samashritah\nMule Tatra Sthito Brahma Madhye Matriganah Smritah',
 '[{"word":"কলশস্য","meaning":"Of the Kalash","role":"Genitive"},{"word":"মুখে","meaning":"In the mouth/opening","role":"Locative"},{"word":"বিষ্ণুঃ","meaning":"Lord Vishnu","role":"Nominative"},{"word":"কণ্ঠে","meaning":"In the neck","role":"Locative"},{"word":"রুদ্রঃ","meaning":"Lord Rudra/Shiva","role":"Nominative"},{"word":"সমাশ্রিতঃ","meaning":"Has taken residence","role":"Past participle"},{"word":"মূলে","meaning":"At the base","role":"Locative"},{"word":"ব্রহ্মা","meaning":"Lord Brahma","role":"Nominative"},{"word":"মধ্যে","meaning":"In the middle","role":"Locative"},{"word":"মাতৃগণাঃ","meaning":"The Divine Mothers","role":"Nominative"}]',
 'Traditional Kalash Sthapana Mantra');

-- -------------------------------------------------------
-- PUJA STEPS
-- -------------------------------------------------------
INSERT INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url) VALUES
(1, 1, 'Achamana', 'আচমন', 'Ritual purification.', 'https://www.youtube.com/watch?v=W0SclE-69S8'),
(1, 2, 'Sankalpa', 'সংকল্প', 'Sacred vow.', 'https://www.youtube.com/watch?v=W0SclE-69S8'),
(7, 1, 'Invocation', 'আবাহন', 'Awakening Durga.', 'https://www.youtube.com/watch?v=FjIuK75Noyk'),
(8, 1, 'Invocation', 'আবাহন', 'Awakening Saraswati.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w'),
(8, 2, 'Pushpanjali', 'পুষ্পাঞ্জলি', 'Flower offering.', 'https://www.youtube.com/watch?v=R0g3v_B1q_w');

-- -------------------------------------------------------
-- RESOURCES
-- -------------------------------------------------------
DELETE FROM resources WHERE puja_id IN (1, 7, 8);
INSERT INTO resources (puja_id, title, resource_type, file_url, is_downloadable) VALUES
(1, 'Ganesh Puja Paddhati', 'PDF', 'https://archive.org/details/dli.ministry.04644/page/n5/mode/2up', TRUE),
(7, 'Durga Puja Paddhati', 'PDF', 'https://archive.org/details/DurgapujaPaddhati/page/n1/mode/2up', TRUE),
(8, 'Saraswati Puja Paddhati', 'PDF', 'https://archive.org/details/saraswati-puja-paddhati-2020/page/n1/mode/2up', TRUE);

-- -------------------------------------------------------
-- HINDU FESTIVALS
-- -------------------------------------------------------
INSERT INTO hindu_festivals (name, name_devanagari, description, puja_id, event_date, days_duration, notification_days_before) VALUES
('Fresh, unbroken'),
(3, 3, '1 piece', 'Unbroken coconut only'),
(3, 13, 'Full pot', 'Fill completely'),
(3, 4, '1 pinch', 'Apply on Kalash'),
(3, 14, '1 teaspoon', 'Mix with water for paste'),
(4, 8, 'Handful', 'Red flowers preferred for Ganesha'),
(4, 5, '1 handful', 'Unbroken rice only'),
(4, 7, '1 diya', 'Pure ghee preferred'),
(4, 15, '1 pinch', 'Mixed with akshat'),
(5, 12, '2 pieces', 'Double camphor for bright flame'),
(5, 7, '1 diya', 'Ghee diya for main aarti');

-- -------------------------------------------------------
-- RESOURCES (PDF books)
-- -------------------------------------------------------
INSERT INTO resources (puja_id, title, resource_type, file_url, page_count, is_downloadable) VALUES
(1, 'Ganesh Puja Paddhati', 'PDF', '/pdfs/ganesh-paddhati.pdf', 45, FALSE),
(2, 'Lakshmi Puja Manual', 'PDF', '/pdfs/lakshmi-paddhati.pdf', 60, FALSE),
(3, 'Satyanarayan Vrat Katha', 'PDF', '/pdfs/satyanarayan-katha.pdf', 80, TRUE),
(4, 'Sri Rudram with Translation', 'PDF', '/pdfs/sri-rudram.pdf', 120, FALSE),
(5, 'Durga Saptashati (Full)', 'PDF', '/pdfs/durga-saptashati.pdf', 200, TRUE),
(7, 'Durga Puja Paddhati', 'PDF', '/pdfs/durga-puja-paddhati.pdf', 85, TRUE);

-- -------------------------------------------------------
-- HINDU FESTIVALS 2025 - 2026
-- -------------------------------------------------------
INSERT INTO hindu_festivals (name, name_devanagari, description, puja_id, event_date, days_duration, notification_days_before) VALUES

('Makar Sankranti', 'मकर संक्रांति',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying. Begins the auspicious Uttarayan period.',
 NULL, '2025-01-14', 1, 20),

('Maha Shivratri', 'महाशिवरात्रि',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya. Most sacred night for Shaivites.',
 4, '2025-02-26', 1, 20),

('Holi', 'होली',
 'Festival of colors celebrating the victory of Prahlada (devotion) over Hiranyakashipu (ego) and the burning of Holika. Rang Panchami follows five days later.',
 NULL, '2025-03-14', 2, 20),

('Ram Navami', 'राम नवमी',
 'Celebration of the birth of Lord Rama, the seventh avatar of Vishnu. Ramayana recitation and Puja of Rama Parivar are central activities.',
 NULL, '2025-04-06', 1, 20),

('Hanuman Jayanti', 'हनुमान जयंती',
 'Birthday of Lord Hanuman. Recitation of Hanuman Chalisa, Sundar Kanda, and distribution of prasad of sindoor and oil.',
 NULL, '2025-04-12', 1, 20),

('Akshaya Tritiya', 'अक्षय तृतीया',
 'One of the most auspicious days in the Hindu calendar. Any charitable act or purchase done on this day is believed to grow manifold.',
 1, '2025-04-30', 1, 20),

('Nirjala Ekadashi', 'निर्जला एकादशी',
 'The toughest of all Ekadashis - a waterless fast. Observed in the scorching summer heat. Dedicated to Lord Vishnu. Said to be equivalent to all 24 Ekadashi fasts.',
 NULL, '2025-06-07', 1, 20),

('Guru Purnima', 'गुरु पूर्णिमा',
 'Full moon day dedicated to the Guru-disciple relationship. Offerings made to one''s spiritual teacher and to Veda Vyasa, compiler of the Vedas.',
 NULL, '2025-07-10', 1, 20),

('Nag Panchami', 'नाग पंचमी',
 'Worship of the Naga (serpent) deities. Milk offered at snake shrines. Part of the Shravan month sacred to Lord Shiva.',
 NULL, '2025-07-29', 1, 20),

('Raksha Bandhan', 'रक्षाबंधन',
 'Sacred bond between siblings. Sisters tie Rakhi on brothers'' wrists, brothers vow their protection. Celebrated on Shravan Purnima.',
 NULL, '2025-08-09', 1, 20),

('Janmashtami', 'जन्माष्टमी',
 'Birth of Lord Krishna, the eighth avatar of Vishnu. Midnight celebrations, Dahi Handi, and Bhagavat recitation. One of the most joyful festivals.',
 NULL, '2025-08-16', 2, 20),

('Ganesh Chaturthi', 'गणेश चतुर्थी',
 'Ten-day festival celebrating the birth of Lord Ganesha. Elaborately decorated Ganesha idols installed in homes and public pandals, culminating in Visarjan.',
 1, '2025-08-27', 10, 20),

('Navratri (Sharad)', 'शारदीय नवरात्रि',
 'Nine nights dedicated to the nine forms of Goddess Durga. Garba and Dandiya dances in Gujarat, Durga Puja in Bengal, Golu display in South India.',
 5, '2025-10-02', 9, 20),

('Durga Puja', 'दुर्गा पूजा',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Enormous pandals, cultural programs, and processions mark this 5-day festival in Bengal.',
 7, '2025-10-02', 5, 25),

('Dussehra (Vijayadashami)', 'दशहरा / विजयादशमी',
 'Victory of Lord Rama over Ravana, celebrated on the tenth day after Navratri. Ravana effigies burned. Also marks Goddess Durga''s departure.',
 NULL, '2025-10-02', 1, 20),

('Kojagari Purnima', 'कोजागरी पूर्णिमा',
 'Lakshmi Puja on the full moon of Ashwin. Goddess Lakshmi is said to descend and bless those who are awake at night.',
 2, '2025-10-07', 1, 20),

('Dhanteras', 'धनतेरस',
 'Two days before Diwali. Lord Dhanvantari, the physician of gods, is worshipped. Gold and silver purchases are considered auspicious.',
 NULL, '2025-10-20', 1, 20),

('Diwali (Deepavali)', 'दीपावली',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas. Lord Rama''s return to Ayodhya is celebrated. Five-day festival culminating in Bhai Dooj.',
 2, '2025-10-20', 5, 25),

('Govardhan Puja', 'गोवर्धन पूजा',
 'One day after Diwali. Celebrates Krishna''s lifting of Govardhan mountain to protect the villagers. Annakut (mountain of food) offering made to Lord.',
 NULL, '2025-10-22', 1, 20),

('Chhath Puja', 'छठ पूजा',
 'Sun worship festival observed in Bihar, Jharkhand, and UP. Devotees stand in water at sunrise and sunset offering arghya to Surya Dev and Chhathi Maiya.',
 NULL, '2025-10-28', 4, 20),

('Kartik Purnima', 'कार्तिक पूर्णिमा',
 'The most sacred full moon of the year. Holy dip at river ghats. Guru Nanak Jayanti is also celebrated on this day.',
 NULL, '2025-11-05', 1, 20),

('Vivah Panchami', 'विवाह पंचमी',
 'The divine marriage of Lord Rama and Sita Mata. Celebrated with Ram-Sita wedding enactments in temples especially in Nepal and Janakpur.',
 NULL, '2025-11-27', 1, 20),

('Makar Sankranti 2026', 'मकर संक्रांति २०२६',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying.',
 NULL, '2026-01-14', 1, 20),

('Basant Panchami', 'बसंत पंचमी',
 'Worship of Goddess Saraswati on the fifth day of spring. Students worship their books and musical instruments. Yellow clothing worn to honor the season.',
 NULL, '2026-01-26', 1, 20),

('Maha Shivratri 2026', 'महाशिवरात्रि २०२६',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya.',
 4, '2026-02-15', 1, 20),

('Holi 2026', 'होली २०२६',
 'Festival of colors celebrating the victory of devotion over ego. Holika Dahan the night before.',
 NULL, '2026-03-03', 2, 20),

('Navratri (Chaitra) 2026', 'चैत्र नवरात्रि २०२६',
 'Nine-night Navratri in the spring month of Chaitra. Ram Navami falls on the ninth day.',
 5, '2026-03-29', 9, 20),

('Ram Navami 2026', 'राम नवमी २०२६',
 'Celebration of the birth of Lord Rama.',
 NULL, '2026-04-06', 1, 20),

('Ganesh Chaturthi 2026', 'गणेश चतुर्थी २०२६',
 'Ten-day festival celebrating the birth of Lord Ganesha.',
 1, '2026-08-17', 10, 20),

('Navratri (Sharad) 2026', 'शारदीय नवरात्रि २०२६',
 'Nine nights dedicated to the nine forms of Goddess Durga.',
 5, '2026-09-22', 9, 20),

('Diwali 2026', 'दीपावली २०२६',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas.',
 2, '2026-10-09', 5, 25),

('Chhath Puja 2026', 'छठ पूजा २०२६',
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