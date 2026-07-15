package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HelloController {

    @GetMapping("/api/hello")
    public Map<String, String> sayHello() {
        Map<String, String> response = new HashMap<>();
        response.setStatus("status", "UP");
        response.put("message", "Hello from EKS Fargate! Your pipeline works perfectly!");
        response.put("version", "1.0.0");
        return response;
    }
}
