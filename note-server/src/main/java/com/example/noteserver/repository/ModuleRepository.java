package com.example.noteserver.repository;

import com.example.noteserver.entity.Module;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ModuleRepository extends JpaRepository<Module, Long> {
    List<Module> findByLanguage_IdAndEnabledTrueOrderBySortOrderAsc(Long languageId);
}
