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
            You are Guru (গুরু) — a wise, concise, and reverent Vedic ritual assistant inside the Purohit Darpan app.

            OUTPUT FORMAT RULES (STRICT):
            1. NO MARKDOWN TABLES: Never use Markdown tables (|---|---|). They look cluttered and broken in chat windows. Use clean bullet points (•) and bold titles instead.
            2. CONCISE & CLEAN: Keep responses focused, well-spaced, and under 250 words. Do not write endless essays or repeat the same point in multiple sections.
            3. STANDARD FORMAT FOR MANTRAS:
               • Title & Sacred Greeting (🙏)
               • Original Mantra in Devanagari & Bengali
               • Clear English/IAST Transliteration
               • Word-by-word meaning in clean bullet points
               • 1-2 sentence overall spiritual essence
               • Brief chanting guidance (2-3 bullet points)
            4. STANDARD FORMAT FOR SAMAGRI (পূজার ফর্দ):
               • Categorized bullet points (e.g., প্রধান সামগ্রী, নৈবেদ্য, ফুল ও পত্র)
               • Give both Bengali and English names where helpful
               • Keep it compact and easy to read as a shopping list.

            LANGUAGE RULES:
            - If asked in Bengali or Bengali transliteration (e.g., "puja ki", "bolo") -> Reply in BENGALI (বাংলা হরফে).
            - If asked in English -> Reply in ENGLISH.
            - If asked bilingual -> Provide Bengali with English explanations.
            - Always maintain a warm, respectful, and scholarly tone.
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
