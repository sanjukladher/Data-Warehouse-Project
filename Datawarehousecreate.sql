use SanjuDATAWAREHOUSE
Go
	
    CREATE TABLE [Shippers_dim](
	[ShipperID] [int] primary key NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[Phone] [nvarchar](24) NULL,
	[Average_Cost] [money] Not NUll,
	[No_Of_Shipments] [decimal](5,1) Not NUll,
	[Delivery_On_Time_Success] [decimal](5,1) Not NULL
	)

	CREATE TABLE [Customers_dim](
	[CustomerID] [nchar](5) primary key NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[City] [nvarchar](15) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	)


	CREATE TABLE [Orders_details_dim](
	[OrderID] [int] primary key NOT NULL,
	[OrderDate] [datetime] NULL,
	[RequiredDate] [datetime] NULL,
	[ShippedDate] [datetime] NULL,
	[ShipFreight] [money] NULL,
	[ShipCity] [nvarchar](15) NULL,
	[ShipCountry] [nvarchar](15) NULL
	)

	
	CREATE TABLE [Employees_dim](
	[EmployeeID] [int] primary key NOT NULL,
	[LastName] [nvarchar](20) NOT NULL,
	[FirstName] [nvarchar](10) NOT NULL,
	[Title] [nvarchar](30) NULL,
	[TitleOfCourtesy] [nvarchar](25) NULL,
	[BirthDate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[City] [nvarchar](15) NULL,
	[Country] [nvarchar](15) NULL,
	[HomePhone] [nvarchar](24) NULL,
	[Notes] [ntext] NULL,
	[ReportsTo] [int] NULL
	)


	CREATE TABLE [Logistic_fact](
	[CustomerID] [nchar](5) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ShipperID] [int] NOT NULL,
    [EmployeeID] [int] NOT NULL,
	[Datekey] [int] Not Null,
	[Shipped_Country] [nvarchar](15) NULL,
	[Ship_Cost_Check] [decimal](5,2) not NULL,
    [DIFOT] [decimal](5,2) not Null	 
	)
	
CREATE TABLE DAY_CALENDAR
(
RequiredCalendarKey int IDENTITY(1,1) PRIMARY KEY,
RequiredDate datetime null,
Year int null,
Quarter int null,
Month nvarchar(15) null,
DayOfYear int null,
Day int null,
Week int null,
WeekDay nvarchar(15) null
);


	Go