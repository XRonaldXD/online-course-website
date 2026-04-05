package com.course.website.controller;

import com.course.website.entity.Comment;
import com.course.website.entity.Lecture;
import com.course.website.entity.User;
import com.course.website.service.CommentService;
import com.course.website.service.LectureService;
import com.course.website.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.IOException;

@Controller
public class LectureController {

    private final LectureService lectureService;
    private final CommentService commentService;
    private final UserService userService;

    public LectureController(LectureService lectureService, CommentService commentService, UserService userService) {
        this.lectureService = lectureService;
        this.commentService = commentService;
        this.userService = userService;
    }

    @GetMapping("/lectures/{id}")
    public String detail(@PathVariable Long id, Model model) {
        Lecture lecture = lectureService.findById(id);
        model.addAttribute("lecture", lecture);
        model.addAttribute("comments", commentService.findByTarget(Comment.TargetType.LECTURE, id));
        return "lecture/detail";
    }

    @PostMapping("/lectures/{id}/comments")
    public String addComment(@PathVariable Long id, @RequestParam String body, Authentication auth,
                             RedirectAttributes ra) {
        User user = userService.findAll().stream()
                .filter(u -> u.getUsername().equals(auth.getName())).findFirst().orElseThrow();
        Comment comment = new Comment();
        comment.setAuthor(user);
        comment.setTargetType(Comment.TargetType.LECTURE);
        comment.setTargetId(id);
        comment.setBody(body);
        commentService.save(comment);
        return "redirect:/lectures/" + id;
    }

    @PostMapping("/lectures/{id}/comments/{commentId}/delete")
    public String deleteComment(@PathVariable Long id, @PathVariable Long commentId) {
        commentService.deleteById(commentId);
        return "redirect:/lectures/" + id;
    }

    @GetMapping("/teacher/lectures/new")
    public String newLectureForm(Model model) {
        model.addAttribute("lecture", new Lecture());
        return "lecture/form";
    }

    @PostMapping("/teacher/lectures")
    public String createLecture(@RequestParam String title, @RequestParam String summary,
                                RedirectAttributes ra) {
        Lecture lecture = new Lecture();
        lecture.setTitle(title);
        lecture.setSummary(summary);
        lectureService.save(lecture);
        ra.addFlashAttribute("success", "Lecture created.");
        return "redirect:/teacher/dashboard";
    }

    @PostMapping("/teacher/lectures/{id}/delete")
    public String deleteLecture(@PathVariable Long id, RedirectAttributes ra) {
        lectureService.deleteById(id);
        ra.addFlashAttribute("success", "Lecture deleted.");
        return "redirect:/teacher/dashboard";
    }

    @PostMapping("/teacher/lectures/{id}/upload")
    public String uploadFile(@PathVariable Long id, @RequestParam("file") MultipartFile file,
                             RedirectAttributes ra) throws IOException {
        lectureService.uploadFile(id, file);
        ra.addFlashAttribute("success", "File uploaded.");
        return "redirect:/lectures/" + id;
    }

    @PostMapping("/teacher/lectures/{lectureId}/files/{fileId}/delete")
    public String deleteFile(@PathVariable Long lectureId, @PathVariable Long fileId, RedirectAttributes ra) {
        lectureService.deleteFile(fileId);
        ra.addFlashAttribute("success", "File deleted.");
        return "redirect:/lectures/" + lectureId;
    }
}
