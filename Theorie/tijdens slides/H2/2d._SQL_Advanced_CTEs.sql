/* Common Table Expression */

/* Common Table Expression: The WITH component */

-- Give per category the minimum price and all products with that minimum price 

-- Solution 1
SELECT CategoryID, ProductID, UnitPrice
FROM Products p
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products WHERE CategoryID = p.CategoryID)


-- Not performant! Loops through all products and calculates the MIN(unitprice) for the category of that specific product: O(n?)
-- The MIN(unitprice) is calculated multiple times for each category!


-- Solution 2
WITH CategoryMinPrice(CategoryID, MinPrice)
         AS (SELECT CategoryID, MIN(UnitPrice)
             FROM Products AS p
             GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
         JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;

-- Using the WITH-component you can give the subquery its own name (with column names) and reuse it in the rest of the query (possibly several times!)


-- Give per category all products that cost less than the average price of that category


-- Give all products from the same category As Tofu, that are not Tofu


--The columns in the CTE should have a name, so
--you can refer to these columns. 
--(1) If not given a name, it will use the 'default' name (e.g. customerid, COUNT(orderid)) 
--(2) Or you can specify the columnname in the  'header' of the CTE 
WITH CategoryMinPrice(CategoryID, MinPrice)
         AS (SELECT CategoryID, MIN(UnitPrice)
             FROM Products AS p
             GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
         JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;


--(3) Or you can give each column a name in the CTE. 
WITH CategoryMinPrice
         AS (SELECT CategoryID As CategoryID, MIN(UnitPrice) AS MinPrice
             FROM Products AS p
             GROUP BY CategoryID)

SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
         JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;

-- the WITH-component has two application areas:
--		Simplify SQL-instructions, e.g. simplified alternative for simple subqueries or avoid repetition of SQL constructs 
--		Traverse recursively hierarchical and network structures


/* CTE's versus Views 

Similarities?
- WITH ~ CREATE VIEW
- Both are virtual tables:?the content is derived from other tables 

Differences?
- A CTE only exists during the SELECT-statement
- A CTE is not visible for other users and applications
*/


/* CTE's versus Subqueries 
Similarities?
- Both are virtual tables:??the content is derived from other tables 

Differences?
- A CTE can be reused in the same query
- A subquery is defined in the clause where it is used (SELECT/FROM/WHERE/?)
- A CTE is defined on top of the query
- A simple subquery can always be replaced by a CTE
*/

-- CTE's with > 1 WITH-component

-- Give per year per customer the relative contribution of this customer to the total revenue

-- Step 1 -> Total revenue per year
SELECT YEAR(OrderDate), SUM(od.UnitPrice * od.Quantity)
FROM Orders o
         INNER JOIN OrderDetails od
                    ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate)

-- Step 2 -> Total revenue per year per customer
SELECT YEAR(OrderDate), o.CustomerID, SUM(od.UnitPrice * od.Quantity)
FROM Orders o
         INNER JOIN OrderDetails od
                    ON o.OrderID = od.OrderID
GROUP BY YEAR(OrderDate), o.CustomerID;

-- Step 3 -> Combine both
WITH TotalRevenuePerYear(RevenueYear, TotalRevenue)
         AS
         (SELECT YEAR(OrderDate), SUM(od.UnitPrice * od.Quantity)
          FROM Orders o
                   INNER JOIN OrderDetails od
                              ON o.OrderID = od.OrderID
          GROUP BY YEAR(OrderDate)),
     TotalRevenuePerYearPerCustomer(RevenueYear, CustomerID, Revenue) AS
         (SELECT YEAR(OrderDate), o.CustomerID, SUM(od.UnitPrice * od.Quantity)
          FROM Orders o
                   INNER JOIN OrderDetails od
                              ON o.OrderID = od.OrderID
          GROUP BY YEAR(OrderDate), o.CustomerID)
SELECT CustomerID, pc.RevenueYear, FORMAT(Revenue / TotalRevenue, 'P') As RelativePart
FROM TotalRevenuePerYearPerCustomer pc
         INNER JOIN TotalRevenuePerYear t
                    ON pc.RevenueYear = t.RevenueYear
ORDER BY 2, 3 DESC


-- Give the employees that process more orders than average
-- cte1 --> the number of processed orders per employee
-- cte2 --> the average
-- employees with number of processed orders > average


/* Recursive SELECT's */

/*
'Recursive' means:?we continue to execute a table expression until a condition is reached.

This allows you to solve problems like:
- Who are the friends of my friends etc. (in a social network)?
- What is the hierarchy of an organisation ??
- Find the parts and subparts of a product (bill of materials).?

*/

-- Give the integers from 1 to 5
WITH numbers(number) AS
         (SELECT 1
          UNION all
          SELECT number + 1
          FROM numbers
          WHERE number < 5)

SELECT *
FROM numbers;

/* Characteristics of recursive use of WITH:
- The with component consists of (at least) 2 expressions, combined with UNION ALL
- A temporary table is consulted in the second expression
- At least one of the expressions may not refer to the temporary table.
*/

-- Give the numbers from 1 to 999

WITH numbers(number) AS
         (SELECT 1
          UNION all
          SELECT number + 1
          FROM numbers
          WHERE number < 999)

SELECT *
FROM numbers;

--> The maximum recursion 100 has been exhausted?before statement completion.

-- Give the numbers from 1 to 999

WITH numbers(number) AS
         (SELECT 1
          UNION all
          SELECT number + 1
          FROM numbers
          WHERE number < 999)

SELECT *
FROM numbers
option (maxrecursion 1000);

--> Maxrecursion is MS SQL Server specific.?

-- Give the total revenue per month in 2016. Not all months occur

SELECT YEAR(OrderDate) * 100 + Month(OrderDate) AS RevenueMonth, SUM(od.UnitPrice * od.Quantity) AS Revenue
FROM Orders o
         INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
WHERE YEAR(OrderDate) = 2016
GROUP BY YEAR(OrderDate) * 100 + Month(OrderDate);

-- Solution: Generate all months with CTE ...
WITH Months AS
         (SELECT 201601 as RevenueMonth
          UNION ALL
          SELECT RevenueMonth + 1
          FROM Months
          WHERE RevenueMonth < 201612)
SELECT *
FROM Months;

-- And combine with outer join
WITH Months(RevenueMonth) AS
         (SELECT 201601 as RevenueMonth
          UNION ALL
          SELECT RevenueMonth + 1
          FROM Months
          WHERE RevenueMonth < 201612),

     Revenues(RevenueMonth, Revenue)
         AS
         (SELECT YEAR(OrderDate) * 100 + Month(OrderDate) AS RevenueMonth, SUM(od.UnitPrice * od.Quantity) AS Revenue
          FROM Orders o
                   INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
          WHERE YEAR(OrderDate) = 2016
          GROUP BY YEAR(OrderDate) * 100 + Month(OrderDate))

SELECT m.RevenueMonth, ISNULL(r.Revenue, 0) As Revenue
FROM Months m
         LEFT JOIN Revenues r ON m.RevenueMonth = r.RevenueMonth


/* Recursively traversing a hierarchical structure */

-- Give all employees who report directly or indirectly to Andrew Fuller (employeeid=2)
-- Step 1 returns all employees that report directly to Andrew Fuller 
-- Step 2 adds the 2nd 'layer': who reports to someone who reports to A. Fuller 
-- ....

WITH Bosses (boss, emp)
         AS
         (SELECT ReportsTo, EmployeeID
          FROM Employees
          WHERE ReportsTo IS NULL
          UNION ALL
          SELECT e.ReportsTo, e.EmployeeID
          FROM Employees e
                   INNER JOIN Bosses b ON e.ReportsTo = b.emp)

SELECT *
FROM Bosses
ORDER BY boss, emp;

-- Change the previous solution to the following solution
/*
boss	emp		title					level	path
NULL	2		Vice President, Sales	1		Vice President, Sales
2		5		Sales Manager			2		Vice President, Sales<--Sales Manager
2		10		Business Manager		2		Vice President, Sales<--Business Manager
2		13		Marketing Director		2		Vice President, Sales<--Marketing Director
5		1		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		3		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		4		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		6		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		7		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
5		8		Inside Sales Coordinator	3	Vice President, Sales<--Sales Manager<--Inside Sales Coordinator
5		9		Sales Representative	3		Vice President, Sales<--Sales Manager<--Sales Representative
...
*/

WITH Bosses (boss, emp, title, level, path)
         AS
         (SELECT ReportsTo, EmployeeID, Title, 1, convert(varchar(max), Title)
          FROM Employees
          WHERE ReportsTo IS NULL
          UNION ALL
          SELECT e.ReportsTo, e.EmployeeID, e.Title, b.level + 1, convert(varchar(max), b.path + '<--' + e.title)
          FROM Employees e
                   INNER JOIN Bosses b ON e.ReportsTo = b.emp)

SELECT *
FROM Bosses
ORDER BY boss, emp;


/* Exercises */


-- 1. Give all employees that started working as an employee in the same year as Robert King
with RobertKing(startYear) as (select year(HireDate) from Employees where FirstName = 'Robert' and LastName = 'King')
select *
from Employees
         inner join RobertKing on RobertKing.startYear = year(Employees.HireDate)


-- 2 Make a histogram of the number of orders per customer, so show how many times each number occurs.
-- E.g. in the graph below: 1 customer placed 1 order, 2 customers placed 2 orders, 7 customers placed 3
-- orders, etc.
/*
nrNumberOfCustomers
11
22
37
46
510
68
77
...
*/
with amountsOrdered(CustomerID, amountOfOrders) as (select CustomerID, count(OrderID) as amountOfOrders
                                                    from Orders
                                                    group by CustomerID)
select count(CustomerID) as NumberOfCustomers, amountOfOrders
from amountsOrdered
group by amountOfOrders
order by amountOfOrders

-- 3. Give the customers of the Country in which most customers live
with whereFrom(amount, country) as (select count(CustomerID) as amountFromCountry, Country
                                    from Customers
                                    group by Country),
     maxInhabits(amount) as (select max(amount) from whereFrom)
select Country
from whereFrom
where amount = maxInhabits.amount

-- 4. Give all employees except for the eldest. Solve this first using a subquery and afterwards using a cte
with eldest(BirthDate) as ((select min(BirthDate) from Employees))
select *
from Employees E
         left join eldest on E.BirthDate = eldest.BirthDate
where eldest.BirthDate is null;

-- 5. What is the total number of customers and suppliers?
with People(Category, id) as (select 'Customer', CustomerID
                              from Customers
                              union
                              select 'Supplier', cast(SupplierID as char)
                              from Suppliers)
select count(id) as totalAmount
from People;

-- 6. Give per title the eldest employee
with EldestEmployee(BirthDate, Title) as (select min(BirthDate), Title
                                          from Employees
                                          group by Title)
select concat(FirstName, ' ', LastName) as FullName, E.Title
from Employees E
         inner join EldestEmployee on E.Title = EldestEmployee.Title and E.BirthDate = EldestEmployee.BirthDate

-- 7. Give per title the employee that earns most
with HighestEarner(Salary, Title) as (select max(Salary), Title
                                      from Employees
                                      group by Title)
select concat(FirstName, ' ', LastName) as FullName, E.Title
from Employees E
         inner join HighestEarner on E.Title = HighestEarner.Title and E.Salary = HighestEarner.Salary;

-- 8. Give the titles for which the eldest employee is also the employee who earns most
with EldestTitle(BirthDate, Title) as (select min(BirthDate), Title
                                       from Employees
                                       group by Title),
     EldestEmployee(FullName, Title) as (select concat(FirstName, ' ', LastName), E.Title
                                         from Employees E
                                                  inner join EldestTitle on E.Title = EldestTitle.Title and
                                                                            E.BirthDate = EldestTitle.BirthDate),
     HighestTitle(Salary, Title) as (select max(Salary)
                                          , Title
                                     from Employees
                                     group by Title),
     HighestEmployee(FullName, Title) as (select concat(FirstName, ' ', LastName), E.Title
                                          from Employees E
                                                   inner join HighestTitle
                                                              on E.Title = HighestTitle.Title and E.Salary = HighestTitle.Salary)
select EldestEmployee.FullName, EldestEmployee.Title
from EldestEmployee
         inner join HighestEmployee on EldestEmployee.FullName = HighestEmployee.FullName


-- 9. Execute the following script:
CREATE TABLE Parts
(
    [Super]
             CHAR(3) NOT NULL,
    [Sub]
             CHAR(3) NOT NULL,
    [Amount] INT     NOT NULL,
    PRIMARY KEY (Super, Sub)
);
INSERT INTO Parts
VALUES ('O1', 'O2', 10);
INSERT INTO Parts
VALUES ('O1', 'O3', 5);
INSERT INTO Parts
VALUES ('O1', 'O4', 10);
INSERT INTO Parts
VALUES ('O2', 'O5', 25);
INSERT INTO Parts
VALUES ('O2', 'O6', 5);
INSERT INTO Parts
VALUES ('O3', 'O7', 10);
INSERT INTO Parts
VALUES ('O6', 'O8', 15);
INSERT INTO Parts
VALUES ('O8', 'O11', 5);
INSERT INTO Parts
VALUES ('O9', 'O10', 20);
INSERT INTO Parts
VALUES ('O10', 'O11', 25);
-- a) Show all parts that are directly or indirectly part of O2, so all parts of which O2 is composed.
with subparts as (select Super, sub
                  from Parts
                  where Super = 'O2'
                  union all
                  select p.Super, p.Sub
                  from Parts p
                           inner join subparts s on s.Sub = p.Super)
select *
from subparts;

-- b) Add an extra column with the path as shown:
/*
SUPER SUB  PAD
O2    O5   O2 <-O5
O2    O6   O2 <-O6
O6    O8   O2 <-O6 <-O8
O8    O11  O2 <-O6 <-O8 <-O11
*/



with subparts as (select Super, sub, convert(varchar(max), Parts.Super + ' <-' + Sub) as path
                  from Parts
                  where Super = 'O2'
                  union all
                  select p.Super, p.sub, convert(varchar(max), s.path + ' <-' + p.Sub)
                  from Parts p
                           inner join subparts s on s.Sub = p.Super)
select *
from subparts;