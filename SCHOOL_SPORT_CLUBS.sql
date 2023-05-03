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

INSERT INTO sports(name) VALUES ('Football');
INSERT INTO sports(name) VALUES('Volleyball');
INSERT INTO coaches(name,egn)
VALUES ('Ivan Petkov','7509041249'),
('Georgi Ivanov Todorov','8010091245'),
('Iliya Todorov Georgiev','8407106352');

UPDATE coaches
SET name = 'Ivan Todorov Petrov'
WHERE id=1;

USE school_sport_clubs;
INSERT INTO `sports` (`name`) VALUES ('Football');
INSERT INTO `sports` (`name`) VALUES ('Volleyball');

INSERT INTO `coaches` (`name`, `egn`)
VALUES ('Иван Петков', '7509001215'),
('Георги Иванов Тодоров', '1010091245'),
('Илиян Тодоров Георгиев', '8107106352');

UPDATE coaches
SET name = 'Иван Тодоров Петров'
WHERE id= 1;

DELETE FROM coaches
WHERE EGN = '8407106352';

INSERT INTO `coaches` (`name`, `egn`) VALUES ('Петър Славков Йорданов', '7010102045');
INSERT INTO `coaches` (`name`, `egn`) VALUES ('Слави Петков Петков', '7106041278');

INSERT INTO students (name, egn, address, phone, class)
VALUES ('Iliyan Ivanov', '9401150045', 'Sofia-Mladost 1', '0893452120', '10'),
('Ivan Iliev Georgiev', '9510104512', 'Sofia-Liylin', '0894123456', '11'),
('Elena Petrova Petrova', '9505052154', 'Sofia-Mladost 3', '0897852412', '11'),
('Ivan Iliev Iliev', '9510104542', 'Sofia-Mladost 3', '0894123457', '11'),
('Maria Hristova Dimova', '9510104547', 'Sofia-Mladost 4', '0894123442', '11'),
('Antoaneta Ivanova Georgieva', '9411104547', 'Sofia-Krasno selo', '0874526235', '10');

INSERT INTO sportGroups (location, dayOfWeek, hourOfTraining, sport_id, coach_id)
VALUES
('Gym A', 'Monday', '09:00:00', 1, 1),
('Gym B', 'Tuesday', '11:30:00', 2, 2),
('Gym C', 'Wednesday', '15:45:00', 3, 5),
('Gym A', 'Thursday', '18:00:00', 4, 7),
('Gym B', 'Friday', '20:15:00', 1, 8);

INSERT INTO student_sport (`student_id`, `sportGroup_id`) VALUES 
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2);

#Еднотабличен SELECT:
SELECT id, name,egn,address,phone,class
FROM students;

SELECT *
FROM students
WHERE id >= 2 AND id <= 5;

SELECT *
FROM students
WHERE id BETWEEN 2 AND 5;

SELECT *
FROM school_sport_clubs.students
WHERE name LIKE 'I%';

#Многотаблични заявки SELECT - INNER JOIN
SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.dayOfWeek,
sports.name
FROM sportgroups JOIN sports
ON sportgroups.sport_id = sports.id;

INSERT INTO sportgroups(location,dayOfWeek,hourOfTraining,sport_id,coach_id)
VALUES('Sofia- Liylin 7','Sunday','09:00:00',2,2);

SELECT coaches.name,sports.name
from coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id
);

#Вложен SELECT:
SELECT coaches.name,sports.name
from coaches JOIN sports
ON coaches.id IN(
SELECT coach_id
FROM sportgroups
WHERE sportgroups.sport_id = sports.id
)
where coaches.id = 1;

SELECT DISTINCT coaches.name,sports.name
from coaches JOIN sportgroups
ON coaches.id = sportgroups.coach_id
JOIN sports
ON sportgroups.sport_id = sports.id
WHERE coaches.id = 1;

INSERT INTO school_sport_clubs.sportgroups
(location, dayOfWeek, hourOfTraining, sport_id,coach_id)
VALUES ('Sofia-Nadezhda', 'Sunday', '08:00', 1,NULL);

SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups JOIN coaches
ON sportgroups.coach_id = coaches.id;

#Външни съединения – OUTER JOIN:
SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups LEFT OUTER JOIN coaches
ON sportgroups.coach_id = coaches.id;

SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups RIGHT JOIN coaches
ON sportgroups.coach_id = coaches.id;

#UNION, FULL JOIN:
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

(SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups LEFT OUTER JOIN coaches
ON sportgroups.coach_id = coaches.id)
UNION ALL
(SELECT sportgroups.location,
sportgroups.dayOfWeek,
sportgroups.hourOfTraining,
sportgroups.sport_id,
coaches.name
FROM sportgroups RIGHT JOIN coaches
ON sportgroups.coach_id = coaches.id
WHERE sportgroups.coach_id is NULL);

#Агрегатни функции:
CREATE TABLE taxesPayments(
id INT AUTO_INCREMENT PRIMARY KEY,
student_id INT NOT NULL,
group_id INT NOT NULL,
paymentAmount double NOT NULL,
month TINYINT,
year YEAR,
dateOfPayment datetime not null,
CONSTRAINT FOREIGN KEY (student_id) references students(id) ,
CONSTRAINT FOREIGN KEY (group_id) references sportgroups(id)
);

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

#ИЗГЛЕДИ – СЪЗДАВАНЕ НА VIEW:
create view footbalGroupsOfIvPetrov
AS
SELECT students.name, students.class, sportgroups.id
FROM students JOIN sportgroups
ON students.id IN (
SELECT student_id
FROM student_sport
WHERE student_sport.sportGroup_id = sportgroups.id
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

#КАСКАДНИ ОБНОВЯВАНИЯ ИИЗТРИВАНИЯ
ALTER TABLE sportgroups
DROP FOREIGN KEY sportgroups_ibfk_2;
ALTER TABLE sportgroups
ADD CONSTRAINT FOREIGN KEY `coach_id_key` (coach_id) references coaches(id)
ON DELETE SET NULL ON UPDATE CASCADE;

UPDATE coaches
SET id = 23
WHERE id = 1;

DELETE
FROM coaches
WHERE id = 1;

UPDATE coaches
SET id = 22
WHERE id = 2;

#СЪХРАНЕНИ ПРОЦЕДУРИ:
delimiter |
create procedure getAllSportGroupsWithSports()
begin
SELECT sg.location as locationOfGroup,
sg.dayOfWeek as trainingDay,
sg.hourOfTraining as trainingHour,
sp.name as sportName
FROM sportgroups as sg JOIN sports as sp
ON sg.sport_id = sp.id;
end
|
delimiter ;

CALL getAllSportGroupsWithSports();

#Променливи:
set @customer_number = 'A454647';
select @customer_number;
SET @coach_name = 'Иван Тодоров Петров';
SELECT *
FROM coaches
WHERE name = @coach_name;

#Параметри на процедури в MySQL:
delimiter |
create procedure inParamProc(IN nameParam VARCHAR(255))
begin
SET @coachName = nameParam;
end;
|
delimiter ;
call inParamProc('Иван Тодоров Петров');
SELECT * from coaches
WHERE name = @coachName;

DELIMITER |
create procedure inParamProcWithChangedParam(IN nameParam VARCHAR(255))
begin
SET nameParam = 'Ivan Petkov';
end;
|
delimiter ;
SET @testCoachName = 'Иван Тодоров Петров';
call inParamProcWithChangedParam(@testCoachName);
SELECT @testCoachName;

delimiter |
create procedure outParamProc(OUT nameParam VARCHAR(255))
begin
SELECT nameParam; #only for test
SET nameParam = 'Иван Тодоров Петров';
end;
|
delimiter ;
SET @testOutParam = 'Some name';
call outParamProc(@testOutParam);

SELECT @testOutParam;

delimiter |
create procedure inoutParamProc(INOUT nameParam VARCHAR(255))
begin
SELECT nameParam; #only for test
SET nameParam = 'Иван Тодоров Петров';
end;
|
delimiter ;
SET @testinOutParam = 'Some name';
call inoutParamProc(@testinOutParam);

SELECT @testinOutParam;

#call inoutParamProc('Ivan Petrov');

#IF-оператор:
delimiter |
CREATE procedure checkMothTax(IN studId INT, IN groupId INT, IN paymentMonth INT, IN paymentYear INT)
BEGIN
DECLARE result char(1);
SET result = 0;
IF( (SELECT paymentAmount
FROM taxespayments
WHERE student_id = studId
AND group_id = groupId
AND MONTH = paymentMonth
AND year = paymentYear) IS NOT NULL)
THEN
SET result = 1;
ELSE
SET result = 0;
END IF;
SELECT result as IsTaxPayed;
end;
|
delimiter ;

CALL `school_sport_clubs`.`checkMothTax`(1, 1,1,2015);

#CASE - оператор:
delimiter |
CREATE procedure getPaymentPeriod(IN studId INT, IN groupId INT, IN paymentYear INT)
BEGIN
DECLARE countOfMonths tinyint;
DECLARE monthStr VARCHAR(10);
DECLARE yearStr varchar(10);
SET monthStr = 'MONTH';
SET yearStr = 'YEAR';
SELECT COUNT(*)
INTO countOfMonths
FROM taxespayments
WHERE student_id = studId
AND group_id = groupId
AND year = paymentYear;
CASE countOfMonths
WHEN 0 THEN SELECT 'This student has not paid for this group/year!' as PAYMENT_PERIOD;
WHEN 1 THEN SELECT concat('ONE_', monthStr) as PAYMENT_PERIOD;
WHEN 3 THEN SELECT concat('THREE_',monthStr, 'S') as PAYMENT_PERIOD;
WHEN 6 THEN SELECT concat('SIX_',monthStr,'S') as PAYMENT_PERIOD;
WHEN 12 THEN SELECT yearStr as PAYMENT_PERIOD;
ELSE
SELECT concat(countOfMonths,monthStr,'S') as PAYMENT_PERIOD;
END CASE;
END;
|
DELIMITER ;

CALL getPaymentPeriod(1,1, 2016);

CALL getPaymentPeriod(1,1, 2015);

#WHILE-цикъл:
delimiter |
CREATE procedure getAllPaymentsAmount(IN firstMonth INT, IN secMonth INT, IN paymentYear INT, IN studId INT)
BEGIN
DECLARE iterator int;
IF(firstMonth >= secMonth)
THEN
SELECT 'Please enter correct months!' as RESULT;
ELSE IF((SELECT COUNT(*)
FROM taxesPayments
WHERE student_id =studId ) = 0)
THEN SELECT 'Please enter correct student_id!' as RESULT;
ELSE
SET ITERATOR = firstMonth;
WHILE(iterator >= firstMonth AND iterator <= secMonth)
DO
SELECT student_id, group_id, paymentAmount, month
FROM taxespayments
WHERE student_id = studId
AND year = paymentYear
AND month = iterator;
SET iterator = iterator + 1;
END WHILE;
END IF;
END IF;
END;
|
DELIMITER ;

CALL getAllPaymentsAmount(6,1,2015,1);

CALL getAllPaymentsAmount(1,6,2015,101);

#Временни таблици:
use school_sport_clubs;
#drop procedure getAllPaymentsAmountOptimized;
delimiter |
CREATE procedure getAllPaymentsAmountOptimized(IN firstMonth INT, IN secMonth INT, IN paymentYear INT, IN studId INT)
BEGIN
DECLARE iterator int;
CREATE TEMPORARY TABLE tempTbl(
student_id int,
group_id int,
paymentAmount double,
month int
) ENGINE = Memory;
IF(firstMonth >= secMonth)
THEN
SELECT 'Please enter correct months!' as RESULT;
ELSE IF((SELECT COUNT(*)
FROM taxesPayments
WHERE student_id =studId ) = 0)
THEN SELECT 'Please enter correct student_id!' as RESULT;
ELSE
SET ITERATOR = firstMonth;
WHILE(iterator >= firstMonth AND iterator <= secMonth)
DO
INSERT INTO tempTbl
SELECT student_id, group_id, paymentAmount, month
FROM taxespayments
WHERE student_id = studId
AND year = paymentYear
AND month = iterator;
SET iterator = iterator + 1;
END WHILE;
END IF;
END IF;
SELECT *
FROM tempTbl;
DROP TABLE tempTbl;
END;
|
DELIMITER ;

#създайте процедура, с необходимите входни параметри, с които да може дапремествате ученици от една група в друга група. 
#Направете нужните проверки иизвеждайте коректни съобщения. Удобно е да използвате фукнцията ROW_COUNT, която връща 
#броя на засегнатите редове след последната заявка Update ili Delete.
DELIMITER |
CREATE PROCEDURE move_student(IN st INT, IN gr_new INT, IN gr_old INT)
BEGIN
	IF ((SELECT COUNT(*) FROM student_sport WHERE sportGroup_id = gr_new)=0)
    THEN SELECT "No such group like new group";
	ELSE IF((SELECT COUNT(*) FROM student_sport WHERE student_id = st AND sportGroup_id = gr_old)=0)
    THEN SELECT "no such student in this group";
    ELSE start transaction;
    UPDATE student_sport SET sportGroup_id = gr_new WHERE student_id = st AND sportGroup_id = gr_old;
    IF(row_count()=0) THEN rollback;
    SELECT "rollback!";
    ELSE commit;
    SELECT "commit";
    END IF;
    END IF;
    END IF;
END
|
DELIMITER ;


SET @st = 2;
SET @gr_old = 2;
SET @gr_new = 1;

CALL move_student(@st, @gr_new, @gr_old);

#курсори
delimiter |
create procedure CursorTest()
begin
declare finished int;
declare tempName varchar(100);
declare tempEgn varchar(10);
declare coachCursor CURSOR for
SELECT name, egn
from coaches
where month_salary is not null;
declare continue handler FOR NOT FOUND set finished = 1;
set finished = 0;
OPEN coachCursor;
coach_loop: while( finished = 0)
DO
FETCH coachCursor INTO tempName,tempEgn;
IF(finished = 1)
THEN
LEAVE coach_loop;
END IF;
SELECT tempName,tempEgn; # or do something with these variables...
end while;
CLOSE coachCursor;
SET finished = 0;
SELECT 'Finished!';
end;
|
delimiter |

delimiter |
create procedure OPTIMIZED_monthHonorariumPayment(IN monthOfPayment INT, in yearOFpayment INT)
procLabel: begin
declare countOfCoaches int;
declare iterator int;
declare countOfRowsBeforeUpdate int;
declare countOfRowsAfterUpdate int;
declare finished int;
declare tempCoachId int;
declare tempSumOfHours int;
DECLARE tempCoachCursor CURSOR FOR
SELECT coach_id, SUM(number_of_hours)
FROM coach_work
where month(coach_work.date) = monthOfPayment
AND YEAR(coach_work.date) = yearOFpayment
AND isPayed = 0
GROUP BY coach_work.coach_id;
DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SELECT 'SQL Exception';
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;
create temporary table tempTbl(
id int auto_increment primary key,
coach_id int,
number_of_hours int,
pay_for_hour decimal,
amount decimal,
paymentMonth int,
paymentYear int
)Engine = Memory;
#Плащане на редовна месечна заплата:
SET @RESULT =0;
call monthSalaryPayment(monthOfPayment, yearOFpayment, @RESULT);
SELECT @RESULT as resultFromMonhtPayment; #only for control and test
SELECT COUNT(*)
INTO countOfRowsBeforeUpdate
FROM coach_work
where month(coach_work.date) = monthOfPayment
AND YEAR(coach_work.date) = yearOFpayment
AND isPayed = 0;
START TRANSACTION;
OPEN tempCoachCursor;
set finished = 0;
while_loop_label: WHILE(finished = 0)
DO
FETCH tempCoachCursor INTO tempCoachId, tempSumOfHours;
IF(finished = 1)
THEN leave while_loop_label;
ELSE
SELECT tempCoachId, tempSumOfHours;
INSERT INTO tempTbl(coach_id, number_of_hours, pay_for_hour, amount, paymentMonth, paymentYear)
SELECT tempCoachId, tempSumOfHours, c.hour_salary, tempSumOfHours*c.hour_salary, monthOfPayment, yearOFpayment
FROM coaches as c
WHERE c.id = tempCoachId;
END IF;
END WHILE;
CLOSE tempCoachCursor;
SELECT * FROM tempTbl;#only for control and test
INSERT INTO salarypayments(`coach_id`, `month`,`year`,`salaryAmount`,`dateOfPayment`)
SELECT coach_id, paymentMonth, paymentYear, amount, NOW()
FROM tempTbl
ON DUPLICATE KEY UPDATE
salaryAmount = salaryAmount + amount,
dateOfPayment = NOW();
UPDATE coach_work
SET isPayed = 1
WHERE month(coach_work.date) = monthOfPayment
AND YEAR(coach_work.date) = yearOFpayment
AND isPayed = 0;
SELECT ROW_COUNT() INTO countOfRowsAfterUpdate;
SELECT countOfRowsAfterUpdate as countOfRowsAfterUpdate; #only for control
SELECT countOfRowsBeforeUpdate as countOfRowsBeforeUpdate;#only for control and test
IF(countOfRowsBeforeUpdate = countOfRowsAfterUpdate)
THEN
commit;
ELSE
rollback;
END IF;
drop table tempTbl;
END;
|
delimiter ;

#ТРИГЕРИ
create table salarypayments_log(
id int auto_increment primary key,
operation ENUM('INSERT','UPDATE','DELETE') not null,
old_coach_id int,
new_coach_id int,
old_month int,
new_month int,
old_year int,
new_year int,
old_salaryAmount decimal,
new_salaryAmount decimal,
old_dateOfPayment datetime,
new_dateOfPayment datetime,
dateOfLog datetime
)Engine = Innodb;

delimiter |
CREATE TRIGGER after_salarypayment_update AFTER UPDATE ON salarypayments
FOR EACH ROW
BEGIN
INSERT INTO salarypayments_log(operation,
old_coach_id,
new_coach_id,
old_month,
new_month,
old_year,
new_year,
old_salaryAmount,
new_salaryAmount,
old_dateOfPayment,
new_dateOfPayment,
dateOfLog)
VALUES ('UPDATE',OLD.coach_id,NEW.coach_id,OLD.month,NEW.month,
OLD.year,NEW.year,OLD.salaryAmount,NEW.salaryAmount,OLD.dateOfPayment,NEW.dateOfPayment,NOW());
END;
|
Delimiter ;

UPDATE `salarypayments` SET `salaryAmount`='2000' WHERE `id`='13';

DROP TRIGGER if exists after_salarypayment_update;
delimiter |
CREATE TRIGGER after_salarypayment_update AFTER UPDATE ON salarypayments
FOR EACH ROW
BEGIN
INSERT INTO salarypayments_log(operation,
old_coach_id,
new_coach_id,
old_month,
new_month,
old_year,
new_year,
old_salaryAmount,
new_salaryAmount,
old_dateOfPayment,
new_dateOfPayment,
dateOfLog)
VALUES ('UPDATE',
OLD.coach_id,
CASE NEW.coach_id WHEN OLD.coach_id THEN NULL ELSE NEW.coach_id END,
OLD.month,
CASE NEW.month WHEN OLD.month THEN NULL ELSE NEW.month END,
OLD.year,
CASE NEW.year WHEN OLD.year THEN NULL ELSE NEW.year END,
OLD.salaryAmount,
CASE NEW.salaryAmount WHEN OLD.salaryAmount THEN NULL ELSE NEW.salaryAmount END,
OLD.dateOfPayment,
CASE NEW.dateOfPayment WHEN OLD.dateOfPayment THEN NULL ELSE NEW.dateOfPayment END,
NOW());
END;
|
Delimiter ;

UPDATE `school_sport_clubs`.`salarypayments` SET `month`='4' WHERE `id`='15';

delimiter |
create trigger before_salarypayments_insert BEFORE INSERT ON salarypayments
FOR EACH row
BEGIN
IF (NEW.salaryAmount < 0) THEN SET NEW.salaryAmount = 0; END IF;
END;
|
delimiter ;

INSERT INTO `school_sport_clubs`.`salarypayments`
(`coach_id`, `month`, `year`, `salaryAmount`, `dateOfPayment`)
VALUES ('4', '4', 2016, '-1450', '2016-04-22 11:45:08');

#СЪБИТИЯ
delimiter |
CREATE EVENT monthly_Payment
ON SCHEDULE EVERY 1 MONTH
STARTS '2016-05-01 06:05:00'
DO
BEGIN
CALL OPTIMIZED_monthHonorariumPayment(MONTH(NOW()),YEAR(NOW()));
END;
|
delimiter ;

