CREATE DATABASE IF NOT EXISTS dishcovery;
USE dishcovery;

-- 1. Language table
CREATE TABLE Language (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- 2. Region table
CREATE TABLE Region (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- 3. Country table
CREATE TABLE Country (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(63),
    main_language_id INT,
    population BIGINT,
    capital VARCHAR(63),
    region_id INT,
    FOREIGN KEY (main_language_id) REFERENCES Language(id),
    FOREIGN KEY (region_id) REFERENCES Region(id)
);

-- 4. Dish table
CREATE TABLE Dish (
    id INT PRIMARY KEY AUTO_INCREMENT,
    country_id INT,
    name VARCHAR(255),
    description TEXT,
    is_national_dish BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (country_id) REFERENCES Country(id)
);

-- 5. Category table
CREATE TABLE Category (
    id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(255)
);

-- 6. Dish_Category junction table
CREATE TABLE Dish_Category (
    dish_id INT,
    category_id INT,
    PRIMARY KEY (dish_id, category_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(id),
    FOREIGN KEY (category_id) REFERENCES Category(id)
);

-- 7. Ingredient table
CREATE TABLE Ingredient (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255)
);

-- 8. Dish_Ingredient junction table
CREATE TABLE Dish_Ingredient (
    dish_id INT,
    ingredient_id INT,
    PRIMARY KEY (dish_id, ingredient_id),
    FOREIGN KEY (dish_id) REFERENCES Dish(id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredient(id)
);