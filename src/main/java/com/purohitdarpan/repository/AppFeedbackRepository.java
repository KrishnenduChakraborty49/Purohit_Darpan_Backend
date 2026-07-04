package com.purohitdarpan.repository;

import com.purohitdarpan.entity.AppFeedback;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AppFeedbackRepository extends JpaRepository<AppFeedback, Long> {
}
