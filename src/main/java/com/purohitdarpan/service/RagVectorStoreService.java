package com.purohitdarpan.service;

import com.purohitdarpan.entity.Mantra;
import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.entity.PujaStep;
import com.purohitdarpan.repository.MantraRepository;
import com.purohitdarpan.repository.PujaRepository;
import com.purohitdarpan.repository.PujaStepRepository;
import com.purohitdarpan.util.TextUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.SearchRequest;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.boot.autoconfigure.condition.ConditionalOnProperty;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
@Slf4j
@ConditionalOnProperty(prefix = "ai.rag", name = "enabled", havingValue = "true")
public class RagVectorStoreService {

    private final VectorStore vectorStore;
    private final MantraRepository mantraRepository;
    private final PujaRepository pujaRepository;
    private final PujaStepRepository pujaStepRepository;

    @Transactional(readOnly = true)
    public int indexAll(boolean reindex) {
        if (reindex) {
            safeDelete("type == 'MANTRA'");
            safeDelete("type == 'PUJA_STEP'");
            safeDelete("type == 'PUJA'");
        }

        List<Document> docs = new ArrayList<>();

        // Index all Pujas (name + description)
        for (Puja puja : pujaRepository.findAll()) {
            if (puja.getName() == null || puja.getName().isBlank()) continue;

            String content = "Puja: " + puja.getName();
            if (puja.getNameDevanagari() != null && !puja.getNameDevanagari().isBlank()) {
                content += " (" + puja.getNameDevanagari() + ")";
            }
            if (puja.getDescription() != null && !puja.getDescription().isBlank()) {
                content += "\n\nDescription: " + puja.getDescription();
            }
            if (puja.getCategory() != null && !puja.getCategory().isBlank()) {
                content += "\nCategory: " + puja.getCategory();
            }
            if (puja.getDifficulty() != null) {
                content += "\nDifficulty: " + puja.getDifficulty();
            }

            docs.add(new Document(content, Map.of(
                    "type", "PUJA",
                    "pujaId", puja.getId() != null ? puja.getId().toString() : "",
                    "pujaName", puja.getName()
            )));
        }

        for (Mantra mantra : mantraRepository.findAll()) {
            if (mantra.getShlokText() == null || mantra.getShlokText().isBlank()) {
                continue;
            }
            String content = mantra.getShlokText().trim();
            if (mantra.getTransliteration() != null && !mantra.getTransliteration().isBlank()) {
                content += "\n\nIAST (transliteration): " + mantra.getTransliteration().trim();
            }

            docs.add(new Document(content, Map.of(
                    "type", "MANTRA",
                    "mantraId", mantra.getId() != null ? mantra.getId().toString() : "",
                    "sourceText", mantra.getSourceText() != null ? mantra.getSourceText() : ""
            )));
        }

        for (PujaStep step : pujaStepRepository.findAll()) {
            if (step.getTitle() == null || step.getTitle().isBlank()) {
                continue;
            }

            String content = "Step Title: " + step.getTitle().trim();
            if (step.getTitleDevanagari() != null && !step.getTitleDevanagari().isBlank()) {
                content += "\nTitle (Devanagari): " + step.getTitleDevanagari().trim();
            }
            if (step.getTitleBengali() != null && !step.getTitleBengali().isBlank()) {
                content += "\nTitle (Bengali): " + step.getTitleBengali().trim();
            }
            if (step.getTitleSanskrit() != null && !step.getTitleSanskrit().isBlank()) {
                content += "\nTitle (Sanskrit): " + step.getTitleSanskrit().trim();
            }

            if (step.getDescription() != null && !step.getDescription().isBlank()) {
                content += "\n\nDescription: " + TextUtils.stripHtml(step.getDescription());
            }

            String pujaId = step.getPuja() != null && step.getPuja().getId() != null
                    ? step.getPuja().getId().toString()
                    : "";

            docs.add(new Document(content, Map.of(
                    "type", "PUJA_STEP",
                    "pujaId", pujaId,
                    "stepId", step.getId() != null ? step.getId().toString() : "",
                    "stepOrder", step.getStepOrder() != null ? step.getStepOrder().toString() : ""
            )));
        }

        if (docs.isEmpty()) {
            log.warn("Vector index not created: no documents found in DB.");
            return 0;
        }

        try {
            vectorStore.add(docs);
            log.info("Vector index created/updated. documentsAdded={}", docs.size());
            return docs.size();
        } catch (Exception e) {
            // If the Qdrant collection doesn't exist / isn't initialized yet,
            // we don't want to crash the whole application.
            log.error("Vector index build failed (will not crash app). error={}", e.getMessage());
            return 0;
        }
    }

    public List<Document> similaritySearch(String query, String typeFilter, int topK) {
        SearchRequest.Builder requestBuilder = SearchRequest.builder()
                .query(query)
                .topK(topK);

        if (typeFilter != null && !typeFilter.isBlank()) {
            requestBuilder.filterExpression("type == '" + typeFilter + "'");
        }

        return vectorStore.similaritySearch(requestBuilder.build());
    }

    public String retrieveContext(String query, String typeFilter, int topK) {
        List<Document> docs = similaritySearch(query, typeFilter, topK);
        StringBuilder sb = new StringBuilder();
        for (Document doc : docs) {
            if (doc.getText() == null || doc.getText().isBlank()) {
                continue;
            }
            if (!sb.isEmpty()) {
                sb.append("\n\n---\n\n");
            }
            sb.append(doc.getText());
        }
        return sb.toString();
    }

    private void safeDelete(String filterExpression) {
        try {
            vectorStore.delete(filterExpression);
        } catch (Exception e) {
            // Some providers may not support delete expressions depending on metadata typing.
            log.warn("Vector store delete failed: filterExpression={}. error={}", filterExpression, e.getMessage());
        }
    }
}

