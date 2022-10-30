-- ��������������� ������:
-- 1. �������� �� ShopDB
-- 2. �������� ������� Employees (�������� 003_ClassWork_CREATE_TABLE.jpg).
-- 3. �������� ������� � ������� ����� ������� �� �������� 003_ClassWork_Constraints.jpg
-- 4. ������� �������: Employees, Customers, Orders.

CREATE DATABASE ShopDB_1
ON                        -- ������ ��������� ���� ������
(
   NAME = 'ShopDB1',    -- ��������� ���������� ��� �� (������������ ��� ��������� � ��).
   FILENAME = 'D:\ShopDB.mdf', -- ��������� ���������� ������ ��� ����� ��.
   SIZE = 10MB,                -- ������ ��������� ������ ����� ��.
   MAXSIZE = 100MB,            -- ������ ������������ ������ ����� ��.
   FILEGROWTH = 10MB           -- ������ ��������, �� ������� ����� ������������� ������ ����� ��.
)
LOG ON                         -- ������ ��������� ������� ���� ������.
(
  NAME = 'ShopDB',       -- ��������� ���������� ��� ������� �� (������������ ��� ��������� � ������� ��).
  FILENAME = 'D:\ShopDB.ldf', -- ��������� ���������� ������ ��� ����� ������� ��.
  SIZE = 5MB,                    -- ������ ��������� ������ ����� ������� ��.
  MAXSIZE = 50MB,                    -- ������ ������������ ������ ����� ������� ��.
  FILEGROWTH = 5MB                   -- ������ ��������, �� ������� ����� ������������� ������ ����� ������� ��.
)

COLLATE Cyrillic_General_CI_AS

Use ShopDB_1
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

ALTER TABLE Employees ADD
   CONSTRAINT PK_Employees PRIMARY KEY(EmployeeID)
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

DROP TABLE Orders;
DROP TABLE Employees;
DROP TABLE Customers;

