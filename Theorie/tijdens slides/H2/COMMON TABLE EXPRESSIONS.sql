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
    (SELECT YEAR (OrderDate), SUM (od.UnitPrice * od.Quantity)
    FROM Orders o INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
    GROUP BY YEAR (OrderDate)), TotalRevenuePerYearPerCustomer(RevenueYear, CustomerID, Revenue)
    AS
    (SELECT YEAR (OrderDate), o.CustomerID, SUM (od.UnitPrice * od.Quantity)
    FROM Orders o INNER JOIN OrderDetails od
    ON o.OrderID = od.OrderID
    GROUP BY YEAR (OrderDate), o.CustomerID)
SELECT CustomerID, pc.RevenueYear, FORMAT(Revenue / TotalRevenue, 'P') As RelativePart
FROM TotalRevenuePerYearPerCustomer pc
         INNER JOIN TotalRevenuePerYear t
                    ON pc.RevenueYear = t.RevenueYear
ORDER BY 2, 3 DESC


-- Recursive SELECT's
