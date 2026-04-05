package com.course.website.controller;

import com.course.website.entity.User;
import com.course.website.service.UserService;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/profile")
public class ProfileController {

    private final UserService userService;

    public ProfileController(UserService userService) {
        this.userService = userService;
    }

    private User getCurrentUser(Authentication auth) {
        return userService.findAll().stream()
                .filter(u -> u.getUsername().equals(auth.getName())).findFirst().orElseThrow();
    }

    @GetMapping
    public String editProfile(Model model, Authentication auth) {
        model.addAttribute("user", getCurrentUser(auth));
        return "profile/edit";
    }

    @PostMapping
    public String updateProfile(@RequestParam String fullName, @RequestParam String email,
                                @RequestParam String phone, @RequestParam(required = false) String password,
                                Authentication auth, RedirectAttributes ra) {
        User user = getCurrentUser(auth);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        userService.saveWithEncodedPassword(user, password);
        ra.addFlashAttribute("success", "Profile updated.");
        return "redirect:/profile";
    }
}
