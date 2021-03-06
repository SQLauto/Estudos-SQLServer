USE AdventureWorks
GO

CREATE TABLE dbo.Orders(
	SalesOrderID int  NOT NULL,
	OrderDate datetime NOT NULL,
	ShipDate datetime NULL,
	Status tinyint NOT NULL,
	PurchaseOrderNumber dbo.OrderNumber NULL,
	CustomerID int NOT NULL,
	ContactID int NOT NULL,
	SalesPersonID int NULL
	);

CREATE TABLE dbo.OrderDetails(
	SalesOrderID int NOT NULL,
	SalesOrderDetailID int NOT NULL,
	CarrierTrackingNumber nvarchar(25),
	OrderQty smallint NOT NULL,
	ProductID int NOT NULL,
	UnitPrice money NOT NULL,
	UnitPriceDiscount money NOT NULL,
	LineTotal  AS (isnull((UnitPrice*((1.0)-UnitPriceDiscount))*OrderQty,(0.0)))
	);

INSERT INTO dbo.Orders
SELECT SalesOrderID, OrderDate, ShipDate, Status, PurchaseOrderNumber,
	CustomerID, ContactID, SalesPersonID 
FROM Sales.SalesOrderHeader;

INSERT INTO dbo.OrderDetails(SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,OrderQty,
	ProductID, UnitPrice, UnitPriceDiscount)
SELECT SalesOrderID, SalesOrderDetailID, CarrierTrackingNumber,OrderQty,
	ProductID, UnitPrice, UnitPriceDiscount
FROM Sales.SalesOrderDetail;


SET STATISTICS IO ON;

SELECT * FROM dbo.Orders;

SET STATISTICS IO OFF


SET STATISTICS IO ON;

SELECT * FROM dbo.Orders
WHERE SalesOrderID =46699;

SET STATISTICS IO OFF;