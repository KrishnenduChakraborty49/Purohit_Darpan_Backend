package com.purohitdarpan.util;

import java.util.HashMap;
import java.util.Map;

public class BengaliTranslator {

    private static final Map<String, String> TITHI_MAP = new HashMap<>();
    private static final Map<String, String> NAKSHATRA_MAP = new HashMap<>();
    private static final Map<String, String> YOGA_MAP = new HashMap<>();
    private static final Map<String, String> KARANA_MAP = new HashMap<>();
    private static final Map<String, String> DAY_MAP = new HashMap<>();

    static {
        // Tithis
        TITHI_MAP.put("Pratipada", "প্রতিপদ");
        TITHI_MAP.put("Dwitiya", "দ্বিতীয়া");
        TITHI_MAP.put("Tritiya", "তৃতীয়া");
        TITHI_MAP.put("Chaturthi", "চতুর্থী");
        TITHI_MAP.put("Panchami", "পঞ্চমী");
        TITHI_MAP.put("Shashti", "ষষ্ঠী");
        TITHI_MAP.put("Shashthi", "ষষ্ঠী");
        TITHI_MAP.put("Saptami", "সপ্তমী");
        TITHI_MAP.put("Ashtami", "অষ্টমী");
        TITHI_MAP.put("Navami", "নবমী");
        TITHI_MAP.put("Dashami", "দশমী");
        TITHI_MAP.put("Ekadashi", "একাদশী");
        TITHI_MAP.put("Dwadashi", "দ্বাদশী");
        TITHI_MAP.put("Trayodashi", "ত্রয়োদশী");
        TITHI_MAP.put("Chaturdashi", "চতুর্দশী");
        TITHI_MAP.put("Purnima", "পূর্ণিমা");
        TITHI_MAP.put("Amavasya", "অমাবস্যা");

        // Nakshatras
        NAKSHATRA_MAP.put("Ashwini", "অশ্বিনী");
        NAKSHATRA_MAP.put("Bharani", "ভরণী");
        NAKSHATRA_MAP.put("Krittika", "কৃত্তিকা");
        NAKSHATRA_MAP.put("Rohini", "রোহিণী");
        NAKSHATRA_MAP.put("Mrigashira", "মৃগশিরা");
        NAKSHATRA_MAP.put("Ardra", "আর্দ্রা");
        NAKSHATRA_MAP.put("Punarvasu", "পুনর্বসু");
        NAKSHATRA_MAP.put("Pushya", "পুষ্যা");
        NAKSHATRA_MAP.put("Ashlesha", "অশ্লেষা");
        NAKSHATRA_MAP.put("Magha", "মঘা");
        NAKSHATRA_MAP.put("Purva Phalguni", "পূর্ব ফাল্গুনী");
        NAKSHATRA_MAP.put("Uttara Phalguni", "উত্তর ফাল্গুনী");
        NAKSHATRA_MAP.put("Hasta", "হস্তা");
        NAKSHATRA_MAP.put("Chitra", "চিত্রা");
        NAKSHATRA_MAP.put("Swati", "স্বাতী");
        NAKSHATRA_MAP.put("Vishakha", "বিশাখা");
        NAKSHATRA_MAP.put("Anuradha", "অনুরাধা");
        NAKSHATRA_MAP.put("Jyeshtha", "জ্যেষ্ঠা");
        NAKSHATRA_MAP.put("Mula", "মূলা");
        NAKSHATRA_MAP.put("Purva Ashadha", "পূর্বাষাঢ়া");
        NAKSHATRA_MAP.put("Uttara Ashadha", "উত্তরাষাঢ়া");
        NAKSHATRA_MAP.put("Shravana", "শ্রবণা");
        NAKSHATRA_MAP.put("Dhanishtha", "ধনিষ্ঠা");
        NAKSHATRA_MAP.put("Shatabhisha", "শতভিষা");
        NAKSHATRA_MAP.put("Purva Bhadrapada", "পূর্ব ভাদ্রপদ");
        NAKSHATRA_MAP.put("Uttara Bhadrapada", "উত্তর ভাদ্রপদ");
        NAKSHATRA_MAP.put("Revati", "রেবতী");

        // Yogas
        YOGA_MAP.put("Vishkambha", "বিষ্কুম্ভ");
        YOGA_MAP.put("Priti", "প্রীতি");
        YOGA_MAP.put("Ayushman", "আয়ুষ্মান");
        YOGA_MAP.put("Saubhagya", "সৌভাগ্য");
        YOGA_MAP.put("Shobhana", "শোভন");
        YOGA_MAP.put("Atiganda", "অতিগণ্ড");
        YOGA_MAP.put("Sukarma", "সুকর্মা");
        YOGA_MAP.put("Dhriti", "ধৃতি");
        YOGA_MAP.put("Shula", "শূল");
        YOGA_MAP.put("Ganda", "গণ্ড");
        YOGA_MAP.put("Vriddhi", "বৃদ্ধি");
        YOGA_MAP.put("Dhruva", "ধ্রুব");
        YOGA_MAP.put("Vyaghata", "ব্যাঘাত");
        YOGA_MAP.put("Harshana", "হর্ষণ");
        YOGA_MAP.put("Vajra", "বজ্র");
        YOGA_MAP.put("Siddhi", "সিদ্ধি");
        YOGA_MAP.put("Vyatipata", "ব্যতীপাত");
        YOGA_MAP.put("Variyan", "বরীয়ান");
        YOGA_MAP.put("Parigha", "পরিঘ");
        YOGA_MAP.put("Shiva", "শিব");
        YOGA_MAP.put("Siddha", "সিদ্ধ");
        YOGA_MAP.put("Sadhya", "সাধ্য");
        YOGA_MAP.put("Shubha", "শুভ");
        YOGA_MAP.put("Shukla", "শুক্ল");
        YOGA_MAP.put("Brahma", "ব্রহ্ম");
        YOGA_MAP.put("Indra", "ইন্দ্র");
        YOGA_MAP.put("Vaidhriti", "বৈধৃতি");

        // Karanas
        KARANA_MAP.put("Bava", "বব");
        KARANA_MAP.put("Balava", "বালব");
        KARANA_MAP.put("Kaulava", "কৌলব");
        KARANA_MAP.put("Taitila", "তৈথিল");
        KARANA_MAP.put("Gara", "গর");
        KARANA_MAP.put("Vanija", "বণিজ");
        KARANA_MAP.put("Vishti", "বিষ্টি (ভদ্রা)");
        KARANA_MAP.put("Shakuni", "শকুনি");
        KARANA_MAP.put("Chatushpada", "চতুষ্পদ");
        KARANA_MAP.put("Naga", "নাগ");
        KARANA_MAP.put("Kintughna", "কিস্তুঘ্ন");

        // Days
        DAY_MAP.put("Sunday", "রবিবার");
        DAY_MAP.put("Monday", "সোমবার");
        DAY_MAP.put("Tuesday", "মঙ্গলবার");
        DAY_MAP.put("Wednesday", "বুধবার");
        DAY_MAP.put("Thursday", "বৃহস্পতিবার");
        DAY_MAP.put("Friday", "শুক্রবার");
        DAY_MAP.put("Saturday", "শনিবার");
    }

    public static String translateTithi(String english) {
        return translate(english, TITHI_MAP);
    }

    public static String translateNakshatra(String english) {
        return translate(english, NAKSHATRA_MAP);
    }

    public static String translateYoga(String english) {
        return translate(english, YOGA_MAP);
    }

    public static String translateKarana(String english) {
        return translate(english, KARANA_MAP);
    }

    public static String translateDay(String english) {
        return translate(english, DAY_MAP);
    }

    private static String translate(String english, Map<String, String> map) {
        if (english == null) return "";
        // Try exact match
        String translated = map.get(english);
        if (translated != null) return translated;
        
        // Try ignoring case
        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (entry.getKey().equalsIgnoreCase(english)) {
                return entry.getValue();
            }
        }
        
        // Fallback to original
        return english;
    }
}
