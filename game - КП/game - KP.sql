DROP DATABASE IF EXISTS game;

CREATE DATABASE game;
USE game;

CREATE TABLE users (
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL UNIQUE,	#every username must be unique
password VARCHAR(255) NOT NULL,
yearOfBirthday YEAR NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE heroes(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255),	#every hero hs a name
blood INT NOT NULL,
atack INT NOT NULL,
magicPoints INT NOT NULL,
killedMonsters INT DEFAULT 0,	#at first every hero isn't killed some monsters
isWizard BOOL DEFAULT TRUE,		#if hero is wizard we have frozen_atack, if hero is not wizard, it is fighter and we have protection
frozenAtack_protection INT NOT NULL,
PRIMARY KEY (id),
user_id INT NOT NULL,	#user, to witch the hero belongs
CONSTRAINT FOREIGN KEY (user_id) REFERENCES users (id)
ON DELETE CASCADE ON UPDATE CASCADE				#Delete all heroes, if user delete his profile
);

CREATE TABLE monsters(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
blood INT NOT NULL,
atack INT NOT NULL,
magicPoints INT NOT NULL,
types ENUM('zombie', 'troll', 'gnome') NOT NULL,
PRIMARY KEY (id), 
hero_id INT,	#hero, who kill the monster
CONSTRAINT FOREIGN KEY(hero_id) REFERENCES heroes(id) ON DELETE SET NULL
);

CREATE TABLE missions (
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL,
descriptions VARCHAR(255),
award INT,
PRIMARY KEY(id)
);

CREATE TABLE heroes_missions(
id_hero INT NOT NULL,
id_mission INT,		#не може да е NOT NULL защото при изтриване на мисия сме го направили да става NULL
CONSTRAINT FOREIGN KEY (id_hero) REFERENCES heroes(id) ON DELETE CASCADE,	#ако изтрием герой, не е необходимо вече да пазим, в кои мисии е участвал
CONSTRAINT FOREIGN KEY (id_mission) REFERENCES missions(id) ON DELETE SET NULL	#ако изтрием мисия, героя трябва да се запази че е участвал в дадена мисия, дори вече тя да не същшествува
);

INSERT INTO users (name, password, yearOfBirthday) VALUES
('Alice', 'password1', 2000),
('Bob', 'password2', 2015),
('Charlie', 'password3', 2009),
('David', 'password4', 2011),
('Eve', 'password5', 2012),
('Frank', 'password6', 2013),
('Grace', 'password7', 2002),
('Hannah', 'password8', 1999),
('Isabella', 'password9', 2001),
('Jack', 'password10', 2020);

INSERT INTO heroes (name, blood, atack, magicPoints, killedMonsters, isWizard, frozenAtack_protection, user_id)
VALUES
    ('Gandalf', 100, 50, 200, 0, TRUE, 80, 1),
    ('Aragorn', 120, 70, 50, 2, FALSE, 10, 1),
    ('Legolas', 80, 90, 20, 0, FALSE, 0, 2),
    ('Gimli', 150, 60, 0, 5, FALSE, 10, 2),
    ('Frodo', 50, 20, 100, 0, TRUE, 50, 3),
    ('Sam', 70, 30, 50, 0, FALSE, 20, 3),
    ('Boromir', 100, 80, 0, 2, FALSE, 30, 4),
    ('Gollum', 40, 10, 70, 0, TRUE, 30, 4),
    ('Gandalf the White', 200, 100, 500, 9, TRUE, 100, 5),
    ('Sauron', 1000, 200, 1000, 0, TRUE, 500, 6),
    ('Saruman', 150, 80, 200, 0, TRUE, 70, 6),
    ('Faramir', 100, 60, 30, 0, FALSE, 40, 7),
    ('Eowyn', 90, 70, 40, 13, FALSE, 50, 7),
    ('Treebeard', 500, 100, 100, 5, TRUE, 150, 8),
    ('Bilbo', 60, 30, 70, 3, TRUE, 40, 9),
    ('Thorin Oakenshield', 200, 100, 17, 17, FALSE, 60, 10),
    ('Bard', 80, 50, 20, 5, FALSE, 70, 10),
    ('Gandalf the Grey', 150, 70, 300, 10, TRUE, 90, 1),
    ('Gimli', 130, 80, 0, 0, FALSE, 80, 3),
    ('Frodo', 60, 20, 120, 50, TRUE, 40, 5),
    ('Legolas', 100, 100, 50, 0, FALSE, 90, 8),
    ('Eomer', 120, 70, 20, 0, FALSE, 100, 10),
    ('Elrond', 150, 90, 200, 0, TRUE, 70, 2),
    ('Galadriel', 120, 80, 300, 20, TRUE, 90, 3),
    ('Glorfindel', 110, 90, 40, 0, FALSE, 10, 4),
    ('Boromir', 100, 80, 0, 11, FALSE, 20, 5),
('Frodo', 50, 20, 100, 0, TRUE, 50, 6),
('Gandalf the White', 200, 100, 500, 0, TRUE, 100, 7),
('Sauron', 1000, 200, 1000, 0, TRUE, 500, 8),
('Saruman', 150, 80, 200, 2, TRUE, 70, 9),
('Faramir', 100, 60, 30, 3, FALSE, 30, 10),
('Eowyn', 90, 70, 40, 3, FALSE, 40, 1),
('Treebeard', 500, 100, 100, 3, TRUE, 150, 2),
('Bilbo', 60, 30, 70, 3, TRUE, 40, 3),
('Thorin Oakenshield', 200, 100, 0, 2, FALSE, 50, 4),
('Bard', 80, 50, 20, 1, FALSE, 60, 5),
('Gandalf the Grey', 150, 70, 300, 0, TRUE, 90, 6),
('Gimli', 130, 80, 0, 1, FALSE, 70, 7),
('Frodo', 60, 20, 120, 0, TRUE, 40, 8),
('Legolas', 100, 100, 50, 7, FALSE, 80, 9),
('Eomer', 120, 70, 20, 6, FALSE, 90, 10),
('Elrond', 150, 90, 200, 8, TRUE, 70, 1),
('Galadriel', 120, 80, 300, 0, TRUE, 90, 2),
('Glorfindel', 110, 90, 40, 0, FALSE, 0, 3),
('Boromir', 100, 80, 0, 6, FALSE, 10, 4),
('Frodo', 50, 20, 100, 8, TRUE, 50, 5),
('Gandalf the White', 200, 100, 500, 0, TRUE, 100, 6),
('Sauron', 1000, 200, 1000, 12, TRUE, 500, 7),
('Saruman', 150, 80, 200, 0, TRUE, 70, 8),
('Faramir', 100, 60, 30, 0, FALSE, 110, 9),
('Eowyn', 90, 70, 40, 0, 56, FALSE, 10),
('Treebeard', 500, 100, 100, 1, TRUE, 150, 1),
('Bilbo', 60, 30, 70, 1, TRUE, 40, 2);

INSERT INTO monsters (name, blood, atack, magicPoints, types, hero_id)
VALUES
("Monster1", 100, 20, 30, 'zombie', 1),
("Monster2", 120, 15, 25, 'troll', 2),
("Monster3", 80, 25, 35, 'gnome', NULL),
("Monster4", 110, 18, 20, 'zombie', 3),
("Monster5", 90, 30, 40, 'troll', NULL),
("Monster6", 95, 22, 27, 'gnome', 4),
("Monster7", 130, 12, 18, 'zombie', NULL),
("Monster8", 70, 35, 50, 'troll', 5),
("Monster9", 115, 20, 30, 'gnome', NULL),
("Monster10", 100, 15, 25, 'zombie', 6),
("Monster11", 85, 28, 35, 'troll', 7),
("Monster12", 75, 18, 20, 'gnome', NULL),
("Monster13", 120, 22, 27, 'zombie', 8),
("Monster14", 110, 30, 40, 'troll', NULL),
("Monster15", 95, 12, 18, 'gnome', 9),
("Monster16", 80, 35, 50, 'zombie', 10),
("Monster17", 90, 20, 30, 'troll', NULL),
("Monster18", 105, 28, 35, 'gnome', 11),
("Monster19", 125, 18, 20, 'zombie', NULL),
("Monster20", 100, 22, 27, 'troll', 12),
("Monster21", 110, 30, 40, 'gnome', 13),
("Monster22", 95, 12, 18, 'zombie', NULL),
("Monster23", 80, 35, 50, 'troll', 14),
("Monster24", 85, 20, 30, 'gnome', NULL),
("Monster25", 120, 28, 35, 'zombie', 15),
("Monster26", 100, 18, 20, 'troll', 16),
("Monster27", 110, 22, 27, 'gnome', NULL),
("Monster28", 90, 30, 40, 'zombie', 16),
("Monster29", 75, 15, 25, 'troll', NULL),
("Monster30", 105, 20, 30, 'gnome', 17),
("Monster31", 125, 12, 18, 'zombie', NULL),
("Monster32", 95, 35, 50, 'troll', 18),
("Monster33", 80, 20, 30, 'gnome', NULL),
("Monster34", 110, 28, 35, 'zombie', 19),
("Monster35", 100, 18, 20, 'troll', 20),
("Monster36", 120, 22, 27, 'gnome', NULL),
("Monster37", 90, 30, 40, 'zombie', 21),
("Monster38", 85, 15, 25, 'troll', NULL),
("Monster39", 100, 20, 30, 'gnome', 22),
("Monster40", 110, 12, 18, 'zombie', NULL),
("Monster41", 120, 35, 50, 'troll', 23),
("Monster42", 75, 20, 30, 'gnome', NULL),
("Monster43", 95, 28, 35, 'zombie', 24),
("Monster44", 85, 18, 20, 'troll', 25),
("Monster45", 105, 22, 27, 'gnome', NULL),
("Monster46", 125, 30, 40, 'zombie', 26),
("Monster47", 90, 15, 25, 'troll', NULL),
("Monster48", 110, 20, 30, 'gnome', 27),
("Monster49", 120, 12, 18, 'zombie', NULL),
("Monster50", 100, 35, 50, 'troll', 28),
("Monster51", 85, 18, 20, 'troll', 1),
("Monster52", 105, 22, 27, 'gnome', NULL),
("Monster53", 125, 30, 40, 'zombie', 2),
("Monster54", 90, 15, 25, 'troll', NULL),
("Monster55", 110, 20, 30, 'gnome', 3),
("Monster56", 120, 12, 18, 'zombie', NULL),
("Monster57", 100, 35, 50, 'troll', 4),
("Monster58", 75, 20, 30, 'gnome', NULL),
("Monster59", 95, 28, 35, 'zombie', 5),
("Monster60", 85, 18, 20, 'troll', 6),
("Monster61", 105, 22, 27, 'gnome', NULL),
("Monster62", 125, 30, 40, 'zombie', 7),
("Monster63", 90, 15, 25, 'troll', NULL),
("Monster64", 110, 20, 30, 'gnome', 8),
("Monster65", 120, 12, 18, 'zombie', NULL),
("Monster66", 100, 35, 50, 'troll', 9),
("Monster67", 75, 20, 30, 'gnome', NULL),
("Monster68", 95, 28, 35, 'zombie', 10),
("Monster69", 85, 18, 20, 'troll', 11),
("Monster70", 105, 22, 27, 'gnome', NULL),
("Monster71", 125, 30, 40, 'zombie', 12),
("Monster72", 90, 15, 25, 'troll', NULL),
("Monster73", 110, 20, 30, 'gnome', 13),
("Monster74", 120, 12, 18, 'zombie', NULL),
("Monster75", 100, 35, 50, 'troll', 14),
("Monster76", 75, 20, 30, 'gnome', NULL),
("Monster77", 95, 28, 35, 'zombie', 15),
("Monster78", 85, 18, 20, 'troll', 16),
("Monster79", 105, 22, 27, 'gnome', NULL),
("Monster80", 125, 30, 40, 'zombie', 17),
("Monster81", 90, 15, 25, 'troll', NULL),
("Monster82", 110, 20, 30, 'gnome', 18),
("Monster83", 120, 12, 18, 'zombie', NULL),
("Monster84", 100, 35, 50, 'troll', 19),
("Monster85", 75, 20, 30, 'gnome', NULL),
("Monster86", 95, 28, 35, 'zombie', 20);

INSERT INTO missions (name, descriptions, award) VALUES
('Collecting herbs', 'Gather rare herbs from the forest', 2),
('Clearing a dungeon', 'Clear out a dangerous dungeon and secure its treasures', 5),
('Rescuing hostages', 'Free hostages held by a group of bandits', 3),
('Hunting for food', 'Hunt wild game to feed a starving village', 1),
('Stopping a thief', 'Catch a notorious thief and recover stolen goods', 4),
('Recovering an artifact', 'Retrieve a powerful artifact from a guarded tomb', 7),
('Tracking a monster', 'Hunt down a dangerous monster terrorizing a nearby town', 6),
('Escorting a caravan', 'Safely escort a caravan through bandit-infested territory', 3),
('Breaking a siege', 'Break a siege and lift the blockade of a fortified city', 8),
('Exploring ruins', 'Explore mysterious ruins and uncover their secrets', 5),
('Assassinating a target', 'Eliminate a high-value target for a wealthy client', 9),
('Sabotaging an operation', 'Sabotage the operations of a rival guild or organization', 6),
('Resolving a conflict', 'Resolve a conflict between two warring factions and restore peace', 4),
('Spying on an enemy', 'Infiltrate enemy territory and gather crucial intelligence', 3),
('Training new recruits', 'Train and mentor a group of new recruits for a guild or organization', 2);

INSERT INTO heroes_missions (id_hero, id_mission)
SELECT 
	FLOOR(RAND() * 53) + 1,  # generate a random number between 1 and 53 for id_hero
	FLOOR(RAND() * 15) + 1  # generate a random number between 1 and 15 for id_mission
FROM 
    (SELECT a.n + b.n * 10 + c.n * 100 + 1 AS n
        FROM 
           (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS a
           CROSS JOIN 
           (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS b
           CROSS JOIN 
           (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 
            UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9) AS c
     ) AS numbers
LIMIT 300;

#Да бъде възможно всеки различен потребител да се автентикира с име и парола и да се извлича информация за всички негови герои:
SELECT * FROM heroes
JOIN users ON heroes.user_id = users.id
WHERE users.name = "Bob" AND users.password = "password2";



#Напишете заявка, в която демонстрирате SELECT с ограничаващо условие по избор.
CREATE VIEW usl2 AS SELECT heroes.name AS heroName, missions.name AS missionName
FROM heroes JOIN heroes_missions ON heroes_missions.id_hero = heroes.id
JOIN missions ON heroes_missions.id_mission = missions.id
WHERE missions.name LIKE "%food%" AND heroes.name NOT LIKE "%Frodo%";  #тази заявка връща имената на героите и мисиите в които са участвали свързани с "храна", но без героя Фродо

SELECT * FROM usl2;



#Напишете заявка, в която използвате агрегатна функция и GROUP BY по ваш избор.
CREATE VIEW usl3 AS SELECT COUNT(heroes.id) AS countOfHeroes, heroes.blood
FROM heroes
WHERE heroes.atack BETWEEN 0 AND 100
GROUP BY heroes.blood; #тази заявка връща броя герои, които имат определено количество кръв

SELECT * FROM usl3;



#Напишете заявка, в която демонстрирате INNER JOIN по ваш избор.
CREATE VIEW usl4 AS SELECT users.name AS userName, heroes.name AS heroName, heroes.blood, heroes.atack, 
heroes.magicPoints, heroes.killedMonsters, missions.name AS missionName
FROM users JOIN heroes ON heroes.user_id = users.id
JOIN heroes_missions ON heroes_missions.id_hero = heroes.id
JOIN missions ON heroes_missions.id_mission = missions.id
WHERE heroes.killedMonsters!=0
ORDER BY users.name;	#тази заявка връща имената на играчите, както и техните герои и кой герой в коя мисия е участвал

SELECT * FROM usl4;

SELECT monsters.name as MonsterName, heroes.name as HeroName
FROM monsters JOIN heroes ON monsters.hero_id = heroes.id; #тази заявка връща като резултат само убитите чудовища, и от кой са убити



#Напишете заявка, в която демонстрирате OUTER JOIN по ваш избор.
SELECT monsters.name as MonsterName, heroes.name as HeroName
FROM monsters LEFT JOIN heroes ON monsters.hero_id = heroes.id;	#тази заявка връща всички чудовища (живи и убити) и героите, от които са убити

SELECT monsters.name as MonsterName, heroes.name as HeroName
FROM monsters RIGHT JOIN heroes ON monsters.hero_id = heroes.id; #тази заявка връща всички герои и убитите от тях чудовища

#SELF JOIN, CONCAT
SELECT heroes.name as HeroName, GROUP_CONCAT(monsters.name ORDER BY monsters.id SEPARATOR ', ')  as MonsterName
FROM heroes LEFT JOIN monsters ON monsters.hero_id = heroes.id
GROUP BY heroes.id;  #тази заявка връща всички герои и убитите от тях чудовища но в една колона

CREATE VIEW usl5 AS (SELECT monsters.name as MonsterName, heroes.name as HeroName
FROM monsters LEFT JOIN heroes ON monsters.hero_id = heroes.id)
UNION
(SELECT monsters.name as MonsterName, heroes.name as HeroName
FROM monsters RIGHT JOIN heroes ON monsters.hero_id = heroes.id); #тази заявка връща всички герои и всички чудовища, без да повтаря записи

SELECT * FROM usl5;



#Напишете заявка, в която демонстрирате вложен SELECT по ваш избор.
CREATE VIEW usl6 AS SELECT heroes.name AS heroName, missions.name AS missionName
FROM heroes JOIN missions
ON heroes.id IN(
SELECT id_hero
FROM heroes_missions
WHERE heroes_missions.id_mission = missions.id
)
WHERE missions.name LIKE "%food%" AND heroes.name NOT LIKE "%Frodo%"; #тази заявка връща имената на героите и мисиите в които са участвали свързани с "храна", но без героя Фродо

SELECT * FROM usl6;



#Напишете заявка, в която демонстрирате едновременно JOIN и агрегатна функция.
SELECT users.name, COUNT(heroes.id) 
FROM users JOIN heroes 
ON heroes.user_id = users.id
GROUP BY users.name
ORDER BY COUNT(heroes.id) DESC;	#тази заявка имената на играчите и броя герои, които имат

SELECT heroes.name, SUM(missions.award)
FROM heroes
JOIN heroes_missions ON heroes_missions.id_hero = heroes.id
JOIN missions ON heroes_missions.id_mission = missions.id
WHERE heroes.isWizard = TRUE
GROUP BY heroes.name
HAVING SUM(missions.award)>10
ORDER BY SUM(missions.award) DESC
LIMIT 5;	#тази заявка връща имената на героите и точките, които са взели от мисии в ТОП 5

CREATE VIEW usl7 AS SELECT users.name, SUM(missions.award) AS Points
FROM heroes JOIN users ON heroes.user_id = users.id
JOIN heroes_missions ON heroes_missions.id_hero = heroes.id
JOIN missions ON heroes_missions.id_mission = missions.id
GROUP BY users.name
HAVING SUM(missions.award)>20
ORDER BY SUM(missions.award) DESC
LIMIT 10;	#тази заявка връща играчите и общия брой точки от мисии на всеки от тях, в ТОП 10

SELECT * FROM usl7;



#Създайте тригер по ваш избор
delimiter |
create trigger not_negative_value_of_blood BEFORE UPDATE ON heroes	#ако някой герой има по малко от 0 кръв, то той е умрял
FOR EACH ROW
BEGIN
IF (NEW.blood < 0) 
THEN SET NEW.blood = 0; 
END IF;
END;
|
delimiter ;

SELECT * FROM heroes;

UPDATE heroes SET blood = blood - 50 WHERE heroes.id=2;

SELECT * FROM heroes;


#Създайте тригер по ваш избор - 2
create table killing_monsters(
id int auto_increment primary key,
operation ENUM('INSERT','UPDATE','DELETE') not null,
id_monster INT NOT NULL,
oldBlood INT,
newBlood INT,
oldAtack INT,
newAtack INT,
oldMagicPoints INT,
newMagicPoints INT,
dateOfChange datetime
)Engine = Innodb;

delimiter |
CREATE TRIGGER change_blood_of_monster BEFORE UPDATE ON monsters
FOR EACH ROW
BEGIN
IF (NEW.blood < 0) 
THEN SET NEW.blood = 0; 
END IF;
INSERT INTO killing_monsters(operation,
id_monster,
oldBlood,
newBlood,
oldAtack,
newAtack,
oldMagicPoints,
newMagicPoints,
dateOfChange)
VALUES ('UPDATE',
OLD.id,
OLD.blood,
CASE NEW.blood WHEN OLD.blood THEN NULL ELSE NEW.blood END,
OLD.atack,
CASE NEW.atack WHEN OLD.atack THEN NULL ELSE NEW.atack END,
OLD.magicPoints,
CASE NEW.magicPoints WHEN OLD.magicPoints THEN NULL ELSE NEW.magicPoints END,
NOW());
END;
|
Delimiter ;

SELECT * FROM monsters;

UPDATE monsters SET blood = blood - 50 WHERE monsters.id=4;

SELECT * FROM monsters;

SELECT * FROM killing_monsters;

#тригер, който не позволява един потребител да има повече от 6 героя:
SELECT heroes.user_id, COUNT(heroes.id) FROM heroes
GROUP BY heroes.user_id;

DELIMITER |
CREATE TRIGGER destrictHeroesCount BEFORE INSERT ON heroes
FOR EACH ROW
BEGIN
DECLARE br INT;
SELECT COUNT(*) INTO br FROM heroes WHERE user_id = NEW.user_id;
IF(br>=6)
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "you haven'y got more than 6 heroes!";
END IF;
END |
DELIMITER ;

INSERT INTO heroes (name, blood, atack, magicPoints, killedMonsters, isWizard, frozenAtack_protection, user_id) 
VALUES ("heroname", 100, 100, 100, 0, 0, 100, 4);

#Да се направи тригер, който автоматично да увеличава броя на убитите монстри на героя, когато той убие нов монстър.
DELIMITER |
CREATE TRIGGER upKilledMonsters AFTER UPDATE ON monsters
FOR EACH ROW
BEGIN
IF(NEW.hero_id!=NULL)
THEN
UPDATE heroes
    SET killedMonsters = killedMonsters + 1
    WHERE id = NEW.hero_id;
END IF;
END |
DELIMITER ;

UPDATE monsters SET hero_id = 1 WHERE id = 3;

#Да се направи тригер, който да проверява при всяка промяна на броя на убитите монстри на даден герой, дали той е убил повече от 
#10 монстъра и да му дава автоматично специален награден артефакт.
CREATE TABLE awards(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
reward INT DEFAULT 0,
id_hero INT,
CONSTRAINT FOREIGN KEY (id_hero) REFERENCES heroes(id) ON UPDATE CASCADE ON DELETE SET NULL
);

DELIMITER |
CREATE TRIGGER addRewards AFTER UPDATE ON heroes
FOR EACH ROW
BEGIN
IF (NEW.killedMonsters%10=0)
THEN
IF ((SELECT COUNT(*) FROM awards WHERE id_hero = NEW.id)=0) 
THEN INSERT INTO awards (reward, id_hero) VALUES (1, NEW.id);
ELSE UPDATE awards SET reward = reward+1 WHERE id_hero = NEW.id;
END IF;
END IF;
END |
DELIMITER ;

UPDATE heroes SET killedMonsters = killedMonsters + 1 WHERE id = 4;

#Да се направи тригер, който да изтрива всички монстри, които са останали в таблицата "monsters", когато е изтрит даден герой.
DELIMITER |
CREATE TRIGGER deleteMonsters BEFORE DELETE ON heroes
FOR EACH ROW
BEGIN
DELETE FROM monsters WHERE monsters.hero_id = OLD.id;
END |
DELIMITER ;

DELETE FROM heroes WHERE id = 1;

#Да се направи тригер, който да предотвратява изтриването на всички мисии от таблицата "missions", когато има герой, който е участвал в тях.
DELIMITER |
CREATE TRIGGER cantDeleteMissions BEFORE DELETE ON missions
FOR EACH ROW BEGIN
DECLARE br INT;
SELECT COUNT(*) INTO br FROM heroes_missions WHERE id_mission = OLD.id;
IF(br!=0)
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "can't delete mission!";
END IF;
END |
DELIMITER ;

#DELETE FROM missions WHERE id = 2;

#Да се направи тригер, който да вкарва нови записи в таблица users само ако въведената възраст на потребителя е над 12 години.
DELIMITER |
CREATE TRIGGER checkAge BEFORE INSERT ON users 
FOR EACH ROW 
BEGIN
DECLARE age INT;
SET age = (YEAR(NOW())-NEW.yearOfBirthday);
IF(age<12)
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'you are yonger than 12YO!';
END IF;
END |
DELIMITER ;

INSERT INTO users (name, password, yearOfBirthday) VALUES ('Vancho1', '123', 1990);

#Да се направи тригер, който да променя стойността на атаката на герой в таблица heroes на половината, ако героят е от тип "замръзвач" и магическите му точки (magicPoints) са по-малко от 10.
DELIMITER |
CREATE TRIGGER check_hero_frozen_attack
BEFORE UPDATE ON heroes
FOR EACH ROW
BEGIN
    IF (NEW.isWizard = TRUE AND NEW.magicPoints < 10)
    THEN
        SET NEW.frozenAtack_protection = NEW.frozenAtack_protection / 2;
    END IF;
END |
DELIMITER ;

UPDATE heroes SET heroes.name = "Gandalfeca" WHERE id = 5;

#променяме атаката на героите на всеки 10 убити чудовища
DELIMITER |
CREATE TRIGGER addAtackPoints BEFORE UPDATE ON heroes
FOR EACH ROW
BEGIN
IF (NEW.killedMonsters%10=0)
THEN
SET NEW.atack = OLD.atack+1;
END IF;
END |
DELIMITER ;

UPDATE heroes SET killedMonsters = killedMonsters + 1 WHERE id = 4;

#Тригер, който да премахва героя от мисията, ако той умре по време на нея
DELIMITER |
CREATE TRIGGER removeHero AFTER UPDATE ON heroes 
FOR EACH ROW
BEGIN
IF(NEW.blood<=0)
THEN DELETE FROM heroes_missions WHERE id_hero=NEW.id;
END IF;
END |
DELIMITER ;

UPDATE heroes SET blood = 0 WHERE id = 6; 

CREATE TABLE updatedHeroesMissions(
oldMissionID INT NOT NULL,
newMissionID INT NOT NULL,
oldHeroID INT NOT NULL,
newHeroID INT NOT NULL,
dateUpdated DATETIME DEFAULT NOW()
);

DELIMITER |
CREATE TRIGGER updateMissins BEFORE UPDATE ON heroes_missions 
FOR EACH ROW
BEGIN
INSERT INTO updatedHeroesMissions(oldMissionID, newMissionID, oldHeroID, newHeroID) VALUES(OLD.id_mission, NEW.id_mission, OLD.id_hero, NEW.id_hero);
END |
DELIMITER ;

UPDATE heroes_missions SET id_mission = 2 WHERE id_hero=3 AND id_mission=12;

#9. Създайте процедура, в която демонстрирате използване на курсор - променяме кръвта на всеки герой, участвал в определена мисия с 50 нагоре
DELIMITER //

CREATE PROCEDURE update_heroes_blood(IN id_mission_out INT)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE hero_id INT;
    DECLARE hero_blood INT;
    DECLARE hero_cursor CURSOR FOR 
        SELECT heroes.id, heroes.blood 
        FROM heroes 
        INNER JOIN heroes_missions ON heroes.id = heroes_missions.id_hero
        WHERE heroes_missions.id_mission = id_mission_out;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
	SET done = 0;
    OPEN hero_cursor;
    hero_loop: WHILE(done = 0)
		DO
        FETCH hero_cursor INTO hero_id, hero_blood;
        IF done=1 THEN
            LEAVE hero_loop;
        END IF;

        -- update hero blood
        UPDATE heroes SET blood = hero_blood + 50 WHERE id = hero_id;

    END WHILE;
    CLOSE hero_cursor;

END//

DELIMITER ;

#CALL update_heroes_blood(4);

SELECT heroes.name, heroes.blood FROM heroes;

#Направете процедура, която приема като входен параметър име на потребител и извежда всички герои на този потребител, които имат по-малко от 5 убити чудовища
DELIMITER |
CREATE PROCEDURE heroesName(IN nameParam VARCHAR(255))
BEGIN
    DECLARE done INT;
    DECLARE h_name VARCHAR(255);
    DECLARE h_blood INT;
    DECLARE km_hero INT;
    DECLARE u_name VARCHAR(255);

    DECLARE heroesNameByUser CURSOR FOR
        SELECT heroes.name, heroes.blood, heroes.killedMonsters, users.name
        FROM heroes JOIN users ON users.id = heroes.user_id 
        WHERE users.name = nameParam AND heroes.killedMonsters < 5;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    CREATE TEMPORARY TABLE heroesUser (
        id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        heroName VARCHAR(255),
        blood INT,
        killedMonsters INT,
        username VARCHAR(255)
    ) ENGINE = MEMORY;

    SET done = 0;
    OPEN heroesNameByUser;
    
    whileLoop: WHILE (done = 0) DO
        IF (done = 1) THEN 
            LEAVE whileLoop; 
        END IF;
        FETCH heroesNameByUser INTO h_name, h_blood, km_hero, u_name;
        INSERT INTO heroesUser (heroName, blood, killedMonsters, username)
        VALUES (h_name, h_blood, km_hero, u_name);
    END WHILE;
    SELECT * FROM heroesUser;
    DROP TABLE heroesUser;
    CLOSE heroesNameByUser;
END |

DELIMITER ;

SET @user_name = 'Bob';

CALL heroesName (@user_name);

#Направете процедура, която приема като входен параметър мисия и извежда всички герои, които участват в тази мисия.
DELIMITER |
CREATE PROCEDURE missionAndHeroes(IN missionName VARCHAR(255))
BEGIN
DECLARE m_name VARCHAR(255);
DECLARE h_name VARCHAR(255);
DECLARE u_name VARCHAR(255);
DECLARE done INT;
DECLARE missionAndHeroes CURSOR FOR SELECT missions.name, heroes.name, users.name 
FROM missions JOIN heroes_missions ON missions.id = heroes_missions.id_mission 
JOIN heroes ON heroes.id = heroes_missions.id_hero
JOIN users ON users.id = heroes.user_id WHERE missions.name = missionName;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
CREATE TEMPORARY TABLE m_h_u(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
mission VARCHAR(255),
hero VARCHAR(255),
user VARCHAR(255)
)ENGINE = MEMORY;
SET done = 0;
OPEN missionAndHeroes;
whileLoop: WHILE(done=0)
DO
IF(done = 1) THEN LEAVE whileloop; END IF;
FETCH missionAndHeroes INTO m_name, h_name, u_name;
INSERT INTO m_h_u (mission, hero, user) VALUES(m_name, h_name, u_name);
END WHILE;
SELECT * FROM m_h_u;
DROP TABLE m_h_u;
CLOSE missionAndHeroes;
END |
DELIMITER ;

SET @missionName = 'Collecting herbs';

CALL missionAndHeroes (@missionName);

#Направете процедура, която приема като входен параметър име на герой и увеличава неговия брой убити чудовища с 1.
DELIMITER |
CREATE PROCEDURE upKilledMonsters(IN nameHero VARCHAR(255), IN username VARCHAR(255))
BEGIN
DECLARE heroID INT;
DECLARE h_name VARCHAR(255);
DECLARE h_km INT;
DECLARE done INT;
DECLARE changeKM CURSOR FOR SELECT heroes.id, heroes.name, heroes.killedMonsters FROM heroes
JOIN users ON users.id = heroes.user_id
WHERE heroes.name = nameHero AND users.name=username;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done = 0;
OPEN changeKM;
whileloop: WHILE(done=0)
DO
IF(done=1) THEN LEAVE whileloop; END IF;
FETCH changeKM INTO heroID, h_name, h_km;
UPDATE heroes SET killedMonsters = killedMonsters+1 WHERE id = heroID;
END WHILE;
CLOSE changeKM;
END |
DELIMITER ;

SET @username = 'Alice';
SET @heroname = 'Aragorn';
CALL upKilledMonsters(@heroname, @username);

