package com.wt.ui.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthCheckController {

    @GetMapping("/api/v1/hc")
    public String healthCheck() {
        return "I'm alive.";
    }
}
