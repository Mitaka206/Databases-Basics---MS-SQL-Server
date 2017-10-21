--Problem 1.	Employee Address
SELECT TOP(5) e.EmployeeID, e.JobTitle, e.AddressID, a.AddressText FROM Employees AS e
JOIN Addresses AS a ON a.AddressID = e.AddressID
ORDER BY e.AddressID



--Problem 2.	Addresses with Towns
USE SoftUni

  SELECT TOP(50)
         e.FirstName, 
  	     e.LastName, 
		 t.Name AS Town,
  	     a.AddressText
    FROM Employees AS e
    JOIN Addresses AS a 
      ON a.AddressID = e.AddressID
    JOIN Towns AS t
      ON t.TownID = a.TownID
ORDER BY e.FirstName, e.LastName



--Problem 3.	Sales Employee
SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY e.EmployeeID



--Problem 4.	Employee Departments
SELECT TOP(5) e.EmployeeID, e.FirstName, e.Salary, d.Name FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID



--Problem 5.	Employees Without Project

SELECT * FROM EmployeesProjects

SELECT TOP(3) e.EmployeeID, e.FirstName FROM Employees AS e
FULL JOIN EmployeesProjects AS ep ON ep.EmployeeID = e.EmployeeID
WHERE ProjectID IS NULL
ORDER BY e.EmployeeID



--Problem 6.	Employees Hired After
SELECT e.FirstName, e.LastName, e.HireDate, d.Name AS DeptName FROM Employees AS e
JOIN Departments AS d ON d.DepartmentID = e.DepartmentID
WHERE e.HireDate > '1.1.1999' AND d.Name IN ('Finance', 'Sales')
ORDER BY HireDate



--Problem 7.	Employees with Project
SELECT TOP(5) e.EmployeeID, e.FirstName, p.Name AS ProjectName FROM EmployeesProjects AS ep
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
JOIN Employees AS e ON e.EmployeeID = ep.EmployeeID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY EmployeeID



--Problem 8.	Employee 24 *****************
SELECT ep.EmployeeID, e.FirstName, IIF(p.StartDate > '2005-01-01', NULL, p.Name) AS ProjectName FROM EmployeesProjects AS ep
JOIN Projects AS p ON p.ProjectID = ep.ProjectID
JOIN Employees AS e ON e.EmployeeID = ep.EmployeeID
WHERE ep.EmployeeID = 24



--Problem 9.	Employee Manager
SELECT e.EmployeeID, e.FirstName, e.ManagerID, e2.FirstName  FROM Employees AS e
JOIN Employees AS e2 ON e2.EmployeeID = e.ManagerID
WHERE e2.EmployeeID = 3 OR e2.EmployeeID = 7
ORDER BY EmployeeID



--Problem 10.	Employee Summary
SELECT TOP(50) 
         e.EmployeeID, 
  	     e.FirstName + ' ' + e.LastName AS EmployeeName, 
  	     e2.FirstName + ' ' + e2.LastName AS ManagerName,
		 d.Name AS DepartmentName
    FROM Employees AS e
    JOIN Employees AS e2 
	  ON e2.EmployeeID = e.ManagerID
	JOIN Departments AS d
	  ON d.DepartmentID = e.DepartmentID
ORDER BY e.EmployeeID



--Problem 11.	Min Average Salary
SELECT  MIN(AverageSalary) FROM
		(SELECT DepartmentID, 
		        AVG(Salary) 
			 AS AverageSalary 
		   FROM Employees
	   GROUP BY DepartmentID) 
	AS AVGTABLE


--Problem 12.	Highest Peaks in Bulgaria
USE Geography

  SELECT mc.CountryCode, m.MountainRange, p.PeakName, p.Elevation 
    FROM Peaks AS p
    JOIN Mountains AS m ON m.Id = p.MountainId
    JOIN MountainsCountries AS mc ON mc.MountainId = p.MountainId
   WHERE Elevation >= 2835 AND mc.CountryCode = 'BG'
ORDER BY p.Elevation DESC


--Problem 13.	Count Mountain Ranges
  SELECT IntMount.CountryCode, COUNT(IntMount.CountryCode) 
    FROM (SELECT * 
          FROM MountainsCountries
         WHERE CountryCode IN('US', 'RU', 'BG')) AS IntMount
GROUP BY IntMount.CountryCode


--Problem 14.	Countries with Rivers
SELECT TOP(5) c.CountryName, r.RiverName FROM Countries AS c
LEFT JOIN CountriesRivers AS cr ON cr.CountryCode = c.CountryCode
LEFT JOIN Rivers AS r ON r.Id = cr.RiverId
WHERE c.ContinentCode = 'AF'
ORDER BY c.CountryName



--Problem 15.	*Continents and Currencies

WITH CTE_TopCurrency (ContinentCode, CurrencyCode, CurrencyUsage)
  AS (SELECT TOP(6) ContinentCode, CurrencyCode , COUNT(CurrencyCode) AS CurrencyUsage FROM Countries AS c
GROUP BY CurrencyCode, ContinentCode
ORDER BY CurrencyUsage DESC)

SELECT * FROM CTE_TopCurrency
ORDER BY ContinentCode

--???????????????????????????????????????????????????????????????????



--Problem 16.	Countries without any Mountains
SELECT * FROM MountainsCountries

SELECT * FROM Countries


--Problem 17.	Highest Peak and Longest River by Country



--Problem 18.	* Highest Peak Name and Elevation by Country



--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

USE SoftUni

--INNER JOIN
 
SELECT e.FirstName + ' ' + e.LastName AS [Full Name], 
       d.Name AS [Department Name],
	   e.JobTitle AS [Job Title]
  FROM Employees AS e
  JOIN Departments AS d
    ON d.DepartmentID = e.DepartmentID

-- CROSS JOIN
USE Diablo

    SELECT u.Email, 
           u.id, 
           u2.id, 
           u2.Email 
      FROM Users AS u
CROSS JOIN Users AS u2
     WHERE u.Id > u2.id

-------------------------------------------------------
USE SoftUni
------------Subqueries

SELECT * FROM Employees
WHERE DepartmentID = (SELECT d.DepartmentID FROM Departments AS d
WHERE d.Name = 'Finance')

SELECT * FROM Employees
WHERE DepartmentID IN(SELECT d.DepartmentID FROM Departments AS d
WHERE d.Name = 'Finance' OR d.Name = 'Sales')

--CTE
WITH CTE_EmployeeInfo (FirstName, LastName, Salary)
  AS (SELECT FirstName, LastName, Salary
        FROM Employees)

SELECT * FROM CTE_EmployeeInfo

/*============================================================================
	File:		ManyIndices.sql

	Summary:	The script demonstrates what is the effect on the DML operations
				when there are a lot of indexes on the table.

				THIS SCRIPT IS PART OF THE Lecture: 
				"Performance Tuning" for SoftUni, Sofia;
				"Joins, Subqueries, CTE and Indices"

	Date:		February 2015, January 2017

	SQL Server Version: 2008 / 2012 / 2014 / 2016
------------------------------------------------------------------------------
	Written by Boris Hristov, SQL Server MVP

	This script is intended only as a supplement to demos and lectures
	given by SoftUni Team.  
  
	THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF 
	ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED 
	TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
	PARTICULAR PURPOSE.
============================================================================*/

USE tempdb
GO
-- Create Table
CREATE TABLE FirstIndex (ID INT, 
						FirstName VARCHAR(100), 
						LastName VARCHAR(100), 
						City VARCHAR(100))
GO


INSERT INTO FirstIndex (ID, FirstName, LastName, City)
SELECT TOP 100000 ROW_NUMBER() OVER(ORDER BY a.name) RowID,'Muncho',
        CASE WHEN ROW_NUMBER() OVER(ORDER BY a.name)%2 = 1 THEN 'Smithov' ELSE 'Ivanov' END,
		CASE WHEN ROW_NUMBER() OVER(ORDER BY a.name)%10 = 1 THEN 'Kaspichan'
		     WHEN ROW_NUMBER() OVER(ORDER BY a.name)%10 = 5 THEN 'Gorno Uino'
		     WHEN ROW_NUMBER() OVER(ORDER BY a.name)%10 = 3 THEN 'Simitli'
		     ELSE 'Buhovo' END
  FROM sys.all_objects a
  cross join sys.all_objects b

  GO

 TRUNCATE TABLE FirstIndex
 GO

 -- Create 10 indexes
CREATE NONCLUSTERED INDEX [IX_FirstIndex_ID] ON [dbo].[FirstIndex] 
(
	[ID] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_FirstName] ON [dbo].[FirstIndex] 
(
	[FirstName] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_LastName] ON [dbo].[FirstIndex] 
(
	[LastName] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_City] ON [dbo].[FirstIndex] 
(
	[City] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_ID_FirstName] ON [dbo].[FirstIndex] 
(
	[ID] ASC,
	[FirstName] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_ID_LastName] ON [dbo].[FirstIndex] 
(
	[ID] ASC,
	[LastName] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_ID_City] ON [dbo].[FirstIndex] 
(
	[ID] ASC,
	[City] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_FirstName_LastName] ON [dbo].[FirstIndex] 
(
	[FirstName] ASC,
	[LastName] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_FirstName_City] ON [dbo].[FirstIndex] 
(
	[FirstName] ASC,
	[City] ASC
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IX_FirstIndex_LastName_City] ON [dbo].[FirstIndex] 
(
	[LastName] ASC,
	[City] ASC
) ON [PRIMARY]
GO

-- Insert One Hundred Thousand Records
-- INSERT 2
INSERT INTO FirstIndex (ID,FirstName,LastName,City)
SELECT TOP 100000 ROW_NUMBER() OVER (ORDER BY a.name) RowID, 
					'Bob', 
					CASE WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%2 = 1 THEN 'Smith' 
					ELSE 'Brown' END,
					CASE WHEN ROW_NUMBER() OVER (ORDER BY a.name)%10 = 1 THEN 'New York' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 5 THEN 'San Marino' 
						WHEN  ROW_NUMBER() OVER (ORDER BY a.name)%10 = 3 THEN 'Los Angeles' 
					ELSE 'Houston' END
FROM sys.all_objects a
CROSS JOIN sys.all_objects b
GO
/*
Question 1: Which insert took most the time INSERT 1 or INSERT 2
WHY?
*/
-- Truncate Table
TRUNCATE TABLE FirstIndex
GO