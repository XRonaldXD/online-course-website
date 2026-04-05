package com.course.website.controller;

import com.course.website.entity.MaterialFile;
import com.course.website.service.LectureService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
public class FileController {

    private final LectureService lectureService;

    public FileController(LectureService lectureService) {
        this.lectureService = lectureService;
    }

    @GetMapping("/files/{id}")
    public ResponseEntity<byte[]> download(@PathVariable Long id) {
        MaterialFile file = lectureService.findFileById(id);
        return ResponseEntity.ok()
                .contentType(MediaType.parseMediaType(file.getContentType()))
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
                .body(file.getData());
    }
}
