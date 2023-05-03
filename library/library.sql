DROP DATABASE IF EXISTS library;
CREATE DATABASE library;
USE library;

CREATE TABLE userRole(
id int not null auto_increment,
type enum("1", "2", "3", "4") not null,
primary key(id)
);

create table users(
id int not null auto_increment,
name varchar(255) not null,
egn varchar(10) not null unique,
pass varchar(255) not null,
phone varchar(15) not null unique,
email varchar(255) not null unique,
userRole_id int not null,
primary key(id),
constraint foreign key (userRole_id) references userRole(id)
);

create table izdatelstvo(
id int not null auto_increment,
name varchar(255) not null,
primary key(id)
);

create table books(
id int not null auto_increment,
title varchar(255) not null,
izd_id int not null,
primary key(id),
constraint foreign key(izd_id) references izdatelstvo(id)
);

create table ekzemplqri (
id int not null auto_increment,
date date not null,
user_id int not null,
book_id int not null,
primary key(id),
constraint foreign key(user_id) references users(id),
constraint foreign key(book_id) references books(id)
);

create table authors (
id int not null auto_increment primary key,
name varchar(255) not null
);

create table genres(
id int not null auto_increment primary key,
name varchar(255)
);

create table author_book(
author_id int not null,
book_id int not null,
constraint foreign key(author_id) references authors(id),
constraint foreign key(book_id) references books(id)
);

create table genre_book(
genre_id int not null,
book_id int not null,
constraint foreign key(genre_id) references genres(id),
constraint foreign key(book_id) references books(id)
);

INSERT INTO userRole(type) VALUES ("1");
INSERT INTO userRole(type) VALUES ("2");
INSERT INTO userRole(type) VALUES ("3");
INSERT INTO userRole(type) VALUES ("4");

INSERT INTO users(name, egn, pass, phone, email, userRole_id) VALUES ("John Doe", "1234567890", "password123", "1234567890", "john.doe@example.com", 1);
INSERT INTO users(name, egn, pass, phone, email, userRole_id) VALUES ("Jane Doe", "0987654321", "password456", "0987654321", "jane.doe@example.com", 2);
INSERT INTO users(name, egn, pass, phone, email, userRole_id) VALUES ("Bob Smith", "0123456789", "password789", "0123456789", "bob.smith@example.com", 3);
INSERT INTO users(name, egn, pass, phone, email, userRole_id) VALUES ("Alice Johnson", "9876543210", "password321", "9876543210", "alice.johnson@example.com", 4);

INSERT INTO izdatelstvo(name) VALUES ("Random House");
INSERT INTO izdatelstvo(name) VALUES ("Penguin Books");
INSERT INTO izdatelstvo(name) VALUES ("HarperCollins");
INSERT INTO izdatelstvo(name) VALUES ("Simon & Schuster");

INSERT INTO books(title, izd_id) VALUES ("The Catcher in the Rye", 1);
INSERT INTO books(title, izd_id) VALUES ("To Kill a Mockingbird", 1);
INSERT INTO books(title, izd_id) VALUES ("1984", 2);
INSERT INTO books(title, izd_id) VALUES ("Animal Farm", 2);
INSERT INTO books(title, izd_id) VALUES ("Brave New World", 2);

INSERT INTO ekzemplqri(date, user_id, book_id) VALUES ("2023-03-31", 1, 1);
INSERT INTO ekzemplqri(date, user_id, book_id) VALUES ("2023-03-31", 2, 2);
INSERT INTO ekzemplqri(date, user_id, book_id) VALUES ("2023-03-30", 3, 3);
INSERT INTO ekzemplqri(date, user_id, book_id) VALUES ("2023-03-30", 4, 4);

INSERT INTO authors (name) VALUES
    ('Haruki Murakami'),
    ('J.K. Rowling'),
    ('Stephen King'),
    ('Gabriel Garcia Marquez'),
    ('Jane Austen');

INSERT INTO genres (name) VALUES
    ('Science Fiction'),
    ('Fantasy'),
    ('Horror'),
    ('Romance'),
    ('Historical Fiction');

INSERT INTO author_book (author_id, book_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (1, 5),
    (2, 5),
    (3, 4),
    (4, 3),
    (5, 2);

INSERT INTO genre_book (genre_id, book_id) VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (4, 4),
    (5, 5),
    (2, 5),
    (3, 5),
    (4, 4),
    (5, 1);
    
SELECT b.title, GROUP_CONCAT(a.name ORDER BY a.id SEPARATOR ', ') AS authors
FROM books b
JOIN author_book ab ON b.id = ab.book_id
JOIN authors a ON ab.author_id = a.id
GROUP BY b.id
HAVING COUNT(DISTINCT a.id) = 2;

SELECT b.title, a1.name AS author1, a2.name AS author2
FROM books b
JOIN author_book ab1 ON b.id = ab1.book_id
JOIN authors a1 ON ab1.author_id = a1.id
JOIN author_book ab2 ON b.id = ab2.book_id
JOIN authors a2 ON ab2.author_id = a2.id AND a1.id <> a2.id
GROUP BY b.id
HAVING COUNT(DISTINCT ab1.author_id) = 2
