package com.example.noteserver.repository;

import com.example.noteserver.entity.KnowledgePoint;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface KnowledgePointRepository extends JpaRepository<KnowledgePoint, Long> {
    List<KnowledgePoint> findByEnabledTrueOrderBySortOrderAsc();

    List<KnowledgePoint> findByModule_IdAndEnabledTrueOrderBySortOrderAsc(Long moduleId);
}

