DROP DATABASE IF EXISTS SCHOOL_SPORT_CLUBS;


#4. Създаване на база данни в MySQL. CREATE_ALTER TABLE

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


#5. Ограничения (CONSTRAINTS). Заявки INSERT, UPDATE, DELETE

USE school_sport_clubs;
INSERT INTO `sports` (`name`) VALUES ('Football');
INSERT INTO `sports` (`name`) VALUES ('Volleyball');

INSERT INTO `coaches` (`name`, `egn`)
VALUES ('Иван Петков', '7509041245'),
('Георги Иванов Тодоров', '8010091245'),
('Илиян Тодоров Георгиев', '8407106352');

UPDATE coaches
SET name = 'Иван Тодоров Петров'
WHERE id= 1;

INSERT INTO `coaches` (`name`, `egn`) VALUES ('Петър Славков Йорданов', '7010102045');
INSERT INTO `coaches` (`name`, `egn`) VALUES ('Слави Петков Петков', '7106041278');

INSERT INTO students (name, egn, address, phone, class)
VALUES ('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10'),
('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11'),
('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11'),
('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11'),
('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11'),
('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');

-- INSERT INTO sportGroups (location, dayOfWeek, hourOfTraining, sport_id, coach_id)
-- VALUES ("Sofia - Mladost", "Monday", "10:30:30", 1, 2);

-- INSERT INTO sportGroups (location, dayOfWeek, hourOfTraining, sport_id, coach_id)
-- VALUES ("Sofia - Lulin", "Monday", "12:30:30", 2, 1);

INSERT INTO sportgroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES('Sofia- Mladost 1','Monday','08:00:00',1,1);

INSERT INTO sportgroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES('Sofia- Mladost 1','Monday','09:30:00',1,1);

INSERT INTO sportgroups(location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES('Sofia- Liylin 7','Sunday','09:00:00',2,2);

INSERT INTO school_sport_clubs.sportgroups
(location, dayOfWeek, hourOfTraining, sport_id,coach_id)
VALUES ('Sofia-Nadezhda', 'Sunday', '08:00', 1, NULL);

INSERT INTO `school_sport_clubs`.`student_sport` (`student_id`, `sportGroup_id`) VALUES (1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2);


#6. Еднотаблични и многотаблични заявки SELECT. JOIN.

SELECT * FROM sportGroups 
WHERE location LIKE '%Mladost%';

SELECT sportGroups.id, sportgroups.location, sportgroups.dayOfWeek, sportgroups.hourOfTraining, sportgroups.sport_id, coaches.name
FROM sportgroups JOIN coaches ON sportgroups.coach_id=coaches.id;

SELECT sports.name, coaches.name		#-????????????? - вложен SELECT
FROM sports JOIN coaches 
ON sports.id IN (
SELECT sport_id FROM sportgroups
WHERE sportgroups.coach_id=coaches.id
);

SELECT sports.name, coaches.name		#-????????????? - вложен SELECT
FROM sports JOIN coaches 
ON coaches.id IN (
SELECT coach_id FROM sportgroups
WHERE sportgroups.sport_id=sports.id
);

SELECT DISTINCT coaches.name,sports.name	#-??????????????????? JOIN на трите таблици
from coaches JOIN sportgroups
ON coaches.id = sportgroups.coach_id
JOIN sports
ON sportgroups.sport_id = sports.id
WHERE coaches.id = 1;

SELECT coaches.name,sports.name	#-??????????????????? JOIN на трите таблици
from coaches JOIN sportgroups
ON coaches.id = sportgroups.coach_id
JOIN sports
ON sportgroups.sport_id = sports.id;

SELECT sportgroups.location, sportgroups.dayofweek, sportgroups.houroftraining, sportgroups.sport_id, coaches.name
FROM sportgroups LEFT JOIN coaches 
ON sportgroups.coach_id=coaches.id;

SELECT sportgroups.location, sportgroups.dayofweek, sportgroups.houroftraining, sportgroups.sport_id, coaches.name
FROM sportgroups RIGHT JOIN coaches 
ON sportgroups.coach_id=coaches.id;

SELECT students.name, students.class, sportgroups.id	#-??????????????????? - вложен SELECT
FROM students JOIN sportgroups
ON students.id IN(
SELECT student_id FROM student_sport
WHERE student_sport.sportgroup_id=sportgroups.id
)
WHERE sportgroups.id IN(
SELECT sportgroup_id
FROM student_sport
WHERE sportGroup_id IN(
SELECT id
FROM sportgroups
WHERE dayOfWeek = 'Monday'
AND hourOfTraining = '08:00:00'
AND coach_id IN(
SELECT id
FROM coaches
WHERE name = 'Иван Тодоров Петров'
)
AND sport_id =(
SELECT id
FROM sports
WHERE name = 'Football'
)
)
);

SELECT students.name, students.class, sportgroups.id
FROM students JOIN sportgroups
ON students.id IN(
SELECT student_id FROM student_sport
WHERE student_sport.sportgroup_id=sportgroups.id
AND dayOfWeek = 'Monday' AND hourOfTraining = '08:00:00'
AND coach_id IN(
SELECT id
FROM coaches
WHERE name = 'Иван Тодоров Петров'
)
AND sport_id = (
SELECT id
FROM sports
WHERE name = 'Football'
)
);

#8. UNION, FULL JOIN

(SELECT name, egn
FROM students)
UNION
(SELECT name, egn
FROM coaches);

(SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups LEFT OUTER JOIN coaches
ON sportgroups.coach_id = coaches.id)
UNION
(SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups RIGHT JOIN coaches
ON sportgroups.coach_id = coaches.id);


#9. Псевдоними на колони и на таблици. SELF JOIN:

SELECT coaches.name as CoachName,sports.name as Sport
from coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id);

SELECT sg.location as locationOfGroup,
sg.dayOfWeek as trainingDay,
sg.hourOfTraining as trainingHour,
sp.name as sportName
FROM sportgroups as sg JOIN sports as sp
ON sg.sport_id = sp.id;

SELECT sofiaSg.sg_id as SportGroupNumber,
sp.name as Sport,
sofiaSg.loc as SportsGroupLocation
FROM sports as sp JOIN (SELECT id as sg_id,
location as loc,
sport_id
FROM sportgroups
WHERE location LIKE '%Sofia%'
) as sofiaSg /**sportgroups from Sofia**/
ON sp.id = sofiaSg.sport_id;

SELECT firstpl.name as firstPlayer, secondpl.name as secondPlayer, sports.name as sportName	#-??????????
FROM students as firstpl JOIN students as secondpl
ON firstpl.id > secondpl.id
JOIN sports ON (
secondpl.id IN(
SELECT student_id
FROM student_sport
WHERE sportGroup_id IN(
SELECT id
FROM sportgroups
WHERE sport_id = sports.id
)
)
AND (firstPl.id IN( SELECT student_id
FROM student_sport
WHERE sportGroup_id IN(
SELECT id
FROM sportgroups WHERE sport_id = sports.id )
)
)
)
WHERE firstPL.id IN(
SELECT student_id
FROM student_sport
WHERE sportGroup_id IN(
SELECT sportGroup_id
FROM student_sport
WHERE student_id = secondPl.id
)
)
ORDER BY sportName;