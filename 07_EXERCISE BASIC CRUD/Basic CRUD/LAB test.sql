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
