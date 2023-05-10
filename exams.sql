#Да се проектира база данни за система за управление на студентски изпити. Системата трябва да може да съхранява информация за студентите, 
#изпитните сесии и оценките. В базата данни трябва да има таблица за студентите, включваща информация за името, факултетния номер и 
#контактните данни на всеки студент. Трябва да има таблица за изпитните сесии, включваща информация за датата на изпита, часа на изпита и 
#името на преподавателя, който води изпита. И накрая, трябва да има таблица за оценките, която да свързва студентите с изпитните сесии и 
#да съхранява информацията за оценката, която всеки студент е получил на всеки изпит.

DROP DATABASE IF EXISTS exams;
CREATE DATABASE exams;
USE exams;

CREATE TABLE students (
    id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    faculty_number VARCHAR(10) NOT NULL,
    email VARCHAR(50) NOT NULL,
    gradeAv DOUBLE DEFAULT 2,
    PRIMARY KEY (id)
);

CREATE TABLE exam_sessions (
    id INT NOT NULL AUTO_INCREMENT,
    date DATE NOT NULL,
    time TIME NOT NULL,
    subjectName VARCHAR(255) NOT NULL,
    lecturer VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE exam_results (
    id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    session_id INT,
    grade DECIMAL(3,1) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (session_id) REFERENCES exam_sessions(id) ON DELETE SET NULL
);

INSERT INTO students (name, faculty_number, email) VALUES
('Петър', '123456', 'petar@mail.com'),
('Мария', '234567', 'maria@mail.com'),
('Иван', '345678', 'ivan@mail.com');

INSERT INTO exam_sessions (date, time, subjectName, lecturer) VALUES
('2023-06-01', '10:00:00', 'база данни', 'Иванов'),
('2023-06-02', '14:00:00', 'БПЕ', 'Петров'),
('2023-06-03', '10:00:00', 'ПНПЕ', 'Георгиев');

INSERT INTO exam_results (student_id, session_id, grade) VALUES
(1, 1, 4.5),
(1, 2, 5.5),
(2, 1, 6.0),
(2, 3, 5.0),
(3, 2, 4.0),
(3, 3, 5.5);

#Да се създаде тригер, който след вмъкване на нов запис в таблицата exam_results да актуализира средната оценка на студента в таблицата students.
DELIMITER |
CREATE TRIGGER updateAverageGrade AFTER INSERT ON exam_results
FOR EACH ROW
BEGIN
DECLARE gr DOUBLE;
SELECT AVG(grade) INTO gr FROM exam_results WHERE student_id = NEW.student_id;
UPDATE students SET students.gradeAv = gr WHERE students.id = NEW.student_id;
END |
DELIMITER ;

INSERT INTO exam_results (student_id, session_id, grade) VALUES
(1, 3, 5.5);

-- INSERT INTO exam_results (student_id, session_id, grade) VALUES
-- (1, 1, 4.5),
-- (1, 2, 5.5),
-- (2, 1, 6.0),
-- (2, 3, 5.0),
-- (3, 2, 4.0),
-- (3, 3, 5.5);

#Да се създаде тригер, който след изтриване на запис от таблицата exam_sessions да изтрива автоматично всички оценки от тази сесия в таблицата exam_results.
DELIMITER |
CREATE TRIGGER delSession BEFORE DELETE ON exam_sessions 
FOR EACH ROW
BEGIN
DELETE FROM exam_results WHERE session_id = OLD.id;
END |
DELIMITER ;

#DELETE FROM exam_sessions WHERE id = 3;

SELECT s.name, s.faculty_number,
       r1.grade AS subject1_grade,
       r2.grade AS subject2_grade,
       r3.grade AS subject3_grade
FROM students s
LEFT JOIN exam_results r1 ON s.id = r1.student_id AND r1.session_id = 1
LEFT JOIN exam_results r2 ON s.id = r2.student_id AND r2.session_id = 2
LEFT JOIN exam_results r3 ON s.id = r3.student_id AND r3.session_id = 3;

#Напишете процедура, която извежда средната оценка за даден студент по всички изпити, които е взел. 
#Процедурата трябва да приема като входен параметър факултетния номер на студента и да използва курсор, за да обходи всички оценки на студента. 
#След като процедурата пресметне средната оценка, тя трябва да я върне.
DELIMITER |
CREATE PROCEDURE avgGrade (IN id_st INT, OUT gr DOUBLE)
BEGIN
DECLARE done INT;
DECLARE t_gr DOUBLE;
DECLARE br INT;
DECLARE cur CURSOR FOR SELECT exam_results.grade FROM exam_results WHERE student_id = id_st;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done = 0;
SET br = 0;
SET gr = 0;
OPEN cur;
whileloop: WHILE(done=0) DO
IF(done = 1) THEN LEAVE whileloop; END IF;
FETCH cur INTO t_gr;
SET gr = gr+t_gr;
SET br = br+1;
END WHILE;
SET gr = gr/br;
CLOSE cur;
END |
DELIMITER ;

DELIMITER | 
CREATE PROCEDURE getID (OUT id_st INT, IN fn VARCHAR(255))
BEGIN
SELECT id INTO id_st FROM students WHERE faculty_number = fn;
END |
DELIMITER ;

SET @grd = 0;
SET @fac_n = '123456';
SET @id_stud = 0;
CALL getID(@id_stud, @fac_n);
CALL avgGrade (@id_stud, @grd);
SELECT @grd;