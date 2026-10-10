package com.purohitdarpan.service;

import com.purohitdarpan.entity.AiFeedback;
import com.purohitdarpan.entity.AiQueryLog;
import com.purohitdarpan.entity.User;
import com.purohitdarpan.repository.AiFeedbackRepository;
import com.purohitdarpan.repository.AiQueryLogRepository;
import com.purohitdarpan.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import reactor.core.publisher.Flux;

import java.time.Instant;
import java.util.Optional;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
@Slf4j
public class AIService {

    private final ChatClient chatClient;
    private final AiQueryLogRepository queryLogRepo;
    private final AiFeedbackRepository feedbackRepo;
    private final UserRepository userRepo;
    private final Optional<RagVectorStoreService> ragVectorStoreService;
    private final DocumentRetrievalService documentRetrievalService;

    private static final String SYSTEM_PROMPT = """
            You are Guru (গুরু) — an authoritative, wise, and deeply learned Vedic and Tantrik Purohit (পুরোহিত) inside the Purohit Darpan (পুরোহিত দর্পণ) application.

            YOUR UNIVERSAL EXPERTISE:
            You have complete, scholarly knowledge of ALL Hindu pujas, rituals, vratas, and samskaras according to traditional Bengali Smriti and Purohit Darpan paddhati (including Kali Puja, Durga Puja, Shiva Puja, Ganesh Puja, Lakshmi Puja, Saraswati Puja, Satyanarayan, Jagaddhatri, Kartick, etc.).

            RULES FOR ANY PUJA QUESTION:
            1. AUTHENTIC MANTRAS & PUSHPANJALI:
               - For ANY deity requested, provide the authentic traditional Sanskrit mantra in Bengali script (বাংলা হরফে) or Devanagari.
               - Include proper pronunciation and the sacred spiritual meaning.
               - Cover Dhyan Mantra (ধ্যান), Pushpanjali (পুষ্পাঞ্জলি), Pranam (প্রণাম), and Gayatri mantras accurately.

            2. AUTHENTIC DEITY-SPECIFIC SAMAGRI (পূজার খাঁটি ফর্দ):
               - When asked for samagri for any puja, provide the authentic traditional Bengali list tailored to that deity:
                 • For Kali Puja: রক্তজবা, লাল চন্দন, কারণবারি/মধু, মাষকলাই, খড়্গ পূজা উপকরণ, ইত্যাদি।
                 • For Shiva Puja: বিল্বপত্র (বেলপাতা), ধুতুরা, আকন্দ ফুল, কাঁচা দুধ, গঙ্গাজল, ইত্যাদি।
                 • For Ganesh Puja: লাল ফুল, রক্তচন্দন, মোদক/লাড্ডু, দূর্বা, ইত্যাদি।
                 • For Saraswati Puja: শ্বেতপদ্ম, পলাশ ফুল, অভ্র-আবীর, দোয়াত-কলম, ইত্যাদি।
               - Always use real ritual ingredients; never invent fake or corrupted words.

            3. STEP-BY-STEP RITUAL PROCEDURES:
               - For any puja procedure, guide the user step by step (e.g., আচমন, স্বস্তিবচন, সংকল্প, ঘটস্থাপন, অঙ্গন্যাস, ধ্যান, পূজা, পুষ্পাঞ্জলি, বিসর্জন).

            OUTPUT FORMAT (STRICT):
            - NO MARKDOWN TABLES. Use clean bullet points (•) and bold titles.
            - Keep responses structured, concise, and easy to read.

            LANGUAGE RULES:
            - If asked in Bengali or Bengali transliteration (e.g., "kali pujar mantra dao", "samagri ki"):
              -> Reply directly in authentic BENGALI script (বাংলা হরফে উত্তর দিন).
            - If asked in English:
              -> Reply in clear, respectful ENGLISH.
            - If requested bilingual:
              -> Provide Bengali with English explanations.
            """;

    /**
     * MODE A: Explain a specific Sanskrit word in context of a shlok
     */

    /**
     * MODE A: Explain a specific Sanskrit word in context of a shlok
     */
    public String explainWord(String word, String shlokContext, String pujaContext,
                              Long userId, Long contextPujaId, Long contextStepId) {
        String resolvedShlokContext = (shlokContext != null && !shlokContext.isBlank())
                ? shlokContext
                : ragVectorStoreService
                .map(s -> {
                    try { return s.retrieveContext(word, "MANTRA", 1); } catch (Exception e) {
                        log.warn("RAG context unavailable for word='{}': {}", word, e.getMessage());
                        return "";
                    }
                })
                .orElse("");

        String resolvedPujaContext = (pujaContext != null && !pujaContext.isBlank())
                ? pujaContext
                : ragVectorStoreService
                .map(s -> {
                    try { return s.retrieveContext(word, "PUJA_STEP", 3); } catch (Exception e) {
                        log.warn("RAG puja context unavailable for word='{}': {}", word, e.getMessage());
                        return "";
                    }
                })
                .orElse("");

        String prompt = String.format(
                """
                Context: The user is studying the puja: %s
                Full shlok: "%s"
                The user tapped on the word: "%s"
                
                Please explain:
                1. The meaning of "%s" in Devanagari and IAST
                2. Its grammatical role in this shlok
                3. How it is pronounced
                4. Its significance in this ritual context
                """,
                resolvedPujaContext != null ? resolvedPujaContext : "",
                resolvedShlokContext != null ? resolvedShlokContext : "",
                word, word);

        return callAI(prompt, AiQueryLog.QueryType.WORD_QUERY, userId,
                contextPujaId, contextStepId, resolvedShlokContext);
    }

    /**
     * MODE A: Explain a full shlok with word-by-word breakdown
     */
    public String explainShlok(String shlokText, String pujaContext,
                                Long userId, Long contextPujaId, Long contextStepId) {
        String prompt = String.format(
                """
                Context: The user is studying the puja: %s
                Shlok to explain: "%s"
                
                Please provide:
                1. Complete word-by-word meaning (anvaya)
                2. Overall translation
                3. Spiritual significance of this shlok
                4. When and how it is chanted in the ritual
                5. Pronunciation guide for key words
                """,
                pujaContext, shlokText);

        return callAI(prompt, AiQueryLog.QueryType.SHLOK_QUERY, userId,
                contextPujaId, contextStepId, shlokText);
    }

    /**
     * MODE B: Answer a general ritual question from the chat panel
     */
    public String answerRitualQuestion(String question, String userContext,
                                        Long userId, Long contextPujaId, Long contextStepId) {
        String resolvedContext = userContext;

        // Step 1: Use in-memory document retrieval (always available, no API key needed)
        if (resolvedContext == null || resolvedContext.isBlank()) {
            try {
                List<DocumentRetrievalService.Chunk> chunks = documentRetrievalService.retrieve(question, 5);
                if (!chunks.isEmpty()) {
                    String docContext = chunks.stream()
                            .map(c -> "[" + c.pujaName() + "]\n" + c.text())
                            .collect(Collectors.joining("\n\n---\n\n"));
                    resolvedContext = "## Relevant Puja Paddhati Excerpts\n" + docContext;
                    log.debug("Retrieved {} document chunks for question: {}", chunks.size(), question);
                }
            } catch (Exception e) {
                log.warn("Document retrieval failed, falling back to pure LLM: {}", e.getMessage());
            }
        }

        // Step 2: Also try Qdrant RAG if available (optional, graceful fallback)
        if ((resolvedContext == null || resolvedContext.isBlank()) && ragVectorStoreService.isPresent()) {
            try {
                String mantraCtx = ragVectorStoreService.get().retrieveContext(question, "MANTRA", 3);
                String stepCtx   = ragVectorStoreService.get().retrieveContext(question, "PUJA_STEP", 3);
                StringBuilder sb = new StringBuilder();
                if (mantraCtx != null && !mantraCtx.isBlank()) sb.append("## Mantra Context\n").append(mantraCtx);
                if (stepCtx   != null && !stepCtx.isBlank())   { if (!sb.isEmpty()) sb.append("\n\n"); sb.append("## Puja Steps\n").append(stepCtx); }
                resolvedContext = sb.toString();
            } catch (Exception e) {
                log.warn("Vector store unavailable: {}", e.getMessage());
            }
        }

        String prompt = (resolvedContext != null && !resolvedContext.isBlank())
                ? """
                  [PUROHIT DARPAN CONTEXT]
                  %s

                  [USER QUESTION]
                  %s
                  """.formatted(resolvedContext.trim(), question.trim())
                : question;

        return callAI(prompt, AiQueryLog.QueryType.GENERAL_QUESTION, userId,
                contextPujaId, contextStepId, null);
    }

    /**
     * Streaming version — returns a Flux<String> of tokens for SSE endpoint.
     */
    public Flux<String> answerRitualQuestionStream(String question, String userContext) {
        String resolvedContext = userContext;
        if (resolvedContext == null || resolvedContext.isBlank()) {
            try {
                List<DocumentRetrievalService.Chunk> chunks = documentRetrievalService.retrieve(question, 5);
                if (!chunks.isEmpty()) {
                    resolvedContext = "## Relevant Puja Paddhati Excerpts\n" +
                            chunks.stream()
                                  .map(c -> "[" + c.pujaName() + "]\n" + c.text())
                                  .collect(Collectors.joining("\n\n---\n\n"));
                }
            } catch (Exception e) {
                log.warn("Document retrieval failed for stream: {}", e.getMessage());
            }
        }

        String prompt = (resolvedContext != null && !resolvedContext.isBlank())
                ? "Use the following context to answer accurately.\n\n"
                  + resolvedContext + "\n\n---\n\nUser question: " + question
                : question;

        return chatClient.prompt()
                .system(SYSTEM_PROMPT)
                .user(prompt)
                .stream()
                .content();
    }

    /**
     * Save feedback for an AI response
     */
    @Transactional
    public void saveFeedback(Long queryLogId, Long userId, byte rating, String comment) {
        AiQueryLog log = queryLogRepo.findById(queryLogId)
                .orElseThrow(() -> new IllegalArgumentException("Query log not found"));
        User user = userRepo.getReferenceById(userId);

        AiFeedback feedback = AiFeedback.builder()
                .queryLog(log)
                .user(user)
                .rating(rating)
                .comment(comment)
                .build();
        feedbackRepo.save(feedback);
    }


    private String callAI(String userPrompt, AiQueryLog.QueryType queryType,
                            Long userId, Long contextPujaId, Long contextStepId,
                            String contextShlok) {
        long startTime = Instant.now().toEpochMilli();

        try {
            String response = chatClient.prompt()
                    .system(SYSTEM_PROMPT)
                    .user(userPrompt)
                    .call()
                    .content();

            // Guard: content() can return null if the model emits an empty response
            if (response == null || response.isBlank()) {
                log.warn("Ollama returned null/blank response for type={}", queryType);
                response = "I'm sorry, I could not generate a response. Please try asking again.";
            }

            long duration = Instant.now().toEpochMilli() - startTime;
            logQuery(userId, queryType, userPrompt, contextPujaId, contextStepId,
                    contextShlok, response, (int) duration);

            return response;

        } catch (Exception e) {
            log.error("AI call failed [type={}]: {} — cause: {}",
                    queryType, e.getMessage(),
                    e.getCause() != null ? e.getCause().getMessage() : "none", e);
            return "I'm sorry, I had trouble responding. Error: " + e.getMessage();
        }
    }

    /**
     * Quick connectivity test — bypasses auth/logging/RAG, calls Ollama directly.
     * Used by GET /api/ai/health
     */
    public String testOllamaDirectly() {
        try {
            return chatClient.prompt()
                    .user("Reply with exactly one word: Hello")
                    .call()
                    .content();
        } catch (Exception e) {
            log.error("Ollama health-check FAILED: {}", e.getMessage(), e);
            return "ERROR: " + e.getMessage()
                    + (e.getCause() != null ? " | Cause: " + e.getCause().getMessage() : "");
        }
    }

    private void logQuery(Long userId, AiQueryLog.QueryType queryType, String queryText,
                           Long pujaId, Long stepId, String shlok, String response, int durationMs) {
        // Skip DB logging if user is null or does not exist — prevents FK violation crashes
        if (userId == null || !userRepo.existsById(userId)) {
            log.warn("Skipping AI query log — user ID {} not found or null", userId);
            return;
        }
        try {
            AiQueryLog logEntry = AiQueryLog.builder()
                    .user(userRepo.getReferenceById(userId))
                    .queryType(queryType)
                    .queryText(queryText)
                    .contextPujaId(pujaId)
                    .contextStepId(stepId)
                    .contextShlok(shlok)
                    .responseText(response)
                    .responseTimeMs(durationMs)
                    .build();
            queryLogRepo.save(logEntry);
        } catch (Exception e) {
            log.warn("Failed to log AI query: {}", e.getMessage());
        }
    }
}
