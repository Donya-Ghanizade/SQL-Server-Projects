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

-- =====================================================
-- 01. Filtering Data with WHERE
-- Find addresses in Seattle or with a specific postal code
-- =====================================================

Select *
From Person.Address
Where City='Seattle'
		or
		PostalCode='98011'

-- =====================================================
-- 02. Aggregate Functions with GROUP BY
-- Calculate order statistics for each salesperson
-- =====================================================

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

-- =====================================================
-- 03. DISTINCT and Column Aliases
-- Retrieve unique person types and names
-- =====================================================

select distinct Per.PersonType as [نوع کارمند],
				Per.title as [عنوان],
				Per.Firstname as [نام],
				Per.middlename as [مخفف نام],
				Per.Lastname as [نام خانوادگی]
From Person.Person as Per

-- =====================================================
-- 04. NULL Handling and Pagination
-- Retrieve sales orders with assigned salespersons
-- =====================================================

Select SalesPersonId,SalesOrderId,SubTotal
From Sales.SalesOrderHeader
Where SalesPersonId is not null  -- Is logical
--SARGABLE Where cluse > Where Isnull (SalesPersonId , 0)<>0
-- تمام تغییرات بهتر است در سمت راست نامساوی قرار بگیرد نه چپ
Order by SalesPersonID,SubTotal Desc
OFFSET 5 /*skip*/ ROWS FETCH NEXT 20 /*fetch*/ ROWS ONLY;

-- =====================================================
-- 05. Simple CASE Expression
-- Assign category names based on ProductCategoryID
-- =====================================================
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

-- =====================================================
-- 06. Searched CASE Expression
-- Classify orders based on their subtotal
-- =====================================================
--Search case
Select SalesOrderID,CustomerId,Subtotal,
	CASE 
		When Subtotal < 1000.00						Then 'Less than 1000'
		When Subtotal Between 1000.00 And 3000.00	Then 'Between 1000 and 3000'
		When Subtotal > 3000.00						Then 'More then 3000'
		Else 'Unknown'
	END AS valuecategory
From Sales.SalesOrderHeader;

-- =====================================================
-- 07. Selecting Specific Columns
-- Retrieve basic information about people
-- =====================================================
---extra example
Select FirstName , LastName , BusinessEntityID
From Person.Person

-- =====================================================
-- 08. Selecting Product Information
-- Retrieve product name, price, and weight
-- =====================================================

Select Name,ListPrice,Weight
From Production.Product

-- =====================================================
-- 09. Filtering Products by Price
-- Retrieve products with a list price greater than 100
-- =====================================================

Select Name,ListPrice
From Production.Product
Where ListPrice >100

-- =====================================================
-- 10. Filtering Products by Color
-- Retrieve products with a black color
-- =====================================================
Select Name,Color
From Production.Product
Where Color ='Black'

-- =====================================================
-- 11. Sorting Products by Price
-- Sort products by list price in descending order
-- =====================================================
Select Name,ListPrice
From Production.Product
Order by ListPrice desc

-- =====================================================
-- 12. CASE Expression for Price Classification
-- Classify products based on their list price
-- =====================================================
Select Name,ListPrice,
	CASE 
		When ListPrice > 1000					Then 'Expensive'
		When ListPrice Between 100 And 1000		Then 'Normal'
		When ListPrice < 100					Then 'Cheap'
	END AS PriceStatus
From Production.Product;

-- =====================================================
-- 13. Sorting by CASE Expression
-- Sort products by price category
-- =====================================================
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

-- =====================================================
-- 14. Counting Orders per Customer
-- Calculate the number of orders for each customer
-- =====================================================
Select CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID;

-- =====================================================
-- 15. Sorting Customers by Order Count
-- Sort customers by the number of orders in descending order
-- =====================================================
Select CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
Order BY OrderCount desc

-- =====================================================
-- 16. TOP and HAVING
-- Find the top 5 customers with more than 20 orders
-- =====================================================
-----Using top for show 5 record , Using percent after 5 show 5% all records
Select top (5) CustomerID,
		count(SalesOrderID) as OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
Having Count(SalesOrderID)> 20
Order BY OrderCount desc

-- =====================================================
-- 17. Filtering and Grouping Customer Orders
-- Find customers with orders above a specific total
-- =====================================================
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
