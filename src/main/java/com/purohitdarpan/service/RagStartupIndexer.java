package com.purohitdarpan.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;

@Component
@RequiredArgsConstructor
@Slf4j
@ConditionalOnProperty(prefix = "ai.rag", name = "enabled", havingValue = "true")
public class RagStartupIndexer {

    private final RagVectorStoreService ragVectorStoreService;

    @Value("${spring.ai.rag.index-on-startup:false}")
    private boolean indexOnStartup;

    @Value("${spring.ai.rag.reindex-on-startup:true}")
    private boolean reindexOnStartup;

    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        if (!indexOnStartup) {
            return;
        }

        log.info("Starting vector index build on startup. reindexOnStartup={}", reindexOnStartup);
        try {
            int added = ragVectorStoreService.indexAll(reindexOnStartup);
            log.info("Vector index build completed. documentsAdded={}", added);
        } catch (Exception e) {
            // Never block app startup on vector indexing.
            log.error("Vector index build failed (continuing startup). error={}", e.getMessage());
        }
    }
}

