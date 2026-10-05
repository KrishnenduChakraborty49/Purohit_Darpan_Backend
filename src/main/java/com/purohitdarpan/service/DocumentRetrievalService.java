package com.purohitdarpan.service;

import lombok.extern.slf4j.Slf4j;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import jakarta.annotation.PostConstruct;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

/**
 * Pure in-memory document retrieval service using TF-IDF keyword scoring.
 * No external API key or vector database needed.
 * Loads your 5 Puja Paddhati DOCX files on startup and retrieves
 * the most relevant paragraphs for any user question.
 */
@Service
@Slf4j
public class DocumentRetrievalService {

    /** A chunk = one retrievable paragraph from a DOCX file */
    public record Chunk(String text, String source, String pujaName) {}

    private final List<Chunk> allChunks = new ArrayList<>();

    private static final Map<String, String> DOCX_FILES = new LinkedHashMap<>();

    static {
        DOCX_FILES.put("Ganesh_Puja_Paddhati.docx",                                          "Ganesh Puja");
        DOCX_FILES.put("Laxmi_Puja_Paddhati_Pandit_Krishnendu_Chakraborty (2).docx",          "Laxmi Puja");
        DOCX_FILES.put("Purohit_Darpan_Durgapuja_Paddhati.docx",                             "Durga Puja");
        DOCX_FILES.put("Saraswati_Puja_Paddhati_Pandit_Krishnendu_Chakraborty.docx",          "Saraswati Puja");
        DOCX_FILES.put("Shiv_Puja_Padhati_Complete.docx",                                    "Shiv Puja");
    }

    @PostConstruct
    public void loadDocuments() {
        log.info("DocumentRetrievalService: Loading Puja Paddhati documents into memory...");
        for (Map.Entry<String, String> entry : DOCX_FILES.entrySet()) {
            loadDocx(entry.getKey(), entry.getValue());
        }
        log.info("DocumentRetrievalService: Loaded {} chunks from {} documents",
                allChunks.size(), DOCX_FILES.size());
    }

    private void loadDocx(String fileName, String pujaName) {
        try {
            ClassPathResource resource = new ClassPathResource(fileName);
            if (!resource.exists()) {
                log.warn("DOCX file not found in resources: {}", fileName);
                return;
            }
            try (InputStream is = resource.getInputStream();
                 XWPFDocument doc = new XWPFDocument(is);
                 XWPFWordExtractor extractor = new XWPFWordExtractor(doc)) {

                String fullText = extractor.getText();
                if (fullText == null || fullText.isBlank()) return;

                // Split into paragraphs (split by double newline or long single newlines)
                String[] paragraphs = fullText.split("\\n{2,}|(?<=\\n)(?=\\n)");

                StringBuilder buffer = new StringBuilder();
                for (String para : paragraphs) {
                    String trimmed = para.trim();
                    if (trimmed.length() < 20) continue; // skip very short lines

                    buffer.append(trimmed).append("\n");

                    // Create a chunk every ~400 chars, with overlap
                    if (buffer.length() >= 400) {
                        allChunks.add(new Chunk(buffer.toString().trim(), fileName, pujaName));
                        // Keep last 100 chars for context overlap
                        String overlap = buffer.substring(Math.max(0, buffer.length() - 100));
                        buffer = new StringBuilder(overlap);
                    }
                }
                // Add remaining text
                if (!buffer.isEmpty() && buffer.length() > 30) {
                    allChunks.add(new Chunk(buffer.toString().trim(), fileName, pujaName));
                }
                log.info("Loaded '{}' → {} chunks", fileName, allChunks.size());
            }
        } catch (Exception e) {
            log.error("Failed to load DOCX: {}", fileName, e);
        }
    }

    /**
     * Retrieve the top-K most relevant chunks for the given query using TF-IDF scoring.
     */
    public List<Chunk> retrieve(String query, int topK) {
        if (allChunks.isEmpty() || query == null || query.isBlank()) return List.of();

        Set<String> queryTokens = tokenize(query.toLowerCase());
        if (queryTokens.isEmpty()) return List.of();

        // Score each chunk
        List<Map.Entry<Chunk, Double>> scored = new ArrayList<>();
        for (Chunk chunk : allChunks) {
            double score = score(queryTokens, chunk.text().toLowerCase(), chunk.pujaName().toLowerCase());
            if (score > 0) scored.add(Map.entry(chunk, score));
        }

        // Sort by score descending
        scored.sort((a, b) -> Double.compare(b.getValue(), a.getValue()));

        return scored.stream()
                .limit(topK)
                .map(Map.Entry::getKey)
                .collect(Collectors.toList());
    }

    private double score(Set<String> queryTokens, String chunkText, String pujaName) {
        double score = 0.0;
        Set<String> chunkTokens = tokenize(chunkText);
        int totalTerms = chunkTokens.size();
        if (totalTerms == 0) return 0;

        for (String token : queryTokens) {
            // Term frequency in chunk
            long tf = chunkTokens.stream().filter(t -> t.equals(token)).count();
            if (tf > 0) {
                // Bonus for appearing in puja name (high relevance)
                double pujaBonus = pujaName.contains(token) ? 3.0 : 1.0;
                score += (tf / (double) totalTerms) * pujaBonus;
            }
        }
        return score;
    }

    private Set<String> tokenize(String text) {
        if (text == null) return Set.of();
        // Split on whitespace and punctuation, filter stopwords, keep stems
        return Arrays.stream(text.split("[\\s\\p{Punct}]+"))
                .filter(t -> t.length() > 2)
                .filter(t -> !STOPWORDS.contains(t))
                .collect(Collectors.toSet());
    }

    /** Common English + Bengali transliteration stopwords */
    private static final Set<String> STOPWORDS = Set.of(
            "the", "and", "for", "are", "was", "you", "that", "this", "with",
            "have", "from", "they", "will", "what", "can", "does", "how",
            "tell", "about", "please", "give", "me", "kya", "hai", "mein",
            "aur", "ki", "ke", "ka", "ko", "se", "ek", "koi", "karo",
            "ami", "tumi", "apni", "kore", "keno", "eta", "ota"
    );

    public int getChunkCount() { return allChunks.size(); }
}
