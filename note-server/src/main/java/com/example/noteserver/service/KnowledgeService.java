package com.example.noteserver.service;

import com.example.noteserver.entity.CodeExample;
import com.example.noteserver.entity.KnowledgePoint;
import com.example.noteserver.entity.Language;
import com.example.noteserver.entity.Module;
import com.example.noteserver.repository.CodeExampleRepository;
import com.example.noteserver.repository.KnowledgePointRepository;
import com.example.noteserver.repository.LanguageRepository;
import com.example.noteserver.repository.ModuleRepository;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class KnowledgeService {
    private final LanguageRepository languageRepository;
    private final ModuleRepository moduleRepository;
    private final KnowledgePointRepository knowledgePointRepository;
    private final CodeExampleRepository codeExampleRepository;

    public KnowledgeService(
            LanguageRepository languageRepository,
            ModuleRepository moduleRepository,
            KnowledgePointRepository knowledgePointRepository,
            CodeExampleRepository codeExampleRepository) {
        this.languageRepository = languageRepository;
        this.moduleRepository = moduleRepository;
        this.knowledgePointRepository = knowledgePointRepository;
        this.codeExampleRepository = codeExampleRepository;
    }

    public List<Language> findAllLanguages() {
        return languageRepository.findAll();
    }

    public List<Module> findModulesByLanguage(Long languageId) {
        return moduleRepository.findByLanguage_IdAndEnabledTrueOrderBySortOrderAsc(languageId);
    }

    public List<KnowledgePoint> findKnowledgePointsByModule(Long moduleId) {
        return knowledgePointRepository.findByModule_IdAndEnabledTrueOrderBySortOrderAsc(moduleId);
    }

    public Optional<KnowledgePoint> findKnowledgePoint(Long id) {
        return knowledgePointRepository.findById(id);
    }

    public List<CodeExample> findExamplesByKnowledgePoint(Long knowledgePointId) {
        return codeExampleRepository.findByKnowledgePoint_IdAndEnabledTrueOrderBySortOrderAsc(knowledgePointId);
    }
}
