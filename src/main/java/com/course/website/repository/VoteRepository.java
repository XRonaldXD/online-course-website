package com.course.website.repository;

import com.course.website.entity.Vote;
import com.course.website.entity.Poll;
import com.course.website.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;

public interface VoteRepository extends JpaRepository<Vote, Long> {
    Optional<Vote> findByPollAndUser(Poll poll, User user);
    List<Vote> findByUser(User user);
    long countByPollAndSelectedOption(Poll poll, int selectedOption);
    void deleteByPoll(Poll poll);
}
