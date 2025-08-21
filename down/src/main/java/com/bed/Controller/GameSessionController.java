package com.bed.Controller;

import com.bed.entity.GameSession;
import com.bed.entity.User;
import com.bed.service.GameSessionService;
import com.bed.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/game-sessions")
public class GameSessionController {
    
    @Autowired
    private GameSessionService gameSessionService;
    
    @Autowired
    private UserService userService;
    
    @GetMapping
    public ResponseEntity<List<GameSession>> getAllGameSessions() {
        List<GameSession> gameSessions = gameSessionService.getAllGameSessions();
        return ResponseEntity.ok(gameSessions);
    }
    
    @GetMapping("/{id}")
    public ResponseEntity<GameSession> getGameSessionById(@PathVariable Long id) {
        Optional<GameSession> gameSession = gameSessionService.getGameSessionById(id);
        return gameSession.map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @GetMapping("/user/{userId}")
    public ResponseEntity<List<GameSession>> getGameSessionsByUser(@PathVariable Long userId) {
        Optional<User> user = userService.getUserById(userId);
        if (user.isPresent()) {
            List<GameSession> gameSessions = gameSessionService.getGameSessionsByUser(user.get());
            return ResponseEntity.ok(gameSessions);
        }
        return ResponseEntity.notFound().build();
    }
    
    @GetMapping("/user/{userId}/active")
    public ResponseEntity<List<GameSession>> getActiveGameSessionsByUser(@PathVariable Long userId) {
        Optional<User> user = userService.getUserById(userId);
        if (user.isPresent()) {
            List<GameSession> gameSessions = gameSessionService.getActiveGameSessionsByUser(user.get());
            return ResponseEntity.ok(gameSessions);
        }
        return ResponseEntity.notFound().build();
    }
    
    @PostMapping
    public ResponseEntity<GameSession> createGameSession(@RequestBody GameSessionRequest request) {
        Optional<User> user = userService.getUserById(request.getUserId());
        if (user.isPresent()) {
            GameSession gameSession = gameSessionService.createGameSession(user.get(), request.getGameType());
            return ResponseEntity.ok(gameSession);
        }
        return ResponseEntity.notFound().build();
    }
    
    @PutMapping("/{id}")
    public ResponseEntity<GameSession> updateGameSession(@PathVariable Long id, @RequestBody GameSession gameSessionDetails) {
        GameSession updatedGameSession = gameSessionService.updateGameSession(id, gameSessionDetails);
        if (updatedGameSession != null) {
            return ResponseEntity.ok(updatedGameSession);
        }
        return ResponseEntity.notFound().build();
    }
    
    @PostMapping("/{id}/complete")
    public ResponseEntity<GameSession> completeGameSession(@PathVariable Long id, @RequestBody CompleteGameRequest request) {
        GameSession completedGameSession = gameSessionService.completeGameSession(id, request.getScore());
        if (completedGameSession != null) {
            return ResponseEntity.ok(completedGameSession);
        }
        return ResponseEntity.notFound().build();
    }
    
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteGameSession(@PathVariable Long id) {
        boolean deleted = gameSessionService.deleteGameSession(id);
        if (deleted) {
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.notFound().build();
    }
    
    @GetMapping("/completed")
    public ResponseEntity<List<GameSession>> getCompletedGameSessions() {
        List<GameSession> gameSessions = gameSessionService.getCompletedGameSessions();
        return ResponseEntity.ok(gameSessions);
    }
    
    // Request DTOs
    public static class GameSessionRequest {
        private Long userId;
        private String gameType;
        
        public Long getUserId() {
            return userId;
        }
        
        public void setUserId(Long userId) {
            this.userId = userId;
        }
        
        public String getGameType() {
            return gameType;
        }
        
        public void setGameType(String gameType) {
            this.gameType = gameType;
        }
    }
    
    public static class CompleteGameRequest {
        private Integer score;
        
        public Integer getScore() {
            return score;
        }
        
        public void setScore(Integer score) {
            this.score = score;
        }
    }
}
