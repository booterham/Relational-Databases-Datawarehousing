/* JOIN */

-- JOIN
-- Give the productID, productName and CategoryName for each product
SELECT p.productID, p.productName, c.CategoryName
FROM Products p
         join Categories c
              ON p.CategoryID = c.CategoryID

-- old style
SELECT ProductID, ProductName, CategoryName
FROM Products,
     Categories
WHERE Products.CategoryID = Categories.CategoryID

-- Using Aliases
SELECT ProductID, ProductName, CategoryName
FROM Products p
         JOIN Categories c
              ON p.CategoryID = c.CategoryID

-- old style
SELECT ProductID, ProductName, CategoryName
FROM Products p,
     Categories c
WHERE p.CategoryID = c.CategoryID

-- INNER JOIN of > 2 tables
-- Give for each product the ProductName, the CategoryName and the CompanyName of the supplier
SELECT p.ProductID, p.ProductName, c.CategoryName, s.CompanyName
FROM Products p
         JOIN Categories c ON p.CategoryID = c.CategoryID
         JOIN Suppliers s ON p.SupplierID = s.SupplierID


-- INNER JOIN with itself
-- Show all employees and the name of whom they have to report to
select e1.employeeID,
       e1.lastname + ' ' + e1.firstname as employee,
       e2.lastname + ' ' + e2.firstname as boss
from employees e1
         inner join employees e2 on
    e1.reportsto = e2.employeeid;

-- LEFT JOIN
-- Show the number of shippings per Shipper
SELECT s.ShipperID, s.CompanyName, COUNT(OrderID) As NumberOfShippings
FROM Shippers s
         JOIN Orders o
              ON s.shipperID = o.shipVia
GROUP BY s.ShipperID, s.CompanyName

SELECT s.ShipperID, s.CompanyName, COUNT(OrderID) As NumberOfShippings
FROM Shippers s
         LEFT JOIN Orders o
                   ON s.shipperID = o.shipVia
GROUP BY s.ShipperID, s.CompanyName

-- RIGHT JOIN
-- Give the employees to whom no one reports
SELECT e1.Firstname + ' ' + e1.LastName As Employee,
       e2.Firstname + ' ' + e2.LastName As ReportsTo
FROM Employees e1
         RIGHT JOIN Employees e2
                    ON e1.ReportsTo = e2.EmployeeID
WHERE e1.Firstname + ' ' + e1.LastName IS NULL

-- FULL OUTER JOIN is the combination(=UNION) of LEFT and RIGHT OUTER JOIN
SELECT o.OrderID, s.ShipperID, s.CompanyName
FROM Shippers s
         FULL OUTER JOIN Orders o
                         ON s.shipperID = o.shipVia


-- CROSS JOIN
-- Make a schedule in which each employee should contact each customer
SELECT s.CompanyName, e.FirstName + ' ' + e.LastName As Emp
FROM Suppliers s
         CROSS JOIN Employees e

/* UNION INTERSECT EXCEPT */

-- UNION
-- Give an overview of all employees (lastname and firstname, city and postal code) 
-- and all customers (name, city and postal code)
SELECT lastname + ' ' + firstname as name, city, postalcode
FROM Employees
UNION
SELECT CompanyName, city, postalcode
FROM Customers

-- INTERSECT
select city, country
from customers
intersect
select city, country
from suppliers

-- EXCEPT
-- Which products have never been ordered? 
SELECT productid
FROM products
EXCEPT
SELECT productid
FROM orderdetails

/* Exercises */
-- 1. Which suppliers (SupplierID and CompanyName) deliver Dairy Products? 
--SupplierID	CompanyName
--5	Cooperativa de Quesos 'Las Cabras'
--14	Formaggi Fortini s.r.l.
--15	Norske Meierier
--28	Gai pâturage
select distinct P.SupplierID, CompanyName
from Products P
         full join Categories C on P.CategoryID = C.CategoryID
         inner join Suppliers S on P.SupplierID = S.SupplierID
where CategoryName = 'Dairy Products'


-- 2. Give for each supplier the number of orders that contain products of that supplier. 
-- Show supplierID, companyname and the number of orders.
-- Order by companyname.
--SupplierID	CompanyName	NrOfOrders
--18	Aux joyeux ecclésiastiques	53
--16	Bigfoot Breweries	64
--5	Cooperativa de Quesos 'Las Cabras'	52
--27	Escargots Nouveaux	18
--1	Exotic Liquids	90
--29	Forêts d'érables	71
-- ...
select SupplierID, CompanyName, count(OrderID)
from (select distinct S.SupplierID, CompanyName, OrderID
      from OrderDetails OD
               left join dbo.Products P on OD.ProductID = P.ProductID
               left join Suppliers S on P.SupplierID = S.SupplierID) as all_orders
group by SupplierID, CompanyName


-- 3. What's for each category the lowest UnitPrice? Show category name and unit price.
--CategoryName	Minimum UnitPrice
--Beverages	4,50
--Condiments	10,00
--Confections	9,20
--Dairy Products	2,50
--Grains/Cereals	7,00
--Meat/Poultry	7,45
--Produce	10,00
--Seafood	6,00
select CategoryName, CAST(ROUND(min(UnitPrice), 2) AS DECIMAL(10, 2)) as lowestUnitPrice
from Products P
         left join Categories C on P.CategoryID = C.CategoryID
group by CategoryName


-- 4. Give for each ordered product: productname, the least (columnname 'Min amount ordered') and the most ordered (columnname 'Max amount ordered'). Order by productname.
--ProductName	Min amount ordered	Max amount ordered
--Alice Mutton	2	100
--Aniseed Syrup	4	60
--Boston Crab Meat	1	91
--Camembert Pierrot	2	100
--Carnarvon Tigers	4	50
--Chai	2	80
select ProductName, min(Quantity) as 'Min amount ordered', max(Quantity) as 'Max amount ordered'
from OrderDetails OD
         left join Products P on OD.ProductID = P.ProductID
group by ProductName
order by ProductName

-- 5. Give a summary for each employee with orderID, employeeID and employeename.
-- Make sure that the list also contains employees who don't have orders yet.
--EmployeeID	Name	OrderID
--5	Steven Buchanan	10248
--6	Michael Suyama	10249
--4	Margaret Peacock	10250
--3	Janet Leverling	10251
--4	Margaret Peacock	10252
--3	Janet Leverling	10253
select Orders.EmployeeID, concat(FirstName, ' ', LastName) as Name, OrderID
from Employees
         left join Orders on Employees.EmployeeID = Orders.EmployeeID


