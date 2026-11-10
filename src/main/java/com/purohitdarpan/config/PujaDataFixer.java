package com.purohitdarpan.config;

import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.entity.PujaStep;
import com.purohitdarpan.entity.Resource;
import com.purohitdarpan.repository.PujaRepository;
import com.purohitdarpan.repository.PujaStepRepository;
import com.purohitdarpan.repository.ResourceRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.Optional;

@Configuration
@RequiredArgsConstructor
@Slf4j
public class PujaDataFixer implements CommandLineRunner {

    private final PujaRepository pujaRepo;
    private final PujaStepRepository stepRepo;
    private final ResourceRepository resourceRepo;
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void run(String... args) {
        log.info("Checking for Puja updates and Kali Puja seeding...");
        
        updatePujaThumbnail("Durga Puja", "/images/durga_closeup.jpg");
        updatePujaThumbnail("Ganesh Puja", "/images/ganesh_closeup.jpg");
        updatePujaThumbnail("Lakshmi Puja", "/images/lakshmi_closeup.jpg");
        updatePujaThumbnail("Saraswati Puja", "/images/saraswati_closeup.jpg");
        updatePujaThumbnail("Shiv Puja", "/images/shiv_closeup.jpg");
        updatePujaThumbnail("Satyanarayan Katha", "/images/satyanarayan_closeup.jpg");
        updatePujaThumbnail("Satyanarayan Puja", "/images/satyanarayan_closeup.jpg");

        seedOrUpdateKaliPuja();
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

    private void seedOrUpdateKaliPuja() {
        try {
            Optional<Puja> existingOpt = pujaRepo.findByNameIgnoreCase("Kali Puja");
            Puja kali;
            if (existingOpt.isPresent()) {
                kali = existingOpt.get();
                kali.setThumbnailUrl("/images/kali_closeup.jpg");
                kali.setIsActive(true);
                kali.setNameDevanagari("শ্রীশ্রী দক্ষিণকালী পূজা");
                kali.setCategory("Shakti");
                kali = pujaRepo.save(kali);
                log.info("SUCCESS: Kali Puja (ID: {}) verified and updated.", kali.getId());
            } else {
                kali = Puja.builder()
                        .name("Kali Puja")
                        .nameDevanagari("শ্রীশ্রী দক্ষিণকালী পূজা")
                        .description("Complete ritual procedure for Kartik Amavasya Shyama Puja - Shodashopachara Puja and Tantrokto Home.")
                        .durationMinutes(180)
                        .difficulty(Puja.Difficulty.ADVANCED)
                        .category("Shakti")
                        .thumbnailUrl("/images/kali_closeup.jpg")
                        .isActive(true)
                        .build();
                kali = pujaRepo.save(kali);
                log.info("SUCCESS: Kali Puja seeded with ID: {}", kali.getId());
            }

            final Long kaliId = kali.getId();
            final Puja kaliRef = kali;

            // Ensure Kali Guide Resource exists
            Resource kaliDoc = resourceRepo.findByPujaId(kaliId).stream()
                    .filter(r -> r.getFileUrl() != null && r.getFileUrl().contains("kali_puja_guide.html"))
                    .findFirst()
                    .orElseGet(() -> {
                        Resource r = Resource.builder()
                                .puja(kaliRef)
                                .title("শ্রীশ্রীদক্ষিণকালী পূজা পদ্ধতি — সম্পূর্ণ গাইড")
                                .resourceType(Resource.ResourceType.DOCX)
                                .fileUrl("/docs/kali_puja_guide.html")
                                .isDownloadable(true)
                                .build();
                        return resourceRepo.save(r);
                    });

            final Resource docResource = kaliDoc;

            // Clean up any steps with stepOrder > 2 for Kali Puja
            try {
                jdbcTemplate.update("DELETE FROM user_puja_progress WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM video_bookmarks WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM user_highlights WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM user_step_notes WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM step_mantras WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM step_samagri WHERE step_id IN (SELECT id FROM puja_steps WHERE puja_id = ? AND step_order > 2)", kaliId);
                jdbcTemplate.update("DELETE FROM puja_steps WHERE puja_id = ? AND step_order > 2", kaliId);
                log.info("Removed legacy steps > 2 for Kali Puja.");
            } catch (Exception ex) {
                log.warn("Notice during step cleanup: {}", ex.getMessage());
            }

            // Step 1: Shodashopachara Puja
            Optional<PujaStep> step1Opt = stepRepo.findByPujaIdAndStepOrder(kaliId, 1);
            PujaStep step1 = step1Opt.orElseGet(() -> PujaStep.builder().puja(kaliRef).stepOrder(1).build());
            step1.setTitle("Shodashopachara Puja");
            step1.setTitleDevanagari("षोडशोपचार पूजा");
            step1.setTitleBengali("ষোড়শোপচার পূজা");
            step1.setDescription("<h3>ষোড়শোপচার পূজা (Shodashopachara Puja)</h3><p>মা দক্ষিণকালিকার উদ্দেশ্যে ষোড়শ উপাচারে যথাবিধি পূজা নিবেদন — আসন, স্বাগত, পদ্য, অর্ঘ্য, আচমনীয়, স্নানীয়, বসন, ভূষণ, গন্ধ, পুষ্প, ধূপ, দীপ, নৈবেদ্য, পানীয় ও তাম্বুল প্রদান।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">পুষ্প ও চন্দন নিবেদন মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ রক্তচন্দন সংমিশ্রং রক্তপুষ্পং মনোহরম্। কাল্যৈ দত্তং ময়া দেব্যৈ গৃহাণ পরমেশ্বরী॥</p><p class=\"text-orange-300 font-semibold mt-2\">বসন ও অর্ঘ্য নিবেদন মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ রক্তবস্ত্রযুগং দেবি সর্বকামার্থসিদ্ধয়ে। ময়া নিবেদিতং ভক্ত্যা গৃহাণ পরমেশ্বরী॥</p></div>");
            step1.setVideoUrl("https://youtu.be/N4wpFi0iyxw?si=ca12IbkVCK1B479I");
            step1.setPdfResource(docResource);
            stepRepo.save(step1);

            // Step 2: Tantrokto Home
            Optional<PujaStep> step2Opt = stepRepo.findByPujaIdAndStepOrder(kaliId, 2);
            PujaStep step2 = step2Opt.orElseGet(() -> PujaStep.builder().puja(kaliRef).stepOrder(2).build());
            step2.setTitle("Tantrokto Home");
            step2.setTitleDevanagari("तन्त्रोक्त होम");
            step2.setTitleBengali("তন্ত্রোক্ত হোম");
            step2.setDescription("<h3>তন্ত্রোক্ত হোম (Tantrokto Home)</h3><p>দেবী কালীর প্রতি তান্ত্রিক বিধান অনুযায়ী হোম ও যজ্ঞবিধি — স্থণ্ডিল নির্মাণ, অগ্নিসংস্কার, বিশ্বামিত্র গোত্রীয় যজ্ঞভুক্ অগ্নি স্থাপন, কুশণ্ডিকা, আজ্যভাগাহুতি, দেবী কালীর সিদ্ধ মূলমন্ত্রে আহুতি এবং মহাব্যাহৃতি ও পূর্ণাহুতি প্রদান।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">অগ্নি আবাহন মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ অগ্নিং দূতং পুরোধায় হব্যবাহমুপব্রুবে। দেবাঁ আসাদয়াদিহ॥ ওঁ যজ্ঞভুগগ্নয়ে নমঃ।</p><p class=\"text-orange-300 font-semibold mt-2\">দেবী কালীর হোম আহুতি মূলমন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ ক্রীঁ দক্ষিণকালিকায়ৈ স্বাহা (ॐ क्रीं काल्यै स्वाहा) — ১০৮ বার যথাবিধি ঘৃতাহুতি।</p><p class=\"text-orange-300 font-semibold mt-2\">পূর্ণাহুতি মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ পূর্ণমদঃ পূর্ণমিদং পূর্ণাৎ পূর্ণমুদচ্যতে। পূর্ণস্য পূর্ণমাদায় পূর্ণমেবাবশিষ্যতে॥ স্বাহা।</p></div>");
            step2.setVideoUrl("https://youtu.be/62qCR6aaUbw?si=Nr_P-AZXnHcSkpRE");
            step2.setPdfResource(docResource);
            stepRepo.save(step2);

            log.info("SUCCESS: Kali Puja configured with Step 1: Shodashopachara Puja & Step 2: Tantrokto Home.");

        } catch (Exception e) {
            log.error("Error seeding/updating Kali Puja: {}", e.getMessage(), e);
        }
    }
}
