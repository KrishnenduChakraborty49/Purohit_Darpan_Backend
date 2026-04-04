package com.purohitdarpan.exception;

import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ProblemDetail;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import java.time.LocalDateTime;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {

    // Final Stability Fix: Capture the last error for diagnostics
    // We can read these from the /api/diagnostics/db-status URL
    public static String lastError = "None";
    public static String lastErrorTrace = "";

    /**
     * Captures ALL unhandled exceptions (500 errors).
     * Saves the error message and stack trace for diagnostic visibility!
     */
    @ExceptionHandler(Exception.class)
    public ProblemDetail handleGeneral(Exception ex) {
        log.error("Unhandled exception: {}", ex.getMessage(), ex);

        // Save the error for our diagnostics tool
        lastError = ex.getClass().getSimpleName() + ": " + ex.getMessage();
        java.io.StringWriter sw = new java.io.StringWriter();
        ex.printStackTrace(new java.io.PrintWriter(sw));
        lastErrorTrace = sw.toString();

        ProblemDetail detail = ProblemDetail.forStatusAndDetail(
                HttpStatus.INTERNAL_SERVER_ERROR,
                "An unexpected system-wide error occurred: " + lastError);

        detail.setProperty("timestamp", LocalDateTime.now().toString());
        return detail;
    }
}


