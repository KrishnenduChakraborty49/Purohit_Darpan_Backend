package com.purohitdarpan.config;

import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.ai.vectorstore.SimpleVectorStore;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@ConditionalOnProperty(prefix = "ai.rag", name = "enabled", havingValue = "false", matchIfMissing = false)
public class VectorStoreFallbackConfig {

    /**
     * When Qdrant is not available (or rag is disabled), we provide an in-memory
     * VectorStore so Spring Boot can start without trying to connect to Qdrant.
     */
    @ConditionalOnMissingBean(name = "vectorStore")
    @Bean
    public VectorStore vectorStore(EmbeddingModel embeddingModel) {
        return SimpleVectorStore.builder(embeddingModel).build();
    }
}

