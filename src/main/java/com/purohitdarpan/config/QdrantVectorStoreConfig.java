package com.purohitdarpan.config;

import io.qdrant.client.QdrantClient;
import io.qdrant.client.QdrantGrpcClient;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.embedding.EmbeddingModel;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.ai.vectorstore.qdrant.QdrantVectorStore;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Manual Qdrant wiring.
 * Spring AI's Qdrant auto-configuration is excluded because it attempts to connect to Qdrant during startup.
 */
@Configuration
@ConditionalOnProperty(prefix = "ai.rag", name = "enabled", havingValue = "true")
@RequiredArgsConstructor
public class QdrantVectorStoreConfig {

    @Value("${spring.ai.vectorstore.qdrant.host:127.0.0.1}")
    private String host;

    @Value("${spring.ai.vectorstore.qdrant.port:6334}")
    private int port;

    @Value("${spring.ai.vectorstore.qdrant.collection-name:purohit_darpan_puja}")
    private String collectionName;

    @Value("${spring.ai.vectorstore.qdrant.initialize-schema:false}")
    private boolean initializeSchema;

    @Value("${spring.ai.vectorstore.qdrant.api-key:}")
    private String apiKey;

    @Bean
    public VectorStore vectorStore(EmbeddingModel embeddingModel) {
        boolean useTls = false;
        QdrantGrpcClient.Builder grpcClientBuilder = QdrantGrpcClient.newBuilder(host, port, useTls);
        if (apiKey != null && !apiKey.isBlank()) {
            grpcClientBuilder.withApiKey(apiKey);
        }

        QdrantClient qdrantClient = new QdrantClient(grpcClientBuilder.build());

        return QdrantVectorStore.builder(qdrantClient, embeddingModel)
                .collectionName(collectionName)
                .initializeSchema(initializeSchema)
                .build();
    }
}

