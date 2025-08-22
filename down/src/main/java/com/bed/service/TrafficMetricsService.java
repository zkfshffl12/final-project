package main.java.com.bed.service;

import org.springframework.stereotype.Service;
import org.springframework.scheduling.annotation.Scheduled;
import java.util.concurrent.atomic.AtomicLong;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.Queue;
import java.time.LocalDateTime;
import java.util.List;
import java.util.ArrayList;
import java.util.stream.Collectors;

@Service
public class TrafficMetricsService {
    
    private final AtomicLong requestCount = new AtomicLong(0);
    private final AtomicLong currentRequestsPerSecond = new AtomicLong(0);
    private final Queue<RequestRecord> recentRequests = new ConcurrentLinkedQueue<>();
    private final int MAX_RECORDS = 100;
    
    public void recordRequest() {
        requestCount.incrementAndGet();
        currentRequestsPerSecond.incrementAndGet();
        
        RequestRecord record = new RequestRecord(LocalDateTime.now());
        recentRequests.offer(record);
        
        // 큐 크기 제한
        if (recentRequests.size() > MAX_RECORDS) {
            recentRequests.poll();
        }
    }
    
    @Scheduled(fixedRate = 1000) // 1초마다 실행
    public void updateMetrics() {
        // 1초 전의 요청들을 제거하고 현재 RPS 계산
        LocalDateTime oneSecondAgo = LocalDateTime.now().minusSeconds(1);
        recentRequests.removeIf(record -> record.timestamp.isBefore(oneSecondAgo));
        
        long currentRPS = recentRequests.size();
        currentRequestsPerSecond.set(currentRPS);
    }
    
    public TrafficMetrics getCurrentMetrics() {
        return new TrafficMetrics(
            currentRequestsPerSecond.get(),
            getPeakRequestsPerSecond(),
            getAverageRequestsPerSecond(),
            getRecentTrafficData()
        );
    }
    
    private long getPeakRequestsPerSecond() {
        // 최근 1분간의 최고 RPS 계산
        LocalDateTime oneMinuteAgo = LocalDateTime.now().minusMinutes(1);
        return recentRequests.stream()
            .filter(record -> record.timestamp.isAfter(oneMinuteAgo))
            .collect(Collectors.groupingBy(
                record -> record.timestamp.withNano(0),
                Collectors.counting()
            ))
            .values()
            .stream()
            .mapToLong(Long::longValue)
            .max()
            .orElse(0);
    }
    
    private long getAverageRequestsPerSecond() {
        // 최근 1분간의 평균 RPS 계산
        LocalDateTime oneMinuteAgo = LocalDateTime.now().minusMinutes(1);
        long totalRequests = recentRequests.stream()
            .filter(record -> record.timestamp.isAfter(oneMinuteAgo))
            .count();
        return totalRequests / 60; // 1분 = 60초
    }
    
    private List<Long> getRecentTrafficData() {
        // 최근 50초간의 트래픽 데이터 반환
        List<Long> trafficData = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();
        
        for (int i = 49; i >= 0; i--) {
            LocalDateTime targetTime = now.minusSeconds(i);
            long count = recentRequests.stream()
                .filter(record -> record.timestamp.isAfter(targetTime.minusSeconds(1)) 
                    && record.timestamp.isBefore(targetTime.plusSeconds(1)))
                .count();
            trafficData.add(count);
        }
        
        return trafficData;
    }
    
    private static class RequestRecord {
        final LocalDateTime timestamp;
        
        RequestRecord(LocalDateTime timestamp) {
            this.timestamp = timestamp;
        }
    }
    
    public static class TrafficMetrics {
        public final long currentRPS;
        public final long peakRPS;
        public final long averageRPS;
        public final List<Long> recentData;
        
        public TrafficMetrics(long currentRPS, long peakRPS, long averageRPS, List<Long> recentData) {
            this.currentRPS = currentRPS;
            this.peakRPS = peakRPS;
            this.averageRPS = averageRPS;
            this.recentData = recentData;
        }
    }
}
