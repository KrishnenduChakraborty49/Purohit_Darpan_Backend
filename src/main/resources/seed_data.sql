-- ============================================================
-- Purohit Darpan - Seed Data
-- Festivals 2025-2026, Sample Pujas, Mantras, Samagri
-- ============================================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- -------------------------------------------------------
-- ADMIN USER
-- password: Admin@123 (BCrypt hash)
-- -------------------------------------------------------
INSERT IGNORE INTO users (username, email, password_hash, full_name, role, is_active)
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
INSERT IGNORE INTO samagri (name, name_devanagari, description) VALUES
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
INSERT IGNORE INTO pujas (name, name_devanagari, description, duration_minutes, difficulty, category, thumbnail_url, created_by) VALUES
('Ganesh Puja', 'गणेश पूजा',
 'The foundational puja performed at the beginning of every ritual. Lord Ganesha is the remover of obstacles and is invoked first to bless any endeavor.',
 60, 'BEGINNER', 'Vighnaharta', '/images/ganesh-puja.jpg', 1),

('Lakshmi Puja', 'लक्ष्मी पूजा',
 'Worship of Goddess Lakshmi, the deity of wealth and prosperity. Performed especially on Diwali and Fridays.',
 90, 'BEGINNER', 'Wealth', '/images/lakshmi-puja.jpg', 1),

('Satyanarayan Katha', 'सत्यनारायण कथा',
 'A complete Vishnu puja with the reading of Satyanarayan Vrat Katha. Performed on Purnima and for special occasions.',
 180, 'INTERMEDIATE', 'Vrat', '/images/satyanarayan.jpg', 1),

('Durga Puja', 'दुर्गा पूजा',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Worship of the Divine Mother for strength, intellect, and prosperity.',
 300, 'ADVANCED', 'Shakti', '/images/durga-puja.jpg', 1),

('Saraswati Puja', 'सरस्वती पूजा',
 'Worship of the Goddess of Knowledge, Music, Art, and Wisdom. Especially performed by students and artists on Vasant Panchami.',
 60, 'BEGINNER', 'Wisdom', '/images/saraswati-puja.jpg', 1);

-- -------------------------------------------------------
-- MANTRAS (Devanagari)
-- -------------------------------------------------------
INSERT IGNORE INTO mantras (shlok_text, transliteration, word_meanings, source_text) VALUES

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
 '[{"word":"ॐ","meaning":"Pranava, the primordial sound","role":"Invocation"},{"word":"भूः","meaning":"Earth","role":"Vyahrti"},{"word":"भुवः","meaning":"Atmosphere","role":"Vyahrti"},{"word":"स्वः","meaning":"Heaven / Upper realms","role":"Vyahrti"},{"word":"तत्","meaning":"That (transcendent)","role":"Pronoun"},{"word":"सवितुः","meaning":"Of the Sun / Divine illuminator","role":"Genitive"},{"word":"वरेण्यम्","meaning":"Most excellent, most worshipful","role":"Accusative"},{"word":"भर्गः","meaning":"Radiance, purifying light","role":"Accusative"},{"word":"देवस्य","meaning":"Of the deity","role":"Genitive"},{"word":"धीमहि","meaning":"Let us meditate","role":"Verb, Optative"},{"word":"धियः","meaning":"Intellects, faculties of understanding","role":"Accusative"},{"word":"यः","meaning":"Who","role":"Relative pronoun"},{"word":"नः","meaning":"Our","role":"Genitive"},{"word":"प्रचोदयात्","meaning":"May he inspire/guide","role":"Verb, Optative"}]',
 'Rigveda 3.62.10'),

-- Durga Mantra
('या देवी सर्वभूतेषु शक्तिरूपेण संस्थिता।\nनमस्तस्यै नमस्तस्यै नमस्तस्यै नमो नमः॥',
 'Ya Devi Sarvabhuteshu Shaktirúpena Samsthita\nNamastasyai Namastasyai Namastasyai Namo Namah',
 '[{"word":"या","meaning":"Who (she who)","role":"Relative pronoun, feminine"},{"word":"देवी","meaning":"The Goddess","role":"Nominative"},{"word":"सर्वभूतेषु","meaning":"In all beings","role":"Locative plural"},{"word":"शक्तिरूपेण","meaning":"In the form of Shakti/power","role":"Instrumental"},{"word":"संस्थिता","meaning":"Abiding, established","role":"Past participle"},{"word":"नमः","meaning":"Salutation","role":"Indeclinable"}]',
 'Durgasaptashati, Markandeya Purana'),

-- Kalash Sthapana Mantra
('कलशस्य मुखे विष्णुर्कण्ठे रुद्रः समाश्रितः।\nमूले तत्र स्थितो ब्रह्मा मध्ये मातृगणाः स्मृताः॥',
 'Kalashasya Mukhe Vishnur Kanthe Rudrah Samashritah\nMule Tatra Sthito Brahma Madhye Matriganah Smritah',
 '[{"word":"कलशस्य","meaning":"Of the Kalash","role":"Genitive"},{"word":"मुखे","meaning":"In the mouth/opening","role":"Locative"},{"word":"विष्णुः","meaning":"Lord Vishnu","role":"Nominative"},{"word":"कण्ठे","meaning":"In the neck","role":"Locative"},{"word":"रुद्रः","meaning":"Lord Rudra/Shiva","role":"Nominative"},{"word":"समाश्रितः","meaning":"Has taken residence","role":"Past participle"},{"word":"मूले","meaning":"At the base","role":"Locative"},{"word":"ब्रह्मा","meaning":"Lord Brahma","role":"Nominative"},{"word":"मध्ये","meaning":"In the middle","role":"Locative"},{"word":"मातृगणाः","meaning":"The Divine Mothers","role":"Nominative"}]',
 'Traditional Kalash Sthapana Mantra');

-- -------------------------------------------------------
-- PUJA STEPS - Ganesh Puja (puja_id = 1)
-- -------------------------------------------------------
INSERT IGNORE INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(1, 1, 'Ganesh Puja Mantra', 'गणेश पूजा मन्त्र',
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
INSERT IGNORE INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(2, 1, 'Puja Mantra', 'पूजा मन्त्र',
 '<h3>Puja Mantra - Invoking Goddess Lakshmi</h3><p>Chant the sacred mantras to invoke Goddess Lakshmi for wealth and prosperity.</p>',
 'https://www.youtube.com/embed/knY4cUlCNXc',
 'In this step we chant the sacred Lakshmi Puja mantras...'),

(2, 2, 'Panchali', 'पांचाली',
 '<h3>Panchali - The Sacred Story</h3><p>Recite or listen to the Kojagari Lakshmi Vrat Katha (Panchali) which details the glory of the Goddess.</p>',
 'https://www.youtube.com/embed/dsWdH8-U8u8',
 'The Panchali describes the divine blessings of Goddess Lakshmi...');

-- -------------------------------------------------------
-- PUJA STEPS - Satyanarayan Puja (puja_id = 3)
-- -------------------------------------------------------
INSERT IGNORE INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(3, 1, 'Satyanarayan Puja Mantra Part 1', 'सत्यनारायण पूजा मन्त्र भाग १',
 '<h3>Satyanarayan Puja Mantra (Part 1)</h3><p>Begin the worship of Lord Shri Hari Vishnu with the foundational mantras and offerings.</p>',
 'https://www.youtube.com/embed/WKxIK_IMT98',
 'In the first part of the Satyanarayan Puja, we start with the purification and foundational mantras...'),

(3, 2, 'Satyanarayan Puja Mantra Part 2', 'सत्यनारायण पूजा मन्त्र भाग २',
 '<h3>Satyanarayan Puja Mantra (Part 2)</h3><p>Continue the profound worship and offerings to the Lord of Truth.</p>',
 'https://www.youtube.com/embed/uyEsWHJEjsQ',
 'Moving forward in the puja, we continue the sacred offerings to Lord Vishnu...'),

(3, 3, 'Satyanarayan Broto Kotha', 'सत्यनारायण व्रत कथा',
 '<h3>Satyanarayan Broto Kotha</h3><p>Listen to the divine stories detailing the glory and blessings of observing the Satyanarayan Vrat.</p>',
 'https://www.youtube.com/embed/JikutyOWrZs',
 'The Satyanarayan Katha narrates the divine grace of Lord Vishnu...');

-- -------------------------------------------------------
-- PUJA STEPS - Durga Puja (puja_id = 4) Multi-Lingual
-- -------------------------------------------------------
INSERT IGNORE INTO puja_steps (puja_id, step_order, title, title_devanagari, title_bengali, title_sanskrit, description, video_url, video_transcript) VALUES

(4, 1, 'Sasthi', 'षष्ठी', 'ষষ্ঠী', 'षष्ठी',
 '<h3>षष्ठी - Sasthi</h3><p>The commencement of Durga Puja with Kalparambha, Bodhon, Amantran, and Adhivas. Goddess Durga is awakened under a Bilva (Bael) tree.</p>',
 'https://www.youtube.com/embed/JAl7pjMa2q8',
 'We begin Durga Puja with Bodhon on Shashthi tithi...'),

(4, 2, 'Saptami', 'सप्तमी', 'সপ্তমী', 'सप्तमी',
 '<h3>सप्तमी - Saptami</h3><p>Installation of Navapatrika (nine plants) representing nine forms of Goddess Durga, followed by the morning Prana Pratishtha and main puja.</p>',
 'https://www.youtube.com/embed/5u-uulot9X4',
 'Navapatrika represents the presence of Durga in nature...'),

(4, 3, 'Aastami', 'अष्टमी', 'অষ্টমী', 'अष्टमी',
 '<h3>अष्टमी - Maha Ashtami</h3><p>The most important day of worship. Devotees offer flowers (Pushpanjali) while fasting, and Kumari Puja is performed to honor the divine feminine.</p>',
 'https://www.youtube.com/embed/yQt_GhyWOXc',
 'The Ashtami Pushpanjali is offered with complete devotion...'),

(4, 4, 'Sandhi Puja', 'संधि पूजा', 'সন্ধি পূজা', 'सन्धिकालापूजा',
 '<h3>संधि पूजा - Sandhi Puja</h3><p>Performed at the exact juncture when Ashtami ends and Navami begins. 108 lamps are lit and 108 lotuses are offered to Goddess Chamunda.</p>',
 'https://www.youtube.com/embed/Ke7NDOzGSXM',
 'Sandhi Puja requires precise timing and 108 lamps...'),

(4, 5, 'Navami', 'नवमी', 'নবমী', 'नवमी',
 '<h3>नवमी - Maha Navami</h3><p>The concluding day of formal worship. Maha Aarti is performed, and the grand Homam (fire sacrifice) seals the ritual energy.</p>',
 'https://www.youtube.com/embed/roS3QBV_xyU',
 'Maha Navami brings the culmination of the grand puja...'),

(4, 6, 'Dashami', 'दशमी', 'দশমী', 'दशमी',
 '<h3>दशमी - Vijaya Dashami</h3><p>The farewell journey of the Goddess. Sindoor Khela is celebrated by women, followed by the immersion (Visarjan) of the idol in water.</p>',
 'https://www.youtube.com/embed/uBr9f0tMrGs',
 'As we bid farewell to Maa Durga, we chant "Asche bochor abar hobe"...');

-- -------------------------------------------------------
-- PUJA STEPS - Saraswati Puja (puja_id = 5)
-- -------------------------------------------------------
INSERT IGNORE INTO puja_steps (puja_id, step_order, title, title_devanagari, description, video_url, video_transcript) VALUES

(5, 1, 'Saraswati Vandana', 'सरस्वती वन्दना',
 '<h3>Saraswati Vandana</h3><p>Chant the Ya Kundendu tushara hara dhavala mantra to invoke the Goddess of Learning and seek blessings for intellect and creativity.</p>',
 'https://www.youtube.com/embed/8aN-DCABQcc',
 'We begin the puja by offering white flowers and chanting the Saraswati Vandana...');

-- -------------------------------------------------------
-- STEP_MANTRAS - map mantras to steps
-- -------------------------------------------------------
INSERT IGNORE INTO step_mantras (step_id, mantra_id, sequence_order) VALUES
(1, 1, 1);

-- -------------------------------------------------------
-- STEP SAMAGRI REQUIREMENTS
-- -------------------------------------------------------
INSERT IGNORE INTO step_samagri (step_id, samagri_id, quantity, notes) VALUES
(1, 13, '3 sips', 'Use copper spoon for sipping');

-- -------------------------------------------------------
-- RESOURCES (PDF books)
-- -------------------------------------------------------
INSERT IGNORE INTO resources (puja_id, title, resource_type, file_url, page_count, is_downloadable) VALUES
(1, 'Ganesh Puja Paddhati', 'PDF', 'http://localhost:8080/pdfs/Ganesh_Puja_Paddhati.pdf', 45, TRUE),
(1, 'Ganesh Puja Complete Guide', 'VIDEO', 'https://youtu.be/DUIrds34eeg?si=h9VZj8_6ctWhq8RO', NULL, FALSE),
(2, 'Lakshmi Puja Manual', 'PDF', '/pdfs/lakshmi-paddhati.pdf', 60, FALSE),
(3, 'Satyanarayan Vrat Katha', 'PDF', '/pdfs/satyanarayan-katha.pdf', 80, TRUE),
(4, 'Durga Puja Paddhati', 'PDF', '/pdfs/durga-puja-paddhati.pdf', 85, TRUE),
(4, 'Purohit Darpan Durga Puja Paddhati', 'PDF', 'http://localhost:8080/pdfs/Purohit_Darpan_Durgapuja_Paddhati.pdf', NULL, TRUE);

-- -------------------------------------------------------
-- HINDU FESTIVALS 2025 - 2026
-- -------------------------------------------------------
INSERT IGNORE INTO hindu_festivals (name, name_devanagari, description, puja_id, event_date, days_duration, notification_days_before) VALUES

('Makar Sankranti', 'मकर संक्रांति',
 'The festival marking the transition of the sun into Capricorn. Celebrated with horse bathing at holy rivers and kite flying. Begins the auspicious Uttarayan period.',
 NULL, '2025-01-14', 1, 20),

('Maha Shivratri', 'महाशिवरात्रि',
 'The great night of Shiva. Devotees fast throughout the day and night, performing Rudrabhishek and chanting Om Namah Shivaya. Most sacred night for Shaivites.',
 NULL, '2025-02-26', 1, 20),

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
 NULL, '2025-10-02', 9, 20),

('Durga Puja', 'दुर्गा पूजा',
 'The grand celebration of Goddess Durga''s victory over the demon Mahishasura. Enormous pandals, cultural programs, and processions mark this 5-day festival in Bengal.',
 4, '2025-10-02', 5, 25),

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
 NULL, '2026-02-15', 1, 20),

('Holi 2026', 'होली २०२६',
 'Festival of colors celebrating the victory of devotion over ego. Holika Dahan the night before.',
 NULL, '2026-03-03', 2, 20),

('Navratri (Chaitra) 2026', 'चैत्र नवरात्रि २०२६',
 'Nine-night Navratri in the spring month of Chaitra. Ram Navami falls on the ninth day.',
 NULL, '2026-03-29', 9, 20),

('Ram Navami 2026', 'राम नवमी २०२६',
 'Celebration of the birth of Lord Rama.',
 NULL, '2026-03-27', 1, 20),

('Ganesh Chaturthi 2026', 'गणेश चतुर्थी २०२६',
 'Ten-day festival celebrating the birth of Lord Ganesha.',
 1, '2026-08-17', 10, 20),

('Navratri (Sharad) 2026', 'शारदीय नवरात्रि २०२६',
 'Nine nights dedicated to the nine forms of Goddess Durga.',
 NULL, '2026-09-22', 9, 20),

('Diwali 2026', 'दीपावली २०२६',
 'Festival of Lights - Goddess Lakshmi is worshipped with elaborately lit diyas.',
 2, '2026-10-09', 5, 25),

('Chhath Puja 2026', 'छठ पूजा २०२६',
 'Sun worship festival observed in Bihar, Jharkhand, and UP.',
 NULL, '2026-10-17', 4, 20);

-- -------------------------------------------------------
-- USER NOTIFICATION PREFERENCES
-- -------------------------------------------------------
INSERT IGNORE INTO user_notification_preferences
    (user_id, festival_reminders, panchang_alerts, learning_reminders, puja_practice, reminder_days_before)
VALUES
(1, TRUE, TRUE, TRUE, TRUE, 20),
(2, TRUE, TRUE, TRUE, TRUE, 20),
(3, TRUE, TRUE, TRUE, TRUE, 20);

-- -------------------------------------------------------
-- MAP RESOURCES TO DURGA PUJA STEPS
-- -------------------------------------------------------
UPDATE puja_steps SET pdf_resource_id = 6 WHERE puja_id = 4;
