package com.purohitdarpan.config;

import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.repository.PujaRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;

import java.util.Optional;

@Configuration
@RequiredArgsConstructor
@Slf4j
public class PujaDataFixer implements CommandLineRunner {

    private final PujaRepository pujaRepo;

    @Override
    public void run(String... args) {
        log.info("Checking for Puja thumbnail updates...");
        
        // Update Durga Puja
        updatePujaThumbnail("Durga Puja", "/images/durga_closeup.jpg");
        
        // Update Ganesh Puja
        updatePujaThumbnail("Ganesh Puja", "/images/ganesh_closeup.jpg");
        
        // Update Lakshmi Puja
        updatePujaThumbnail("Lakshmi Puja", "/images/lakshmi_closeup.jpg");
        
        // Update Saraswati Puja
        updatePujaThumbnail("Saraswati Puja", "/images/saraswati_closeup.jpg");
        
        // Update Satyanarayan Puja (supporting common spelling variants)
        updatePujaThumbnail("Satyanarayan Katha", "/images/satyanarayan_closeup.jpg");
        updatePujaThumbnail("Satyanarayan Puja", "/images/satyanarayan_closeup.jpg");
    }

    private void updatePujaThumbnail(String name, String path) {
        Optional<Puja> pujaOpt = pujaRepo.findByNameIgnoreCase(name);
        if (pujaOpt.isPresent()) {
            Puja puja = pujaOpt.get();
            if (puja.getThumbnailUrl() == null || !puja.getThumbnailUrl().equals(path)) {
                puja.setThumbnailUrl(path);
                pujaRepo.save(puja);
                log.info("SUCCESS: " + name + " thumbnail updated to: " + path);
            }
        }
    }
}