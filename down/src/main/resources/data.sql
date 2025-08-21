-- 테스트 사용자 데이터 (비밀번호: password123)
INSERT INTO users (username, email, password) VALUES 
('testuser1', 'test1@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f'),
('testuser2', 'test2@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f'),
('admin', 'admin@example.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f')
ON DUPLICATE KEY UPDATE username=username;

-- 테스트 게임 세션 데이터
INSERT INTO game_sessions (user_id, game_type, score, status) VALUES 
(1, 'PUZZLE', 100, 'COMPLETED'),
(1, 'ACTION', 85, 'COMPLETED'),
(2, 'PUZZLE', 95, 'ACTIVE'),
(3, 'STRATEGY', 120, 'COMPLETED')
ON DUPLICATE KEY UPDATE id=id;
