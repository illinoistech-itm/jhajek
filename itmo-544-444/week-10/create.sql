CREATE DATABASE company;

USE company;

CREATE TABLE jobs
(
ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
RecordNumber VARCHAR(32), -- This is the UUID
CustomerName VARCHAR(32),
Email VARCHAR(32),
Phone VARCHAR(12),
Status INT(1) DEFAULT 0, -- Job status, not done is 0, done is 1
S3URL VARCHAR(100) -- set the returned S3URL here
);
