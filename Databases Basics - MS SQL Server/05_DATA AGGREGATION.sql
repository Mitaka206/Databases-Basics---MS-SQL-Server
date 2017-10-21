--Problem 1.	Records’ Count
USE Gringotts

SELECT COUNT(*) FROM WizzardDeposits



--Problem 2.	Longest Magic Wand
SELECT MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits


--Problem 3.	Longest Magic Wand per Deposit Groups
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand FROM WizzardDeposits
GROUP BY DepositGroup


--Problem 4.	* Smallest Deposit Group per Magic Wand Size
SELECT TOP 2 DepositGroup FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)


--Problem 5.	Deposits Sum
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
GROUP BY DepositGroup


--Problem 6.	Deposits Sum for Ollivander Family
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup


--Problem 7.	Deposits Filter
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC

SELECT *FROM WizzardDeposits


--Problem 8.	 Deposit Charge
SELECT DepositGroup, MagicWandCreator, MIN(DepositCharge) AS MinDepositCharge FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup ASC


--Problem 9.	Age Groups
use Gringotts

SELECT ageGroups.AgeGroup, COUNT(*) FROM
	(
	SELECT 
	CASE
	WHEN Age BETWEEN 0 AND 10 THEN '[0-10]'
	WHEN Age BETWEEN 11 AND 20 THEN '[11-20]'
	WHEN Age BETWEEN 21 AND 30 THEN '[21-30]'
	WHEN Age BETWEEN 31 AND 40 THEN '[31-40]'
	WHEN Age BETWEEN 41 AND 50 THEN '[41-50]'
	WHEN Age BETWEEN 51 AND 60 THEN '[51-60]'
	WHEN Age >= 61 THEN '[61+]'
	END AS AgeGroup
	FROM WizzardDeposits)
AS ageGroups
GROUP BY ageGroups.AgeGroup


--Problem 10.	First Letter
SELECT DISTINCT LEFT(FirstName, 1) AS FirstLetter FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
ORDER BY FirstLetter



--Problem 11.	Average Interest
SELECT DepositGroup, IsDepositExpired, AVG(DepositInterest) AS AverageInterest FROM WizzardDeposits
WHERE DepositExpirationDate >= '01/01/1985'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired ASC



--Problem 12.	* Rich Wizard, Poor Wizard
SELECT * FROM WizzardDeposits



--Problem 13.	Departments Total Salaries
USE SoftUni

SELECT DepartmentID, SUM(Salary) AS TotalSalary FROM Employees
GROUP BY DepartmentID



--Problem 14.	Employees Minimum Salaries
SELECT DepartmentID, MIN(Salary) FROM Employees
WHERE HireDate > 01/01/2000 AND DepartmentID IN (2, 5, 7)
GROUP BY DepartmentID


--Problem 15.	Employees Average Salaries
SELECT * INTO NewTable FROM Employees

DELETE FROM NewTable
WHERE ManagerID = 42

UPDATE NewTable
SET Salary += 5000
WHERE Salary >= 30000 AND DepartmentID = 1

SELECT DepartmentID, AVG(Salary) AS AverageSalary FROM NewTable
GROUP BY DepartmentID




--Problem 16.	Employees Maximum Salaries
SELECT DepartmentID, MAX(Salary) AS MaxSalary FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000



--Problem 17.	Employees Count Salaries



--Problem 18.	*3rd Highest Salary
USE SoftUni

SELECT DepartmentID, Salary FROM Employees


--Problem 19.	**Salary Challenge
SELECT AVG(Salary) FROM Employees
GROUP BY DepartmentId 

SELECT TOP 10 e1.FirstName, e1.LastName, e1.DepartmentID FROM Employees AS e1
WHERE Salary > (SELECT AVG(Salary) FROM Employees AS e2 WHERE e2.DepartmentID = e1.DepartmentID
GROUP BY DepartmentId)

--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

USE SoftUni

SELECT DepartmentID, SUM(Salary) AS [TOTAL SALARY] FROM Employees
GROUP BY DepartmentID
ORDER BY [TOTAL SALARY] DESC

SELECT DepartmentID, COUNT(Salary) AS SalaryCount FROM Employees
GROUP BY DepartmentID


SELECT EmployeeID, ProjectID FROM EmployeesProjects
ORDER BY ProjectID

SELECT COUNT(EmployeeID) AS Empl, ProjectID FROM EmployeesProjects
GROUP BY ProjectID
ORDER BY Empl DESc

SELECT FirstName, COUNT(EmployeeID) FROM Employees
GROUP BY FirstName


USE Geography

SELECT COUNT(Id), MountainId FROM Peaks
GROUP BY MountainId

-------------------------------------------------------------------------------------------------
USE Chinook

SELECT InvoiceId, COUNT(InvoiceLineId), SUM(UnitPrice) FROM InvoiceLine
GROUP BY InvoiceId
ORDER BY InvoiceId

SELECT CustomerId, SUM(Total) FROM Invoice
GROUP BY CustomerId

--------------------------------------------------------------------------------------------------
USE SoftUni

SELECT E.DepartmentID, ROUND(AVG(Salary), 2) AS AvgSalary FROM Employees AS E
GROUP BY DepartmentID
HAVING ROUND(AVG(Salary), 2) > 20000
ORDER BY AvgSalary DESC