package com.purohitdarpan.controller;

import com.purohitdarpan.repository.AiQueryLogRepository;
import com.purohitdarpan.service.AIService;
import com.purohitdarpan.service.DocumentRetrievalService;
import jakarta.validation.constraints.NotBlank;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.codec.ServerSentEvent;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Flux;

import java.util.Map;

@RestController
@RequestMapping("/api/ai")
@RequiredArgsConstructor
public class AIController {

    private final AIService aiService;
    private final AiQueryLogRepository queryLogRepo;
    private final DocumentRetrievalService documentRetrievalService;

    @org.springframework.beans.factory.annotation.Value("${spring.ai.openai.api-key:}")
    private String groqApiKey;

    /**
     * GET /api/ai/health — public Ollama connectivity test (no auth required)
     */
    @GetMapping("/health")
    public ResponseEntity<Map<String, String>> health() {
        String result = aiService.testOllamaDirectly();
        boolean ok = !result.startsWith("ERROR");
        return ResponseEntity.ok(Map.of("status", ok ? "OK" : "FAIL", "response", result));
    }

    /**
     * GET /api/ai/models — diagnostics: returns exact model IDs supported by the Groq key
     */
    @GetMapping(value = "/models", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<String> listModels() {
        try {
            java.net.http.HttpClient client = java.net.http.HttpClient.newHttpClient();
            java.net.http.HttpRequest req = java.net.http.HttpRequest.newBuilder()
                    .uri(java.net.URI.create("https://api.groq.com/openai/v1/models"))
                    .header("Authorization", "Bearer " + groqApiKey)
                    .GET()
                    .build();
            java.net.http.HttpResponse<String> resp = client.send(req, java.net.http.HttpResponse.BodyHandlers.ofString());
            return ResponseEntity.status(resp.statusCode()).body(resp.body());
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    /**
     * POST /api/ai/query — general ritual question
     * FIX: Removed @PreAuthorize to allow public "Ask Guru" queries
     */
    @PostMapping("/query")
    public ResponseEntity<Map<String, String>> query(@RequestBody QueryRequest req) {
        String response = aiService.answerRitualQuestion(
                req.getQuestion(), req.getUserContext(),
                req.getUserId(), req.getContextPujaId(), req.getContextStepId());
        Map<String, String> body = new java.util.HashMap<>();
        body.put("response", response != null ? response : "");
        return ResponseEntity.ok(body);
    }

    /**
     * POST /api/ai/explain-word — explain a Sanskrit word in shlok context
     * FIX: Removed @PreAuthorize to allow public explanations
     */
    @PostMapping("/explain-word")
    public ResponseEntity<Map<String, String>> explainWord(@RequestBody WordRequest req) {
        String response = aiService.explainWord(
                req.getWord(), req.getShlokContext(), req.getPujaContext(),
                req.getUserId(), req.getContextPujaId(), req.getContextStepId());
        Map<String, String> body = new java.util.HashMap<>();
        body.put("response", response != null ? response : "");
        return ResponseEntity.ok(body);
    }

    /**
     * POST /api/ai/explain-shlok — full shlok breakdown
     * FIX: Removed @PreAuthorize to allow public explanations
     */
    @PostMapping("/explain-shlok")
    public ResponseEntity<Map<String, String>> explainShlok(@RequestBody ShlokRequest req) {
        String response = aiService.explainShlok(
                req.getShlokText(), req.getPujaContext(),
                req.getUserId(), req.getContextPujaId(), req.getContextStepId());
        Map<String, String> body = new java.util.HashMap<>();
        body.put("response", response != null ? response : "");
        return ResponseEntity.ok(body);
    }

    /**
     * GET /api/ai/history/{userId} — conversation history (Secure)
     */
    @GetMapping("/history/{userId}")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> history(
            @PathVariable Long userId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        return ResponseEntity.ok(
                queryLogRepo.findByUserIdOrderByCreatedAtDesc(userId, PageRequest.of(page, size)));
    }

    /**
     * GET /api/ai/ask/stream?question=...&userContext=...
     * Streams the Guru's answer word-by-word as Server-Sent Events (SSE)
     */
    @GetMapping(value = "/ask/stream", produces = MediaType.TEXT_EVENT_STREAM_VALUE)
    public Flux<ServerSentEvent<String>> streamAnswer(
            @RequestParam String question,
            @RequestParam(required = false) String userContext) {
        return aiService.answerRitualQuestionStream(question, userContext)
                .map(token -> ServerSentEvent.<String>builder()
                        .event("token")
                        .data(token)
                        .build())
                .concatWith(Flux.just(ServerSentEvent.<String>builder()
                        .event("done")
                        .data("[DONE]")
                        .build()));
    }

    /**
     * GET /api/ai/rag/stats — shows how many document chunks are loaded in memory
     */
    @GetMapping("/rag/stats")
    public ResponseEntity<Map<String, Object>> ragStats() {
        return ResponseEntity.ok(Map.of(
                "chunksLoaded", documentRetrievalService.getChunkCount(),
                "status", documentRetrievalService.getChunkCount() > 0 ? "READY" : "EMPTY"
        ));
    }

    /**
     * POST /api/ai/feedback — thumbs up/down for a query (Secure)
     */
    @PostMapping("/feedback")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<Void> saveFeedback(@RequestBody FeedbackRequest req) {
        aiService.saveFeedback(req.getQueryLogId(), req.getUserId(),
                req.getRating(), req.getComment());
        return ResponseEntity.ok().build();
    }

    // ── Inner DTOs ──────────────────────────────────────────────
    @Data
    public static class QueryRequest {
        @NotBlank private String question;
        private String userContext;
        private Long userId, contextPujaId, contextStepId;
    }

    @Data
    public static class WordRequest {
        @NotBlank private String word;
        private String shlokContext, pujaContext;
        private Long userId, contextPujaId, contextStepId;
    }

    @Data
    public static class ShlokRequest {
        @NotBlank private String shlokText;
        private String pujaContext;
        private Long userId, contextPujaId, contextStepId;
    }

    @Data
    public static class FeedbackRequest {
        private Long queryLogId, userId;
        private byte rating;
        private String comment;
    }
}
