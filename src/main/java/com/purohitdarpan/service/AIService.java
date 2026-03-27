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
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.model.ChatResponse;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.Optional;
import java.util.List;

@Service
@RequiredArgsConstructor
@Slf4j
public class AIService {

    private final ChatClient chatClient;
    private final AiQueryLogRepository queryLogRepo;
    private final AiFeedbackRepository feedbackRepo;
    private final UserRepository userRepo;
    private final Optional<RagVectorStoreService> ragVectorStoreService;

    private static final String SYSTEM_PROMPT = """
            You are Guru, a helpful Hindu ritual assistant inside Purohit Darpan.
            Your job is to help priests understand Sanskrit mantras, puja rituals, and samagri.

            RULES:
            1. Answer ONLY questions about Hindu rituals, Sanskrit, pujas, mantras, and samagri.
            2. If asked anything unrelated, say: I am here only for Vedic ritual assistance.
            3. ALWAYS reply in the SAME LANGUAGE the user writes in (Bengali, Hindi, English, or Sanskrit).
            4. For Sanskrit words: give Devanagari text, pronunciation, and simple meaning.
            5. Keep it simple, clear, and encouraging.
            """;

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
        if (resolvedContext == null || resolvedContext.isBlank()) {
            if (ragVectorStoreService.isPresent()) {
                try {
                    String mantraContext = ragVectorStoreService.get().retrieveContext(question, "MANTRA", 3);
                    String pujaStepContext = ragVectorStoreService.get().retrieveContext(question, "PUJA_STEP", 5);

                    StringBuilder sb = new StringBuilder();
                    if (mantraContext != null && !mantraContext.isBlank()) {
                        sb.append("## Mantra Context\n").append(mantraContext);
                    }
                    if (pujaStepContext != null && !pujaStepContext.isBlank()) {
                        if (sb.length() > 0) sb.append("\n\n");
                        sb.append("## Puja Step Context\n").append(pujaStepContext);
                    }
                    resolvedContext = sb.toString();
                } catch (Exception e) {
                    // Qdrant is offline — gracefully fall back to pure LLM mode
                    log.warn("Vector store unavailable, falling back to pure LLM mode. error={}", e.getMessage());
                    resolvedContext = "";
                }
            }
        }

        String prompt = resolvedContext != null && !resolvedContext.isBlank()
                ? String.format("Context: %s\n\nUser question: %s", resolvedContext, question)
                : question;

        return callAI(prompt, AiQueryLog.QueryType.GENERAL_QUESTION, userId,
                contextPujaId, contextStepId, null);
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
        // Skip DB logging if userId is null — prevents NPE inside getReferenceById(null)
        if (userId == null) {
            log.debug("Skipping AI query log — no userId provided");
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
