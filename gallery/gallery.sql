DROP DATABASE IF EXISTS gallery;
CREATE DATABASE gallery;
USE gallery;

CREATE TABLE person(
id INT AUTO_INCREMENT NOT NULL,
name VARCHAR(255) NOT NULL, 
address VARCHAR(255) NOT NULL,
phone VARCHAR(255) NOT NULL UNIQUE,
isArtist BOOL NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE products(
id INT AUTO_INCREMENT NOT NULL,
type ENUM("picture", "border", "sovereign") NOT NULL,
price DOUBLE NOT NULL, 
size VARCHAR(255) NOT NULL,
year DATE NOT NULL,
autor_id INT DEFAULT NULL,
PRIMARY KEY(id),
CONSTRAINT FOREIGN KEY(autor_id) REFERENCES person (id)
);

CREATE TABLE services (
id INT AUTO_INCREMENT NOT NULL,
type ENUM("border montage", "draw", "buy a product") NOT NULL,
client_id INT NOT NULL,
startDate DATE NOT NULL,
receivedDate DATE NOT NULL,
isReady BOOL DEFAULT FALSE,
isReceived BOOL DEFAULT FALSE,
comment VARCHAR(255),
employee_name VARCHAR(255) NOT NULL,
artist_id INT DEFAULT NULL,
borderNumber_id INT NOT NULL, 
PRIMARY KEY(id),
CONSTRAINT FOREIGN KEY(client_id) REFERENCES person(id),
CONSTRAINT FOREIGN KEY(artist_id) REFERENCES person(id),
CONSTRAINT FOREIGN KEY(borderNumber_id) REFERENCES products(id)
);

INSERT INTO person(name, address, phone, isArtist)
VALUES("Ivan Ivanov", "Sofia", "0888888888", FALSE);

INSERT INTO person(name, address, phone, isArtist)
VALUES("Velcho Ivchov", "Vraca", "0999999999", FALSE);

INSERT INTO person(name, address, phone, isArtist)
VALUES("Siso Sisov", "Plovdiv", "0111111111", TRUE);

INSERT INTO person(name, address, phone, isArtist)
VALUES("Siso Dzhantov", "Sofia", "0222222222", TRUE);

INSERT INTO products(type, price, size, year, autor_id)
VALUES("picture", 30.25, "300x200x10", '2005-7-04', 3);

INSERT INTO products(type, price, size, year)
VALUES("border", 25.00, "300x200x10", '2001-7-04');

INSERT INTO products(type, price, size, year, autor_id)
VALUES("sovereign", 3.20, "30x20x20", '2020-7-04', 3);

INSERT INTO products(type, price, size, year)
VALUES("picture", 20.25, "200x150x10", '2009-7-04');

INSERT INTO products(type, price, size, year)
VALUES("border", 15.00, "200x150x10", '2005-7-04');

INSERT INTO products(type, price, size, year, autor_id)
VALUES("sovereign", 3.00, "20x20x20", '2023-7-04', 4);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, artist_id, borderNumber_id)
VALUES("border montage", 2, '2023-03-20', '2023-03-25', FALSE, FALSE, 'no comment', "Stef4o", 3, 2);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, artist_id, borderNumber_id)
VALUES("border montage", 1, '2023-03-10', '2023-03-20', TRUE, TRUE, 'no comment', "Stef4o", 4, 5);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, borderNumber_id)
VALUES("draw", 1, '2023-03-10', '2023-03-22', TRUE, FALSE, 'no comment', "Stef4o", 2);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, artist_id, borderNumber_id)
VALUES("draw", 2, '2023-03-10', '2023-03-12', TRUE, TRUE, 'no comment', "Stef4o", 3, 2);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, artist_id, borderNumber_id)
VALUES("draw", 1, '2023-03-10', '2023-03-22', TRUE, TRUE, 'no comment', "Stef4o", 3, 2);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, borderNumber_id)
VALUES("draw", 1, '2023-03-10', '2023-03-22', TRUE, TRUE, 'no comment', "Stef4o", 2);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, borderNumber_id)
VALUES("buy a product", 1, '2023-03-10', '2023-03-10', TRUE, TRUE, 'no comment', "Stef4o", 5);

INSERT INTO services(type, client_id, startDate, receivedDate, isReady, isReceived, comment, employee_name, borderNumber_id)
VALUES("buy a product", 1, '2023-03-12', '2023-03-12', FALSE, FALSE, 'no comment', "Stef4o", 2);

SELECT services.type, person.name as clientName, services.startDate, services.receivedDate, services.isReady, 
services.isReceived, services.comment, services.employee_name, services.borderNumber_id, p.name as artistName
FROM services JOIN person
ON services.client_id=person.id
LEFT JOIN person as p
ON services.artist_id=p.id
WHERE person.name="Ivan Ivanov" AND services.type="draw" AND services.isReady=TRUE AND services.isReceived=TRUE;

SELECT person.name as clientName, SUM(products.price) as bill
FROM services JOIN person
ON services.client_id=person.id
JOIN products ON services.borderNumber_id=products.id
WHERE services.isReady=1 AND services.isReceived=1
GROUP BY person.name
HAVING bill>AVG(products.price)
ORDER BY person.name
LIMIT 6;

SELECT AVG(products.price) FROM products;

