DROP DATABASE IF EXISTS Administration;

CREATE DATABASE Administration;
USE Administration;

CREATE TABLE department(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL UNIQUE,
PRIMARY KEY(id)
);

CREATE TABLE person (
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL, 
egn VARCHAR(255) NOT NULL UNIQUE,
dep_id INT NOT NULL,
PRIMARY KEY(id), 
CONSTRAINT FOREIGN KEY (dep_id) REFERENCES department(id)
);

CREATE TABLE IT(
type ENUM("backend", "frontend", "fullstack") NOT NULL,
person_id INT NOT NULL UNIQUE,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE QA(
type ENUM("manual", "automation") NOT NULL,
person_id INT NOT NULL UNIQUE,
CONSTRAINT FOREIGN KEY (person_id) REFERENCES person(id)
);

CREATE TABLE languages(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL UNIQUE,
PRIMARY KEY(id)
);

CREATE TABLE it_languages(
it_id INT NOT NULL, 
lang_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(it_id) REFERENCES IT(person_id),
CONSTRAINT FOREIGN KEY(lang_id) REFERENCES languages(id)
);

INSERT INTO department(name)
VALUES ("Computer ingeneering");

INSERT INTO person(name, egn, dep_id)
VALUES("Ivan", "02020202020", 1);

INSERT INTO person(name, egn, dep_id)
VALUES("Vasil", "0234567898", 1);

INSERT INTO person(name, egn, dep_id)
VALUES("Hristo", "56776834876", 1);

INSERT INTO IT(type, person_id)
VALUES("frontend", 1);

INSERT INTO IT(type, person_id)
VALUES("backend", 2);

INSERT INTO QA(type, person_id)
VALUES("manual", 3);

INSERT INTO languages(name)
VALUES("C#");

INSERT INTO languages(name)
VALUES("C++");

INSERT INTO languages(name)
VALUES("C");

INSERT INTO languages(name)
VALUES("Java");

INSERT INTO languages(name)
VALUES("Python");

INSERT INTO it_languages(it_id, lang_id)
VALUES(1, 1);

INSERT INTO it_languages(it_id, lang_id)
VALUES(1, 4);

INSERT INTO it_languages(it_id, lang_id)
VALUES(1, 5);

INSERT INTO it_languages(it_id, lang_id)
VALUES(2, 2);

INSERT INTO it_languages(it_id, lang_id)
VALUES(2, 3);

SELECT p.name as NameOfPerson, p.egn as EGN, d.name as Department
FROM person as p JOIN department as d ON p.dep_id=d.id;

SELECT person.name, person.egn, languages.name
FROM person LEFT JOIN 
languages 
ON person.id 
IN(SELECT it_id 
FROM it_languages 
WHERE it_languages.lang_id=languages.id);

(SELECT * FROM person LEFT JOIN it ON it.person_id=person.id)
UNION
(SELECT * FROM person RIGHT JOIN it ON it.person_id=person.id);