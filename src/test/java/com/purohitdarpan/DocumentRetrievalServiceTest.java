package com.purohitdarpan;

import com.purohitdarpan.service.DocumentRetrievalService;
import org.junit.jupiter.api.Test;

public class DocumentRetrievalServiceTest {
    @Test
    public void testInit() {
        DocumentRetrievalService s = new DocumentRetrievalService();
        System.out.println("Initialized successfully!");
    }
}
