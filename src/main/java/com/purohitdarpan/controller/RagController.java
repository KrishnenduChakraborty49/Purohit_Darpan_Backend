package com.purohitdarpan.controller;

import com.purohitdarpan.service.RagVectorStoreService;
import lombok.Data;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

import java.util.Map;

@RestController
@RequestMapping("/api/ai/rag")
@RequiredArgsConstructor
@ConditionalOnProperty(prefix = "ai.rag", name = "enabled", havingValue = "true")
public class RagController {

    private final RagVectorStoreService ragVectorStoreService;

    @PostMapping("/index")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Map<String, Object>> index(@RequestBody(required = false) IndexRequest req) {
        boolean reindex = req != null && req.isReindex();
        int added = ragVectorStoreService.indexAll(reindex);
        return ResponseEntity.ok(Map.of(
                "addedDocuments", added,
                "reindex", reindex
        ));
    }

    @Data
    public static class IndexRequest {
        private boolean reindex;
    }
}

