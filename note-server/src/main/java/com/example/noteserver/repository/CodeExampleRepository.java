package com.example.noteserver.repository;

import com.example.noteserver.entity.CodeExample;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface CodeExampleRepository extends JpaRepository<CodeExample, Long> {
    List<CodeExample> findByKnowledgePoint_IdAndEnabledTrueOrderBySortOrderAsc(Long knowledgePointId);
}

