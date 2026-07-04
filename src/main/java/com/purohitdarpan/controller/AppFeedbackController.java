package com.purohitdarpan.controller;

import com.purohitdarpan.dto.request.FeedbackRequest;
import com.purohitdarpan.entity.AppFeedback;
import com.purohitdarpan.entity.User;
import com.purohitdarpan.repository.AppFeedbackRepository;
import com.purohitdarpan.repository.UserRepository;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/feedback")
@RequiredArgsConstructor
@CrossOrigin(origins = "*", maxAge = 3600)
public class AppFeedbackController {

    private final AppFeedbackRepository appFeedbackRepository;
    private final UserRepository userRepository;

    @PostMapping
    public ResponseEntity<?> submitFeedback(@Valid @RequestBody FeedbackRequest request) {
        String username = SecurityContextHolder.getContext().getAuthentication().getName();
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new RuntimeException("User not found"));

        AppFeedback feedback = AppFeedback.builder()
                .user(user)
                .rating(request.getRating())
                .comments(request.getComments())
                .build();

        appFeedbackRepository.save(feedback);

        return ResponseEntity.ok().body("Feedback submitted successfully");
    }
}
