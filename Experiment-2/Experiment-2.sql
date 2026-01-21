-- DROP TABLE (optional, if table already exists)
DROP TABLE Students CASCADE CONSTRAINTS;

-- CREATE TABLE
CREATE TABLE Students (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    city VARCHAR2(30),
    marks NUMBER(10)
);

-- INSERT DATA
INSERT INTO Students VALUES (1, 'Aman', 'Mohali', 85);
INSERT INTO Students VALUES (2, 'Rohit', 'Mohali', 78);
INSERT INTO Students VALUES (3, 'Neha', 'Mohali', 92);
INSERT INTO Students VALUES (4, 'Simran', 'Amritsar', 88);
INSERT INTO Students VALUES (5, 'Karan', 'Amritsar', 75);

-- COUNT NUMBER OF STUDENTS IN EACH CITY
SELECT city, COUNT(*) AS count_students
FROM Students
GROUP BY city;

-- SORT CITIES BY COUNT OF STUDENTS (ASCENDING)
SELECT city, COUNT(*) AS count_students
FROM Students
GROUP BY city
ORDER BY count_students ASC;

-- FIND CITIES HAVING AT LEAST 3 STUDENTS
SELECT city, COUNT(*) AS count_students
FROM Students
GROUP BY city
HAVING COUNT(*) >= 3;

-- FIND AVERAGE MARKS OF EACH CITY
SELECT city, ROUND(AVG(marks), 2) AS average_marks
FROM Students
GROUP BY city;

-- SUM, MIN, MAX MARKS OF EACH CITY
SELECT 
    city,
    SUM(marks) AS total_marks,
    MIN(marks) AS minimum_marks,
    MAX(marks) AS maximum_marks
FROM Students
GROUP BY city;
