DROP DATABASE IF EXISTS gallery1;
CREATE DATABASE gallery1;
USE gallery1;

CREATE TABLE person (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
phone VARCHAR (15) NOT NULL UNIQUE,
isArtist BOOL DEFAULT FALSE, 
PRIMARY KEY(id)
);

CREATE TABLE goods (
good_no INT NOT NULL AUTO_INCREMENT,
type ENUM ("picture", "border", "sovereign") NOT NULL,
price DOUBLE NOT NULL,
size VARCHAR(20),
year YEAR NOT NULL,
artist_id INT DEFAULT NULL,
PRIMARY KEY(good_no),
CONSTRAINT FOREIGN KEY(artist_id) REFERENCES person(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE services (
id INT NOT NULL AUTO_INCREMENT,
type ENUM ("borderMontage", "drawing", "buy") NOT NULL,
customer_id INT NOT NULL,
dateCreated DATETIME NOT NULL,
endDate DATETIME NOT NULL,
isReady BOOL DEFAULT FALSE,
isReceived BOOL DEFAULT FALSE,
comment VARCHAR (255) DEFAULT NULL,
empl_name VARCHAR(255) NOT NULL,
artist_id INT DEFAULT NULL,
good_id INT,
size VARCHAR(20),
finalPrice DOUBLE NOT NULL,
PRIMARY KEY (id),
CONSTRAINT FOREIGN KEY(customer_id) REFERENCES person(id) ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY(good_id) REFERENCES goods(good_no) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (artist_id) REFERENCES person (id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO person (name, address, phone, isArtist) VALUES
('John Doe', '123 Main St', '555-1234', FALSE),
('Jane Smith', '456 Elm St', '555-5678', TRUE),
('Bob Johnson', '789 Oak St', '555-9012', FALSE),
('Sarah Lee', '321 Maple Ave', '555-3456', TRUE),
('David Kim', '654 Pine Rd', '555-7890', FALSE),
('Emily Wang', '987 Cedar Ln', '555-2345', TRUE),
('Alex Wong', '246 Birch Dr', '555-6789', FALSE),
('Jessica Chen', '135 Walnut Blvd', '555-0123', TRUE),
('Mark Lee', '864 Cherry St', '555-4567', FALSE),
('Karen Kim', '279 Spruce Ave', '555-8901', TRUE);

INSERT INTO goods (type, price, size, year, artist_id) VALUES
("picture", 500.00, "24x36", 2020, 3),
("border", 50.00, "18x24", 2021, 2),
("sovereign", 250.00, "12x16", 2022, 7),
("picture", 700.00, "30x40", 2021, 6),
("border", 40.00, "11x14", 2020, 1),
("sovereign", 1000.00, "24x36", 2023, 9),
("picture", 1200.00, "36x48", 2022, 4),
("border", 30.00, "8x10", 2020, 10),
("sovereign", 800.00, "16x20", 2021, 5),
("picture", 900.00, "24x30", 2023, 8);

INSERT INTO services (type, customer_id, dateCreated, endDate, isReady, isReceived, comment, empl_name, artist_id, good_id, size, finalPrice)
VALUES
('drawing', 5, '2023-03-29 10:00:00', '2023-04-02 12:00:00', TRUE, FALSE, 'Need it ASAP', 'John', 8, 10, '30x40', 150.00),
('borderMontage', 1, '2023-03-29 14:00:00', '2023-04-05 10:00:00', TRUE, FALSE, NULL, 'Jane', 3, 2, '40x60', 100.00),
('buy', 6, '2023-03-30 09:00:00', '2023-04-10 12:00:00', TRUE, TRUE, 'Will pick up in person', 'Jack', NULL, 1, NULL, 50.00),
('buy', 4, '2023-03-31 15:00:00', '2023-04-03 17:00:00', TRUE, TRUE, 'Deliver to my address', 'Kate', NULL, 9, NULL, 200.00),
('drawing', 5, '2023-04-01 13:00:00', '2023-04-07 16:00:00', TRUE, TRUE, NULL, 'Emily', 1, NULL, '50x70', 300.00),
('borderMontage', 5, '2023-04-02 11:00:00', '2023-04-08 13:00:00', TRUE, TRUE, 'Need to be perfect', 'Samantha', 9, 9, '30x40', 120.00),
('buy', 5, '2023-04-03 10:00:00', '2023-04-09 14:00:00', TRUE, FALSE, 'Would like gift wrapping', 'Michael', NULL, 4, NULL, 80.00),
('drawing', 1, '2023-04-04 09:00:00', '2023-04-10 12:00:00', FALSE, TRUE, 'Can you make it colorful?', 'Daniel', 6, NULL, '20x25', 50.00),
('buy', 10, '2023-04-05 15:00:00', '2023-04-12 12:00:00', FALSE, FALSE, 'Would like to pay in installments', 'Adam', NULL, 5, NULL, 600.00),
('drawing', 5, '2023-04-06 16:00:00', '2023-04-13 10:00:00', TRUE, TRUE, 'Can you make it look like a photo?', 'Olivia', 7, NULL, '30x40', 90.00),
('borderMontage', 8, '2023-04-07 13:00:00', '2023-04-14 15:00:00', FALSE, FALSE, NULL, 'Sophia', 2, 7, '40x60', 150.00);

SELECT customer.name AS customerName, services.type, services.comment, services.finalPrice, artist.name AS artistName
FROM services JOIN person AS customer ON services.customer_id = customer.id
JOIN person AS artist ON services.artist_id = artist.id
WHERE customer.name = "David Kim" AND services.isReady = TRUE AND services.isReceived = TRUE AND services.type="drawing";

SELECT person.name, SUM(services.finalPrice) 
FROM person JOIN services ON services.customer_id = person.id
WHERE services.isReady = TRUE AND services.isReceived = TRUE
GROUP BY person.name
HAVING SUM(services.finalPrice) > (SELECT AVG(services.finalPrice) FROM services)
ORDER BY person.name
LIMIT 6;

SELECT AVG(services.finalPrice) FROM services;