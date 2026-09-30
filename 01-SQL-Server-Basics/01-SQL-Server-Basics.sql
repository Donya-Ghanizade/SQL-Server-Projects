/*
=========================================================
SQL Server Basics & Query Practice
Database: AdventureWorks
Tool: SQL Server Management Studio (SSMS)

Topics:
- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- Aggregate Functions
- CASE
- TOP
- OFFSET / FETCH
- NULL Handling
=========================================================
*/

Select ...


----------------------------1
Select *
From Person.Address
Where City='Seattle'
		or
		PostalCode='98011'
-----------------------------2
Select	SalesPersonID,
		count(salesorderid) as CountOrders,
		Sum(SubTotal) as SumSubTotal,
		Min(SubTotal) as MinSubTotal,
		Max(Subtotal) as MaxSubtotal
From Sales.SalesOrderHeader
Group by SalesPersonID
Having Count(SalesOrderID)>100
and min(SubTotal)>20
Order by CountOrders asc
-------------------------------3
select distinct Per.PersonType as [نوع کارمند],
				Per.title as [عنوان],
				Per.Firstname as [نام],
				Per.middlename as [مخفف نام],
				Per.Lastname as [نام خانوادگی]
From Person.Person as Per
---------------------------------4
Select SalesPersonId,SalesOrderId,SubTotal
From Sales.SalesOrderHeader
Where SalesPersonId is not null  -- Is logical
--SARGABLE Where cluse > Where Isnull (SalesPersonId , 0)<>0
-- تمام تغییرات بهتر است در سمت راست نامساوی قرار بگیرد نه چپ
Order by SalesPersonID,SubTotal Desc
OFFSET 5 /*skip*/ ROWS FETCH NEXT 20 /*fetch*/ ROWS ONLY;
----------------------------------5
---Using case
Select productSubCategoryid, Name,ProductCategoryID,
	CASE ProductCategoryID
		When 1 Then 'Bikes'
		When 2 Then 'Components'
		When 3 Then 'Clothing'
		When 4 Then 'Accessories'
		Else 'Unknown Category '
	END AS categoryname -- یه ستون با نام مشخص شده ایجاد کن
From [Production].[ProductSubcategory]
-----------------------------------6
--Search case
Select SalesOrderID,CustomerId,Subtotal,
	CASE 
		When Subtotal < 1000.00						Then 'Less than 1000'
		When Subtotal Between 1000.00 And 3000.00	Then 'Between 1000 and 3000'
		When Subtotal > 3000.00						Then 'More then 3000'
		Else 'Unknown'
	END AS valuecategory
From Sales.SalesOrderHeader;
------------------------------------7
---extra example
Select FirstName , LastName , BusinessEntityID
From Person.Person
------------------------------------8
Select Name,ListPrice,Weight
From Production.Product
------------------------------------9
Select Name,ListPrice
From Production.Product
Where ListPrice >100
----------------------------------10
Select Name,Color
From Production.Product
Where Color ='Black'
---------------------------------11
Select Name,ListPrice
From Production.Product
Order by ListPrice desc
---------------------------------12
Select Name,ListPrice,
	CASE 
		When ListPrice > 1000					Then 'Expensive'
		When ListPrice Between 100 And 1000		Then 'Normal'
		When ListPrice < 100					Then 'Cheap'
	END AS PriceStatus
From Production.Product;
----------------------------------13
Select Name,ListPrice,
	CASE 
		When ListPrice > 1000					Then 'Expensive'
		When ListPrice Between 100 And 1000		Then 'Normal'
		When ListPrice < 100					Then 'Cheap'
	END AS PriceStatus
From Production.Product
Order by 
	CASE 
		When ListPrice > 1000					Then 1
		When ListPrice Between 100 And 1000		Then 2
		When ListPrice < 100					Then 3
	END;
-----------------------------------14
Select CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;
------------------------------------15
Select CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
Order BY OrderCount desc
-------------------------------------16
-----Using top for show 5 record , Using percent after 5 show 5% all records
Select top (5) CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
Having Count(SalesOrderID)> 20
Order BY OrderCount desc
-------------------------------------17
Select CustomerID,COUNT(SalesOrderID) AS OrderCount
From Sales.SalesOrderHeader
Where TotalDue > 1000
Group BY CustomerID
Having Count(SalesOrderID)> 3
Order BY OrderCount





---Three Valued Logic
--True - False - Unknown

--From - Where - Group by - Having - Select - Order by - top
-- Logical Proccesing In SQl
