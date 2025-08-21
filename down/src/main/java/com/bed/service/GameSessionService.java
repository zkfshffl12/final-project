package com.bed.service;

import com.bed.entity.GameSession;
import com.bed.entity.User;
import com.bed.repository.GameSessionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@Service
public class GameSessionService {
    
    @Autowired
    private GameSessionRepository gameSessionRepository;
    
    public List<GameSession> getAllGameSessions() {
        return gameSessionRepository.findAll();
    }
    
    public Optional<GameSession> getGameSessionById(Long id) {
        return gameSessionRepository.findById(id);
    }
    
    public List<GameSession> getGameSessionsByUser(User user) {
        return gameSessionRepository.findByUser(user);
    }
    
    public List<GameSession> getActiveGameSessionsByUser(User user) {
        return gameSessionRepository.findByUserAndStatus(user, GameSession.GameStatus.ACTIVE);
    }
    
    public GameSession createGameSession(User user, String gameType) {
        GameSession gameSession = new GameSession();
        gameSession.setUser(user);
        gameSession.setGameType(gameType);
        gameSession.setStatus(GameSession.GameStatus.ACTIVE);
        return gameSessionRepository.save(gameSession);
    }
    
    public GameSession updateGameSession(Long id, GameSession gameSessionDetails) {
        Optional<GameSession> gameSessionOptional = gameSessionRepository.findById(id);
        if (gameSessionOptional.isPresent()) {
            GameSession gameSession = gameSessionOptional.get();
            gameSession.setSessionData(gameSessionDetails.getSessionData());
            gameSession.setScore(gameSessionDetails.getScore());
            gameSession.setStatus(gameSessionDetails.getStatus());
            if (gameSessionDetails.getStatus() == GameSession.GameStatus.COMPLETED) {
                gameSession.setEndedAt(LocalDateTime.now());
            }
            return gameSessionRepository.save(gameSession);
        }
        return null;
    }
    
    public GameSession completeGameSession(Long id, Integer score) {
        Optional<GameSession> gameSessionOptional = gameSessionRepository.findById(id);
        if (gameSessionOptional.isPresent()) {
            GameSession gameSession = gameSessionOptional.get();
            gameSession.setScore(score);
            gameSession.setStatus(GameSession.GameStatus.COMPLETED);
            gameSession.setEndedAt(LocalDateTime.now());
            return gameSessionRepository.save(gameSession);
        }
        return null;
    }
    
    public boolean deleteGameSession(Long id) {
        if (gameSessionRepository.existsById(id)) {
            gameSessionRepository.deleteById(id);
            return true;
        }
        return false;
    }
    
    public List<GameSession> getCompletedGameSessions() {
        return gameSessionRepository.findByStatus(GameSession.GameStatus.COMPLETED);
    }
}
