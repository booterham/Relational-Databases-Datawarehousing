IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'NorthwindDWH')
BEGIN
  CREATE DATABASE NorthwindDWH;
END;
GO

USE [NorthwindDWH]

CREATE TABLE [dbo].[DimCustomer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[CustomerID] [nchar](5) NULL,
	[CompanyName] [nvarchar](40) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[Country] [nvarchar](15) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL
) 

CREATE TABLE [dbo].[DimDate](
	[DateKey] [int] NOT NULL PRIMARY KEY,
	[FullDateAlternateKey] [date] NOT NULL,
	[DayOfMonth] [varchar](2) NULL,
	[EnglishDayNameOfWeek] [varchar](10) NOT NULL,
	[DutchDayNameOfWeek] [varchar](10) NOT NULL,
	[DayOfWeek] [char](1) NULL,
	[DayOfWeekInMonth] [varchar](2) NULL,
	[DayOfWeekInYear] [varchar](2) NULL,
	[DayOfQuarter] [varchar](3) NULL,
	[DayOfYear] [varchar](3) NULL,
	[WeekOfMonth] [varchar](1) NULL,
	[WeekOfQuarter] [varchar](2) NULL,
	[WeekOfYear] [varchar](2) NULL,
	[Month] [varchar](2) NULL,
	[EnglishMonthName] [varchar](10) NOT NULL,
	[DutchMonthName] [varchar](10) NOT NULL,
	[MonthOfQuarter] [varchar](2) NULL,
	[Quarter] [char](1) NULL,
	[QuarterName] [varchar](9) NULL,
	[Year] [char](4) NULL,
	[MonthYear] [char](10) NULL,
	[MMYYYY] [char](6) NULL
) 

CREATE TABLE [dbo].[DimProduct](
	[ProductKey] [int] NOT NULL PRIMARY KEY,
	[ProductName] [nvarchar](40) NULL,
	[CategoryName] [nvarchar](15) NULL,
	[QuantityPerUnit] [nvarchar](20) NULL,
	[UnitPrice] [money] NULL,
) 

CREATE TABLE [dbo].[FactSales](
	[OrderLine] [int] NOT NULL,
	[ProductKey] [int] NOT NULL REFERENCES DimProduct (ProductKey),
	[CustomerKey] [int] NOT NULL REFERENCES DimCustomer (CustomerKey),
	[OrderDateKey] [int] NOT NULL  REFERENCES DimDate (DateKey),
	[OrderUnitPrice] [money] NOT NULL,
	[OrderQuantity] [smallint] NOT NULL,
	[OrderDiscount] [real] NOT NULL,
 CONSTRAINT [PK_FactSales] PRIMARY KEY CLUSTERED 
(
	[OrderLine] ASC,
	[ProductKey] ASC
)
) 
