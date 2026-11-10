package com.purohitdarpan.config;

import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.entity.PujaStep;
import com.purohitdarpan.repository.PujaRepository;
import com.purohitdarpan.repository.PujaStepRepository;
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
    private final PujaStepRepository stepRepo;

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
                if (kali.getNameDevanagari() == null || kali.getNameDevanagari().isEmpty()) {
                    kali.setNameDevanagari("काली पूजा");
                }
                if (kali.getCategory() == null || kali.getCategory().isEmpty()) {
                    kali.setCategory("Shakti");
                }
                kali = pujaRepo.save(kali);
                log.info("SUCCESS: Kali Puja (ID: {}) verified and updated.", kali.getId());
            } else {
                kali = Puja.builder()
                        .name("Kali Puja")
                        .nameDevanagari("काली पूजा")
                        .description("Complete ritual procedure for Kartik Amavasya Shyama Puja - invocation, shodashopachara worship, pushpanjali, and midnight arati.")
                        .durationMinutes(180)
                        .difficulty(Puja.Difficulty.ADVANCED)
                        .category("Shakti")
                        .thumbnailUrl("/images/kali_closeup.jpg")
                        .isActive(true)
                        .build();
                kali = pujaRepo.save(kali);
                log.info("SUCCESS: Kali Puja seeded with ID: {}", kali.getId());
            }

            int stepCount = stepRepo.countByPujaId(kali.getId());
            if (stepCount == 0) {
                log.info("Seeding 6 sacred steps for Kali Puja (ID: {})...", kali.getId());

                saveStep(kali, 1,
                        "Achamana & Svastivachana",
                        "आचमन एवं स्वस्तिवाचन",
                        "আচমন ও স্বস্তিবচন",
                        "<h3>আচমন ও স্বস্তিবচন (Achamana & Svastivachana)</h3><p>পবিত্র গঙ্গাজল কুশীতে নিয়ে তিনবার আচমন এবং ওঁ বিষ্ণু স্মরণ। স্বস্তিবাচন মন্ত্র পাঠ করে পূজার শুভারম্ভ করা হয়।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ তদ্বিষ্ণোঃ পরমং পদং সদা পশ্যন্তি সূরয়ঃ দিবীব চক্ষুরাততম্।</p></div>",
                        "https://www.youtube.com/watch?v=kYJ5oQ6zFZs");

                saveStep(kali, 2,
                        "Sankalpa & Ghatasthapana",
                        "संकल्प एवं घटस्थापन",
                        "সংকল্প ও ঘটস্থাপন",
                        "<h3>সংকল্প ও ঘটস্থাপন (Sankalpa & Ghatasthapana)</h3><p>কার্তিক অমাবস্যা তিথিতে মা কালীর পূজার সংকল্প গ্রহণ এবং পঞ্চগুঁড়ি, গঙ্গামৃত্তিকা ও পঞ্চপল্লব সহযোগে মঙ্গলঘট স্থাপন।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">সংকল্প বাক্য:</p><p class=\"italic text-orange-200\">বিষ্ণুরোম্ তৎসৎ অদ্য কার্তিকী অমাবস্যায়াং তিথৌ... শ্রীমদ্দক্ষিণকালিকা প্রীতিকামঃ পূজাকর্মাহং করিষ্যে।</p></div>",
                        "https://www.youtube.com/watch?v=yQt_GhyWOXc");

                saveStep(kali, 3,
                        "Maa Kali Dhyana & Avahana",
                        "माँ काली ध्यान एवं आवाहन",
                        "মা কালীর ধ্যান ও আবাহন",
                        "<h3>মা কালীর ধ্যান ও আবাহন (Maa Kali Dhyana & Avahana)</h3><p>শ্রী শ্রী দক্ষিণকালিকার দিব্য ধ্যান ও প্রাণপ্রতিষ্ঠা। করালবদনা চতুর্ভুজা খড়্গধারিণী মা ভবতারিণীর রূপ ধ্যান।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">ধ্যান মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ করালবদনাং ঘোরাং মুক্তকেশীং চতুর্ভুজাং। কালিকাং দক্ষিণাং দিব্যাং মুণ্ডমালাবিভূষিতাম্॥ সদাহাস্যাননাং দেবীং পীনোন্নতপয়োধরাম্। মহামেঘপ্রভাং শ্যামাং ত্রিনেত্রাং বরদাভয়াম্॥</p></div>",
                        "https://www.youtube.com/watch?v=JAl7pjMa2q8");

                saveStep(kali, 4,
                        "Shodashopachara Puja",
                        "षोडशोपचार पूजा",
                        "ষোড়শোপচারে পূজা",
                        "<h3>ষোড়শোপচারে পূজা ও অর্ঘ্য প্রদান (Shodashopachara Puja)</h3><p>দেবীকে ষোড়শ উপচার নিবেদন — আসন, স্বাগত, পদ্য, অর্ঘ্য, আচমনীয়, মধুপর্ক, স্নানীয়, বস্ত্র, ভূষণ, গন্ধ (রক্তচন্দন), পুষ্প (১০৮ লাল জবা ফুল), ধূপ, দীপ, নৈবেদ্য, পানীয় ও তাম্বুল।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">জবা পুষ্প প্রদান মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ রক্তচন্দন সংমিশ্রং রক্তপুষ্পং মনোহরম্। কাল্যৈ দত্তং ময়া দেব্যৈ গৃহাণ পরমেশ্বরী॥</p></div>",
                        "https://www.youtube.com/watch?v=5u-uulot9X4");

                saveStep(kali, 5,
                        "Pushpanjali & Japa Mantra",
                        "पुष्पाञ्जलि एवं मूल मन्त्र",
                        "পুষ্পাঞ্জলি মন্ত্র ও জপ",
                        "<h3>পুষ্পাঞ্জলি ও মূল বীজ মন্ত্র (Pushpanjali & Japa)</h3><p>ভক্তবৃন্দের সমবেত পুষ্পাঞ্জলি এবং দেবী কালীর সিদ্ধ বীজমন্ত্র জপ।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">পুষ্পাঞ্জলি মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ জয়ন্তী মঙ্গলা কালী ভদ্রকালী কপালিনী। দুর্গা শিবা ক্ষমা ধাত্রী স্বাহা স্বধা নমোঽস্তু তে॥<br/>এষ সচন্দন পুষ্পবিল্বপত্রাঞ্জলিঃ শ্রীমদ্দক্ষিণকালিকায়ৈ নমঃ।</p><p class=\"text-orange-300 font-semibold mt-2\">মূল বীজ মন্ত্র:</p><p class=\"italic text-orange-200\">ওঁ ক্রীঁ কাল্যৈ নমঃ (ॐ क्रीं काल्यै नमः)</p></div>",
                        "https://www.youtube.com/watch?v=roS3QBV_xyU");

                saveStep(kali, 6,
                        "Nishitha Aarti & Visarjan",
                        "निशीथ आरती एवं विसर्जन",
                        "নিশীথ আরতি ও বিসর্জন",
                        "<h3>নিশীথ আরতি, স্তব ও বিসর্জন (Nishitha Aarti & Visarjan)</h3><p>অমাবস্যার নিশীথকালে পঞ্চপ্রদীপ ও কর্পূর আরতি। দেবীস্তোত্র পাঠ, অপরাধ ভঞ্জন স্তব এবং সর্বশেষে মায়ের শান্তিজল গ্রহণ।</p><div class=\"bg-amber-950/30 p-3 rounded-lg border border-orange-500/20 mt-2\"><p class=\"text-orange-300 font-semibold\">প্রণাম মন্ত্র:</p><p class=\"italic text-orange-200\">সর্বমঙ্গল মঙ্গল্যে শিবে সর্বার্থ সাধিকে। শরণ্যে ত্র্যম্বকে গৌরি নারায়ণি নমোঽস্তু তে॥</p></div>",
                        "https://www.youtube.com/watch?v=uBr9f0tMrGs");

                log.info("SUCCESS: 6 sacred steps seeded for Kali Puja.");
            }
        } catch (Exception e) {
            log.error("Error seeding/updating Kali Puja: {}", e.getMessage(), e);
        }
    }

    private void saveStep(Puja puja, int order, String title, String titleDevanagari, String titleBengali, String desc, String videoUrl) {
        PujaStep step = PujaStep.builder()
                .puja(puja)
                .stepOrder(order)
                .title(title)
                .titleDevanagari(titleDevanagari)
                .titleBengali(titleBengali)
                .description(desc)
                .videoUrl(videoUrl)
                .build();
        stepRepo.save(step);
    }
}
