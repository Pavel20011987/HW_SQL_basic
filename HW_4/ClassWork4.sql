CREATE DATABASE ClassWork4

USE ClassWork4
GO

alter authorization on database::[ClassWork4] to [sa]


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

ALTER TABLE Employees ADD
  CONSTRAINT PK_Employess PRIMARY KEY(EmployeeID)
GO

CREATE TABLE Customers
(
CustomerNo int NOT NULL IDENTITY,
FName nvarchar(15) NOT NULL,
LName nvarchar(15) NOT NULL,
MName nvarchar(15) NULL,
Address1 nvarchar(50) NOT NULL,
Address2 nvarchar(50) NULL,
City nchar(10) NOT NULL,
Phone char(12) NOT NULL,
DateInSystem date NULL
)
GO

ALTER TABLE Customers ADD
  CONSTRAINT PK_Customers PRIMARY KEY(CustomerNo)
GO

DROP TABLE Orders

CREATE TABLE Orders
(
 OrderID int NOT NULL IDENTITY,
 CustomerNo int NULL,
 OrderDate date NOT NULL,
 EmployeeID int NULL
 )
 GO

ALTER TABLE Orders ADD
  CONSTRAINT PK_Orders PRIMARY KEY(OrderID)
GO

ALTER TABLE Orders ADD
   CONSTRAINT FK_Orders_Customers FOREIGN KEY(CustomerNo)
   REFERENCES Customers(CustomerNo)
GO

ALTER TABLE Orders ADD
   CONSTRAINT FK_Orders_Employees FOREIGN KEY(EmployeeID)
   REFERENCES Employees(EmployeeID)
GO

---

CREATE TABLE Products
(
  ProdID int NOT NULL IDENTITY,
  [Description] nchar(50) NOT NULL,
  UnitPrice money NULL,
  [Weight] numeric(18, 0) NULL
)
GO

ALTER TABLE Products ADD CONSTRAINT
   PK_Products PRIMARY KEY(ProdID)
GO

CREATE TABLE OrderDetails
(
  OrderID int NOT NULL,
  LineItem int NOT NULL,
  ProdID int NULL,
  Qty int NOT NULL,
  UnitPrice money NOT NULL

)
GO

ALTER TABLE OrderDetails ADD CONSTRAINT
  PK_OrderDetails PRIMARY KEY
  (
    OrderID,
	LineItem
  )
GO
   
ALTER TABLE OrderDetails ADD
   CONSTRAINT FK_OrdersDetails_Products FOREIGN KEY(ProdID)
   REFERENCES Products(ProdID)
GO

ALTER TABLE OrderDetails ADD
   CONSTRAINT FK_OrdersDetails_Orders FOREIGN KEY(OrderID)
   REFERENCES Orders(OrderID)
GO