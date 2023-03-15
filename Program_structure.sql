DROP DATABASE IF EXISTS Program_structure;

CREATE DATABASE Program_structure;
USE Program_structure;

CREATE TABLE programmers(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(255) NOT NULL,
address VARCHAR(255) NOT NULL,
startWorkingDate DATE, /** YYYY-MM-DD**/
teamLead_id INT NULL DEFAULT NULL,
CONSTRAINT FOREIGN KEY (teamLead_id) REFERENCES programmers(id)
);
INSERT INTO `programmers` (`name`, `address`, `startWorkingDate`, `teamLead_id`) VALUES ('Ivan Ivanov', 'Sofia', '1999-05-25', NULL),
('Georgi Petkov Todorov', 'Bulgaria- Sofia Nadezhda, bl. 35', '2002-12-01', '1'),('Todor Petkov', 'Sofia - Liylin 7', '2009-11-01', 1),
('Sofiq Dimitrova Petrova', 'Sofia - Mladost 4, bl. 7', '2010-01-01', 1),
('Teodor Ivanov Stoyanov', 'Sofia - Obelya, bl. 48', '2011-10-01', NULL),
('Iliya Stoynov Todorov', 'Sofia - Nadezhda, bl. 28', '2000-02-01', 5),
('Mariela Dimitrova Yordanova', 'Sofia - Knyajevo, bl. 17', '2005-05-01', 5),
('Elena Miroslavova Georgieva', 'Sofia - Krasno Selo, bl. 27', '2008-04-01', 5),
('Teodor Milanov Milanov', 'Sofia - Lozenetz', '2012-04-01', 5);

#9. Псевдоними на колони и на таблици. SELF JOIN
SELECT progr.name as ProgrammerName, progr.address as ProgrammerAddres, teamLeads.name as TeamLeadName
FROM programmers as progr JOIN programmers as teamLeads
WHERE progr.teamLead_id = teamLeads.id;

SELECT progr.name as ProgrammerName, progr.address as ProgrammerAddres, teamLeads.name as TeamLeadName
FROM programmers as progr LEFT JOIN programmers as teamLeads
ON progr.teamLead_id = teamLeads.id;