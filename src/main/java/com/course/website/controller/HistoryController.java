package com.course.website.controller;

import com.course.website.entity.*;
import com.course.website.service.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/history")
public class HistoryController {

    private final UserService userService;
    private final VoteService voteService;
    private final CommentService commentService;
    private final PollService pollService;
    private final LectureService lectureService;

    public HistoryController(UserService userService, VoteService voteService,
                             CommentService commentService, PollService pollService,
                             LectureService lectureService) {
        this.userService = userService;
        this.voteService = voteService;
        this.commentService = commentService;
        this.pollService = pollService;
        this.lectureService = lectureService;
    }

    private User getCurrentUser(Authentication auth) {
        return userService.findAll().stream()
                .filter(u -> u.getUsername().equals(auth.getName())).findFirst().orElseThrow();
    }

    @GetMapping("/votes")
    public String votes(Model model, Authentication auth) {
        User user = getCurrentUser(auth);
        List<Vote> votes = voteService.findByUser(user);
        model.addAttribute("votes", votes);
        return "history/votes";
    }

    @GetMapping("/comments")
    public String comments(Model model, Authentication auth) {
        User user = getCurrentUser(auth);
        List<Comment> comments = commentService.findByAuthor(user);
        model.addAttribute("comments", comments);
        model.addAttribute("lectureService", lectureService);
        model.addAttribute("pollService", pollService);
        return "history/comments";
    }
}
