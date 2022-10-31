
-- —амосто€тельное задание: 1. ѕоказать статистику по количеству проданых едениц товара в пор€дке убывани€ (от большего к меньшему)
--							2. ¬ывести общую суму продаж по каждому из товаров
--							3. ¬ывести общее количество продаж по каждому из сотрудиков
--							4. ¬ывести количество продаж по городам
--							5. ѕоказать даты покупок по каждому из покупателей
--							6. ¬ывести кто и продавцов каких покупателей обслуживает.

USE ShopDB
GO

-- 1. ѕоказать статистику по количеству проданных единиц товара в пор€дке убывани€ (от большего к меньшему)
SELECT (SELECT ProdID FROM Products
        WHERE Products.ProdID = OrderDetails.ProdID) AS ProdID,
		(SELECT [Description] FROM Products
		WHERE Products.ProdID = OrderDetails.ProdID) AS [Description], Qty, TotalPrice
FROM OrderDetails
ORDER BY TotalPrice DESC

-- WITH ... AS - ќбобщенные табличные выражени€ используютс€ вместо временных таблиц
-- тем самым избега€ хранени€ дублирующих данных.
-- 2. ¬ывести общую сумму продаж по каждому из товаров.
WITH Product (ProdID, [Description], Qty, TotalPrice) AS
(
 SELECT (
         SELECT ProdID FROM Products
		 WHERE ProdID IN (
		                   SELECT ProdID FROM Products 
						   WHERE Products.ProdID = OrderDetails.ProdID
						   )
		),
		(
		 SELECT [Description] FROM Products 
		 WHERE ProdID IN (
		                  SELECT ProdID FROM Products 
						   WHERE Products.ProdID = OrderDetails.ProdID
						   )
		),
		Qty,
		TotalPrice
FROM OrderDetails
)
  SELECT ProdID, [Description], SUM(Qty) AS Qty, SUM(TotalPrice) AS [Total Sold]
  FROM Product GROUP BY ProdID, [Description] ORDER BY [Total Sold];
GO

-- 3.¬ывести общее количество продаж по каждому из сотрудиков

WITH Managers (FName, LName, MName, TotalPrice) AS
(
 SELECT (
         SELECT FName FROM Employees
		 WHERE EmployeeID = (
		                   SELECT EmployeeID FROM Orders 
						   WHERE Orders.OrderID = OrderDetails.OrderID
						   )
		),
		(
		 SELECT LName FROM Employees
		 WHERE EmployeeID = (
		                   SELECT EmployeeID FROM Orders 
						   WHERE Orders.OrderID = OrderDetails.OrderID
						   )
		),
		(
		 SELECT MName FROM Employees
		 WHERE EmployeeID = (
		                   SELECT EmployeeID FROM Orders 
						   WHERE Orders.OrderID = OrderDetails.OrderID
						   )
		),
		TotalPrice
FROM OrderDetails
)
  SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold]
     FROM Managers GROUP BY FName, LName, MName
GO

-- 4. ¬ывести количество продаж по городам

WITH Citys(City, Qty) AS
(
SELECT (
        SELECT City FROM Customers
		WHERE CustomerNo = (
		                    SELECT CustomerNo FROM Orders
							WHERE Orders.OrderID = OrderDetails.OrderID
							)
		),
		Qty
FROM OrderDetails
)
   SELECT City, SUM(Qty) AS Qty
   FROM Citys GROUP BY City;
GO

-- 5. ѕоказать даты покупок по каждому из покупателей
SELECT FName, LName, MName,
(SELECT OrderDate FROM Orders
WHERE Cust.CustomerNo=Orders.CustomerNo) FROM Customers Cust

-- 6. ¬ывести кто и продавцов каких покупателей обслуживает.

SELECT FName, LName, MName,
(SELECT FName FROM Employees
WHERE Employees.EmployeeID IN
                          (SELECT EmployeeID FROM Orders
						   WHERE Cust.CustomerNo=Orders.CustomerNo)) AS EmpFName,
(SELECT MName FROM Employees
WHERE Employees.EmployeeID IN
                          (SELECT EmployeeID FROM Orders
						   WHERE Cust.CustomerNo=Orders.CustomerNo)) AS EmpMName,
(SELECT LName FROM Employees
WHERE Employees.EmployeeID IN
                          (SELECT EmployeeID FROM Orders
						   WHERE Cust.CustomerNo=Orders.CustomerNo)) AS EmpLName
FROM Customers AS Cust