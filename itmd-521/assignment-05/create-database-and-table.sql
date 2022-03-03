-- Creates a table to hold the temperature data from page 142

CREATE DATABASE IF NOT EXISTS Assignment05;

USE Assignment05;

CREATE TABLE temperatures
(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
temperature JSON
);

-- This is a second table we are creating to be able to do the union exercise

CREATE DATABASE IF NOT EXISTS Assignment05b;

USE Assignment05b;

CREATE TABLE temperatures
(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
temperature JSON
);