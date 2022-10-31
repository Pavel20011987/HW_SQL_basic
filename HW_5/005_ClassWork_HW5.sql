
-- —амосто€тельное задание: 1. ѕоказать статистику по количеству проданых едениц товара в пор€дке убывани€ (от большего к меньшему)
--							2. ¬ывести общую суму продаж по каждому из товаров
--							3. ¬ывести общее количество продаж по каждому из сотрудиков
--							4. ѕоказать даты покупок по каждому из покупателей
--							5. ¬ывести кто из продавцов каких покупателей обслуживает.

USE ShopDB
GO

CREATE TABLE Employees
(
 EmployeeID int NOT NULL,
 FName nvarchar(15) NOT NULL,
 LName nvarchar(15) NOT NULL,
 MName nvarchar(15) NOT NULL,
 Salary money NOT NULL,
 PriorSalary money NOT NULL,
 HireDate date NOT NULL,
 TerminationDate date NULL,
 ManagerEmpID int NULL
 )
 GO

 -- 1. ѕоказать статистику по количеству проданых едениц товара в пор€дке убывани€ (от большего к меньшему)

 SELECT Products.ProdID, [Description], Qty, TotalPrice 
    FROM Products
INNER JOIN OrderDetails
   ON Products.ProdID = OrderDetails.ProdID
ORDER BY TotalPrice DESC;

-- 2. ¬ывести общую сумму продаж по каждому из товаров
SELECT Products.ProdID, [Description], SUM(Qty) AS Qty, SUM(TotalPrice) AS TotalPrice
  FROM Products
INNER JOIN OrderDetails
     ON Products.ProdID = OrderDetails.ProdID
GROUP BY Products.ProdID,
           [Description]
ORDER BY TotalPrice;

-- 3. ¬ывести общее количество продаж по каждому из сотрудников
SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] FROM Employees
      LEFT JOIN Orders
	  ON Employees.EmployeeID = Orders.EmployeeID
	  LEFT JOIN OrderDetails
	  ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Employees.FName,
         Employees.LName,
		 Employees.MName;
-- 4. ¬ывести количество продаж по городам
SELECT City, SUM(Qty) AS Qty FROM Customers
JOIN Orders 
ON Customers.CustomerNo = Orders.CustomerNo
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
GROUP BY City;
 
-- 5. ѕоказать даты покупок по каждому из покупателей
SELECT FName, LName, MName, OrderDate FROM Customers
INNER JOIN Orders
ON Customers.CustomerNo = Orders.CustomerNo;

-- 6. ¬ывести, кто из продавцов и каких покупателей обслуживает.
SELECT Emp1.FName, Emp1.MName, Emp1.LName, Cust.FName, Cust.MName, Cust.LName
 FROM Employees Emp1
 INNER JOIN Orders
 ON Emp1.EmployeeID = Orders.EmployeeID
 INNER JOIN Customers Cust
 ON Cust.CustomerNo = Orders.CustomerNo; 