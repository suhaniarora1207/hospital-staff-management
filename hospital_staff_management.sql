/*A. Theory:
Explain the purpose of DISTINCT, LIKE, IN, and BETWEEN in SQL. Describe how these operators are used with the WHERE clause. Also explain the difference between COUNT(*) and COUNT(column_name), and describe how column aliases are used to make query results easier to understand.
B. Practical:
Create a Hospital Staff Management System using Department and Staff tables.
1. Create both tables with suitable attributes and establish a Primary Key and Foreign Key relationship.
2. Apply appropriate NOT NULL, UNIQUE, DEFAULT, and CHECK constraints.
3. Insert at least 4 department records and 6 staff records.
4. Display staff members whose salaries fall between ₹25,000 and ₹50,000.
5. Display staff members whose names start with a specified letter using LIKE.
6. Display staff members belonging to selected departments using IN.
7. Display unique staff designations using DISTINCT.
8. Count the number of staff members in each department using GROUP BY and COUNT().
9. Display the maximum and minimum salary using MAX() and MIN().
10. Update the salary of a staff member.
11. Display the final staff records using SELECT with appropriate column aliases.*/
CREATE DATABASE HOSPITALL;
USE HOSPITALL;

CREATE TABLE DEPARTMENTS (
    DEPT_ID INT PRIMARY KEY,
    DEPT_NAME VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE STAFF (
    STAFF_ID INT PRIMARY KEY,
    STAFF_NAME VARCHAR(50) NOT NULL,
    STAFF_SALARY DECIMAL(10,2) NOT NULL DEFAULT 25000,
    STAFF_DESIGNATION VARCHAR(30) NOT NULL,
    DEPT_ID INT NOT NULL,
    FOREIGN KEY (DEPT_ID) REFERENCES DEPARTMENTS(DEPT_ID),
    CHECK (STAFF_SALARY >= 0)
);

INSERT INTO DEPARTMENTS (DEPT_ID, DEPT_NAME)
VALUES
(101, 'THERAPY'),
(102, 'DENTAL'),
(103, 'NEUROSCIENCE'),
(104, 'ORTHOPEDICS');

INSERT INTO STAFF (STAFF_ID, STAFF_NAME, STAFF_SALARY, STAFF_DESIGNATION, DEPT_ID)
VALUES
(1, 'XYZ', 50000, 'DOCTOR', 101),
(2, 'XY', 25000, 'NURSE', 102),
(3, 'YZ', 40000, 'SURGEON', 103),
(4, 'XZ', 35000, 'NURSE', 104),
(5, 'XYZX', 10000, 'RECEPTIONIST', 101),
(6, 'XYZY', 45000, 'DOCTOR', 102);

SELECT *
FROM STAFF
WHERE STAFF_SALARY BETWEEN 25000 AND 50000;

SELECT *
FROM STAFF
WHERE STAFF_NAME LIKE 'X%';

SELECT *
FROM STAFF
WHERE DEPT_ID IN (101, 102);

SELECT DISTINCT STAFF_DESIGNATION
FROM STAFF;

SELECT D.DEPT_NAME, COUNT(S.STAFF_ID) AS TOTAL_STAFF
FROM DEPARTMENTS D
LEFT JOIN STAFF S ON D.DEPT_ID = S.DEPT_ID
GROUP BY D.DEPT_ID, D.DEPT_NAME;

SELECT MAX(STAFF_SALARY) AS MAX_SALARY,
       MIN(STAFF_SALARY) AS MIN_SALARY
FROM STAFF;

UPDATE STAFF
SET STAFF_SALARY = 90000
WHERE STAFF_ID = 1;

SELECT S.STAFF_ID AS ID,
       S.STAFF_NAME AS NAME,
       S.STAFF_DESIGNATION AS DESIGNATION,
       S.STAFF_SALARY AS SALARY,
       D.DEPT_NAME AS DEPARTMENT
FROM STAFF S
JOIN DEPARTMENTS D ON S.DEPT_ID = D.DEPT_ID;