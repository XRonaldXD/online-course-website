package com.course.website.service;

import com.course.website.entity.Comment;
import com.course.website.entity.User;
import com.course.website.repository.CommentRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;

    public CommentService(CommentRepository commentRepository) {
        this.commentRepository = commentRepository;
    }

    @Transactional
    public Comment save(Comment comment) { return commentRepository.save(comment); }

    public List<Comment> findByTarget(Comment.TargetType type, Long id) {
        return commentRepository.findByTargetTypeAndTargetIdOrderByCreatedAtAsc(type, id);
    }

    public List<Comment> findByAuthor(User author) {
        return commentRepository.findByAuthorOrderByCreatedAtDesc(author);
    }

    @Transactional
    public void deleteById(Long id) { commentRepository.deleteById(id); }
}
