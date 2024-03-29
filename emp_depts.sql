CREATE DATABASE emp_depts;
USE emp_depts;
CREATE TABLE departments(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL
) ENGINE = InnoDB;
CREATE TABLE employees(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(200) NOT NULL,
egn VARCHAR(10),
address varchar(250) NULL DEFAULT NULL,
department_id INT,
CONSTRAINT FOREIGN KEY (department_id) REFERENCES departments(id)
ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO departments (`name`)
VALUES ('Човешки ресурси'),
('Финансов анализ'),
('Кредитна администрация');
INSERT INTO employees (name, egn, address, department_id)
VALUES ('Иван Райнов', '7412051425', 'София-Младост', '1'),
('Георги Георгиев', '7512032154', 'София - Изток 23', '1'),
('Елеонора Петрова', '8405051245', 'София- Лагера бл. 34', '2');

DELETE FROM
departments
WHERE ID = 1;

UPDATE departments SET id=4
WHERE id=2;