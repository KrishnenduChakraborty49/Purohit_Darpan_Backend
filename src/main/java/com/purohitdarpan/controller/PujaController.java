package com.purohitdarpan.controller;

import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.entity.PujaStep;
import com.purohitdarpan.repository.PujaRepository;
import com.purohitdarpan.repository.PujaStepRepository;
import com.purohitdarpan.repository.ResourceRepository;
import com.purohitdarpan.entity.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pujas")
@RequiredArgsConstructor
public class PujaController {

    private final PujaRepository pujaRepo;
    private final PujaStepRepository stepRepo;
    private final ResourceRepository resourceRepo;

    @GetMapping
    public ResponseEntity<List<Puja>> getAllPujas() {
        return ResponseEntity.ok(pujaRepo.findByIsActiveTrueOrderByNameAsc());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Puja> getPuja(@PathVariable Long id) {
        return pujaRepo.findById(id).map(puja -> {
            if (puja.getSteps() != null) {
                puja.getSteps().forEach(step -> {
                    if (step.getPdfResource() != null) {
                        org.hibernate.Hibernate.initialize(step.getPdfResource());
                    }
                });
            }
            return ResponseEntity.ok(puja);
        }).orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{pujaId}/steps")
    public ResponseEntity<List<PujaStep>> getSteps(@PathVariable Long pujaId) {
        List<PujaStep> steps = stepRepo.findByPujaIdOrderByStepOrderAsc(pujaId);
        // Force initialize lazy proxy for Jackson
        steps.forEach(step -> {
            if (step.getPdfResource() != null) {
                org.hibernate.Hibernate.initialize(step.getPdfResource());
            }
        });
        return ResponseEntity.ok(steps);
    }

    @GetMapping("/{pujaId}/resources")
    public ResponseEntity<List<Resource>> getResources(@PathVariable Long pujaId) {
        return ResponseEntity.ok(resourceRepo.findByPujaId(pujaId));
    }

    @GetMapping("/{pujaId}/steps/{stepId}")
    public ResponseEntity<PujaStep> getStep(
            @PathVariable Long pujaId, @PathVariable Long stepId) {
        return stepRepo.findById(stepId)
                .filter(s -> s.getPuja() != null && s.getPuja().getId().equals(pujaId))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/search")
    public ResponseEntity<List<Puja>> search(@RequestParam String q) {
        return ResponseEntity.ok(pujaRepo.searchByKeyword(q));
    }

    @PostMapping
    public ResponseEntity<Puja> createPuja(@RequestBody Puja puja) {
        return ResponseEntity.ok(pujaRepo.save(puja));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Puja> updatePuja(@PathVariable Long id, @RequestBody Puja puja) {
        return pujaRepo.findById(id).map(existing -> {
            puja.setId(id);
            return ResponseEntity.ok(pujaRepo.save(puja));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deletePuja(@PathVariable Long id) {
        pujaRepo.findById(id).ifPresent(p -> {
            p.setIsActive(false);
            pujaRepo.save(p);
        });
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{pujaId}/steps")
    public ResponseEntity<PujaStep> addStep(
            @PathVariable Long pujaId, @RequestBody PujaStep step) {
        return pujaRepo.findById(pujaId).map(puja -> {
            step.setPuja(puja);
            if (step.getStepOrder() == null) {
                step.setStepOrder(stepRepo.countByPujaId(pujaId) + 1);
            }
            return ResponseEntity.ok(stepRepo.save(step));
        }).orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{pujaId}/steps/{stepId}")
    public ResponseEntity<PujaStep> updateStep(
            @PathVariable Long pujaId, @PathVariable Long stepId, @RequestBody PujaStep updated) {
        return stepRepo.findById(stepId)
                .filter(s -> s.getPuja() != null && s.getPuja().getId().equals(pujaId))
                .map(existing -> {
                    if (updated.getTitle() != null) existing.setTitle(updated.getTitle());
                    if (updated.getTitleBengali() != null) existing.setTitleBengali(updated.getTitleBengali());
                    if (updated.getTitleDevanagari() != null) existing.setTitleDevanagari(updated.getTitleDevanagari());
                    if (updated.getDescription() != null) existing.setDescription(updated.getDescription());
                    if (updated.getVideoUrl() != null) existing.setVideoUrl(updated.getVideoUrl());
                    if (updated.getVideoTranscript() != null) existing.setVideoTranscript(updated.getVideoTranscript());
                    if (updated.getStepOrder() != null) existing.setStepOrder(updated.getStepOrder());
                    if (updated.getDurationSeconds() != null) existing.setDurationSeconds(updated.getDurationSeconds());
                    return ResponseEntity.ok(stepRepo.save(existing));
                }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{pujaId}/steps/{stepId}")
    public ResponseEntity<Void> deleteStep(
            @PathVariable Long pujaId, @PathVariable Long stepId) {
        return stepRepo.findById(stepId)
                .filter(s -> s.getPuja() != null && s.getPuja().getId().equals(pujaId))
                .map(step -> {
                    stepRepo.delete(step);
                    return ResponseEntity.ok().<Void>build();
                }).orElse(ResponseEntity.notFound().build());
    }
}
