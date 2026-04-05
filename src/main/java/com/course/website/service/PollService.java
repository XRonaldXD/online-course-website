package com.course.website.service;

import com.course.website.entity.Poll;
import com.course.website.repository.PollRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class PollService {
    private final PollRepository pollRepository;

    public PollService(PollRepository pollRepository) {
        this.pollRepository = pollRepository;
    }

    public List<Poll> findAll() { return pollRepository.findAll(); }
    public Poll findById(Long id) { return pollRepository.findById(id).orElseThrow(); }

    @Transactional
    public Poll save(Poll poll) { return pollRepository.save(poll); }

    @Transactional
    public void deleteById(Long id) { pollRepository.deleteById(id); }

    public long count() { return pollRepository.count(); }
}
