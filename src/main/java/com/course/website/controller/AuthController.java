package com.course.website.controller;

import com.course.website.entity.User;
import com.course.website.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String loginPage() {
        return "auth/login";
    }

    @GetMapping("/register")
    public String registerPage(Model model) {
        model.addAttribute("user", new User());
        return "auth/register";
    }

    @PostMapping("/register")
    public String register(@RequestParam String username,
                           @RequestParam String password,
                           @RequestParam String fullName,
                           @RequestParam String email,
                           @RequestParam String phone,
                           RedirectAttributes redirectAttributes) {
        if (username.isBlank() || password.isBlank() || fullName.isBlank() || email.isBlank() || phone.isBlank()) {
            redirectAttributes.addFlashAttribute("error", "All fields are required.");
            return "redirect:/register";
        }
        if (userService.existsByUsername(username)) {
            redirectAttributes.addFlashAttribute("error", "Username already taken.");
            return "redirect:/register";
        }
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        userService.register(user);
        redirectAttributes.addFlashAttribute("success", "Registration successful! Please log in.");
        return "redirect:/login";
    }
}
