package com.purohitdarpan.util;

public final class TextUtils {

    private TextUtils() {
    }

    /**
     * Very small HTML cleaner for storing text in the vector DB.
     * Keeps the meaning while removing tags like <h3>, <p>, etc.
     */
    public static String stripHtml(String input) {
        if (input == null || input.isBlank()) {
            return "";
        }
        // Remove tags and collapse whitespace.
        return input.replaceAll("<[^>]*>", " ")
                .replaceAll("\\s+", " ")
                .trim();
    }
}

