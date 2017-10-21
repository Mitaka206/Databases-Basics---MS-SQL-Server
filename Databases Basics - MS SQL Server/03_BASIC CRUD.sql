--1.	Examine the Databases

--Part I – Queries for SoftUni Database

--2.	Find All Information About Departments
USE SoftUni
SELECT * FROM Departments


--3.	Find all Department Names
SELECT Name FROM Departments


--4.	Find Salary of Each Employee
SELECT FirstName, LastName, Salary FROM Employees


--5.	Find Full Name of Each Employee
SELECT FirstName, MiddleName, LastName FROM Employees


--6.	Find Email Address of Each Employee
SELECT FirstName + '.' + LastName + '@softuni.bg'  AS [Full Email Address] FROM Employees


--7.	Find All Different Employee’s Salaries
SELECT DISTINCT Salary FROM Employees


--8.	Find all Information About Employees
SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'


--9.	Find Names of All Employees by Salary in Range
SELECT FirstName, LastName, JobTitle FROM Employees
WHERE Salary BETWEEN 20000 AND 30000


--10.	 Find Names of All Employees
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
WHERE Salary IN(25000, 14000, 12500, 23600)


--11.	 Find All Employees Without Manager
SELECT FirstName, LastName FROM Employees
WHERE ManagerID IS NULL


--12.	 Find All Employees with Salary More Than 50000
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary >= 50000
ORDER BY Salary DESC


--13.	 Find 5 Best Paid Employees.
SELECT TOP 5 FirstName, LastName FROM Employees
ORDER BY Salary DESC


--14.	Find All Employees Except Marketing
SELECT FirstName, LastName FROM Employees
WHERE NOT (DepartmentID = 4)


--15.	Sort Employees Table
SELECT * FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC


--16.	 Create View Employees with Salaries
CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary FROM Employees

SELECT * FROM V_EmployeesSalaries


--17.	Create View Employees with Job Titles
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName + ' ' + COALESCE (MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle AS [Job Title] FROM Employees

SELECT * FROM V_EmployeeNameJobTitle


--18.	 Distinct Job Titles
SELECT DISTINCT JobTitle FROM Employees
ORDER BY JobTitle


--19.	Find First 10 Started Projects
SELECT TOP 10 * FROM Projects
ORDER BY StartDate, Name ASC


--20.	 Last 7 Hired Employees
SELECT TOP 7 FirstName, LastName, HireDate FROM Employees
ORDER BY HireDate DESC


--21.	Increase Salaries
UPDATE Employees
SET Salary = Salary * 1.12
WHERE DepartmentID IN(1, 2, 4, 11)

SELECT Salary FROM Employees

SELECT * FROM Departments


--Part II – Queries for Geography Database

--22.	 All Mountain Peaks
use Geography

SELECT PeakName FROM Peaks
ORDER BY PeakName


--23.	 Biggest Countries by Population
SELECT TOP 30 CountryName, Population FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName ASC


--24.	 *Countries and Currency (Euro / Not Euro)
SELECT CountryName, CountryCode,(CASE CurrencyCode WHEN 'EUR' THEN 'Euro' ELSE 'Not Euro' END) AS [Currency] FROM Countries
ORDER BY CountryName


--Part III – Queries for Diablo Database

--25.	 All Diablo Characters
USE Diablo

SELECT Name FROM Characters
ORDER BY Name


--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

USE SoftUni

SELECT * FROM Employees
SELECT EmployeeID, FirstName AS [First Name], LastName AS [Last Name], Salary FROM Employees
WHERE Salary > 20000
ORDER BY FirstName
--ORDER BY Salary DESC

-------------------------------------------------------------------------------------------------
SELECT * FROM Employees

CREATE VIEW v_EmplName AS
SELECT d.DepartmentID AS [Department ID], 
	d.Name AS [Departments Name] , 
	e.FirstName + ' ' + e.LastName AS [Full Name], 
	e.Salary  FROM Departments as d
JOIN Employees as [e] ON d.ManagerID = e.EmployeeID
ORDER BY e.Salary DESC
GO

SELECT * fROM v_EmplName

SELECT * FROM Departments
SELECT Employees.EmployeeID AS [Employ Numbeer], Employees.FirstName AS [First Name], Departments.Name AS [Job Name], Employees.JobTitle AS [Job Title] FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID
where salary < 10000
ORDER BY EmployeeID
--------------------------------------------------------------------------------------------------

SELECT FirstName + ' ' + LastName AS [Full Name], 
       JobTitle AS [Job Title], 
	   Salary 
  FROM Employees
--ORDER BY Salary DESC


SELECT * FROM Employees
WHERE NOT(ManagerID = 3 OR ManagerID = 4)
--     ||
SELECT * FROM Employees
WHERE ManagerID NOT IN(3, 4)
--------------------------------------------------------------

SELECT * FROM Employees
WHERE MiddleName is NULL

-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
USE Geography

CREATE VIEW v_TopPeak AS
SELECT TOP 1 * FROM Peaks
ORDER BY Elevation DESC

SELECT * FROM v_TopPeak

GO

-- create tabe and auto inserting info from view
USE SoftUni

SELECT *
  INTO TestNewTable
  FROM v_EmplName

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------

CREATE SEQUENCE seq_TestSequence
	     As INT
	 START WITH 5
   INCREMENT BY 10

SELECT NEXT VALUE FOR seq_TestSequence -- steps of 5

----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
--DELETE

SELECT * FROM TestNewTable

DELETE FROM TestNewTable
WHERE [Department ID] = 5

--UPDATE

USE SoftUni

UPDATE Employees
SET MiddleName = 'Ivanov'
WHERE EmployeeID = 3

SELECT * FROM Employees

-----------------------
SELECT * FROM Projects

UPDATE Projects
   SET EndDate = GETDATE()
 WHERE EndDate IS NULL

