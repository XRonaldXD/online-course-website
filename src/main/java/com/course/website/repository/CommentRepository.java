package com.course.website.repository;

import com.course.website.entity.Comment;
import com.course.website.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface CommentRepository extends JpaRepository<Comment, Long> {
    List<Comment> findByTargetTypeAndTargetIdOrderByCreatedAtAsc(Comment.TargetType targetType, Long targetId);
    List<Comment> findByAuthorOrderByCreatedAtDesc(User author);
}
