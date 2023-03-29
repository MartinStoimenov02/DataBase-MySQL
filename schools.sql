DROP DATABASE IF EXISTS schools;
CREATE DATABASE schools;
USE schools;

CREATE TABLE teachers(
id INT NOT NULL AUTO_INCREMENT,
fname VARCHAR(255) NOT NULL,
lname VARCHAR (255) NOT NULL,
username VARCHAR(255) NOT NULL,
password VARCHAR (255) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE students (
id INT NOT NULL AUTO_INCREMENT,
fname VARCHAR(255) NOT NULL,
lname VARCHAR (255) NOT NULL,
class_id INT NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE class (
id INT NOT NULL AUTO_INCREMENT,
number ENUM ('1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12') NOT NULL,
letter ENUM('A', 'B', 'C', 'D', 'E'),
PRIMARY KEY(id), 
school_id INT NOT NULL
);

ALTER TABLE students
ADD CONSTRAINT FOREIGN KEY (class_id) REFERENCES class(id);

CREATE TABLE school (
id INT NOT NULL AUTO_INCREMENT, 
city VARCHAR(255) NOT NULL,
name VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);

ALTER TABLE class 
ADD CONSTRAINT FOREIGN KEY (school_id) REFERENCES school(id);

CREATE TABLE exams (
id INT NOT NULL AUTO_INCREMENT, 
answer VARCHAR (255) NOT NULL,
wrong3 VARCHAR (255) DEFAULT NULL,
PRIMARY KEY (id),
author_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (author_id) REFERENCES teachers(id)
);

CREATE TABLE exam_class(
exam_id INT NOT NULL,
class_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (exam_id) REFERENCES exams(id),
CONSTRAINT FOREIGN KEY (class_id) REFERENCES class(id)
);

CREATE TABLE teacher_class(
teacher_id INT NOT NULL,
class_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (teacher_id) REFERENCES teachers(id),
CONSTRAINT FOREIGN KEY (class_id) REFERENCES class(id)
);

-- Insert queries for the teachers table
INSERT INTO teachers (fname, lname, username, password) VALUES
  ('John', 'Doe', 'jdoe', 'password123'),
  ('Jane', 'Doe', 'jane', 'password456'),
  ('Bob', 'Smith', 'bsmith', 'password789'),
  ('Alice', 'Johnson', 'ajohnson', 'password101'),
  ('David', 'Lee', 'dlee', 'password202');

-- Insert queries for the school table
INSERT INTO school (city, name) VALUES
  ('New York', 'Central High School'),
  ('Los Angeles', 'West High School'),
  ('Chicago', 'North High School'),
  ('Houston', 'South High School'),
  ('Miami', 'East High School');

-- Insert queries for the class table
INSERT INTO class (number, letter, school_id) VALUES
  ('1', 'A', 1),
  ('2', 'B', 1),
  ('3', 'C', 2),
  ('4', 'D', 2),
  ('5', 'E', 3);

-- Insert queries for the students table
INSERT INTO students (fname, lname, class_id) VALUES
  ('Sarah', 'Johnson', 1),
  ('Michael', 'Lee', 2),
  ('Emily', 'Wong', 3),
  ('Jacob', 'Kim', 4),
  ('Sophia', 'Chen', 5);

-- Insert queries for the exams table
INSERT INTO exams (answer, wrong3, author_id) VALUES
  ('A', 'B', 1),
  ('B', 'C', 2),
  ('C', 'D', 3),
  ('D', 'E', 4),
  ('E', 'F', 5);

-- Insert queries for the exam_class table
INSERT INTO exam_class (exam_id, class_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

-- Insert queries for the teacher_class table
INSERT INTO teacher_class (teacher_id, class_id) VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 4),
  (5, 5);

