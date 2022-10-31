
-- ��������������� �������: 1. �������� ���������� �� ���������� �������� ������ ������ � ������� �������� (�� �������� � ��������)
--							2. ������� ����� ���� ������ �� ������� �� �������
--							3. ������� ����� ���������� ������ �� ������� �� ����������
--							4. �������� ���� ������� �� ������� �� �����������
--							5. ������� ��� �� ��������� ����� ����������� �����������.

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

 -- 1. �������� ���������� �� ���������� �������� ������ ������ � ������� �������� (�� �������� � ��������)

 SELECT Products.ProdID, [Description], Qty, TotalPrice 
    FROM Products
INNER JOIN OrderDetails
   ON Products.ProdID = OrderDetails.ProdID
ORDER BY TotalPrice DESC;

-- 2. ������� ����� ����� ������ �� ������� �� �������
SELECT Products.ProdID, [Description], SUM(Qty) AS Qty, SUM(TotalPrice) AS TotalPrice
  FROM Products
INNER JOIN OrderDetails
     ON Products.ProdID = OrderDetails.ProdID
GROUP BY Products.ProdID,
           [Description]
ORDER BY TotalPrice;

-- 3. ������� ����� ���������� ������ �� ������� �� �����������
SELECT FName, LName, MName, SUM(TotalPrice) AS [Total Sold] FROM Employees
      LEFT JOIN Orders
	  ON Employees.EmployeeID = Orders.EmployeeID
	  LEFT JOIN OrderDetails
	  ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Employees.FName,
         Employees.LName,
		 Employees.MName;
-- 4. ������� ���������� ������ �� �������
SELECT City, SUM(Qty) AS Qty FROM Customers
JOIN Orders 
ON Customers.CustomerNo = Orders.CustomerNo
JOIN OrderDetails
ON Orders.OrderID = OrderDetails.OrderID
GROUP BY City;
 
-- 5. �������� ���� ������� �� ������� �� �����������
SELECT FName, LName, MName, OrderDate FROM Customers
INNER JOIN Orders
ON Customers.CustomerNo = Orders.CustomerNo;

-- 6. �������, ��� �� ��������� � ����� ����������� �����������.
SELECT Emp1.FName, Emp1.MName, Emp1.LName, Cust.FName, Cust.MName, Cust.LName
 FROM Employees Emp1
 INNER JOIN Orders
 ON Emp1.EmployeeID = Orders.EmployeeID
 INNER JOIN Customers Cust
 ON Cust.CustomerNo = Orders.CustomerNo; 