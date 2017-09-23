USE SoftUni

SELECT * FROM Employees
SELECT EmployeeID, FirstName AS [First Name], LastName AS [Last Name], Salary FROM Employees
WHERE Salary > 20000
ORDER BY FirstName
--ORDER BY Salary DESC

-------------------------------------------------------------
SELECT * FROM Employees
SELECT Departments.DepartmentID AS [Department ID], Departments.Name AS [Departments Name] , Employees.FirstName + ' ' + Employees.LastName AS [Full Name]  FROM Departments
JOIN Employees ON Departments.ManagerID = Employees.EmployeeID

