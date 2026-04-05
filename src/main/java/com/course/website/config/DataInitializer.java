package com.course.website.config;

import com.course.website.entity.*;
import com.course.website.repository.*;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    private final UserRepository userRepository;
    private final LectureRepository lectureRepository;
    private final PollRepository pollRepository;
    private final PasswordEncoder passwordEncoder;

    public DataInitializer(UserRepository userRepository, LectureRepository lectureRepository,
                           PollRepository pollRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.lectureRepository = lectureRepository;
        this.pollRepository = pollRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        User teacher = new User();
        teacher.setUsername("teacher");
        teacher.setPassword(passwordEncoder.encode("teacher123!"));
        teacher.setFullName("Professor Smith");
        teacher.setEmail("teacher@course.edu");
        teacher.setPhone("555-0100");
        teacher.setRole(User.Role.TEACHER);
        userRepository.save(teacher);

        User student = new User();
        student.setUsername("student");
        student.setPassword(passwordEncoder.encode("student123!"));
        student.setFullName("Alice Johnson");
        student.setEmail("alice@student.edu");
        student.setPhone("555-0101");
        student.setRole(User.Role.STUDENT);
        userRepository.save(student);

        Lecture l1 = new Lecture();
        l1.setTitle("Introduction to Web Development");
        l1.setSummary("This lecture covers the fundamentals of web development including HTML, CSS, and JavaScript. We explore how browsers render pages and the client-server model.");
        lectureRepository.save(l1);

        Lecture l2 = new Lecture();
        l2.setTitle("Spring MVC Framework");
        l2.setSummary("Deep dive into Spring MVC architecture, controllers, view resolvers, and request mapping. Learn how Spring handles HTTP requests and produces dynamic responses.");
        lectureRepository.save(l2);

        Poll p1 = new Poll();
        p1.setQuestion("Which web framework would you like to learn next?");
        p1.setOption1("React.js");
        p1.setOption2("Vue.js");
        p1.setOption3("Angular");
        p1.setOption4("Svelte");
        p1.setOption5("Next.js");
        pollRepository.save(p1);

        Poll p2 = new Poll();
        p2.setQuestion("Which topic should be introduced in the next class?");
        p2.setOption1("RESTful APIs");
        p2.setOption2("Microservices");
        p2.setOption3("Docker & Kubernetes");
        p2.setOption4("GraphQL");
        p2.setOption5("WebSockets");
        pollRepository.save(p2);
    }
}
