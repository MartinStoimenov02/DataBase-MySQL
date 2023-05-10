DROP DATABASE IF EXISTS `cableCompany`;
CREATE DATABASE `cableCompany`;
USE `cableCompany`;

CREATE TABLE `cableCompany`.`customers` (
	`customerID` INT UNSIGNED NOT NULL AUTO_INCREMENT ,
	`firstName` VARCHAR( 55 ) NOT NULL ,
	`middleName` VARCHAR( 55 ) NOT NULL ,
	`lastName` VARCHAR( 55 ) NOT NULL ,
	`email` VARCHAR( 55 ) NULL , 
	`phone` VARCHAR( 20 ) NOT NULL , 
	`address` VARCHAR( 255 ) NOT NULL ,
	PRIMARY KEY ( `customerID` )
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`accounts` (
	`accountID` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY ,
	`amount` DOUBLE NOT NULL ,
	`customer_id` INT UNSIGNED NOT NULL ,
	CONSTRAINT FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers` ( `customerID` )
		ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`plans` (
	`planID` INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	`name` VARCHAR(32) NOT NULL,
	`monthly_fee` DOUBLE NOT NULL
) ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`payments`(
	`paymentID` INT AUTO_INCREMENT PRIMARY KEY ,
	`paymentAmount` DOUBLE NOT NULL ,
	`month` TINYINT NOT NULL ,
	`year` YEAR NOT NULL ,
	`dateOfPayment` DATETIME NOT NULL ,
	`customer_id` INT UNSIGNED NOT NULL ,
	`plan_id` INT UNSIGNED NOT NULL ,		
	CONSTRAINT FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers`( `customerID` ) ,
	CONSTRAINT FOREIGN KEY ( `plan_id` ) 
		REFERENCES `cableCompany`.`plans` ( `planID` )
)ENGINE = InnoDB;

CREATE TABLE `cableCompany`.`debtors`(
	`customer_id` INT UNSIGNED NOT NULL ,
	`plan_id` INT UNSIGNED NOT NULL ,
	`debt_amount` DOUBLE NOT NULL ,
	FOREIGN KEY ( `customer_id` )
		REFERENCES `cableCompany`.`customers`( `customerID` ) ,
	FOREIGN KEY ( `plan_id` )
		REFERENCES `cableCompany`.`plans`( `planID` ) 
	,PRIMARY KEY ( `customer_id`, `plan_id` )
) ENGINE = InnoDB;

INSERT INTO cableCompany.customers (firstName, middleName, lastName, email, phone, address) VALUES
('Bank', 'cable', 'Company', 'cableCompany@bank.org.com', '555-5555', 'park avenue 1'),
('John', 'A.', 'Doe', 'johndoe@email.com', '555-1234', '123 Main St.'),
('Jane', 'B.', 'Smith', 'janesmith@email.com', '555-5678', '456 Elm St.'),
('Bob', 'C.', 'Johnson', 'bobjohnson@email.com', '555-9012', '789 Maple Ave.'),
('Samantha', 'D.', 'Williams', 'samanthawilliams@email.com', '555-3456', '1010 Oak Ln.'),
('Tom', 'E.', 'Brown', 'tombrown@email.com', '555-7890', '1212 Pine St.'),
('Maggie', 'F.', 'Taylor', 'maggietaylor@email.com', '555-2345', '1414 Cedar Ave.'),
('David', 'G.', 'Martin', 'davidmartin@email.com', '555-6789', '1616 Spruce St.'),
('Amy', 'H.', 'Anderson', 'amyanderson@email.com', '555-1234', '1818 Walnut St.'),
('Michael', 'I.', 'Miller', 'michaelmiller@email.com', '555-5678', '2020 Birch Ln.'),
('Karen', 'J.', 'Davis', 'karendavis@email.com', '555-9012', '2222 Maple St.');

-- Insert into customers table
INSERT INTO `cableCompany`.`customers` (`firstName`, `middleName`, `lastName`, `email`, `phone`, `address`)
VALUES
	('John', 'M', 'Doe', 'johndoe@gmail.com', '123-456-7890', '123 Main St'),
	('Jane', 'L', 'Smith', 'janesmith@gmail.com', '555-555-1212', '456 1st Ave'),
	('Bob', 'T', 'Johnson', NULL, '555-123-4567', '789 Elm St'),
	('Samantha', 'A', 'Williams', 'samanthawilliams@gmail.com', '123-555-7890', '321 Oak St'),
	('Michael', 'P', 'Davis', 'michaelpdavis@yahoo.com', '444-555-6666', '567 Maple Ave'),
	('Emily', 'R', 'Taylor', NULL, '555-777-8888', '999 2nd St'),
	('Mark', 'D', 'Miller', 'markdmiller@gmail.com', '777-555-1234', '111 Pine St'),
	('Lisa', 'K', 'Garcia', 'lisakgarcia@gmail.com', '555-555-8888', '222 Cherry Ln'),
	('Brian', 'M', 'Brown', 'brianmbrown@yahoo.com', '123-555-7777', '333 Cedar Rd'),
	('Jessica', 'N', 'Lee', NULL, '555-888-9999', '444 Elm Ave');

-- Insert into accounts table
INSERT INTO `cableCompany`.`accounts` (`amount`, `customer_id`)
VALUES
	(0.00, 1),
	(75.00, 2),
	(120.00, 3),
	(90.00, 4),
	(65.00, 5),
	(80.00, 6),
	(100.00, 7),
	(110.00, 8),
	(95.00, 9),
	(70.00, 10),
    (0.00, 11),
	(75.00, 12),
	(120.00, 13),
	(90.00, 14),
	(65.00, 15),
	(80.00, 16),
	(100.00, 17),
	(110.00, 18),
	(95.00, 19),
	(70.00, 20);
    
    -- Insert into plans table
INSERT INTO `cableCompany`.`plans` (`name`, `monthly_fee`)
VALUES
	('Basic', 20.00),
	('Standard', 40.00),
	('Premium', 60.00),
	('Sports', 30.00),
	('Movies', 35.00),
	('Kids', 25.00),
	('News', 20.00),
	('Entertainment', 35.00),
	('Educational', 30.00),
	('International', 50.00);
    
        INSERT INTO `cableCompany`.`payments` 
(`paymentAmount`, `month`, `year`, `dateOfPayment`, `customer_id`, `plan_id`)
VALUES 
(50.00, 1, 2022, '2022-01-15 09:30:00', 1, 1),
(60.00, 2, 2022, '2022-02-15 09:30:00', 2, 1),
(45.00, 3, 2022, '2022-03-15 09:30:00', 3, 2),
(55.00, 4, 2022, '2022-04-15 09:30:00', 4, 2),
(50.00, 5, 2022, '2022-05-15 09:30:00', 5, 3),
(60.00, 6, 2022, '2022-06-15 09:30:00', 6, 3),
(45.00, 7, 2022, '2022-07-15 09:30:00', 7, 4),
(55.00, 8, 2022, '2022-08-15 09:30:00', 8, 4),
(50.00, 9, 2022, '2022-09-15 09:30:00', 9, 5),
(60.00, 10, 2022, '2022-10-15 09:30:00', 10, 5);


#1. Създайте процедура, всеки месец извършва превод от депозираната от клиента сума, с който се заплаща месечната такса. 
#Нека процедурата получава като входни параметри id на клиента и сума за превод, ако преводът е успешен - 
#третият изходен параметър от тип BIT да приема стойност 1, в противен случай 0.
DELIMITER |
CREATE PROCEDURE monthPayment (IN client INT, IN price DOUBLE, OUT flag BIT)
BEGIN
DECLARE amountBefore_client DOUBLE;
DECLARE amountBefore_bank DOUBLE;
DECLARE amountAfter_client DOUBLE;
DECLARE amountAfter_bank DOUBLE;
SELECT accounts.amount INTO amountBefore_client FROM accounts WHERE accountID=client;
SELECT accounts.amount INTO amountBefore_bank FROM accounts WHERE accountID=1;
UPDATE accounts SET amount = amount + price WHERE accountID = 1;
UPDATE accounts SET amount = amount - price WHERE accountID = client;
SELECT accounts.amount INTO amountAfter_client FROM accounts WHERE accountID=client;
SELECT accounts.amount INTO amountAfter_bank FROM accounts WHERE accountID=1;
IF(amountBefore_client-price=amountAfter_client AND amountBefore_bank+price=amountAfter_bank)
THEN commit; SET flag=1;
ELSE rollback; SET flag = 0;
END IF;
END |
DELIMITER ;

SET @flag = NULL;
CALL monthPayment(2, 20.00, @flag);
SELECT @flag;

#2. Създайте процедура, която извършва плащания в системата за потребителите, депозирали суми. 
#Ако някое плащане е неуспешно, трябва да се направи запис в таблица длъжници. Използвайте трансакция и курсор.
DELIMITER |
CREATE PROCEDURE deptorsUsers (IN sender INT, IN price DOUBLE, IN plan INT)
BEGIN
DECLARE acc_id INT;
DECLARE balans DOUBLE;
DECLARE balansBefore_receiver DOUBLE;
DECLARE balansAfter_receiver DOUBLE;
DECLARE balansBefore_sender DOUBLE;
DECLARE balansAfter_sender DOUBLE;
DECLARE debt DOUBLE;
DECLARE done INT;
DECLARE getBalans CURSOR FOR SELECT accounts.accountID, accounts.amount FROM accounts WHERE accountID!=sender;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done=0;
OPEN getBalans;
whileloop: WHILE(done=0)
DO
IF(done=1) THEN LEAVE whileloop; END IF;
FETCH getBalans INTO acc_id, balans;
SELECT amount INTO balansBefore_receiver FROM accounts WHERE accountID=acc_id;
UPDATE accounts SET amount=amount+price WHERE accountID=acc_id;
SELECT amount INTO balansAfter_receiver FROM accounts WHERE accountID=acc_id;
SELECT amount INTO balansBefore_sender FROM accounts WHERE accountID=sender;
UPDATE accounts SET amount=amount-price WHERE accountID=sender;

SELECT amount INTO balansAfter_sender FROM accounts WHERE accountID=sender;
SET debt=balansBefore_sender-balansAfter_sender;
IF(balansAfter_receiver-balansBefore_receiver=price AND balansBefore_sender-balansAfter_sender=price)
THEN commit;
SELECT accounts.amount INTO debt FROM accounts WHERE accountID = sender;
IF(debt<=0)
THEN
UPDATE accounts SET amount = 0 WHERE accountID = sender;
IF((SELECT COUNT(*) FROM debtors WHERE customer_id=sender)=0)
THEN 
INSERT INTO debtors(customer_id, plan_id, debt_amount) VALUES (sender, plan, ABS(debt));
ELSE 
UPDATE debtors SET debt_amount= debt_amount+price WHERE customer_id=sender;
END IF;
END IF;
ELSE rollback;
END IF;
END WHILE;
END |
DELIMITER ;

SET @sender = 2;
SET @price = 10.00;
SET @plan = 2;
CALL deptorsUsers (@sender, @price, @plan);

#3. Създайте event, който се изпълнява на 28-я ден от всеки месец и извиква втората процедура.
SHOW PROCESSLIST;
SET GLOBAL event_scheduler = OFF;
SET GLOBAL event_scheduler = ON;

DELIMITER |
CREATE EVENT payMonthBill
ON SCHEDULE EVERY 1 YEAR
STARTS '2023-05-05 17:45:00'
DO
BEGIN
CALL monthPayment ();
END |
DELIMITER ;

#4. Създайте VIEW, което да носи информация за трите имена на клиентите, дата на подписване на договор, план, дължимите суми.
CREATE VIEW clientPlan AS 
SELECT customers.firstName, customers.middleName, customers.lastName, payments.dateOfPayment, plans.name, debtors.debt_amount
FROM customers JOIN payments ON payments.customer_id=customers.customerID JOIN plans ON payments.plan_id = plans.planID 
LEFT JOIN debtors ON debtors.customer_id = customers.customerID;

SELECT * FROM clientPlan;

#5. Създайте тригер, който при добавяне на нов план, проверява дали въведената такса е по-малка от 10 лева. 
#Ако е по-малка, то добавянето се прекратява, ако не, то се осъществява.
DELIMITER |
CREATE TRIGGER checkPlan BEFORE INSERT ON plans
FOR EACH ROW
BEGIN
IF(NEW.monthly_fee<10)
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "can't add plan under 10 lv!";
END IF;
END |
DELIMITER ;

#INSERT INTO plans (name, monthly_fee) VALUES ('discount!', 9.00);

#6. Създайте тригер, който при добавяне на сума в клиентска сметка проверява дали сумата, която трябва да бъде добавена не е по-малка от дължимата сума. 
#Ако е по-малка, то добавянето се прекратява, ако не, то се осъществява.
DELIMITER |
CREATE TRIGGER checkDebt BEFORE UPDATE ON accounts 
FOR EACH ROW
BEGIN
DECLARE debt DOUBLE;
DECLARE balans DOUBLE;
SELECT debtors.debt_amount INTO debt FROM debtors WHERE debtors.customer_id = NEW.accountID;
IF(NEW.amount < debt)
THEN SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "can't add smaller sum, than you debt!";
ELSE 
SET balans = NEW.amount-debt;
DELETE FROM debtors WHERE debtors.customer_id = NEW.accountID;
SET NEW.amount = balans;
END IF;
END |
DELIMITER ;

UPDATE accounts SET amount = amount + 150 WHERE accountID=2;


#7. Създайте процедура, която при подадени имена на клиент извежда всички данни за клиента, както и извършените плащания.
DELIMITER |
CREATE PROCEDURE allPayments (IN name_out VARCHAR(255))
BEGIN
DECLARE name VARCHAR (255);
DECLARE email VARCHAR(255);
DECLARE phone VARCHAR(255);
DECLARE address VARCHAR(255);
DECLARE paymentAmount DOUBLE;
DECLARE dateOfPayment DATETIME;
DECLARE done INT;
DECLARE curs CURSOR FOR SELECT CONCAT(customers.firstName, " ", customers.middleName, " ", customers.lastName), customers.email, customers.phone, customers.address, 
payments.paymentAmount, payments.dateOfPayment FROM customers JOIN payments ON payments.customer_id = customers.customerID WHERE
CONCAT(customers.firstName, " ", customers.middleName, " ", customers.lastName)=name_out;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done = 0;
CREATE TEMPORARY TABLE client_payments(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
name VARCHAR(255),
email VARCHAR(255),
phone VARCHAR(255),
address VARCHAR(255),
paymentAmount DOUBLE,
dateOfPayment DATETIME
)ENGINE=MEMORY;

OPEN curs;

whileloop: WHILE (done = 0)
DO
IF(done=1) THEN LEAVE whileloop; END IF;
FETCH curs INTO name, email, phone, address, paymentAmount, dateOfPayment;
INSERT INTO client_payments (name, email, phone, address, paymentAmount, dateOfPayment) 
VALUES(name, email, phone, address, paymentAmount, dateOfPayment);
END WHILE;
CLOSE curs;
SELECT * FROM client_payments;
DROP TABLE client_payments;
END|
DELIMITER ;

CALL allPayments ('John A. Doe');