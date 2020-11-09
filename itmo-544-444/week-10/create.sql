CREATE DATABASE company;

USE company;

CREATE TABLE jobs
(
id INT(6) AUTO_INCREMENT PRIMARY KEY,
RecordNumber VARCHAR(64) NOT NULL, -- This is the UUID
CustomerName VARCHAR(64) NOT NULL,
Email VARCHAR(64) NOT NULL,
Phone VARCHAR(32) NOT NULL,
Stat INT(1) NOT NULL DEFAULT 0, -- Job status, not done is 0, done is 1
S3URL VARCHAR(200) NOT NULL, -- set the returned S3URL here
);

INSERT INTO jobs(RecordNumber,CustomerName,Email,Phone,Stat,S3URL) VALUES('00000',"NAME","email@iit.edu","000-000-0000",0,"http://");
