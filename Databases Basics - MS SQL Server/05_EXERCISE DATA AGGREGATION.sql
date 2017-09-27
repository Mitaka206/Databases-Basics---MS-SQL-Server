--Problem 1.	Records’ Count



--Problem 2.	Longest Magic Wand



--Problem 3.	Longest Magic Wand per Deposit Groups



--Problem 4.	* Smallest Deposit Group per Magic Wand Size



--Problem 5.	Deposits Sum



--Problem 6.	Deposits Sum for Ollivander Family



--Problem 7.	Deposits Filter



--Problem 8.	 Deposit Charge



--Problem 9.	Age Groups



--Problem 10.	First Letter



--Problem 11.	Average Interest



--Problem 12.	* Rich Wizard, Poor Wizard



--Problem 13.	Departments Total Salaries



--Problem 14.	Employees Minimum Salaries



--Problem 15.	Employees Average Salaries



--Problem 16.	Employees Maximum Salaries



--Problem 17.	Employees Count Salaries



--Problem 18.	*3rd Highest Salary



--Problem 19.	**Salary Challenge


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
ORDER BY Empl DESC

