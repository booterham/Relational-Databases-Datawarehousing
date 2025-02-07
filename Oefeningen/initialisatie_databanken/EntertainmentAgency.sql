CREATE DATABASE [EntertainmentAgency]
GO

USE [EntertainmentAgency]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[AgentID] [int] IDENTITY(1,1) NOT NULL,
	[AgtFirstName] [varchar](25) NULL,
	[AgtLastName] [varchar](25) NULL,
	[AgtStreetAddress] [varchar](50) NULL,
	[AgtCity] [varchar](30) NULL,
	[AgtState] [varchar](2) NULL,
	[AgtZipCode] [varchar](10) NULL,
	[AgtPhoneNumber] [varchar](15) NULL,
	[DateHired] [date] NULL,
	[Salary] [money] NULL,
	[CommissionRate] [real] NULL,
 CONSTRAINT [Agents_PK] PRIMARY KEY CLUSTERED 
(
	[AgentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[CustFirstName] [varchar](25) NULL,
	[CustLastName] [varchar](25) NULL,
	[CustStreetAddress] [varchar](50) NULL,
	[CustCity] [varchar](30) NULL,
	[CustState] [varchar](2) NULL,
	[CustZipCode] [varchar](10) NULL,
	[CustPhoneNumber] [varchar](15) NULL,
 CONSTRAINT [Customers_PK] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Engagements]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Engagements](
	[EngagementNumber] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[StartTime] [time](7) NULL,
	[StopTime] [time](7) NULL,
	[ContractPrice] [money] NULL,
	[CustomerID] [int] NULL,
	[AgentID] [int] NULL,
	[EntertainerID] [int] NULL,
 CONSTRAINT [Engagements_PK] PRIMARY KEY CLUSTERED 
(
	[EngagementNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entertainer_Members]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entertainer_Members](
	[EntertainerID] [int] NOT NULL,
	[MemberID] [int] NOT NULL,
	[Status] [smallint] NULL,
 CONSTRAINT [Entertainer_Members_PK] PRIMARY KEY CLUSTERED 
(
	[EntertainerID] ASC,
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entertainer_Styles]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entertainer_Styles](
	[EntertainerID] [int] NOT NULL,
	[StyleID] [int] NOT NULL,
	[StyleStrength] [smallint] NOT NULL,
 CONSTRAINT [Entertainer_Styles_PK] PRIMARY KEY CLUSTERED 
(
	[EntertainerID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Entertainers]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Entertainers](
	[EntertainerID] [int] IDENTITY(1,1) NOT NULL,
	[EntStageName] [varchar](50) NULL,
	[EntSSN] [varchar](12) NULL,
	[EntStreetAddress] [varchar](50) NULL,
	[EntCity] [varchar](30) NULL,
	[EntState] [varchar](2) NULL,
	[EntZipCode] [varchar](10) NULL,
	[EntPhoneNumber] [varchar](15) NULL,
	[EntWebPage] [varchar](50) NULL,
	[EntEMailAddress] [varchar](50) NULL,
	[DateEntered] [date] NULL,
	[EntPricePerDay] [money] NULL,
 CONSTRAINT [Entertainers_PK] PRIMARY KEY CLUSTERED 
(
	[EntertainerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Members]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[MemberID] [int] IDENTITY(1,1) NOT NULL,
	[MbrFirstName] [varchar](25) NULL,
	[MbrLastName] [varchar](25) NULL,
	[MbrPhoneNumber] [varchar](15) NULL,
	[Gender] [varchar](2) NULL,
 CONSTRAINT [Members_PK] PRIMARY KEY CLUSTERED 
(
	[MemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Musical_Preferences]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musical_Preferences](
	[CustomerID] [int] NOT NULL,
	[StyleID] [int] NOT NULL,
	[PreferenceSeq] [smallint] NOT NULL,
 CONSTRAINT [Musical_Preferences_PK] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC,
	[StyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Musical_Styles]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Musical_Styles](
	[StyleID] [int] IDENTITY(1,1) NOT NULL,
	[StyleName] [varchar](75) NULL,
 CONSTRAINT [Musical_Styles_PK] PRIMARY KEY CLUSTERED 
(
	[StyleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ztblDays]    Script Date: 23/09/2022 20:49:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ztblDays](
	[DateField] [date] NOT NULL
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Agents] ON 

INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (1, N'William', N'Thompson', N'122 Spring River Drive', N'Redmond', N'WA', N'98053', N'555-2681', CAST(N'1997-05-15' AS Date), 35000.0000, 0.04)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (2, N'Scott', N'Johnson', N'66 Spring Valley Drive', N'Seattle', N'WA', N'98125', N'555-2666', CAST(N'1998-02-05' AS Date), 27000.0000, 0.04)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (3, N'Carol', N'Viescas', N'667 Red River Road', N'Bellevue', N'WA', N'98006', N'555-2571', CAST(N'1997-11-19' AS Date), 30000.0000, 0.05)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (4, N'Karen', N'Smith', N'30301 - 166th Ave. N.E.', N'Seattle', N'WA', N'98125', N'555-2551', CAST(N'1998-03-05' AS Date), 22000.0000, 0.055)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (5, N'Marianne', N'Davidson', N'908 W. Capital Way', N'Tacoma', N'WA', N'98413', N'555-2606', CAST(N'1998-02-02' AS Date), 24500.0000, 0.045)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (6, N'John', N'Kennedy', N'16679 NE 41st Court', N'Seattle', N'WA', N'98125', N'555-2621', CAST(N'1997-05-15' AS Date), 33000.0000, 0.06)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (7, N'Caleb', N'Viescas', N'4501 Wetland Road', N'Redmond', N'WA', N'98052', N'555-0037', CAST(N'1998-02-16' AS Date), 22100.0000, 0.035)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (8, N'Maria', N'Patterson', N'3445 Cheyenne Road', N'Bellevue', N'WA', N'98006', N'555-2291', CAST(N'1997-09-03' AS Date), 30000.0000, 0.04)
INSERT [dbo].[Agents] ([AgentID], [AgtFirstName], [AgtLastName], [AgtStreetAddress], [AgtCity], [AgtState], [AgtZipCode], [AgtPhoneNumber], [DateHired], [Salary], [CommissionRate]) VALUES (9, N'Daffy', N'Dumbwit', N'1234 Main Street', N'Kirkland', N'WA', N'98033', N'555-1234', CAST(N'2000-02-05' AS Date), 50.0000, 0.01)
SET IDENTITY_INSERT [dbo].[Agents] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10001, N'Doug', N'Steele', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'555-2671')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10002, N'Deb', N'Smith', N'908 W. Capital Way', N'Tacoma', N'WA', N'98413', N'555-2496')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10003, N'Ben', N'Clothier', N'722 Moss Bay Blvd.', N'Kirkland', N'WA', N'98033', N'555-2501')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10004, N'Tom', N'Wickerath', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'555-2506')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10005, N'Elizabeth', N'Hallmark', N'Route 2, Box 203B', N'Auburn', N'WA', N'98002', N'555-2521')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10006, N'Matt', N'Johnson', N'908 W. Capital Way', N'Tacoma', N'WA', N'98413', N'555-2581')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10007, N'Liz', N'Smith', N'13920 S.E. 40th Street', N'Bellevue', N'WA', N'98006', N'555-2556')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10008, N'Darren', N'Davidson', N'2601 Seaview Lane', N'Kirkland', N'WA', N'98033', N'555-2616')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10009, N'Sarah', N'Thompson', N'2222 Springer Road', N'Bellevue', N'WA', N'98006', N'555-2626')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10010, N'Zachary', N'Johnson', N'12330 Kingman Drive', N'Kirkland', N'WA', N'98033', N'555-2721')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10011, N'Joyce', N'Smith', N'2424 Thames Drive', N'Bellevue', N'WA', N'98006', N'555-2726')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10012, N'Kerry', N'Patterson', N'777 Fenexet Blvd', N'Redmond', N'WA', N'98052', N'555-0399')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10013, N'Louise', N'Johnson', N'2500 Rosales Lane', N'Bellevue', N'WA', N'98006', N'555-9938')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10014, N'Mark', N'Davison', N'323 Advocate Lane', N'Bellevue', N'WA', N'98006', N'555-2286')
INSERT [dbo].[Customers] ([CustomerID], [CustFirstName], [CustLastName], [CustStreetAddress], [CustCity], [CustState], [CustZipCode], [CustPhoneNumber]) VALUES (10015, N'Carol', N'Viescas', N'754 Fourth Ave', N'Beverly Hills', N'CA', N'90210', N'555-2296')
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[Engagements] ON 

INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (2, CAST(N'2015-09-01' AS Date), CAST(N'2015-09-05' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 200.0000, 10006, 4, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (3, CAST(N'2015-09-10' AS Date), CAST(N'2015-09-15' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 590.0000, 10001, 3, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (4, CAST(N'2015-09-11' AS Date), CAST(N'2015-09-17' AS Date), CAST(N'20:00:00' AS Time), CAST(N'00:00:00' AS Time), 470.0000, 10007, 3, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (5, CAST(N'2015-09-11' AS Date), CAST(N'2015-09-14' AS Date), CAST(N'16:00:00' AS Time), CAST(N'19:00:00' AS Time), 1130.0000, 10006, 5, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (6, CAST(N'2015-09-10' AS Date), CAST(N'2015-09-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'21:00:00' AS Time), 2300.0000, 10014, 7, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (7, CAST(N'2015-09-11' AS Date), CAST(N'2015-09-18' AS Date), CAST(N'17:00:00' AS Time), CAST(N'20:00:00' AS Time), 770.0000, 10004, 4, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (8, CAST(N'2015-09-18' AS Date), CAST(N'2015-09-25' AS Date), CAST(N'20:00:00' AS Time), CAST(N'23:00:00' AS Time), 1850.0000, 10006, 3, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (9, CAST(N'2015-09-18' AS Date), CAST(N'2015-09-28' AS Date), CAST(N'19:00:00' AS Time), CAST(N'21:00:00' AS Time), 1370.0000, 10010, 2, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (10, CAST(N'2015-09-17' AS Date), CAST(N'2015-09-26' AS Date), CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), 3650.0000, 10005, 3, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (11, CAST(N'2015-09-15' AS Date), CAST(N'2015-09-16' AS Date), CAST(N'18:00:00' AS Time), CAST(N'00:00:00' AS Time), 950.0000, 10005, 4, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (12, CAST(N'2015-09-18' AS Date), CAST(N'2015-09-26' AS Date), CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time), 1670.0000, 10014, 8, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (13, CAST(N'2015-09-17' AS Date), CAST(N'2015-09-20' AS Date), CAST(N'20:00:00' AS Time), CAST(N'23:00:00' AS Time), 770.0000, 10003, 1, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (14, CAST(N'2015-09-24' AS Date), CAST(N'2015-09-29' AS Date), CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time), 2750.0000, 10001, 1, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (15, CAST(N'2015-09-24' AS Date), CAST(N'2015-09-29' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 770.0000, 10007, 1, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (16, CAST(N'2015-10-02' AS Date), CAST(N'2015-10-06' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 1550.0000, 10010, 5, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (17, CAST(N'2015-09-29' AS Date), CAST(N'2015-10-02' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 530.0000, 10002, 8, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (19, CAST(N'2015-09-29' AS Date), CAST(N'2015-10-05' AS Date), CAST(N'20:00:00' AS Time), CAST(N'23:00:00' AS Time), 365.0000, 10009, 8, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (21, CAST(N'2015-09-30' AS Date), CAST(N'2015-10-03' AS Date), CAST(N'12:00:00' AS Time), CAST(N'16:00:00' AS Time), 1490.0000, 10005, 1, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (22, CAST(N'2015-09-30' AS Date), CAST(N'2015-10-05' AS Date), CAST(N'12:00:00' AS Time), CAST(N'15:00:00' AS Time), 590.0000, 10004, 5, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (23, CAST(N'2015-09-30' AS Date), CAST(N'2015-09-30' AS Date), CAST(N'20:00:00' AS Time), CAST(N'00:00:00' AS Time), 290.0000, 10012, 4, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (24, CAST(N'2015-10-01' AS Date), CAST(N'2015-10-07' AS Date), CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time), 1940.0000, 10001, 4, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (26, CAST(N'2015-10-09' AS Date), CAST(N'2015-10-14' AS Date), CAST(N'17:00:00' AS Time), CAST(N'22:00:00' AS Time), 950.0000, 10001, 6, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (27, CAST(N'2015-10-07' AS Date), CAST(N'2015-10-12' AS Date), CAST(N'12:00:00' AS Time), CAST(N'16:00:00' AS Time), 2210.0000, 10015, 7, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (28, CAST(N'2015-10-06' AS Date), CAST(N'2015-10-15' AS Date), CAST(N'17:00:00' AS Time), CAST(N'22:00:00' AS Time), 3800.0000, 10003, 4, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (30, CAST(N'2015-10-06' AS Date), CAST(N'2015-10-08' AS Date), CAST(N'17:00:00' AS Time), CAST(N'22:00:00' AS Time), 275.0000, 10009, 5, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (31, CAST(N'2015-10-07' AS Date), CAST(N'2015-10-16' AS Date), CAST(N'16:00:00' AS Time), CAST(N'20:00:00' AS Time), 2450.0000, 10002, 8, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (32, CAST(N'2015-10-07' AS Date), CAST(N'2015-10-16' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1250.0000, 10010, 7, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (34, CAST(N'2015-10-14' AS Date), CAST(N'2015-10-20' AS Date), CAST(N'16:00:00' AS Time), CAST(N'18:00:00' AS Time), 680.0000, 10004, 8, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (35, CAST(N'2015-10-14' AS Date), CAST(N'2015-10-15' AS Date), CAST(N'19:00:00' AS Time), CAST(N'23:00:00' AS Time), 410.0000, 10005, 8, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (36, CAST(N'2015-10-13' AS Date), CAST(N'2015-10-23' AS Date), CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time), 710.0000, 10014, 3, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (37, CAST(N'2015-10-13' AS Date), CAST(N'2015-10-19' AS Date), CAST(N'14:00:00' AS Time), CAST(N'19:00:00' AS Time), 2675.0000, 10006, 3, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (38, CAST(N'2015-10-14' AS Date), CAST(N'2015-10-18' AS Date), CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time), 1850.0000, 10013, 4, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (41, CAST(N'2015-10-20' AS Date), CAST(N'2015-10-28' AS Date), CAST(N'18:00:00' AS Time), CAST(N'21:00:00' AS Time), 860.0000, 10013, 3, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (42, CAST(N'2015-10-20' AS Date), CAST(N'2015-10-26' AS Date), CAST(N'17:00:00' AS Time), CAST(N'22:00:00' AS Time), 2150.0000, 10002, 1, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (43, CAST(N'2015-10-21' AS Date), CAST(N'2015-10-21' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 140.0000, 10001, 8, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (44, CAST(N'2015-10-22' AS Date), CAST(N'2015-10-26' AS Date), CAST(N'14:00:00' AS Time), CAST(N'19:00:00' AS Time), 1925.0000, 10006, 3, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (45, CAST(N'2015-10-21' AS Date), CAST(N'2015-10-28' AS Date), CAST(N'14:00:00' AS Time), CAST(N'18:00:00' AS Time), 530.0000, 10015, 1, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (46, CAST(N'2015-10-28' AS Date), CAST(N'2015-11-05' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1400.0000, 10009, 4, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (48, CAST(N'2015-11-05' AS Date), CAST(N'2015-11-06' AS Date), CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time), 950.0000, 10002, 1, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (49, CAST(N'2015-11-13' AS Date), CAST(N'2015-11-19' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 680.0000, 10014, 5, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (51, CAST(N'2015-11-13' AS Date), CAST(N'2015-11-14' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 650.0000, 10013, 3, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (52, CAST(N'2015-11-13' AS Date), CAST(N'2015-11-14' AS Date), CAST(N'16:00:00' AS Time), CAST(N'21:00:00' AS Time), 650.0000, 10010, 3, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (53, CAST(N'2015-11-11' AS Date), CAST(N'2015-11-12' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 350.0000, 10002, 5, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (55, CAST(N'2015-11-19' AS Date), CAST(N'2015-11-26' AS Date), CAST(N'20:00:00' AS Time), CAST(N'02:00:00' AS Time), 770.0000, 10002, 3, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (56, CAST(N'2015-11-25' AS Date), CAST(N'2015-11-28' AS Date), CAST(N'14:00:00' AS Time), CAST(N'19:00:00' AS Time), 1550.0000, 10010, 3, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (58, CAST(N'2015-12-01' AS Date), CAST(N'2015-12-04' AS Date), CAST(N'17:00:00' AS Time), CAST(N'23:00:00' AS Time), 770.0000, 10001, 2, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (59, CAST(N'2015-12-01' AS Date), CAST(N'2015-12-04' AS Date), CAST(N'15:00:00' AS Time), CAST(N'19:00:00' AS Time), 290.0000, 10004, 6, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (60, CAST(N'2015-12-02' AS Date), CAST(N'2015-12-04' AS Date), CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), 230.0000, 10010, 8, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (61, CAST(N'2015-12-03' AS Date), CAST(N'2015-12-10' AS Date), CAST(N'17:00:00' AS Time), CAST(N'20:00:00' AS Time), 410.0000, 10015, 8, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (62, CAST(N'2015-12-09' AS Date), CAST(N'2015-12-10' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 500.0000, 10003, 2, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (63, CAST(N'2015-12-18' AS Date), CAST(N'2015-12-21' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 650.0000, 10009, 3, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (64, CAST(N'2015-12-25' AS Date), CAST(N'2016-01-03' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 1250.0000, 10007, 3, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (66, CAST(N'2015-12-22' AS Date), CAST(N'2015-12-29' AS Date), CAST(N'20:00:00' AS Time), CAST(N'02:00:00' AS Time), 2930.0000, 10005, 5, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (68, CAST(N'2015-12-24' AS Date), CAST(N'2015-12-29' AS Date), CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time), 1670.0000, 10009, 1, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (69, CAST(N'2015-12-22' AS Date), CAST(N'2015-12-23' AS Date), CAST(N'15:00:00' AS Time), CAST(N'18:00:00' AS Time), 500.0000, 10004, 7, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (70, CAST(N'2015-12-23' AS Date), CAST(N'2015-12-26' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 410.0000, 10010, 6, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (71, CAST(N'2015-12-22' AS Date), CAST(N'2015-12-27' AS Date), CAST(N'14:00:00' AS Time), CAST(N'17:00:00' AS Time), 1670.0000, 10002, 1, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (72, CAST(N'2015-12-22' AS Date), CAST(N'2016-01-01' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 875.0000, 10012, 4, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (73, CAST(N'2015-12-29' AS Date), CAST(N'2016-01-07' AS Date), CAST(N'19:00:00' AS Time), CAST(N'22:00:00' AS Time), 1400.0000, 10014, 5, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (74, CAST(N'2016-01-01' AS Date), CAST(N'2016-01-06' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 590.0000, 10004, 1, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (75, CAST(N'2016-01-01' AS Date), CAST(N'2016-01-11' AS Date), CAST(N'17:00:00' AS Time), CAST(N'20:00:00' AS Time), 2525.0000, 10001, 7, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (76, CAST(N'2015-12-30' AS Date), CAST(N'2016-01-03' AS Date), CAST(N'16:00:00' AS Time), CAST(N'22:00:00' AS Time), 500.0000, 10005, 7, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (77, CAST(N'2015-12-30' AS Date), CAST(N'2016-01-04' AS Date), CAST(N'17:00:00' AS Time), CAST(N'20:00:00' AS Time), 1670.0000, 10015, 5, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (78, CAST(N'2016-01-01' AS Date), CAST(N'2016-01-03' AS Date), CAST(N'16:00:00' AS Time), CAST(N'20:00:00' AS Time), 770.0000, 10010, 4, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (79, CAST(N'2015-12-30' AS Date), CAST(N'2016-01-03' AS Date), CAST(N'12:00:00' AS Time), CAST(N'17:00:00' AS Time), 1550.0000, 10006, 8, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (80, CAST(N'2015-12-31' AS Date), CAST(N'2016-01-01' AS Date), CAST(N'17:00:00' AS Time), CAST(N'21:00:00' AS Time), 650.0000, 10002, 5, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (81, CAST(N'2016-01-01' AS Date), CAST(N'2016-01-09' AS Date), CAST(N'13:00:00' AS Time), CAST(N'17:00:00' AS Time), 1130.0000, 10013, 4, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (82, CAST(N'2016-01-08' AS Date), CAST(N'2016-01-09' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 950.0000, 10014, 8, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (83, CAST(N'2016-01-06' AS Date), CAST(N'2016-01-10' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 650.0000, 10010, 2, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (84, CAST(N'2016-01-06' AS Date), CAST(N'2016-01-11' AS Date), CAST(N'17:00:00' AS Time), CAST(N'19:00:00' AS Time), 230.0000, 10007, 3, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (85, CAST(N'2016-01-06' AS Date), CAST(N'2016-01-08' AS Date), CAST(N'14:00:00' AS Time), CAST(N'19:00:00' AS Time), 1175.0000, 10015, 4, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (87, CAST(N'2016-01-04' AS Date), CAST(N'2016-01-06' AS Date), CAST(N'16:00:00' AS Time), CAST(N'19:00:00' AS Time), 275.0000, 10007, 6, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (88, CAST(N'2016-01-07' AS Date), CAST(N'2016-01-17' AS Date), CAST(N'12:00:00' AS Time), CAST(N'14:00:00' AS Time), 1370.0000, 10004, 8, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (89, CAST(N'2016-01-06' AS Date), CAST(N'2016-01-07' AS Date), CAST(N'14:00:00' AS Time), CAST(N'16:00:00' AS Time), 290.0000, 10003, 8, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (90, CAST(N'2016-01-08' AS Date), CAST(N'2016-01-08' AS Date), CAST(N'20:00:00' AS Time), CAST(N'02:00:00' AS Time), 320.0000, 10006, 5, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (91, CAST(N'2016-01-05' AS Date), CAST(N'2016-01-12' AS Date), CAST(N'13:00:00' AS Time), CAST(N'19:00:00' AS Time), 770.0000, 10009, 3, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (92, CAST(N'2016-01-12' AS Date), CAST(N'2016-01-16' AS Date), CAST(N'19:00:00' AS Time), CAST(N'00:00:00' AS Time), 1925.0000, 10012, 6, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (95, CAST(N'2016-01-15' AS Date), CAST(N'2016-01-18' AS Date), CAST(N'20:00:00' AS Time), CAST(N'01:00:00' AS Time), 1550.0000, 10010, 6, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (96, CAST(N'2016-01-22' AS Date), CAST(N'2016-01-31' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 950.0000, 10009, 6, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (97, CAST(N'2016-01-19' AS Date), CAST(N'2016-01-19' AS Date), CAST(N'17:00:00' AS Time), CAST(N'21:00:00' AS Time), 110.0000, 10012, 8, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (98, CAST(N'2016-01-20' AS Date), CAST(N'2016-01-27' AS Date), CAST(N'20:00:00' AS Time), CAST(N'02:00:00' AS Time), 2930.0000, 10012, 2, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (99, CAST(N'2016-01-22' AS Date), CAST(N'2016-02-22' AS Date), CAST(N'14:00:00' AS Time), CAST(N'20:00:00' AS Time), 14105.0000, 10005, 6, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (100, CAST(N'2016-01-19' AS Date), CAST(N'2016-01-23' AS Date), CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time), 1850.0000, 10015, 3, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (101, CAST(N'2016-01-22' AS Date), CAST(N'2016-01-30' AS Date), CAST(N'14:00:00' AS Time), CAST(N'18:00:00' AS Time), 1670.0000, 10004, 5, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (102, CAST(N'2016-01-22' AS Date), CAST(N'2016-01-31' AS Date), CAST(N'12:00:00' AS Time), CAST(N'15:00:00' AS Time), 2300.0000, 10013, 5, 1007)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (103, CAST(N'2016-01-21' AS Date), CAST(N'2016-01-27' AS Date), CAST(N'12:00:00' AS Time), CAST(N'17:00:00' AS Time), 575.0000, 10010, 4, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (104, CAST(N'2016-01-28' AS Date), CAST(N'2016-02-01' AS Date), CAST(N'13:00:00' AS Time), CAST(N'16:00:00' AS Time), 1400.0000, 10010, 6, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (105, CAST(N'2016-01-27' AS Date), CAST(N'2016-02-01' AS Date), CAST(N'12:00:00' AS Time), CAST(N'17:00:00' AS Time), 1850.0000, 10002, 4, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (106, CAST(N'2016-01-29' AS Date), CAST(N'2016-02-01' AS Date), CAST(N'15:00:00' AS Time), CAST(N'18:00:00' AS Time), 770.0000, 10003, 6, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (107, CAST(N'2016-01-29' AS Date), CAST(N'2016-01-30' AS Date), CAST(N'16:00:00' AS Time), CAST(N'21:00:00' AS Time), 200.0000, 10007, 4, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (108, CAST(N'2016-02-02' AS Date), CAST(N'2016-02-04' AS Date), CAST(N'18:00:00' AS Time), CAST(N'00:00:00' AS Time), 320.0000, 10004, 5, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (109, CAST(N'2016-02-11' AS Date), CAST(N'2016-02-15' AS Date), CAST(N'13:00:00' AS Time), CAST(N'19:00:00' AS Time), 1850.0000, 10014, 5, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (110, CAST(N'2016-02-11' AS Date), CAST(N'2016-02-19' AS Date), CAST(N'15:00:00' AS Time), CAST(N'19:00:00' AS Time), 1670.0000, 10006, 8, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (111, CAST(N'2016-02-12' AS Date), CAST(N'2016-02-14' AS Date), CAST(N'15:00:00' AS Time), CAST(N'18:00:00' AS Time), 185.0000, 10012, 1, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (112, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-24' AS Date), CAST(N'18:00:00' AS Time), CAST(N'22:00:00' AS Time), 410.0000, 10015, 7, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (114, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'12:00:00' AS Time), CAST(N'17:00:00' AS Time), 1550.0000, 10005, 1, 1002)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (115, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-22' AS Date), CAST(N'12:00:00' AS Time), CAST(N'18:00:00' AS Time), 1490.0000, 10007, 5, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (116, CAST(N'2016-02-16' AS Date), CAST(N'2016-02-25' AS Date), CAST(N'14:00:00' AS Time), CAST(N'19:00:00' AS Time), 800.0000, 10003, 6, 1012)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (118, CAST(N'2016-02-18' AS Date), CAST(N'2016-02-18' AS Date), CAST(N'19:00:00' AS Time), CAST(N'00:00:00' AS Time), 350.0000, 10014, 1, 1010)
GO
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (119, CAST(N'2016-02-19' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'18:00:00' AS Time), CAST(N'21:00:00' AS Time), 500.0000, 10012, 2, 1004)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (120, CAST(N'2016-02-17' AS Date), CAST(N'2016-02-20' AS Date), CAST(N'20:00:00' AS Time), CAST(N'23:00:00' AS Time), 950.0000, 10002, 7, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (121, CAST(N'2016-02-16' AS Date), CAST(N'2016-02-22' AS Date), CAST(N'17:00:00' AS Time), CAST(N'23:00:00' AS Time), 2570.0000, 10004, 3, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (122, CAST(N'2016-02-24' AS Date), CAST(N'2016-02-27' AS Date), CAST(N'15:00:00' AS Time), CAST(N'19:00:00' AS Time), 1010.0000, 10014, 5, 1010)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (123, CAST(N'2016-02-25' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'16:00:00' AS Time), CAST(N'20:00:00' AS Time), 770.0000, 10013, 1, 1001)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (124, CAST(N'2016-02-23' AS Date), CAST(N'2016-03-02' AS Date), CAST(N'14:00:00' AS Time), CAST(N'17:00:00' AS Time), 1850.0000, 10006, 1, 1008)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (125, CAST(N'2016-02-23' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'13:00:00' AS Time), CAST(N'15:00:00' AS Time), 1130.0000, 10001, 3, 1003)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (126, CAST(N'2016-02-24' AS Date), CAST(N'2016-03-03' AS Date), CAST(N'18:00:00' AS Time), CAST(N'20:00:00' AS Time), 1010.0000, 10009, 6, 1006)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (127, CAST(N'2016-02-24' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'20:00:00' AS Time), CAST(N'22:00:00' AS Time), 500.0000, 10010, 4, 1005)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (128, CAST(N'2016-02-26' AS Date), CAST(N'2016-02-28' AS Date), CAST(N'19:00:00' AS Time), CAST(N'01:00:00' AS Time), 320.0000, 10003, 4, 1011)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (129, CAST(N'2016-02-24' AS Date), CAST(N'2016-03-05' AS Date), CAST(N'17:00:00' AS Time), CAST(N'21:00:00' AS Time), 2450.0000, 10004, 5, 1013)
INSERT [dbo].[Engagements] ([EngagementNumber], [StartDate], [EndDate], [StartTime], [StopTime], [ContractPrice], [CustomerID], [AgentID], [EntertainerID]) VALUES (131, CAST(N'2016-03-03' AS Date), CAST(N'2016-03-12' AS Date), CAST(N'15:00:00' AS Time), CAST(N'17:00:00' AS Time), 1850.0000, 10014, 1, 1003)
SET IDENTITY_INSERT [dbo].[Engagements] OFF
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1001, 106, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1001, 107, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1001, 118, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1002, 120, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1002, 121, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 102, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 103, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 104, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 109, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 117, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1003, 119, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1004, 125, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1005, 116, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1005, 120, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1005, 121, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1006, 104, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1006, 113, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1006, 118, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1006, 120, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1007, 101, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1007, 102, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1007, 105, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1007, 107, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1007, 110, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1008, 103, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1008, 105, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1008, 111, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1008, 114, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1008, 115, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1009, 121, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1010, 108, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1010, 112, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1010, 123, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1010, 124, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1011, 122, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1012, 123, 2)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1013, 112, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1013, 114, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1013, 117, 1)
INSERT [dbo].[Entertainer_Members] ([EntertainerID], [MemberID], [Status]) VALUES (1013, 124, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1001, 10, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1001, 20, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1001, 21, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1002, 17, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1002, 19, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1002, 23, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1003, 3, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1003, 8, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1004, 13, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1005, 15, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1005, 19, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1005, 24, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1006, 22, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1006, 23, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1006, 24, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1007, 6, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1007, 11, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1008, 3, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1008, 6, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1009, 7, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1009, 14, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1009, 21, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1010, 4, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1010, 21, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1010, 22, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1011, 7, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1011, 14, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1011, 20, 3)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1012, 7, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1012, 13, 1)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1013, 10, 2)
INSERT [dbo].[Entertainer_Styles] ([EntertainerID], [StyleID], [StyleStrength]) VALUES (1013, 15, 1)
SET IDENTITY_INSERT [dbo].[Entertainers] ON 

INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1001, N'Carol Peacock Trio', N'888-90-1121', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'555-2691', N'www.cptrio.com', N'carolp@cptrio.com', CAST(N'1997-05-24' AS Date), 175.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1002, N'Topazz', N'888-50-1061', N'16 Maple Lane', N'Auburn', N'WA', N'98002', N'555-2591', N'www.topazz.com', NULL, CAST(N'1996-02-14' AS Date), 120.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1003, N'JV & the Deep Six', N'888-18-1013', N'15127 NE 24th, #383', N'Redmond', N'WA', N'98052', N'555-2511', N'www.jvd6.com', N'jv@myspring.com', CAST(N'1998-03-18' AS Date), 275.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1004, N'Jim Glynn', N'888-26-1025', N'13920 S.E. 40th Street', N'Bellevue', N'WA', N'98009', N'555-2531', NULL, NULL, CAST(N'1996-04-01' AS Date), 60.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1005, N'Jazz Persuasion', N'888-30-1031', N'233 West Valley Hwy', N'Bellevue', N'WA', N'98005', N'555-2541', N'www.jazzper.com', NULL, CAST(N'1997-05-12' AS Date), 125.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1006, N'Modern Dance', N'888-66-1085', N'Route 2, Box 203B', N'Woodinville', N'WA', N'98072', N'555-2631', N'www.moderndance.com', N'mikeh@moderndance.com', CAST(N'1995-05-16' AS Date), 250.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1007, N'Coldwater Cattle Company', N'888-38-1043', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'555-2561', N'www.coldwatercows.com', NULL, CAST(N'1995-11-30' AS Date), 275.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1008, N'Country Feeling', N'888-98-1133', N'PO Box 223311', N'Seattle', N'WA', N'98125', N'555-2711', NULL, NULL, CAST(N'1996-02-28' AS Date), 280.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1009, N'Katherine Ehrlich', N'888-61-1103', N'777 Fenexet Blvd', N'Woodinville', N'WA', N'98072', N'555-0399', NULL, N'ke@mzo.com', CAST(N'1998-09-13' AS Date), 145.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1010, N'Saturday Revue', N'888-64-1109', N'3887 Easy Street', N'Seattle', N'WA', N'98125', N'555-0039', N'www.satrevue.com', N'edz@coolness.com', CAST(N'1995-01-20' AS Date), 250.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1011, N'Julia Schnebly', N'888-65-1111', N'2343 Harmony Lane', N'Seattle', N'WA', N'99837', N'555-9936', NULL, NULL, CAST(N'1996-04-12' AS Date), 90.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1012, N'Susan McLain', N'888-70-1121', N'511 Lenora Ave', N'Bellevue', N'WA', N'98006', N'555-2301', N'www.greensleeves.com', N'susan@gs.com', CAST(N'1998-10-12' AS Date), 75.0000)
INSERT [dbo].[Entertainers] ([EntertainerID], [EntStageName], [EntSSN], [EntStreetAddress], [EntCity], [EntState], [EntZipCode], [EntPhoneNumber], [EntWebPage], [EntEMailAddress], [DateEntered], [EntPricePerDay]) VALUES (1013, N'Caroline Coie Cuartet', N'888-71-1123', N'298 Forest Lane', N'Auburn', N'WA', N'98002', N'555-2306', NULL, N'carolinec@willow.com', CAST(N'1997-07-11' AS Date), 250.0000)
SET IDENTITY_INSERT [dbo].[Entertainers] OFF
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (101, N'David', N'Smith', N'555-2701', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (102, N'Suzanne', N'Viescas', N'555-2686', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (103, N'Gary', N'Hallmark', N'555-2676', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (104, N'Jeffrey', N'Davidson', N'555-2596', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (105, N'Robert', N'Brown', N'555-2491', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (106, N'Mary', N'Kennedy', N'555-2526', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (107, N'Sara', N'Sheskey', N'555-2566', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (108, N'Rachel', N'Patterson', N'555-2546', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (109, N'David', N'Viescas', N'555-2661', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (110, N'Megan', N'Johnson', N'555-2641', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (111, N'Kathryn', N'Patterson', N'555-2651', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (112, N'Kim', N'Smith', N'555-2716', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (113, N'Steve', N'Davidson', N'555-9938', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (114, N'George', N'Johnson', N'555-9930', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (115, N'Joe', N'Smith', N'555-2281', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (116, N'Angel', N'Kennedy', N'555-2311', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (117, N'Luke', N'Patterson', N'555-2316', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (118, N'Janice', N'Davidson', N'555-2691', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (119, N'John', N'Viescas', N'555-2511', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (120, N'Michael', N'Hernandez', N'555-2711', N'M')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (121, N'Katherine', N'Smith', N'555-0399', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (122, N'Julia', N'Johnson', N'555-9936', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (123, N'Susan', N'Davidson', N'555-2301', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (124, N'Caroline', N'Viescas', N'555-2306', N'F')
INSERT [dbo].[Members] ([MemberID], [MbrFirstName], [MbrLastName], [MbrPhoneNumber], [Gender]) VALUES (125, N'Jim', N'Smith', N'555-2531', NULL)
SET IDENTITY_INSERT [dbo].[Members] OFF
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10001, 10, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10001, 22, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10002, 3, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10002, 8, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10003, 17, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10003, 19, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10004, 15, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10004, 21, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10005, 7, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10005, 14, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10006, 13, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10006, 23, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10007, 4, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10007, 8, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10007, 19, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10008, 10, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10008, 21, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10009, 6, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10009, 11, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10009, 18, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10010, 15, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10010, 19, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10010, 24, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10011, 1, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10011, 7, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10011, 21, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10012, 10, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10012, 20, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10013, 15, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10013, 24, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10014, 5, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10014, 18, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10014, 22, 1)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10015, 1, 3)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10015, 20, 2)
INSERT [dbo].[Musical_Preferences] ([CustomerID], [StyleID], [PreferenceSeq]) VALUES (10015, 21, 1)
SET IDENTITY_INSERT [dbo].[Musical_Styles] ON 

INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (1, N'40''s Ballroom Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (2, N'50''s Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (3, N'60''s Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (4, N'70''s Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (5, N'80''s Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (6, N'Country')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (7, N'Classical')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (8, N'Classic Rock & Roll')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (9, N'Rap')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (10, N'Contemporary')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (11, N'Country Rock')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (12, N'Elvis')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (13, N'Folk')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (14, N'Chamber Music')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (15, N'Jazz')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (16, N'Karaoke')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (17, N'Motown')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (18, N'Modern Rock')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (19, N'Rhythm and Blues')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (20, N'Show Tunes')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (21, N'Standards')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (22, N'Top 40 Hits')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (23, N'Variety')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (24, N'Salsa')
INSERT [dbo].[Musical_Styles] ([StyleID], [StyleName]) VALUES (25, N'90''s Music')
SET IDENTITY_INSERT [dbo].[Musical_Styles] OFF
ALTER TABLE [dbo].[Agents] ADD  CONSTRAINT [Salary_Default]  DEFAULT ((0)) FOR [Salary]
GO
ALTER TABLE [dbo].[Agents] ADD  CONSTRAINT [Commision_Rate_Default]  DEFAULT ((0)) FOR [CommissionRate]
GO
ALTER TABLE [dbo].[Engagements] ADD  CONSTRAINT [Contract_Price_Default]  DEFAULT ((0)) FOR [ContractPrice]
GO
ALTER TABLE [dbo].[Entertainer_Members] ADD  CONSTRAINT [EM_Status_Default]  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Entertainer_Styles] ADD  CONSTRAINT [StyleStrength_Default]  DEFAULT ((0)) FOR [StyleStrength]
GO
ALTER TABLE [dbo].[Musical_Preferences] ADD  CONSTRAINT [Pref_Seq_Default]  DEFAULT ((0)) FOR [PreferenceSeq]
GO
ALTER TABLE [dbo].[Engagements]  WITH CHECK ADD  CONSTRAINT [Engagements_FK00] FOREIGN KEY([AgentID])
REFERENCES [dbo].[Agents] ([AgentID])
GO
ALTER TABLE [dbo].[Engagements] CHECK CONSTRAINT [Engagements_FK00]
GO
ALTER TABLE [dbo].[Engagements]  WITH CHECK ADD  CONSTRAINT [Engagements_FK01] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Engagements] CHECK CONSTRAINT [Engagements_FK01]
GO
ALTER TABLE [dbo].[Engagements]  WITH CHECK ADD  CONSTRAINT [Engagements_FK02] FOREIGN KEY([EntertainerID])
REFERENCES [dbo].[Entertainers] ([EntertainerID])
GO
ALTER TABLE [dbo].[Engagements] CHECK CONSTRAINT [Engagements_FK02]
GO
ALTER TABLE [dbo].[Entertainer_Members]  WITH CHECK ADD  CONSTRAINT [Entertainer_Members_FK00] FOREIGN KEY([EntertainerID])
REFERENCES [dbo].[Entertainers] ([EntertainerID])
GO
ALTER TABLE [dbo].[Entertainer_Members] CHECK CONSTRAINT [Entertainer_Members_FK00]
GO
ALTER TABLE [dbo].[Entertainer_Members]  WITH CHECK ADD  CONSTRAINT [Entertainer_Members_FK01] FOREIGN KEY([MemberID])
REFERENCES [dbo].[Members] ([MemberID])
GO
ALTER TABLE [dbo].[Entertainer_Members] CHECK CONSTRAINT [Entertainer_Members_FK01]
GO
ALTER TABLE [dbo].[Entertainer_Styles]  WITH CHECK ADD  CONSTRAINT [Entertainer_Styles_FK00] FOREIGN KEY([EntertainerID])
REFERENCES [dbo].[Entertainers] ([EntertainerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Entertainer_Styles] CHECK CONSTRAINT [Entertainer_Styles_FK00]
GO
ALTER TABLE [dbo].[Entertainer_Styles]  WITH CHECK ADD  CONSTRAINT [Entertainer_Styles_FK01] FOREIGN KEY([StyleID])
REFERENCES [dbo].[Musical_Styles] ([StyleID])
GO
ALTER TABLE [dbo].[Entertainer_Styles] CHECK CONSTRAINT [Entertainer_Styles_FK01]
GO
ALTER TABLE [dbo].[Musical_Preferences]  WITH CHECK ADD  CONSTRAINT [Musical_Preferences_FK00] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Musical_Preferences] CHECK CONSTRAINT [Musical_Preferences_FK00]
GO
ALTER TABLE [dbo].[Musical_Preferences]  WITH CHECK ADD  CONSTRAINT [Musical_Preferences_FK01] FOREIGN KEY([StyleID])
REFERENCES [dbo].[Musical_Styles] ([StyleID])
GO
ALTER TABLE [dbo].[Musical_Preferences] CHECK CONSTRAINT [Musical_Preferences_FK01]
GO
