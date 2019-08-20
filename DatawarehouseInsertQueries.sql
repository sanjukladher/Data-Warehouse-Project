USE [SanjuDATAWAREHOUSE]

---Insert Customers_dim 
USE [SanjuDATAWAREHOUSE]

INSERT INTO [dbo].[Customers_dim]
(
CustomerID,
CompanyName,
ContactName,
ContactTitle,
City,
Country,
Phone
)
SELECT 
c.CustomerID,
c.CompanyName,
c.ContactName,
c.ContactTitle,
c.City,
c.Country,
c.Phone
FROM [Sanju].[dbo].Customers AS c

-- iNSERT ORDER  Dimension
USE [SanjuDATAWAREHOUSE]
INSERT INTO [dbo].[Orders_details_dim]
(
OrderID,
OrderDate,
RequiredDate,
ShippedDate,
ShipFreight,
ShipCity,
ShipCountry
)
SELECT 
o.OrderID,
o.OrderDate,
o.RequiredDate,
o.ShippedDate,
o.Freight,
o.ShipCity,
o.ShipCountry

FROM [Sanju].[dbo].Orders AS o

--Insert shippers Table;




INSERT INTO [dbo].[Shippers_dim]
(
ShipperID,
CompanyName,
Phone,
Average_Cost,
No_Of_Shipments,
Delivery_On_Time_Success
)
SELECT
sh.ShipperID,
sh.CompanyName,
sh.Phone,
((select sum(Freight) from [Sanju].[dbo].Orders where ShipVia = sh.Shipperid ) /(select count(OrderID) from [Sanju].[dbo].Orders where ShipVia = sh.Shipperid))  as Average_cost,
CONVERT(decimal(5,1),(select count(OrderID) from [Sanju].[dbo].Orders where ShipVia = sh.Shipperid)) as No_Of_Shipments,
CONVERT(decimal(5,1),(SELECT (count(DATEDIFF(day,(ShippedDate+3),RequiredDate))) FROM [Sanju].[dbo].Orders where DATEDIFF(day,(ShippedDate+3),RequiredDate) > 0 and ShipVia =sh.ShipperID)) as Delivery_on_Time_success

FROM [Sanju].[dbo].Shippers AS sh
Join [Sanju].[dbo].Orders as o
on o.ShipVia = sh.ShipperID
group By  sh.ShipperID,sh.CompanyName,sh.Phone





----Insertion Employees Tables



INSERT INTO [dbo].[Employees_dim]
           ([EmployeeID],
		   [LastName],
           [FirstName],
           [Title],
           [TitleOfCourtesy],
           [BirthDate],
           [HireDate],
           [City],
           [Country],
           [HomePhone],
           [Notes],
           [ReportsTo] 
		   )
     Select 
	       [EmployeeID],  
           [LastName],
           [FirstName],
           [Title],
           [TitleOfCourtesy],
           [BirthDate],
           [HireDate],
           [City],
           [Country],
           [HomePhone],
           [Notes],
           [ReportsTo]

from [Sanju].[dbo].Employees 


-- Insert Day Calendar table

INSERT INTO [dbo].[DAY_CALENDAR]
           ([RequiredDate]
           ,[Year]
           ,[Quarter]
           ,[Month]
           ,[DayOfYear]
           ,[Day]
           ,[Week]
           ,[WeekDay]
		   )
select Distinct 
         RequiredDate, 
		 DATEPART(Year,RequiredDate) Year,
		 DATEPART(Quarter,RequiredDate) Quarter,
	     datename(Month,RequiredDate) Month,
		 DATEPART(DayOfYear,RequiredDate) DayOfYear,
		 DATEPART(Day,RequiredDate) Day,
		 DATEPART(Week,RequiredDate) Week, 
         datename(WeekDay,RequiredDate) WeekDay 
		 from Sanju.dbo.Orders;

------Insert Logistic fact



INSERT INTO [dbo].[Logistic_fact]
           ([CustomerID]
           ,[OrderID]
           ,[ShipperID]
           ,[EmployeeID]
           ,[Datekey]
           ,[Shipped_Country]
           ,[Ship_Cost_Check]
           ,[DIFOT])
      Select
	       o.CustomerID,
		   o.OrderID,
		   o.ShipVia,
		   o.EmployeeID,
		   p.RequiredCalendarKey,
		   o.ShipCountry,
		   IIF(o.Freight<sh.Average_Cost, o.Freight,0) as Ship_Cost_Check,
		   (select (Delivery_On_Time_Success/No_of_Shipments)*100 from [dbo].[Shippers_dim] where ShipperID =o.ShipVia) as DIFOT
    
	from  Sanju.[dbo].Orders as o 
	Join [SanjuDATAWAREHOUSE].[dbo].DAY_CALENDAR as p
	ON p.RequiredDate = o.OrderDate
	left join  [SanjuDATAWAREHOUSE].[dbo].Shippers_dim as sh
	on sh.ShipperID =o.Shipvia
 	GO



 -- Put your database name in here
/**********************************************************************************/
