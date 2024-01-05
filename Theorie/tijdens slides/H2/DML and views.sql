----- INSERT -----
-- INSERT of 1 row
begin transaction
insert into Products(ProductName)
values ('Testproduct')

select *
from Products
where ProductID = (select max(ProductID) from Products)

rollback

-- INSERT of rows selected from other tables
begin transaction
INSERT INTO Customers (CustomerID, ContactName, ContactTitle, CompanyName)
SELECT substring(FirstName, 1, 2) + substring(LastName, 1, 3),
       FirstName + ' ' +
       LastName,
       Title,
       'EmployeeCompany'
FROM Employees

select *
from Customers
where CompanyName = 'EmployeeCompany'

rollback


----- UPDATE -----
-- all rows
begin transaction
select max(UnitPrice)
from Products

UPDATE Products
SET UnitPrice = UnitPrice * 1.1

select max(UnitPrice)
from Products

rollback

-- 1 row or a group of rows
begin transaction
UPDATE Products
SET UnitPrice    = UnitPrice * 1.1,
    UnitsInStock = 0
WHERE ProductName LIKE '%Bröd%'

rollback

-- Change rows based on data in another table
begin transaction

UPDATE Products
SET UnitPrice = (UnitPrice * 1.1)
WHERE SupplierID IN
      (SELECT SupplierID FROM Suppliers WHERE Country = 'USA')

rollback

----- DELETE -----
-- Delete some rows (moet wel rekening houden met key constraints, maar ga ze niet aanpassen hier)
begin transaction
DELETE
FROM Products
WHERE ProductName LIKE '%Bröd%'
rollback


-- all rows in a table (moet wel rekening houden met key constraints, maar ga ze niet aanpassen hier)
begin transaction
-- the identity value restarts from 1
TRUNCATE TABLE Products
rollback


-- based on data in another table
begin transaction
DELETE
FROM OrderDetails
WHERE OrderID IN
      (SELECT OrderID FROM Orders WHERE OrderDate = (SELECT MAX(OrderDate) from Orders))
rollback


----- MERGE -----
BEGIN TRANSACTION
-- Script to create temporary table
/* First execute following script to simulate the Excel file that has been imported
to a temporary table ShippersUpdate */
DROP TABLE IF EXISTS ShippersUpdate;
-- Add everything from Shippers to ShippersUpdate
SELECT *
INTO ShippersUpdate
FROM Shippers
-- Add an extra record to ShippersUpdate
INSERT INTO ShippersUpdate
VALUES ('Pickup', '(503) 555-9647')
-- Update a record of ShippersUpdate
UPDATE ShippersUpdate
SET Phone = '(503) 555-4512'
WHERE ShipperID = 1
-- Remove a record from ShippersUpdate
DELETE
FROM ShippersUpdate
WHERE shipperID = 4

-- merge
MERGE Shippers as t -- t = target
USING ShippersUpdate as s -- s = source
ON (t.ShipperID = s.ShipperID)
    -- Which rows are in source and have different values for CompanyName or Phone?
-- Update those rows in target with the values coming from source
WHEN MATCHED AND t.CompanyName <> s.CompanyName OR ISNULL(t.Phone, '') <> ISNULL(s.Phone, '')
    THEN
    UPDATE
    SET t.CompanyName = s.CompanyName,
        t.Phone=s.Phone
    -- Which rows are in target and not in source?
-- Add those rows to source
WHEN NOT MATCHED BY target --> new rows
    THEN
    INSERT (CompanyName, Phone)
    VALUES (s.CompanyName, s.Phone)
    -- Which rows are in source and not in target?
-- Delete those rows from target
WHEN NOT MATCHED BY source --> rows to delete
    THEN DELETE;
-- Check the result
SELECT *
FROM Shippers
ROLLBACK;


----- VIEWS -----
-- Creating a view
-- CREATE VIEW view_name [(column_list)] AS select_statement
create view V_ProductsCustomer(productcode, company, quantity) as
select od.ProductID, c.CompanyName, sum(od.Quantity)
FROM Customers c
         JOIN Orders o ON o.CustomerID = c.CustomerID
         JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY od.ProductID, c.CompanyName;

-- Using a view
SELECT *
FROM V_ProductsCustomer;

-- Changing a view
    ALTER VIEW V_ProductsCustomer(productcode, company)
    AS SELECT od.ProductID, c.CompanyName
       FROM Customers c
                JOIN Orders o ON o.CustomerID = c.CustomerID
                JOIN OrderDetails od ON o.OrderID = od.OrderID
       GROUP BY od.ProductID, c.CompanyName;

-- Dropping a view
DROP VIEW V_ProductsCustomer;

--- Example: views as partial solution for complex problems
-- Create a view with the number of orders per employee per year
CREATE OR ALTER VIEW vw_number_of_orders_per_employee_per_year
AS
SELECT EmployeeID, YEAR(OrderDate) As OrderYear, COUNT(OrderID) As NumberOfOrders
FROM Orders
GROUP BY EmployeeID, YEAR(OrderDate)
-- Check the result
SELECT *
FROM vw_number_of_orders_per_employee_per_year
-- Add the running total. Use the view.
SELECT EmployeeID,
       OrderYear,
       NumberOfOrders,
       (SELECT SUM(NumberOfOrders)
        FROM vw_number_of_orders_per_employee_per_year
        WHERE OrderYear <= vw.OrderYear
          AND EmployeeID = vw.EmployeeID) As TotalNumberOfOrders
FROM vw_number_of_orders_per_employee_per_year vw
ORDER BY EmployeeID, OrderYear
