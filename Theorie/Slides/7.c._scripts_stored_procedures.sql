CREATE OR ALTER PROCEDURE CheckAndUpdateDimDate 
AS
BEGIN

DECLARE @minDateNorthwind DATETIME, @minDateNorthwindDWH DATETIME, @maxDateNorthwindDWH DATETIME, @startDate DATETIME,  @endDate DATETIME
SET @minDateNorthwind = (SELECT MIN(OrderDate) FROM Northwind.dbo.Orders)
SET @minDateNorthwindDWH = (SELECT MIN(FullDateAlternateKey) FROM NorthwindDWH.dbo.DimDate)
SET @maxDateNorthwindDWH =  (SELECT MAX(FullDateAlternateKey) FROM NorthwindDWH.dbo.DimDate)

IF (@minDateNorthwindDWH IS NULL) OR (@minDateNorthwind < @minDateNorthwindDWH OR GetDATE() > @maxDateNorthwindDWH)
BEGIN
	DELETE FROM NorthwindDWH.dbo.DimDate
	SET @startDate = (select DATEFROMPARTS(YEAR(@minDateNorthwind), 1, 1))
	SET @endDate  = (SELECT DATEADD(yy, DATEDIFF(yy, 0, GETDATE()) + 1, -1))
	EXEC NorthwindDWH.dbo.FillDimDate @startDate, @endDate

END

END 

GO;

CREATE OR ALTER PROCEDURE CheckAndUpdateDimProduct
AS
-- Fill DimProduct
-- Add products to DimProduct that are already in the OLTP database (Products) but that aren't yet in the DWH (DimProduct)
-- It's possible that there are products in DimProduct that aren't in Products any more, but that is no problem.
BEGIN
MERGE NorthwindDWH.dbo.DimProduct as t -- t = target
USING Northwind.dbo.VWProduct as s -- s = source
ON (t.ProductKey = s.ProductKey)
-- Which rows are in source and have different values for ProductName, CategoryName, QuantityPerUnit or UnitPrice ?
-- Update those rows in target with the values coming from source
WHEN MATCHED AND t.ProductName <> s.ProductName OR t.CategoryName <> s.ProductName OR t.QuantityPerUnit <> s.QuantityPerUnit OR t.UnitPrice <> s.UnitPrice
THEN UPDATE SET t.ProductName = s.ProductName, t.CategoryName=s.CategoryName, t.QuantityPerUnit=s.QuantityPerUnit, t.UnitPrice=s.UnitPrice
-- Which rows are in source and not in target?
-- Insert those rows from source into target
WHEN NOT MATCHED BY target --> rows to insert
THEN INSERT VALUES (s.ProductKey,s.ProductName, s.CategoryName, s.QuantityPerUnit, s.UnitPrice);
END



GO;


-- Fill DimCustomer -- Slowly Changing Dimension
CREATE OR ALTER PROCEDURE CheckAndUpdateDimCustomer
AS

BEGIN

-- Create a temporary table #CustomerTempTable to contain the values that have changed
SELECT dc.CustomerKey, c.customerID, c.companyName, c.city, c.region, c.country
INTO #CustomerTempTable
FROM NorthwindDWH.dbo.DimCustomer dc JOIN Northwind.dbo.Customers c
ON dc.CustomerID = c.CustomerID
WHERE dc.EndDate IS NULL AND (dc.CompanyName <> c.CompanyName OR dc.City <> c.city OR dc.Region <> c.region OR dc.country <> c.country)

-- Change the EndDate of those records which contain old values to yesterday  
DECLARE @yesterday DATETIME = (SELECT DATEADD(day, -1, GETDATE()))

UPDATE NorthwindDWH.dbo.DimCustomer 
SET EndDate = @yesterday
WHERE customerKey IN (SELECT CustomerKey FROM #CustomerTempTable)

-- Insert these records (from the temporary table) into NorthwindDWH.dbo.DimCustomer. 
-- Use Today as StartDate.
INSERT INTO NorthwindDWH.dbo.DimCustomer(CustomerID, CompanyName, City, Region, Country, StartDate)
SELECT CustomerID, CompanyName, City, Region, Country, GETDATE()
FROM #CustomerTempTable

DROP TABLE #CustomerTempTable 

-- Insert the entirely new customers from Northwind.dbo.Customers into DimCustomer. 
-- This will also make sure that DimCustomer get’s filled for the first time (if it was still empty)
-- If DimCustomer was empty => Startdate is the minimum date of Orders for the newly inserted records
DECLARE @StartDate DATETIME = (SELECT MIN(OrderDate) FROM Northwind.dbo.Orders)

-- If DimCustomer already contains values => Startdate = today for the newly inserted records
IF EXISTS (SELECT * FROM DimCustomer)
	SET @StartDate = GETDATE()

INSERT INTO DimCustomer(CustomerID, CompanyName, City, Region, Country, StartDate)
SELECT CustomerID, CompanyName, City, Region, Country, @StartDate
FROM Northwind.dbo.Customers 
WHERE CustomerID NOT IN (SELECT DISTINCT CustomerID FROM NorthwindDWH.dbo.DimCustomer)


END


GO;




CREATE OR ALTER PROCEDURE UpdateFactSales
AS
BEGIN
INSERT INTO NorthwindDWH.dbo.FactSales(OrderLine, ProductKey, CustomerKey, OrderDateKey, OrderUnitPrice, OrderQuantity, OrderDiscount)
SELECT od.OrderID, od.productID, dc.CustomerKey, CAST(FORMAT(o.OrderDate,'yyyyMMdd') as int), od.UnitPrice, od.Quantity, od.Discount
from Northwind.dbo.OrderDetails od JOIN Northwind.dbo.Orders o ON od.OrderID = o.OrderID
join NorthwindDWH.dbo.DimCustomer dc on o.CustomerID = dc.CustomerID
WHERE 
/* Slowly Changing Dimension dimCustomer */
o.OrderDate >= dc.startDate and (dc.EndDate is null or o.orderdate <= dc.EndDate)
AND
/* only add new lines + make sure it runs from an empty FactSales table */
o.OrderID > (SELECT ISNULL(MAX(OrderLine),0) from NorthwindDWH.dbo.FactSales)
END


CREATE OR ALTER PROCEDURE UpdateDWH
AS
BEGIN
EXEC CheckAndUpdateDimDate

EXEC CheckAndUpdateDimProduct

EXEC CheckAndUpdateDimCustomer

EXEC UpdateFactSales
END


