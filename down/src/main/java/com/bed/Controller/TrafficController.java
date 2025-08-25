package com.bed.Controller;

import com.bed.service.TrafficMetricsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;

@RestController
@CrossOrigin(origins = "*")
public class TrafficController {
    
    @Autowired
    private TrafficMetricsService trafficMetricsService;
    
    @GetMapping("/api/traffic/metrics")
    public ResponseEntity<TrafficMetricsService.TrafficMetrics> getTrafficMetrics() {
        return ResponseEntity.ok(trafficMetricsService.getCurrentMetrics());
    }
    
    @PostMapping("/api/traffic/record")
    public ResponseEntity<String> recordTraffic() {
        trafficMetricsService.recordRequest();
        return ResponseEntity.ok("Traffic recorded");
    }
    
    @GetMapping("/api/traffic/test")
    public ResponseEntity<String> testEndpoint() {
        trafficMetricsService.recordRequest();
        return ResponseEntity.ok("Test request recorded - Current time: " + java.time.LocalDateTime.now());
    }
}
