DROP DATABASE IF EXISTS shop;
CREATE DATABASE shop;
USE shop;

-- Създаване на таблицата "categories"
CREATE TABLE categories (
  category_id INT PRIMARY KEY AUTO_INCREMENT,
  category_name VARCHAR(50) NOT NULL
);

-- Създаване на таблицата "products"
CREATE TABLE products (
  product_id INT PRIMARY KEY AUTO_INCREMENT,
  product_name VARCHAR(50) NOT NULL,
  category_id INT NOT NULL,
  unit_price DECIMAL(10,2) NOT NULL,
  units_in_stock INT NOT NULL,
  CONSTRAINT FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Създаване на таблицата "customers"
CREATE TABLE customers (
  customer_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_name VARCHAR(50) NOT NULL,
  address VARCHAR(50) NOT NULL
);

-- Създаване на таблицата "orders"
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  customer_id INT NOT NULL,
  order_date DATE NOT NULL,
  ship_date DATE NOT NULL,
  ship_address VARCHAR(50) NOT NULL,
  price DOUBLE DEFAULT 0.00,
ship_country VARCHAR(50) NOT NULL,
CONSTRAINT FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE orders_products(
product_id INT,
order_id INT,
CONSTRAINT FOREIGN KEY(product_id) REFERENCES products(product_id),
CONSTRAINT FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

-- Добавяне на примерни данни в таблицата "categories"
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home and Garden'),
('Toys');

-- Добавяне на примерни данни в таблицата "products"
INSERT INTO products (product_name, category_id, unit_price, units_in_stock)
VALUES
('Smartphone', 1, 499.99, 10),
('Laptop', 1, 899.99, 5),
('T-Shirt', 2, 19.99, 50),
('Jeans', 2, 59.99, 25),
('Fiction Book', 3, 12.99, 100),
('Gardening Tools Set', 4, 39.99, 20),
('Wooden Chair', 4, 69.99, 15),
('Lego Set', 5, 49.99, 30),
('Board Game', 5, 29.99, 40);

-- Добавяне на примерни данни в таблицата "customers"
INSERT INTO customers (customer_name, address)
VALUES
('John Smith', '123 Main St'),
('Emily Johnson', '456 Oak Ave'),
('Hans Müller', '789 Lindenstrasse'),
('Sophie Dubois', '456 Rue de la Paix'),
('Marco Rossi', 'Via Roma 123');

-- Добавяне на примерни данни в таблицата "orders"
INSERT INTO orders (customer_id, order_date, ship_date, ship_address, ship_country)
VALUES
(1, '2023-05-01', '2023-05-05', '123 Main St', 'USA'),
(2, '2023-05-02', '2023-05-06', '456 Oak Ave', 'USA'),
(3, '2023-05-03', '2023-05-07', '789 Lindenstrasse', 'Germany'),
(4, '2023-05-04', '2023-05-08', '456 Rue de la Paix', 'France'),
(5, '2023-05-05', '2023-05-09', 'Via Roma 123', 'Italy');

-- Добавяне на примерни данни в таблицата "orders_products"
INSERT INTO orders_products (product_id, order_id)
VALUES
(1, 1),
(6, 2),
(2, 3),
(7, 4),
(9, 5);

DELIMITER |
CREATE PROCEDURE calculatePrice ()
BEGIN
DECLARE done INT;
DECLARE o_id INT;
DECLARE pr_pr DOUBLE;
DECLARE productPrices CURSOR FOR SELECT orders_products.order_id, products.unit_price FROM orders_products JOIN products ON orders_products.product_id = products.product_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done = 0;
OPEN productPrices;
whileloop: WHILE (done=0)
DO 
IF(done = 1) THEN LEAVE whileloop; END IF;
FETCH productPrices INTO o_id, pr_pr;
UPDATE orders SET price = price + pr_pr WHERE order_id = o_id;
END WHILE;
CLOSE productPrices;
END |
DELIMITER ;

-- DELIMITER |
-- CREATE EVENT updateOrderPrice
-- ON SCHEDULE EVERY 1 SECOND
-- STARTS '2023-05-09 14:31:00'
-- DO
-- BEGIN
-- CALL calculatePrice ();
-- END |
-- DELIMITER ;

-- INSERT INTO orders_products (product_id, order_id)
-- VALUES
-- (2, 1);

CALL calculatePrice ();

#Да се изберат името на продукта, цената му, името на категорията, където принадлежи и името на клиента, който е направил поръчката, 
#за всички поръчки, направени след 1-ви януари 2022 година, като се подредят по дата на поръчката в нарастващ ред
SELECT p.product_name, p.unit_price, c.category_name, cu.customer_name, o.order_date
FROM orders o
JOIN customers cu ON cu.customer_id = o.customer_id
JOIN orders_products op ON op.order_id = o.order_id
JOIN products p ON p.product_id = op.product_id
JOIN categories c ON c.category_id = p.category_id
WHERE o.order_date >= '2022-01-01'
ORDER BY o.order_date ASC;

#Тригер, който автоматично обновява броя на наличните продукти при добавяне на нова поръчка
DELIMITER |
CREATE TRIGGER updateCount AFTER INSERT ON orders_products
FOR EACH ROW
BEGIN
UPDATE products SET units_in_stock = units_in_stock - 1 WHERE product_id = NEW.product_id;
END |
DELIMITER ;

#Тригер, който автоматично изчислява общата цена на поръчката при добавяне на нов продукт в поръчката:
DELIMITER |
CREATE TRIGGER updatePrice AFTER INSERT ON orders_products 
FOR EACH ROW
BEGIN
DECLARE pr DOUBLE;
SELECT unit_price INTO pr FROM products WHERE product_id = NEW.product_id;
UPDATE orders SET price = price + pr WHERE order_id = NEW.order_id;
END |
DELIMITER ;

INSERT INTO orders_products (product_id, order_id)
VALUES
(2, 1);

#Тригер, който автоматично добавя нов клиент към таблицата "customers", ако не е намерен съществуващ клиент със същото име при добавяне на нова поръчка
DELIMITER |
CREATE TRIGGER addClient BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
DECLARE cl INT;
SELECT COUNT(*) INTO cl FROM customers WHERE customer_id = NEW.customer_id;
IF(cl=0) THEN
INSERT INTO customers (customer_id, customer_name, address) VALUES (NEW.customer_id, 'ADD name!', 'Add address!');
END IF;
END |
DELIMITER ;

INSERT INTO orders (customer_id, order_date, ship_date, ship_address, ship_country)
VALUES
(8, '2023-05-01', '2023-05-05', '123 Main St', 'USA');

DROP TABLE IF EXISTS t;

#Напишете процедура, която да извежда списък на всички продукти, групирани по категории, като за всяка категория да се извежда и общото им количество в склада
DELIMITER |
CREATE PROCEDURE allStocks ()
BEGIN
DECLARE done INT;
DECLARE cat VARCHAR(255);
DECLARE col INT;
DECLARE cat_id INT;
DECLARE cur CURSOR FOR SELECT categories.category_id, categories.category_name, products.units_in_stock FROM categories JOIN products ON products.category_id = categories.category_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
CREATE TEMPORARY TABLE t (
id INT PRIMARY KEY,
cat_name VARCHAR(255),
sum INT
)ENGINE = MEMORY;
SET done = 0;
OPEN cur;
whileloop: WHILE (done = 0)DO
IF(done = 1) THEN LEAVE whileloop; END IF;
FETCH cur INTO cat_id, cat, col;
IF((SELECT COUNT(cat_name) FROM t WHERE id = cat_id)=0) THEN
INSERT INTO t (id, cat_name, sum) VALUES(cat_id, cat, col);
ELSE
UPDATE t SET sum = sum + col WHERE id = cat_id;
END IF;
END WHILE;
CLOSE cur;
SELECT * FROM t;
DROP TABLE t;
END |
DELIMITER ;

CALL allStocks();

#Напишете процедура, която да обновява цените на всички продукти на базата данни, като добавя 10% от текущата цена. 
#Използвайте курсор за да обходите всички продукти и да обновите цените им.
DELIMITER |
CREATE PROCEDURE updatePrices (IN downBorder INT, IN upBorder INT, IN priceChangePerc DOUBLE, IN upDown BOOL, OUT ready BOOL)
BEGIN
DECLARE done INT;
DECLARE id INT;
DECLARE pr DOUBLE;
DECLARE countPr INT;
DECLARE cur CURSOR FOR SELECT product_id, unit_price FROM products WHERE product_id BETWEEN downBorder AND upBorder;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
SET done = 0;
SET countPr = 0;
OPEN cur;
whileloop: WHILE (done = 0) DO
IF (done = 1) THEN LEAVE whileloop; END IF;
FETCH cur INTO id, pr;
IF (upDown = 1) THEN
UPDATE products SET unit_price = unit_price + (unit_price*priceChangePerc/100) WHERE product_id = id; SET countPr = countPr + 1; 
ELSE UPDATE products SET unit_price = unit_price - (unit_price*priceChangePerc/100) WHERE product_id = id; SET countPr = countPr + 1; 
END IF;
END WHILE;
IF ((SELECT COUNT(*) FROM products) = countPr) THEN SET ready = 1;
ELSE SET ready = 0;
END IF;
END |
DELIMITER ;

SET @r = 1;
CALL updatePrices(2, 4, 10, 1, @r);