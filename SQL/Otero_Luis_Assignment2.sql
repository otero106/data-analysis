-- Luis Otero
-- March 2, 2020

-- 1. Give me the names of the vendors based in Ballard, Bellevue, and Redmond.

SELECT VendName, VendCity 
FROM Vendors
WHERE VendCity in ('Ballard', 'Bellevue', 'Redmond');

-- The names of the vendors are Shinoman, Inc., Nikoma of America, and Kona, Inc.

-- 2. Which vendors do not have a webpage listed?

SELECT VendName, VendWebPage
FROM Vendors
WHERE VendWebPage IS NULL;

-- The Vendors that do not have a webpage listed are Big Sky Mountain Bikes, Dog Ear,
-- Sun Sports Suppliers, and Lone Star Bike Supply.

-- 3. Show me all orders that occurred in January of 2013

SELECT OrderNumber, OrderDate
FROM Orders
WHERE OrderDate LIKE '2013-01%';

-- 4. Return all customers whose first name starts with ‘An’

SELECT CustFirstName
FROM Customers
WHERE CustFirstName LIKE 'An%';

-- 5. Show me the Customers first name and last name whose order date 
-- is greater than or equal to January 1st 2013 and who ordered a quantity less than 6.

SELECT cust.CustFirstName, cust.CustLastName, cust.CustomerID, 
ord.OrderDate, ord.OrderNumber, dtl.QuantityOrdered
FROM Customers cust
INNER JOIN Orders ord
ON cust.CustomerID = ord.CustomerID
INNER JOIN Order_Details dtl
ON ord.OrderNumber = dtl.OrderNumber
WHERE OrderDate >= '2013-01' AND dtl.QuantityOrdered < 6;

-- 6. Show me all customers and employees with the same last name.

SELECT cust.CustFirstName, cust.CustLastName, emp.EmpFirstName
FROM Customers cust
INNER JOIN Employees emp
ON cust.CustLastName = emp.EmpLastName;


-- 7. Display all orders, the products in each order, and the quantity ordered 
-- for each product, in order number sequence (ascending).

SELECT ord.OrderNumber, dtl.ProductNumber, prod.ProductName, dtl.QuantityOrdered
FROM Orders ord
INNER JOIN Order_Details dtl
ON ord.OrderNumber = dtl.OrderNumber
INNER JOIN Products prod
ON dtl.ProductNumber = prod.ProductNumber
ORDER BY dtl.OrderNumber ASC;

-- 8. List all product names where the category description is “Bikes”

SELECT prod.ProductName, cat.CategoryDescription
FROM Products prod
INNER JOIN Categories cat
ON prod.CategoryID = cat.CategoryID
WHERE cat.CategoryDescription = 'Bikes';

-- 9. Return a distinct list of vendor names whose Days to Deliver is between 2 and 6 days

SELECT DISTINCT(vend.VendName), vend.VendorID, prod.DaysToDeliver
FROM Vendors vend
INNER JOIN Product_Vendors prod
ON vend.VendorID = prod.VendorID
WHERE prod.DaysToDeliver BETWEEN 2 AND 6;

-- 10. Show me customers and employees who live in the same state

SELECT cust.CustFirstName, cust.CustLastName, emp.EmpFirstName, 
emp.EmpLastName, cust.CustState
FROM Customers cust
INNER JOIN Employees emp
ON cust.CustState = emp.EmpState;
