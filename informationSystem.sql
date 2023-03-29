DROP DATABASE IF EXISTS information;
CREATE DATABASE information;
USE information;

CREATE TABLE users(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
role ENUM("reader", "autor", "recenzent") NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE articles (
id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
content TEXT NOT NULL,
dateOf DATE NOT NULL,
isApproved BOOL DEFAULT FALSE,
id_recedent INT DEFAULT NULL,
id_autor INT,
PRIMARY KEY(id),
CONSTRAINT FOREIGN KEY (id_recedent) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT FOREIGN KEY (id_autor) REFERENCES users(id) ON DELETE SET NULL ON UPDATE CASCADE
);

INSERT INTO users (name, role) VALUES
("John Doe", "reader"),
("Jane Smith", "autor"),
("Bob Johnson", "recenzent"),
("Sarah Lee", "reader"),
("David Kim", "autor"),
("Emily Wang", "recenzent"),
("Alex Wong", "reader"),
("Jessica Chen", "autor"),
("Mark Lee", "recenzent"),
("Karen Kim", "reader");

INSERT INTO articles (title, content, dateOf, isApproved, id_recedent, id_autor) VALUES
('Article 1', 'Content of article 1', '2023-03-01', TRUE, 3, 2),
('Article 2', 'Content of article 2', '2023-03-02', FALSE, NULL, 2),
('Article 3', 'Content of article 3', '2023-03-03', TRUE, 6, 3),
('Article 4', 'Content of article 4', '2023-03-04', FALSE, NULL, 3),
('Article 5', 'Content of article 5', '2023-03-05', TRUE, 9, 2),
('Article 6', 'Content of article 6', '2023-03-06', FALSE, NULL, 2),
('Article 7', 'Content of article 7', '2023-03-07', TRUE, 3, 2),
('Article 8', 'Content of article 8', '2023-03-08', FALSE, NULL, 5),
('Article 9', 'Content of article 9', '2023-03-09', TRUE, 6, 3),
('Article 10', 'Content of article 10', '2023-03-10', FALSE, NULL, 6),
('Article 11', 'Content of article 11', '2023-03-11', TRUE, 6, 3),
('Article 12', 'Content of article 12', '2023-03-12', FALSE, NULL, 2),
('Article 13', 'Content of article 13', '2023-03-13', TRUE, 3, 6),
('Article 14', 'Content of article 14', '2023-03-14', FALSE, NULL, 8),
('Article 15', 'Content of article 15', '2023-03-15', TRUE, 9, 9),
('Article 16', 'Content of article 16', '2023-03-16', FALSE, NULL, 9),
('Article 17', 'Content of article 17', '2023-03-17', TRUE, 9, 5),
('Article 18', 'Content of article 18', '2023-03-18', FALSE, NULL, 2),
('Article 19', 'Content of article 19', '2023-03-19', TRUE, 10, 5),
('Article 20', 'Content of article 20', '2023-03-20', FALSE, NULL, 6);

SELECT articles.title, articles.content, articles.dateOf, articles.isApproved, users.name
FROM articles JOIN users ON articles.id_autor = users.id
WHERE users.name = "Jane Smith" AND isApproved = FALSE;

SELECT articles.title, articles.content, articles.dateOf, articles.isApproved, 
recedent.name AS recedent_name, autor.name AS autor_name
FROM articles
LEFT JOIN users AS recedent ON articles.id_recedent = recedent.id
LEFT JOIN users AS autor ON articles.id_autor = autor.id
ORDER BY articles.isApproved DESC;

(SELECT autor.name AS autor_name, COUNT(articles.id_autor) as countOfArticles
FROM users AS autor JOIN articles ON articles.id_autor = autor.id
WHERE isApproved = TRUE
GROUP BY autor.name)
UNION
(SELECT autor.name AS autor_name, COUNT(articles.id_autor) as countOfArticles
FROM users AS autor JOIN articles ON articles.id_autor = autor.id
WHERE isApproved = False
GROUP BY autor.name);