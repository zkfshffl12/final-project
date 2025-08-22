package com.bed.Controller;

import main.java.com.bed.service.TrafficMetricsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

@RestController
public class HealthController {
    
    @Autowired
    private TrafficMetricsService trafficMetricsService;
    
    @GetMapping("/health")
    public ResponseEntity<String> health() {
        trafficMetricsService.recordRequest();
        return ResponseEntity.ok("Game server is running!");
    }
}
