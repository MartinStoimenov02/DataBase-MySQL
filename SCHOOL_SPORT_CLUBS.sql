DROP DATABASE SCHOOL_SPORT_CLUBS;
CREATE DATABASE SCHOOL_SPORT_CLUBS;
USE SCHOOL_SPORT_CLUBS;

CREATE TABLE students(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE,
address VARCHAR(255) NOT NULL,
phone VARCHAR(20) NULL DEFAULT NULL,
class VARCHAR(10) NULL DEFAULT NULL   
);

CREATE TABLE sportGroups(
id INT AUTO_INCREMENT PRIMARY KEY,
location VARCHAR(255) NOT NULL,
dayOfWeek ENUM('Monday','Tuesday','Wednesday','Thursday','Friday','Saturday','Sunday'),
hourOfTraining TIME NOT NULL,
UNIQUE KEY(location,dayOfWeek,hourOfTraining)
);

CREATE TABLE student_sport(
student_id int not null,  
CONSTRAINT FOREIGN KEY (student_id) REFERENCES students(id),
sportGroup_id int not null,
CONSTRAINT FOREIGN KEY (sportGroup_id) REFERENCES sportGroups(id),
PRIMARY KEY(student_id,sportGroup_id)
);

CREATE TABLE sports(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL
);

ALTER TABLE sportGroups
ADD sport_id INT NOT NULL;

ALTER TABLE sportGroups
ADD CONSTRAINT FOREIGN KEY(sport_id) REFERENCES sports(id);

CREATE TABLE coaches(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
egn VARCHAR(10) NOT NULL UNIQUE
);

ALTER TABLE sportGroups
ADD coach_id INT;

ALTER TABLE sportGroups
ADD CONSTRAINT FOREIGN KEY (coach_id) REFERENCES coaches(id);

USE school_sport_clubs;
INSERT INTO sports(name) VALUES ('Football');
INSERT INTO sports(name) VALUES('Volleyball');
INSERT INTO coaches(name,egn)
VALUES ('Ivan Petkov','7509041245'),
('Georgi Ivanov Todorov','8010091245'),
('Iliya Todorov Georgiev','8407106352');

UPDATE coaches
SET name = 'Ivan Todorov Petrov'
WHERE id=1;
INSERT INTO coaches (name, egn) VALUES ('Petar Slavkov Yordanov', '7010102045');
INSERT INTO  coaches (name, egn) VALUES ('Slavi Petkov Petkov', '7106041278');
INSERT INTO students (name, egn, address, phone, class) 
VALUES ('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10'),
('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11'),
('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11'),
('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11'),
('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11'),
('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');
INSERT INTO sportgroups(location,dayOfWeek,hourOfTraining,sport_id,coach_id)
VALUES ('Sofia-Mladost 1','Monday','8:00:00',1,1),
('Sofia-Mladost 1','Monday','9:30:00',2,2);
INSERT INTO school_sport_clubs.student_sport (student_id, sportGroup_id) VALUES (1, 1),
 (2, 1),
 (3, 1),
 (4, 2),
 (5, 2),
 (6, 2);

DROP TABLE IF EXISTS taxesPayments;
CREATE TABLE taxesPayments(
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
group_id INT NOT NULL,
paymentAmount double NOT NULL,
month TINYINT,
year YEAR,
dateOfPayment datetime not null,
CONSTRAINT FOREIGN KEY (student_id) references students(id),
CONSTRAINT FOREIGN KEY (group_id) references sportgroups(id)
);

DROP TABLE IF EXISTS salaryPayments;
CREATE TABLE salaryPayments(
id INT AUTO_INCREMENT PRIMARY KEY,
coach_id INT NOT NULL,
month TINYINT,
year YEAR,
salaryAmount double,
dateOfPayment datetime not null,
CONSTRAINT FOREIGN KEY (coach_id) references coaches(id),
UNIQUE KEY(`coach_id`,`month`,`year`)
);

SELECT coaches.name,sports.name
FROM coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id
);

INSERT INTO `school_sport_clubs`.`taxespayments` (`student_id`, `group_id`, `paymentAmount`, `month`, `year`,`dateOfPayment`) VALUES ('1', '1', '200', '1', 2015, now()),
('1', '1', '200', '2', 2015, now()),
('1', '1', '200', '3', 2015, now()),
('1', '1', '200', '4', 2015, now()),
('1', '1', '200', '5', 2015, now()),
('1', '1', '200', '6', 2015, now()),
('1', '1', '200', '7', 2015, now()),
('1', '1', '200', '8', 2015, now()),
('1', '1', '200', '9', 2015, now()),
('1', '1', '200', '10', 2015, now()),
('1', '1', '200', '11', 2015, now()),
('1', '1', '200', '12', 2015, now()),

('2', '1', '250', '1', 2015, now()),
('2', '1', '250', '2', 2015, now()),
('2', '1', '250', '3', 2015, now()),
('2', '1', '250', '4', 2015, now()),
('2', '1', '250', '5', 2015, now()),
('2', '1', '250', '6', 2015, now()),
('2', '1', '250', '7', 2015, now()),
('2', '1', '250', '8', 2015, now()),
('2', '1', '250', '9', 2015, now()),
('2', '1', '250', '10', 2015, now()),
('2', '1', '250', '11', 2015, now()),
('2', '1', '250', '12', 2015, now()),

('3', '1', '250', '1', 2015, now()),
('3', '1', '250', '2', 2015, now()),
('3', '1', '250', '3', 2015, now()),
('3', '1', '250', '4', 2015, now()),
('3', '1', '250', '5', 2015, now()),
('3', '1', '250', '6', 2015, now()),
('3', '1', '250', '7', 2015, now()),
('3', '1', '250', '8', 2015, now()),
('3', '1', '250', '9', 2015, now()),
('3', '1', '250', '10', 2015, now()),
('3', '1', '250', '11', 2015, now()),
('3', '1', '250', '12', 2015, now()),


('1', '2', '200', '1', 2015, now()),
('1', '2', '200', '2', 2015, now()),
('1', '2', '200', '3', 2015, now()),
('1', '2', '200', '4', 2015, now()),
('1', '2', '200', '5', 2015, now()),
('1', '2', '200', '6', 2015, now()),
('1', '2', '200', '7', 2015, now()),
('1', '2', '200', '8', 2015, now()),
('1', '2', '200', '9', 2015, now()),
('1', '2', '200', '10', 2015, now()),
('1', '2', '200', '11', 2015, now()),
('1', '2', '200', '12', 2015, now()),

('4', '2', '200', '1', 2015, now()),
('4', '2', '200', '2', 2015, now()),
('4', '2', '200', '3', 2015, now()),
('4', '2', '200', '4', 2015, now()),
('4', '2', '200', '5', 2015, now()),
('4', '2', '200', '6', 2015, now()),
('4', '2', '200', '7', 2015, now()),
('4', '2', '200', '8', 2015, now()),
('4', '2', '200', '9', 2015, now()),
('4', '2', '200', '10', 2015, now()),
('4', '2', '200', '11', 2015, now()),
('4', '2', '200', '12', 2015, now()),
/**2014**/
('1', '1', '200', '1', 2014, now()),
('1', '1', '200', '2', 2014, now()),
('1', '1', '200', '3', 2014, now()),
('1', '1', '200', '4', 2014, now()),
('1', '1', '200', '5', 2014, now()),
('1', '1', '200', '6', 2014, now()),
('1', '1', '200', '7', 2014, now()),
('1', '1', '200', '8', 2014, now()),
('1', '1', '200', '9', 2014, now()),
('1', '1', '200', '10', 2014, now()),
('1', '1', '200', '11', 2014, now()),
('1', '1', '200', '12', 2014, now()),

('2', '1', '250', '1', 2014, now()),
('2', '1', '250', '2', 2014, now()),
('2', '1', '250', '3', 2014, now()),
('2', '1', '250', '4', 2014, now()),
('2', '1', '250', '5', 2014, now()),
('2', '1', '250', '6', 2014, now()),
('2', '1', '250', '7', 2014, now()),
('2', '1', '250', '8', 2014, now()),
('2', '1', '250', '9', 2014, now()),
('2', '1', '250', '10', 2014, now()),
('2', '1', '250', '11', 2014, now()),
('2', '1', '250', '12', 2014, now()),

('3', '1', '250', '1', 2014, now()),
('3', '1', '250', '2', 2014, now()),
('3', '1', '250', '3', 2014, now()),
('3', '1', '250', '4', 2014, now()),
('3', '1', '250', '5', 2014, now()),
('3', '1', '250', '6', 2014, now()),
('3', '1', '250', '7', 2014, now()),
('3', '1', '250', '8', 2014, now()),
('3', '1', '250', '9', 2014, now()),
('3', '1', '250', '10', 2014, now()),
('3', '1', '250', '11', 2014, now()),
('3', '1', '250', '12', 2014, now()),


('1', '2', '200', '1', 2014, now()),
('1', '2', '200', '2', 2014, now()),
('1', '2', '200', '3', 2014, now()),
('1', '2', '200', '4', 2014, now()),
('1', '2', '200', '5', 2014, now()),
('1', '2', '200', '6', 2014, now()),
('1', '2', '200', '7', 2014, now()),
('1', '2', '200', '8', 2014, now()),
('1', '2', '200', '9', 2014, now()),
('1', '2', '200', '10', 2014, now()),
('1', '2', '200', '11', 2014, now()),
('1', '2', '200', '12', 2014, now()),

('4', '2', '200', '1', 2014, now()),
('4', '2', '200', '2', 2014, now()),
('4', '2', '200', '3', 2014, now()),
('4', '2', '200', '4', 2014, now()),
('4', '2', '200', '5', 2014, now()),
('4', '2', '200', '6', 2014, now()),
('4', '2', '200', '7', 2014, now()),
('4', '2', '200', '8', 2014, now()),
('4', '2', '200', '9', 2014, now()),
('4', '2', '200', '10', 2014, now()),
('4', '2', '200', '11', 2014, now()),
('4', '2', '200', '12', 2014, now()),


/**2016**/
('1', '1', '200', '1', 2016, now()),
('1', '1', '200', '2', 2016, now()),
('1', '1', '200', '3', 2016, now()),


('2', '1', '250', '1', 2016, now()),

('3', '1', '250', '1', 2016, now()),
('3', '1', '250', '2', 2016, now()),



('1', '2', '200', '1', 2016, now()),
('1', '2', '200', '2', 2016, now()),
('1', '2', '200', '3', 2016, now()),


('4', '2', '200', '1', 2016, now()),
('4', '2', '200', '2', 2016, now());

SELECT COUNT(coach_id) as CountOFSportGroupsWithCoaches
FROM sportgroups;

SELECT SUM(paymentAmount) as SumOfStudentPayment
FROM taxespayments
WHERE student_id = 1;

SELECT MIN(paymentAmount) as MinOfStudentPayment
FROM taxespayments
WHERE student_id = 1;

SELECT AVG(paymentAmount) as AvgOfAllPayment
FROM taxespayments
WHERE group_id = 1;

SELECT group_id as GroupId, AVG(paymentAmount) as AvgOfAllPaymentPerGroup
FROM taxespayments
GROUP BY group_id;

SELECT students.id, students.name as StudentName, SUM(tp.paymentAmount) as SumOfAllPaymentPerGroup, tp.month as Month
FROM taxespayments as tp JOIN students 
ON tp.student_id = students.id
GROUP BY month, student_id;

SELECT students.id, students.name as StudentName, SUM(tp.paymentAmount) as SumOfAllPaymentPerGroup, tp.month as Month
FROM taxespayments as tp JOIN students 
ON tp.student_id = students.id
GROUP BY month, student_id
ORDER BY StudentName
LIMIT 15;

SELECT students.id, students.name as StudentName, SUM(tp.paymentAmount) as SumOfAllPaymentPerGroup, tp.month as Month
FROM taxespayments as tp JOIN students 
ON tp.student_id = students.id
group by month, student_id
HAVING SumOfAllPaymentPerGroup >1000;