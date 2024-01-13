----- the WITH component -----
-- one with

-- naam geven aan de subquery, basically same als de join die ik eerst gebruikte
-- handig om te hergebruiken wel
WITH CategoryMinPrice(CategoryID, MinPrice)
         AS (SELECT CategoryID, MIN(UnitPrice)
             FROM Products AS p
             GROUP BY CategoryID)
SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
         JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;


-- more than 1 WITH - component, geen meerder with's, gewoon meerere as's
WITH TotalRevenuePerYear(RevenueYear, TotalRevenue)
         AS
         (SELECT YEAR(OrderDate), SUM(od.UnitPrice * od.Quantity)
          FROM Orders o
                   INNER JOIN OrderDetails od
                              ON o.OrderID = od.OrderID
          GROUP BY YEAR(OrderDate)),
     TotalRevenuePerYearPerCustomer(RevenueYear, CustomerID, Revenue)
         AS
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


--- Recursive SELECT's
-- recursive use of WITH
WITH numbers(number) AS
         (SELECT 1
          UNION all
          SELECT number + 1
          FROM numbers
          WHERE number < 5)
SELECT *
FROM numbers;

--- application: generate missing months
--- application: Recursively traversing a hierarchical structure
with Bosses(boss, emp) as (select ReportsTo, EmployeeID
                           from Employees
                           where ReportsTo is null
                           union all
                           select e.ReportsTo, e.EmployeeID
                           from Employees e
                                    inner join Bosses b on e.ReportsTo = b.emp)
select *
from Bosses
order by boss, emp

-- draw org chart
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