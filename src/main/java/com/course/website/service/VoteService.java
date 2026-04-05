package com.course.website.service;

import com.course.website.entity.Poll;
import com.course.website.entity.User;
import com.course.website.entity.Vote;
import com.course.website.repository.VoteRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class VoteService {
    private final VoteRepository voteRepository;

    public VoteService(VoteRepository voteRepository) {
        this.voteRepository = voteRepository;
    }

    @Transactional
    public Vote vote(Poll poll, User user, int selectedOption) {
        Optional<Vote> existing = voteRepository.findByPollAndUser(poll, user);
        Vote vote = existing.orElse(new Vote());
        vote.setPoll(poll);
        vote.setUser(user);
        vote.setSelectedOption(selectedOption);
        return voteRepository.save(vote);
    }

    public Optional<Vote> findByPollAndUser(Poll poll, User user) {
        return voteRepository.findByPollAndUser(poll, user);
    }

    public long countByPollAndOption(Poll poll, int option) {
        return voteRepository.countByPollAndSelectedOption(poll, option);
    }

    public List<Vote> findByUser(User user) { return voteRepository.findByUser(user); }
}
