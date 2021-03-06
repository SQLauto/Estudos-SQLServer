USE AdventureWorks
GO
CREATE UNIQUE CLUSTERED INDEX CLIDX_Orders_SalesOrderID
	ON dbo.Orders(SalesOrderID)
GO

SET STATISTICS IO ON;

SELECT * FROM dbo.Orders;

SELECT * FROM dbo.Orders
WHERE SalesOrderID =46699;

SET STATISTICS IO OFF;
GO

SELECT * FROM dbo.Orders
ORDER BY SalesOrderID;

SELECT * FROM dbo.Orders
ORDER BY OrderDate;



CREATE UNIQUE CLUSTERED INDEX CLIDX_OrderDetails
	ON dbo.OrderDetails(SalesOrderID,SalesOrderDetailID)

SELECT * FROM dbo.OrderDetails
WHERE SalesOrderID = 46999

SELECT * FROM dbo.OrderDetails
WHERE SalesOrderDetailID = 14147
