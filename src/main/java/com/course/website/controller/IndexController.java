package com.course.website.controller;

import com.course.website.service.LectureService;
import com.course.website.service.PollService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    private final LectureService lectureService;
    private final PollService pollService;

    public IndexController(LectureService lectureService, PollService pollService) {
        this.lectureService = lectureService;
        this.pollService = pollService;
    }

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("lectures", lectureService.findAll());
        model.addAttribute("polls", pollService.findAll());
        return "index";
    }
}
