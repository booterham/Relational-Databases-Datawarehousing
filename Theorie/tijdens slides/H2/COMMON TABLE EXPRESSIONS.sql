----- the WITH component -----
-- naam geven aan de subquery, basically same als de join die ik eerst gebruikte
-- handig om te hergebruiken wel
WITH CategoryMinPrice(CategoryID, MinPrice)
         AS (SELECT CategoryID, MIN(UnitPrice)
             FROM Products AS p
             GROUP BY CategoryID)
SELECT c.CategoryID, p.ProductID, MinPrice
FROM Products AS p
         JOIN CategoryMinPrice AS c ON p.CategoryID = c.CategoryID AND p.UnitPrice = c.MinPrice;