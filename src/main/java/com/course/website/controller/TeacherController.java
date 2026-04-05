package com.course.website.controller;

import com.course.website.entity.User;
import com.course.website.service.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/teacher")
public class TeacherController {

    private final UserService userService;
    private final LectureService lectureService;
    private final PollService pollService;
    private final PasswordEncoder passwordEncoder;

    public TeacherController(UserService userService, LectureService lectureService,
                             PollService pollService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.lectureService = lectureService;
        this.pollService = pollService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        model.addAttribute("userCount", userService.count());
        model.addAttribute("lectureCount", lectureService.count());
        model.addAttribute("pollCount", pollService.count());
        model.addAttribute("lectures", lectureService.findAll());
        model.addAttribute("polls", pollService.findAll());
        return "teacher/dashboard";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userService.findAll());
        return "teacher/users";
    }

    @GetMapping("/users/new")
    public String newUserForm(Model model) {
        model.addAttribute("user", new User());
        return "teacher/userForm";
    }

    @PostMapping("/users")
    public String createUser(@RequestParam String username, @RequestParam String password,
                             @RequestParam String fullName, @RequestParam String email,
                             @RequestParam String phone, @RequestParam String role,
                             RedirectAttributes ra) {
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole(User.Role.valueOf(role));
        userService.save(user);
        ra.addFlashAttribute("success", "User created.");
        return "redirect:/teacher/users";
    }

    @GetMapping("/users/{id}/edit")
    public String editUserForm(@PathVariable Long id, Model model) {
        model.addAttribute("user", userService.findById(id));
        return "teacher/userEdit";
    }

    @PostMapping("/users/{id}")
    public String updateUser(@PathVariable Long id, @RequestParam String fullName,
                             @RequestParam String email, @RequestParam String phone,
                             @RequestParam String role, @RequestParam(required = false) String password,
                             RedirectAttributes ra) {
        User user = userService.findById(id);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole(User.Role.valueOf(role));
        userService.saveWithEncodedPassword(user, password);
        ra.addFlashAttribute("success", "User updated.");
        return "redirect:/teacher/users";
    }

    @PostMapping("/users/{id}/delete")
    public String deleteUser(@PathVariable Long id, Authentication auth, RedirectAttributes ra) {
        User current = userService.findAll().stream()
                .filter(u -> u.getUsername().equals(auth.getName())).findFirst().orElseThrow();
        if (current.getId().equals(id)) {
            ra.addFlashAttribute("error", "Cannot delete yourself.");
            return "redirect:/teacher/users";
        }
        userService.deleteById(id);
        ra.addFlashAttribute("success", "User deleted.");
        return "redirect:/teacher/users";
    }
}
