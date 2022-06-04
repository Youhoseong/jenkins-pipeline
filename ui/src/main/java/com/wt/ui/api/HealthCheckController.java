package com.wt.ui.api;

import com.wt.core.User;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@RestController
public class HealthCheckController {

    @GetMapping("/api/v1/whoami")
    public User getUser() {
        return User.builder()
                .id(UUID.randomUUID().toString())
                .name("iron man")
                .build();
    }

    @GetMapping
    public String get() {
        return "hello";
    }
}
