package com.course.website.service;

import com.course.website.entity.Lecture;
import com.course.website.entity.MaterialFile;
import com.course.website.repository.LectureRepository;
import com.course.website.repository.MaterialFileRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

@Service
public class LectureService {
    private final LectureRepository lectureRepository;
    private final MaterialFileRepository materialFileRepository;

    public LectureService(LectureRepository lectureRepository, MaterialFileRepository materialFileRepository) {
        this.lectureRepository = lectureRepository;
        this.materialFileRepository = materialFileRepository;
    }

    public List<Lecture> findAll() { return lectureRepository.findAll(); }
    public Lecture findById(Long id) { return lectureRepository.findById(id).orElseThrow(); }

    @Transactional
    public Lecture save(Lecture lecture) { return lectureRepository.save(lecture); }

    @Transactional
    public void deleteById(Long id) { lectureRepository.deleteById(id); }

    @Transactional
    public void uploadFile(Long lectureId, MultipartFile file) throws IOException {
        Lecture lecture = findById(lectureId);
        MaterialFile mf = new MaterialFile();
        mf.setLecture(lecture);
        mf.setFilename(file.getOriginalFilename());
        mf.setContentType(file.getContentType());
        mf.setData(file.getBytes());
        materialFileRepository.save(mf);
    }

    @Transactional
    public void deleteFile(Long fileId) { materialFileRepository.deleteById(fileId); }

    public MaterialFile findFileById(Long id) { return materialFileRepository.findById(id).orElseThrow(); }

    public long count() { return lectureRepository.count(); }
}
