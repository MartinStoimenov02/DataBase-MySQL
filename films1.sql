DROP DATABASE IF EXISTS filmDataBase;
CREATE DATABASE filmDataBase;
USE filmDatabase;

CREATE TABLE actors(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
gender ENUM('M', 'F', 'O') NOT NULL,
bday DATE NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE studios (
id INT NOT NULL AUTO_INCREMENT,
address VARCHAR(255) NOT NULL,
bulstat VARCHAR(10) NOT NULL UNIQUE,
PRIMARY KEY(id)
);

CREATE TABLE producers (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
studio_id INT NOT NULL,
PRIMARY KEY(id),
CONSTRAINT FOREIGN KEY(studio_id) REFERENCES studios(id)
);

CREATE TABLE films(
id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
year YEAR NOT NULL,
size DOUBLE NOT NULL,
studio_id INT NOT NULL,
producer_id INT NOT NULL,
budget double not null,
primary key (id), 
CONSTRAINT FOREIGN KEY (studio_id) REFERENCES studios(id),
CONSTRAINT FOREIGN KEY (producer_id) REFERENCES producers(id)
);

CREATE TABLE film_actor(
film_id INT NOT NULL,
actor_id INT NOT NULL,
CONSTRAINT FOREIGN KEY(film_id) REFERENCES films(id),
CONSTRAINT FOREIGN KEY (actor_id) REFERENCES actors(id)
);

INSERT INTO actors (name, address, gender, bday)
VALUES
('Tom Hanks', '123 Main St, Los Angeles, CA', 'M', '1956-07-09'),
('Meryl Streep', '456 Elm St, New York, NY', 'F', '1949-06-22'),
('Brad Pitt', '789 Oak St, Beverly Hills, CA', 'M', '1963-12-18'),
('Angelina Jolie', '1010 Maple St, Malibu, CA', 'F', '1975-06-04'),
('Denzel Washington', '1212 Pine St, Washington, D.C.', 'M', '1954-12-28'),
('Viola Davis', '1414 Cedar St, Atlanta, GA', 'F', '1965-08-11'),
('Leonardo DiCaprio', '1616 Walnut St, Santa Monica, CA', 'M', '1974-11-11'),
('Emma Stone', '1818 Birch St, Los Angeles, CA', 'F', '1988-11-06'),
('Will Smith', '2020 Spruce St, Miami, FL', 'M', '1968-09-25'),
('Charlize Theron', '2222 Oakwood St, Beverly Hills, CA', 'F', '1975-08-07');

INSERT INTO studios (address, bulstat)
VALUES
('123 Main St, Los Angeles, CA', '1234567890'),
('456 Elm St, New York, NY', '0987654321'),
('789 Oak St, Beverly Hills, CA', '1122334455'),
('1010 Maple St, Malibu, CA', '9876543210'),
('1212 Pine St, Washington, D.C.', '5432109876'),
('1414 Cedar St, Atlanta, GA', '1111111111'),
('1616 Walnut St, Santa Monica, CA', '2222222222'),
('1818 Birch St, Los Angeles, CA', '3333333333'),
('2020 Spruce St, Miami, FL', '4444444444'),
('2222 Oakwood St, Beverly Hills, CA', '5555555555');

INSERT INTO producers (name, address, studio_id)
VALUES
('John Smith', '123 Main St, Los Angeles, CA', 1),
('Jane Doe', '456 Elm St, New York, NY', 1),
('Bob Johnson', '789 Oak St, Beverly Hills, CA', 3),
('John Smith', '1010 Maple St, Malibu, CA', 4),
('Chris Brown', '1212 Pine St, Washington, D.C.', 1),
('Melissa Green', '1414 Cedar St, Atlanta, GA', 4),
('David White', '1616 Walnut St, Santa Monica, CA', 4),
('Jennifer Black', '1818 Birch St, Los Angeles, CA', 3),
('John Smith', '2020 Spruce St, Miami, FL', 3),
('Mike Davis', '2222 Oakwood St, Beverly Hills, CA', 3);

INSERT INTO films (title, year, size, studio_id, producer_id, budget)
VALUES
('The Great Adventure', 1995, 2.3, 3, 2, 1000000),
('Love in Paris', 2021, 1.9, 6, 4, 800000),
('Chasing Dreams', 1999, 2.5, 9, 7, 1200000),
('The Last Chance', 2020, 1.8, 1, 5, 900000),
('Beyond the Horizon', 1996, 3.1, 10, 3, 1500000),
('Secrets and Lies', 2022, 2.2, 2, 10, 1100000),
('In the Dark', 2021, 1.7, 5, 9, 700000),
('The Lost City', 1991, 3.3, 8, 1, 1700000),
('Rising Tides', 2022, 2.4, 4, 8, 1300000),
('The Final Countdown', 1990, 1.5, 7, 6, 600000);

INSERT INTO film_actor (film_id, actor_id)
VALUES
(2, 3), (6, 8), (1, 2), (9, 7), (8, 10), (5, 4), (7, 1), (4, 6), (10, 9), (3, 5),
(2, 7), (6, 4), (1, 8), (9, 10), (8, 2), (5, 9), (7, 3), (4, 10), (10, 1), (3, 6);

SELECT * FROM actors 
WHERE address LIKE '%Beverly Hills%' OR gender='M';

SELECT * FROM films 
WHERE year>1990 AND year<2000
ORDER BY budget DESC
LIMIT 3;

SELECT films.title, actors.name 
FROM films JOIN film_actor ON
film_actor.film_id = films.id
JOIN actors ON film_actor.actor_id = actors.id
JOIN producers ON films.producer_id = producers.id
WHERE producers.name LIKE "%John Smith%";

/*
SELECT films.title AS filmName, actors.name AS actorName
FROM films JOIN actors 
ON films.id IN(
SELECT film_actor.film_id 
FROM film_actor
WHERE film_actor.actor_id=actors.id)
WHERE producer_id IN(
SELECT producers.id 
FROM producers 
WHERE name = "John Smith");
*/

SELECT actors.name, AVG(films.size)
FROM actors JOIN film_actor ON film_actor.actor_id = actors.id
JOIN films ON film_actor.film_id = films.id
WHERE films.size > (SELECT AVG(films.size) FROM films WHERE films.year<2000)
GROUP BY actors.name;

/*
SELECT actors.name, AVG(films.size)
FROM actors JOIN films
ON actors.id IN (
SELECT actor_id 
FROM film_actor 
WHERE film_actor.film_id = films.id)
WHERE films.size>(
SELECT AVG(films.size)
FROM films
WHERE year<2000)
GROUP BY (actors.name);
*/