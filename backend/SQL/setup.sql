-- Create and use database [if database doesn't exist]
CREATE DATABASE IF NOT EXISTS fitnessTracker;
USE fitnessTracker;

-- Each row is for one unique exercise category
-- Based off primary muscle mover 
-- Ex. Back for "pull up"
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(255) UNIQUE NOT NULL
);

-- Each row is one unique exercise
CREATE TABLE IF NOT EXISTS exercises (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_name VARCHAR(100) UNIQUE NOT NULL,
    categories_id INT NOT NULL,
    FOREIGN KEY (categories_id) 
        REFERENCES categories(id)
);

-- Each metrics row is one set
-- Ex. 135 lbs at 3 reps
CREATE TABLE IF NOT EXISTS metrics (
    id INT  AUTO_INCREMENT PRIMARY KEY,
    wgt DECIMAL(10,1) DEFAULT 0,
    reps INT NOT NULL,    
    created_at TIMESTAMP DEFAULT NOW()
);

-- Log to represent per day
-- Includes workout per day and association per user (future implementation)
CREATE TABLE IF NOT EXISTS logs (
    id INT PRIMARY KEY AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Individual workout contains single exercise done and corresponding reps/set
CREATE TABLE IF NOT EXISTS workouts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    exercise_id INT NOT NULL,
    metrics_id INT NOT NULL,
    logs_id INT NOT NULL,
    FOREIGN KEY (exercise_id) 
        REFERENCES exercises(id),
    FOREIGN KEY (metrics_id) 
        REFERENCES metrics(id) 
        ON DELETE CASCADE
);

-- -- Users table (for future)
-- CREATE TABLE IF NOT EXISTS users (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     created_at TIMESTAMP DEFAULT NOW(),
--     logs_id INT NOT NULL
-- )