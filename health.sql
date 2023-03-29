DROP DATABASE IF EXISTS health;
CREATE DATABASE health;
USE health;

CREATE TABLE patients(
id INT NOT NULL AUTO_INCREMENT,
EGN VARCHAR(10) NOT NULL UNIQUE,
name VARCHAR(255) NOT NULL,
PRIMARY KEY(id)
);

CREATE TABLE threatments (
id INT NOT NULL AUTO_INCREMENT,
price DOUBLE,	#ako lechenieto e po zdravna kasa i e bezplatno - poleto ne e zadulzhitelno
PRIMARY KEY (id)
);

CREATE TABLE doctors(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR (255),
PRIMARY KEY(id)
);

CREATE TABLE procedures (
id INT NOT NULL AUTO_INCREMENT,
pTime DATETIME NOT NULL,
roomNum VARCHAR(5) NOT NULL,
PRIMARY KEY(id),
doctor_id INT NOT NULL,
patient_id INT NOT NULL,
threatment_id INT NOT NULL,
CONSTRAINT FOREIGN KEY (doctor_id) REFERENCES doctors(id),
CONSTRAINT FOREIGN KEY(patient_id) REFERENCES patients(id),
CONSTRAINT FOREIGN KEY (threatment_id) REFERENCES threatments(id)
);

INSERT INTO patients (EGN, name)
VALUES 
('9106225698', 'John Doe'),
('8304232577', 'Jane Smith'),
('9505213663', 'David Wilson'),
('7409214523', 'Maria Garcia'),
('8208033312', 'Ahmed Ali'),
('8107152345', 'Jasmine Lee'),
('9002034432', 'Mehmet Kaya'),
('8804091234', 'Annie Chen'),
('9205283421', 'Ivan Petrov'),
('7607253321', 'Lena Andersson');

INSERT INTO threatments (price)
VALUES
(100.00),
(50.00),
(80.00),
(NULL),
(90.00),
(70.00),
(60.00),
(130.00),
(110.00),
(85.00);

INSERT INTO doctors (name)
VALUES
('Dr. John Smith'),
('Dr. Sarah Lee'),
('Dr. Michael Johnson'),
('Dr. Ivan Ivanov'),
('Dr. Mark Davis'),
('Dr. Karen Kim'),
('Dr. Mohammad Ali'),
('Dr. Anna Chen'),
('Dr. Maria Hernandez'),
('Dr. Ivan Ivanov');

INSERT INTO procedures (pTime, roomNum, doctor_id, patient_id, threatment_id)
VALUES 
('2023-03-29 08:00:00', 'R-001', 1, 2, 3),
('2023-03-29 09:00:00', 'R-002', 2, 3, 2),
('2023-03-29 10:00:00', 'R-003', 3, 4, 1),
('2023-03-29 11:00:00', 'R-004', 4, 5, 4),
('2023-03-29 12:00:00', 'R-005', 5, 6, 3),
('2023-03-30 08:00:00', 'R-001', 6, 7, 5),
('2023-03-30 09:00:00', 'R-002', 7, 8, 2),
('2023-03-30 10:00:00', 'R-003', 8, 9, 4),
('2023-03-30 11:00:00', 'R-004', 9, 10, 5),
('2023-03-30 12:00:00', 'R-005', 10, 1, 1),
('2023-03-31 08:00:00', 'R-001', 1, 3, 3),
('2023-03-31 09:00:00', 'R-003', 3, 4, 5),
('2023-03-31 10:00:00', 'R-003', 3, 5, 2),
('2023-03-31 11:00:00', 'R-004', 4, 6, 1),
('2023-03-31 12:00:00', 'R-005', 5, 7, 4),
('2023-04-01 08:00:00', 'R-001', 6, 8, 1),
('2023-04-01 09:00:00', 'R-002', 7, 9, 3),
('2023-04-01 10:00:00', 'R-003', 8, 10, 2),
('2023-04-01 11:00:00', 'R-004', 9, 1, 5),
('2023-04-01 12:00:00', 'R-005', 10, 2, 4),
('2023-04-02 08:00:00', 'R-001', 1, 4, 3),
('2023-04-02 09:00:00', 'R-002', 2, 5, 4),
('2023-04-02 10:00:00', 'R-003', 3, 6, 2),
('2023-04-02 11:00:00', 'R-004', 4, 7, 5),
('2023-04-02 12:00:00', 'R-005', 5, 8, 1);

SELECT patients.name, procedures.doctor_id, procedures.roomNum, procedures.pTime
FROM patients JOIN procedures 
ON procedures.patient_id = patients.id
WHERE procedures.threatment_id = 1;

SELECT patients.name, procedures.doctor_id, procedures.roomNum, procedures.pTime
FROM procedures JOIN patients ON
procedures.patient_id = patients.id
JOIN doctors ON procedures.doctor_id = doctors.id
WHERE procedures.threatment_id = 1 AND doctors.name LIKE "%Ivan Ivanov%";

SELECT patients.name, SUM(threatments.price) 
FROM patients JOIN procedures
ON procedures.patient_id = patients.id
JOIN threatments ON procedures.threatment_id = threatments.id
JOIN doctors ON procedures.doctor_id = doctors.id
WHERE doctors.name LIKE "%Michael Johnson%" AND procedures.roomNum = 'R-003'
GROUP BY patients.name;