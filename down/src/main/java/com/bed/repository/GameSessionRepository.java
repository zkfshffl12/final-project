package com.bed.repository;

import com.bed.entity.GameSession;
import com.bed.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GameSessionRepository extends JpaRepository<GameSession, Long> {
    
    List<GameSession> findByUser(User user);
    
    List<GameSession> findByUserAndStatus(User user, GameSession.GameStatus status);
    
    List<GameSession> findByStatus(GameSession.GameStatus status);
}
