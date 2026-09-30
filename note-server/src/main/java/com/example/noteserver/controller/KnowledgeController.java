package com.example.noteserver.controller;

import com.example.noteserver.dto.ApiResponse;
import com.example.noteserver.entity.CodeExample;
import com.example.noteserver.entity.KnowledgePoint;
import com.example.noteserver.entity.Language;
import com.example.noteserver.entity.Module;
import com.example.noteserver.service.KnowledgeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api")
public class KnowledgeController {
    private final KnowledgeService knowledgeService;

    public KnowledgeController(KnowledgeService knowledgeService) {
        this.knowledgeService = knowledgeService;
    }

    @GetMapping("/languages")
    public ApiResponse<List<Language>> getLanguages() {
        return ApiResponse.success(knowledgeService.findAllLanguages());
    }

    @GetMapping("/modules")
    public ApiResponse<List<Module>> getModules() {
        return ApiResponse.success(knowledgeService.findModulesByLanguage(1L));
    }

    @GetMapping("/modules/{languageId}")
    public ApiResponse<List<Module>> getModulesByLanguage(@PathVariable Long languageId) {
        return ApiResponse.success(knowledgeService.findModulesByLanguage(languageId));
    }

    @GetMapping("/knowledge-points/{moduleId}")
    public ApiResponse<List<KnowledgePoint>> getKnowledgePoints(@PathVariable Long moduleId) {
        return ApiResponse.success(knowledgeService.findKnowledgePointsByModule(moduleId));
    }

    @GetMapping("/knowledge-points/detail/{id}")
    public ApiResponse<KnowledgePoint> getKnowledgePoint(@PathVariable Long id) {
        return knowledgeService.findKnowledgePoint(id)
                .map(ApiResponse::success)
                .orElse(ApiResponse.error("Not found"));
    }

    @GetMapping("/examples/{knowledgePointId}")
    public ApiResponse<List<CodeExample>> getExamples(@PathVariable Long knowledgePointId) {
        return ApiResponse.success(knowledgeService.findExamplesByKnowledgePoint(knowledgePointId));
    }
}

