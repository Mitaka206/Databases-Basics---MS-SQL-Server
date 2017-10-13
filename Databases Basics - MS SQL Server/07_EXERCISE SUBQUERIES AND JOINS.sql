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



--Problem 12.	Highest Peaks in Bulgaria



--Problem 13.	Count Mountain Ranges



--Problem 14.	Countries with Rivers



--Problem 15.	*Continents and Currencies



--Problem 16.	Countries without any Mountains



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

  

