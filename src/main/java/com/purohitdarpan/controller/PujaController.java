package com.purohitdarpan.controller;

import com.purohitdarpan.entity.Puja;
import com.purohitdarpan.entity.PujaStep;
import com.purohitdarpan.repository.PujaRepository;
import com.purohitdarpan.repository.PujaStepRepository;
import com.purohitdarpan.repository.ResourceRepository;
import com.purohitdarpan.entity.Resource;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
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
                .filter(s -> s.getPuja().getId().equals(pujaId))
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/search")
    public ResponseEntity<List<Puja>> search(@RequestParam String q) {
        return ResponseEntity.ok(pujaRepo.searchByKeyword(q));
    }

    @PostMapping
    @PreAuthorize("hasAnyRole('MENTOR','ADMIN')")
    public ResponseEntity<Puja> createPuja(@RequestBody Puja puja) {
        return ResponseEntity.ok(pujaRepo.save(puja));
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('MENTOR','ADMIN')")
    public ResponseEntity<Puja> updatePuja(@PathVariable Long id, @RequestBody Puja puja) {
        return pujaRepo.findById(id).map(existing -> {
            puja.setId(id);
            return ResponseEntity.ok(pujaRepo.save(puja));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasRole('ADMIN')")
    public ResponseEntity<Void> deletePuja(@PathVariable Long id) {
        pujaRepo.findById(id).ifPresent(p -> {
            p.setIsActive(false);
            pujaRepo.save(p);
        });
        return ResponseEntity.noContent().build();
    }
}
