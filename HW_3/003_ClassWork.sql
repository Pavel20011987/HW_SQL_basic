-- Самостоятельная работа:
-- 1. Создайте БД ShopDB
-- 2. Создайте таблицу Employees (смотрите 003_ClassWork_CREATE_TABLE.jpg).
-- 3. Допишите таблицы и задайте связи заданые на картинке 003_ClassWork_Constraints.jpg
-- 4. Удалите таблицы: Employees, Customers, Orders.

CREATE DATABASE ShopDB_1
ON                        -- Задаем параметры базы данных
(
   NAME = 'ShopDB1',    -- Указываем логическое имя БД (используется при обращении к БД).
   FILENAME = 'D:\ShopDB.mdf', -- Указываем Физическое полное имя файла БД.
   SIZE = 10MB,                -- Задаем начальный размер файла БД.
   MAXSIZE = 100MB,            -- Задаем максимальный размер файла БД.
   FILEGROWTH = 10MB           -- Задаем значение, на которое будет увеличиваться размер файла БД.
)
LOG ON                         -- Задаем параметры журнала Базы Данных.
(
  NAME = 'ShopDB',       -- Указываем логическое имя журнала БД (используется при обращении к журналу БД).
  FILENAME = 'D:\ShopDB.ldf', -- Указываем Физическое полное имя файла журнала БД.
  SIZE = 5MB,                    -- Задаем начальный размер файла журнала БД.
  MAXSIZE = 50MB,                    -- Задаем максимальный размер файла журнала БД.
  FILEGROWTH = 5MB                   -- Задаем значение, на которое будет увеличиваться размер файла журнала БД.
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

