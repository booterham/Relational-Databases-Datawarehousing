/* SUBQUERYS */

/********************************************/
/* Subqueries in the WHERE OR HAVING clause */
/********************************************/

/* SUBQUERY that returns a single value */

-- What is the UnitPrice of the most expensive product?
SELECT MAX(UnitPrice) As MaxPrice
FROM Products

-- Alternative?
SELECT TOP 1 productName, UnitPrice
FROM products
ORDER BY unitPrice DESC

-- What is the most expensive product?
SELECT ProductID, ProductName, UnitPrice As MaxPrice
FROM Products
WHERE UnitPrice = (SELECT MAX(UnitPrice) FROM Products)

-- Alternative???
SELECT TOP 1 ProductID, ProductName, UnitPrice As MaxPrice
FROM Products
ORDER BY UnitPrice DESC


-- Give the products that cost more than average
SELECT ProductID, ProductName, UnitPrice As MaxPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)

-- Who is the youngest employee from the USA?


-- Give the full name of the employee who earns most


-- Give the name of the most frequently sold product


/* SUBQUERY that returns a single column */

-- Give the CustomerID and CompanyName of all customers that already placed an order
SELECT c.CustomerID, c.CompanyName
FROM Customers c
WHERE c.CustomerID IN (SELECT DISTINCT CustomerID FROM Orders)

-- Alternative?
SELECT DISTINCT c.CustomerID, c.CompanyName
FROM Customers c
         JOIN Orders o ON c.CustomerID = o.CustomerID

-- Give the CustomerID and CompanyName of all customers that not yet placed an order
SELECT c.CustomerID, c.CompanyName
FROM Customers c
WHERE c.CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)

-- Alternative?
SELECT c.CustomerID, c.CompanyName
FROM Customers c
         LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID is NULL

-- Give the CompanyName of the shippers that haven't shipped anything yet


-- Give the productID's for which some customers got a discount and other customers did not


/* Correlated subquerys */
/*
In a correlated subquery the inner query depends on information from the outer query.
The subquery contains a search condition that refers to the main query, 
which makes the subquery depends on the main query
*/

-- Give employees with a salary larger than the average salary
SELECT FirstName + ' ' + LastName As FullName, Salary
FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees)

-- Give the employees whose salary is larger 
-- than the average salary of the employees who report to the same boss.
SELECT FirstName + ' ' + LastName As FullName, ReportsTo, Salary
FROM Employees As e
WHERE Salary >
      (SELECT AVG(Salary) FROM Employees WHERE ReportsTo = e.ReportsTo)

-- Give all products that cost more 
-- than the average unitprice of products of the same category


-- Give the customers that ordered more often in 2016 than in 2017


/* Subqueries and the EXISTS operator */
-- Give the CustomerID and CompanyName of all customers that already placed an order
SELECT c.CustomerID, c.CompanyName
FROM Customers c
WHERE EXISTS
              (SELECT * FROM Orders WHERE CustomerID = c.customerID)

-- Give the CustomerID and CompanyName of all customers that have not placed any orders yet
SELECT c.CustomerID, c.CompanyName
FROM Customers c
WHERE NOT EXISTS
              (SELECT * FROM Orders WHERE CustomerID = c.customerID)

-- Alternative?
SELECT c.CustomerID, c.CompanyName
FROM Customers c
         LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE o.CustomerID is NULL


-- Alternative?
SELECT CustomerID, CompanyName
FROM Customers
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM Orders)


/***************************************************/
/* Subqueries in the SELECT and in the FROM clause */
/***************************************************/

-- The previous examples showed how subqueries can be used in the WHERE-clause
-- Since the result of a query is a table it can be used in the FROM-clause.
-- But we will be using CTE's (see further) instead

-- In a SELECT clause scalar (simple or correlated) subqueries can be used
-- Example: Give for each employee how much they earn more (or less) than the average salary of all employees with the same supervisor 


SELECT Lastname,
       Firstname,
       Salary,
       Salary -
       (SELECT AVG(Salary)
        FROM Employees
        WHERE ReportsTo = e.ReportsTo)
FROM Employees e


/* Application: running totals */

-- Give the cumulative sum of freight per year
SELECT OrderID,
       OrderDate,
       Freight,
       (SELECT SUM(Freight)
        FROM Orders
        WHERE YEAR(OrderDate) = YEAR(o.OrderDate)
          and OrderID <= o.OrderID) As TotalFreight
FROM Orders o
ORDER BY Orderid;


/* Exercises */

-- 1. Give the id and name of the products that have not been purchased yet. 
-- Empty dataset
select ProductName, P.ProductID
from Products P
         full join OrderDetails OD on P.ProductID = OD.ProductID
where OrderID is null


-- 2. Select the names of the suppliers who supply products that have not been ordered yet.
-- Empty dataset
select CompanyName, S.SupplierID
from Suppliers S
         full join Products P on S.SupplierID = P.SupplierID
         full join OrderDetails OD on P.ProductID = OD.ProductID
where OrderID is null


-- 3. Give a list of all customers from the same country as the customer Maison Dewey
--CompanyName	country
--Maison Dewey	Belgium
--Suprêmes délices	Belgium
select CompanyName, C.Country
from Customers C
         inner join (select Country from Customers where CompanyName = 'Maison Dewey') as countryOfDewey
                    on C.Country = countryOfDewey.Country


-- 4. Give for each product how much the price differs from the average price of all products of the same category
--ProductID	ProductName	UnitPrice	differenceToCategory
--1	Chai	18,00	-19,9791
--2	Chang	19,00	-18,9791
--3	Aniseed Syrup	10,00	-13,0625
--4	Chef Anton's Cajun Seasoning	22,00	-1,0625
--- avg price per category vinden
select CategoryID, avg(UnitPrice) as avgCatPrice
from Products
group by CategoryID

--- samen voegen
select ProductID, ProductName, UnitPrice, UnitPrice - avgCatPrice as differenceToCat
from Products P
         left join (select CategoryID, avg(UnitPrice) as avgCatPrice
                    from Products
                    group by CategoryID) as avgPrices on P.CategoryID = avgPrices.CategoryID


-- 5. Give per title the employee that was last hired
--title	FullName	HireDate
--Vice President, Sales	Andrew Fuller	2012-08-14 00:00:00.000
--Sales Representative	Anne Dodsworth	2014-11-15 00:00:00.000
--Sales Manager	Steven Buchanan	2013-10-17 00:00:00.000
--Inside Sales Coordinator	Laura Callahan	2014-03-05 00:00:00.000
--- hiredates vinden per title
select Title, max(HireDate) as Hiredate
from Employees
group by Title

--- employees vinden die title en hiredate matchen
select E.Title, concat(FirstName, ' ', LastName) as FullName, E.HireDate
from Employees E
         inner join (select Title, max(HireDate) as hire
                     from Employees
                     group by Title) as HD on E.Title = HD.Title and E.HireDate = HD.hire


-- 6. Which employee has processed most orders?
-- Margaret Peacock		156
--- max orders vinden
select max(amountOfOrders) as maxOrders
from (select count(OrderID) as amountOfOrders
      from Orders
      group by EmployeeID) as orderCount

--- employeeid vinden en naam
select concat(FirstName, ' ', LastName) as FullName, amountOfOrders
from (select employeeid, count(OrderID) as amountOfOrders
      from Orders
      group by EmployeeID) as ORD
         inner join (select max(amountOfOrders) as maxOrders
                     from (select count(OrderID) as amountOfOrders
                           from Orders
                           group by EmployeeID) as orderCount) as maxi on maxi.maxOrders = ORD.amountOfOrders
         inner join Employees E on E.EmployeeID = ORD.EmployeeID


-- 7. What's the most common ContactTitle in Customers?
-- Owner
select max(occurences) as maxOccurences
from (select count(CustomerID) as occurences
      from Customers
      group by ContactTitle) as occurCount;


select ContactTitle
from (select ContactTitle, count(CustomerID) as occurences
      from Customers
      group by ContactTitle) as contacttitles
         inner join (select max(occurences) as maxOccurences
                     from (select count(CustomerID) as occurences
                           from Customers
                           group by ContactTitle) as occurCount) as maxtitles
                    on contacttitles.occurences = maxtitles.maxOccurences


-- 8. Is there a supplier that has the same name as a customer?
-- Empty dataset
select S.CompanyName as SupplierName
from Suppliers S
         inner join Customers C on S.CompanyName = C.CompanyName

-- 9. Give all the orders for which the ShipAddress is different from the CustomerAddress
-- 48 records
select count(*)
from Orders O
         inner join Customers C on O.CustomerID = C.CustomerID
where ShipAddress <> Address

