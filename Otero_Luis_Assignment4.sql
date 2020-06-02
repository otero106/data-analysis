-- Luis Otero
-- March 23, 2020

--1. Display student marital status based on a code
--a. M = Married, S = Single, D = Divorced, W = Widowed

SELECT StudFirstName,
CASE StudMaritalStatus
WHEN 'M' THEN 'Married'
WHEN 'S' THEN 'Single'
WHEN 'D' THEN 'Divorced'
ELSE 'Widowed'
END AS Marital_Status
FROM Students;

--2. Consider the following query from the Sales_Orders database.
-- Alter the query to return the quantity ordered per category description
-- as its own column by order date.

SELECT OrderDate, QuantityOrdered,
SUM(CASE WHEN CategoryDescription = 'Accessories' THEN QuantityOrdered END) AS Accessories,
SUM(CASE WHEN CategoryDescription = 'Car racks' THEN QuantityOrdered END) AS Car_Racks,
SUM(CASE WHEN CategoryDescription = 'Clothing' THEN QuantityOrdered END) AS Clothing,
SUM(CASE WHEN CategoryDescription = 'Components' THEN QuantityOrdered END) AS Components,
SUM(CASE WHEN CategoryDescription = 'Tires' THEN QuantityOrdered END) AS Tires
FROM Orders ord
INNER JOIN Order_Details dtl ON ord.OrderNumber = dtl.OrderNumber
INNER JOIN Products prod ON dtl.ProductNumber = prod.ProductNumber
INNER JOIN Categories cat ON prod.CategoryID = cat.CategoryID
GROUP BY OrderDate;

-- 3. Create a table called Daily_Sales. In this table create the following columns.
-- Data inputted into the Description column can be string of varying length.
-- - OrderNumber
-- - Date
-- - Price
-- - Quantity
-- - Description

CREATE TABLE Daily_Sales1
(OrderNumber INT NOT NULL,
Date FORMAT 'yyyy-mm-dd',
Price FLOAT,
Quantity INT,
Description CHAR (255)
);

-- 4. Increase the salary of a full time tenured staff by 5%

UPDATE Staff
SET Salary = Salary + (Salary * .05)
WHERE StaffID IN
(SELECT StaffID
 FROM Faculty
 WHERE Status = 'Full Time' AND Tenured = 1);

--5. For all staff in Zip Codes 98002 AND 98125, change the area code to 92614.

UPDATE Staff SET StfZipCode = 92614
WHERE StfZipCode IN (98002, 98125);

-- 6. Angel Kennedy wants to register as a student. Her husband, John, is already enrolled.
-- Create a new student record for Angel using the information from John’s record. Make
-- up any information that is not already listed for John.

DELETE FROM Students WHERE StudFirstName = 'Angel';

INSERT INTO Students
VALUES (1019, 'Angel', 'Kennedy', '16679 NE 41st Court', 'Portland', 'OR',
'97208', '503', '555-2621', '1993-07-21', 'F', 'M', 5);

-- 7. Staff member Tim Smith wants to enroll as a Student. Create a new student record from
-- Tim’s staff record. Make up any information that is not listed in the staff table.

INSERT INTO Students
VALUES (1020, 'Tim', 'Smith', '30301 - 166th Ave. N.E.', 'Seattle', 'WA',
'98106', '206', '555-2536', '1962-12-17', 'M', 'S', 3);

-- 8. Delete all students who are not registered for any class.

DELETE FROM Students
WHERE StudentID IN
(SELECT StudentID
 FROM Student_Schedules
 WHERE ClassStatus != 1);

-- 9. Delete subjects that have no classes.

DELETE FROM Subjects
WHERE SubjectID NOT IN
 (SELECT SubjectID FROM Classes)

-- 10. Drop all tables in that start with ‘ztbl’

DROP TABLE ztblGenderMatrix;
DROP TABLE ztblMaritalStatusMatrix;
DROP TABLE ztblProfRatings;
DROP TABLE ztblSemesterDays;
