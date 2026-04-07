package com.course.website.controller;

import com.course.website.entity.*;
import com.course.website.service.*;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class PollController {

    private final PollService pollService;
    private final VoteService voteService;
    private final CommentService commentService;
    private final UserService userService;

    public PollController(PollService pollService, VoteService voteService,
                          CommentService commentService, UserService userService) {
        this.pollService = pollService;
        this.voteService = voteService;
        this.commentService = commentService;
        this.userService = userService;
    }

    private User getUser(Authentication auth) {
        return userService.findAll().stream()
                .filter(u -> u.getUsername().equals(auth.getName())).findFirst().orElseThrow();
    }

    @GetMapping("/polls/{id}")
    public String detail(@PathVariable Long id, Model model, Authentication auth) {
        Poll poll = pollService.findById(id);
        User user = getUser(auth);
        Vote existingVote = voteService.findByPollAndUser(poll, user).orElse(null);

        model.addAttribute("poll", poll);
        model.addAttribute("existingVote", existingVote);
        model.addAttribute("counts1", voteService.countByPollAndOption(poll, 1));
        model.addAttribute("counts2", voteService.countByPollAndOption(poll, 2));
        model.addAttribute("counts3", voteService.countByPollAndOption(poll, 3));
        model.addAttribute("counts4", voteService.countByPollAndOption(poll, 4));
        model.addAttribute("counts5", voteService.countByPollAndOption(poll, 5));
        model.addAttribute("comments", commentService.findByTarget(Comment.TargetType.POLL, id));
        return "poll/detail";
    }

    @PostMapping("/polls/{id}/vote")
    public String vote(@PathVariable Long id, @RequestParam int selectedOption,
                       Authentication auth, RedirectAttributes ra) {
        Poll poll = pollService.findById(id);
        User user = getUser(auth);
        voteService.vote(poll, user, selectedOption);
        ra.addFlashAttribute("success", "Vote recorded!");
        return "redirect:/polls/" + id;
    }

    @PostMapping("/polls/{id}/comments")
    public String addComment(@PathVariable Long id, @RequestParam String body,
                             Authentication auth) {
        User user = getUser(auth);
        Comment comment = new Comment();
        comment.setAuthor(user);
        comment.setTargetType(Comment.TargetType.POLL);
        comment.setTargetId(id);
        comment.setBody(body);
        commentService.save(comment);
        return "redirect:/polls/" + id;
    }

    @PostMapping("/polls/{id}/comments/{commentId}/delete")
    public String deleteComment(@PathVariable Long id, @PathVariable Long commentId) {
        commentService.deleteById(commentId);
        return "redirect:/polls/" + id;
    }

    @PostMapping("/teacher/polls/{id}/delete")
    public String deletePoll(@PathVariable Long id, RedirectAttributes ra) {
        Poll poll = pollService.findById(id);
        voteService.deleteByPoll(poll);
        commentService.deleteByTarget(Comment.TargetType.POLL, id);
        pollService.deleteById(id);
        ra.addFlashAttribute("success", "Poll deleted.");
        return "redirect:/teacher/dashboard";
    }

    @GetMapping("/teacher/polls/new")
    public String newPollForm(Model model) {
        model.addAttribute("poll", new Poll());
        return "poll/form";
    }

    @PostMapping("/teacher/polls")
    public String createPoll(@RequestParam String question,
                             @RequestParam String option1, @RequestParam String option2,
                             @RequestParam String option3, @RequestParam String option4,
                             @RequestParam String option5, RedirectAttributes ra) {
        Poll poll = new Poll();
        poll.setQuestion(question);
        poll.setOption1(option1);
        poll.setOption2(option2);
        poll.setOption3(option3);
        poll.setOption4(option4);
        poll.setOption5(option5);
        pollService.save(poll);
        ra.addFlashAttribute("success", "Poll created.");
        return "redirect:/teacher/dashboard";
    }

}
