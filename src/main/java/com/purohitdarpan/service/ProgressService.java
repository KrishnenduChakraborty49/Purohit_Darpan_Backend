package com.purohitdarpan.service;

import com.purohitdarpan.entity.*;
import com.purohitdarpan.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ProgressService {

    private final UserPujaProgressRepository progressRepo;
    private final UserStepNoteRepository noteRepo;
    private final UserHighlightRepository highlightRepo;
    private final VideoBookmarkRepository videoBookmarkRepo;
    private final PdfAnnotationRepository pdfAnnotationRepo;
    private final UserRepository userRepo;
    private final PujaRepository pujaRepo;
    private final PujaStepRepository stepRepo;
    private final ResourceRepository resourceRepo;
    private final FCMService fcmService;
    private final NotificationLogRepository notifLogRepo;

    @Transactional
    public UserPujaProgress updateProgress(Long userId, Long pujaId, Long stepId,
                                           String format, boolean completed) {
        UserPujaProgress.LearningFormat fmt = UserPujaProgress.LearningFormat.valueOf(format);
        Optional<UserPujaProgress> existing =
                progressRepo.findByUserIdAndPujaIdAndStepIdAndFormat(userId, pujaId, stepId, fmt);

        UserPujaProgress progress;
        if (existing.isPresent()) {
            progress = existing.get();
            boolean wasCompleted = Boolean.TRUE.equals(progress.getCompleted());
            progress.setCompleted(completed);
            if (completed && !wasCompleted) { sendCompletionNotif(progress); }
        } else {
            progress = UserPujaProgress.builder()
                    .user(userRepo.getReferenceById(userId))
                    .puja(pujaRepo.getReferenceById(pujaId))
                    .step(stepRepo.findById(stepId).orElseThrow(() -> new RuntimeException("Step not found"))) 
                    .format(fmt)
                    .completed(completed)
                    .build();
            if (completed) { sendCompletionNotif(progress); }
        }
        return progressRepo.save(progress);
    }

    public List<UserPujaProgress> getProgress(Long userId, Long pujaId) {
        return progressRepo.findByUserIdAndPujaId(userId, pujaId);
    }

    @Transactional
    public UserStepNote saveNote(Long userId, Long stepId, String noteText) {
        UserStepNote note = UserStepNote.builder()
                .user(userRepo.getReferenceById(userId))
                .step(stepRepo.findById(stepId).orElseThrow(() -> new RuntimeException("Step not found"))) 
                .noteText(noteText)
                .build();
        return noteRepo.save(note);
    }

    public List<UserStepNote> getNotes(Long userId, Long stepId) {
        return noteRepo.findByUserIdAndStepIdOrderByCreatedAtDesc(userId, stepId);
    }

    @Transactional
    public void deleteNote(Long userId, Long noteId) {
        noteRepo.deleteByUserIdAndId(userId, noteId);
    }

    @Transactional
    public UserHighlight saveHighlight(Long userId, Long stepId, String text, int start, int end) {
        UserHighlight hl = UserHighlight.builder()
                .user(userRepo.getReferenceById(userId))
                .step(stepRepo.findById(stepId).orElseThrow(() -> new RuntimeException("Step not found"))) 
                .highlightedText(text)
                .startOffset(start)
                .endOffset(end)
                .build();
        return highlightRepo.save(hl);
    }

    public List<UserHighlight> getHighlights(Long userId, Long stepId) {
        return highlightRepo.findByUserIdAndStepId(userId, stepId);
    }

    @Transactional
    public VideoBookmark saveVideoBookmark(Long userId, Long stepId,
                                           String videoUrl, int timestampSeconds, String label) {
        VideoBookmark bm = VideoBookmark.builder()
                .user(userRepo.getReferenceById(userId))
                .step(stepRepo.findById(stepId).orElseThrow(() -> new RuntimeException("Step not found"))) 
                .videoUrl(videoUrl)
                .timestampSeconds(timestampSeconds)
                .label(label)
                .build();
        return videoBookmarkRepo.save(bm);
    }

    public List<VideoBookmark> getVideoBookmarks(Long userId, Long stepId) {
        return videoBookmarkRepo.findByUserIdAndStepIdOrderByTimestampSecondsAsc(userId, stepId);
    }

    @Transactional
    public PdfAnnotation savePdfAnnotation(Long userId, Long resourceId, int pageNumber,
                                            String text, float x, float y) {
        PdfAnnotation ann = PdfAnnotation.builder()
                .user(userRepo.getReferenceById(userId))
                .resource(resourceRepo.getReferenceById(resourceId))
                .pageNumber(pageNumber)
                .annotationText(text)
                .positionX(x)
                .positionY(y)
                .build();
        return pdfAnnotationRepo.save(ann);
    }

    public List<PdfAnnotation> getPdfAnnotations(Long userId, Long resourceId) {
        return pdfAnnotationRepo
                .findByUserIdAndResourceIdOrderByPageNumberAscPositionYAsc(userId, resourceId);
    }

    private void sendCompletionNotif(UserPujaProgress p) {
        String title = "?? Step Completed: " + p.getStep().getTitle();
        String body  = "Great progress! You've mastered this ritual step. Ready for the next one?";
        String url   = "/puja/" + p.getPuja().getId();
        
        // Use FCMService and log it
        String msgId = fcmService.sendNotification(p.getUser().getFcmToken(), title, body, java.util.Map.of("type", "COMPLETION", "url", url));
        
        notifLogRepo.save(com.purohitdarpan.entity.NotificationLog.builder()
            .user(p.getUser())
            .notificationType(com.purohitdarpan.entity.NotificationLog.NotificationType.PUJA_PRACTICE)
            .title(title).body(body).actionUrl(url).fcmMessageId(msgId).build());
    }
}



