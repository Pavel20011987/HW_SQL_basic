/****** Script for SelectTopNRows command from SSMS  ******/
/*
Сделайте выборку всех
продуктов StandardCost которых свыше 100
*/

SELECT *
  FROM [AdventureWorks2014].[Production].[Product]

  where StandardCost > 100
/*
сделайте выборку всех продуктов наименование
которых начинается с ML
*/
SELECT *
  FROM [AdventureWorks2014].[Production].[Product]

  where Name LIKE 'ML%'
/*
сделайте выборку  наименование продукта в столбце ProductNumber будет начинаться с RM. 
*/
SELECT *
  FROM [AdventureWorks2014].[Production].[Product]

  where ProductNumber LIKE 'RM%'