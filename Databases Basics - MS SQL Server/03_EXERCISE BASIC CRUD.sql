--1.	Examine the Databases
--Download and get familiar with the SoftUni, Diablo and Geography database schemas and tables. You will use them in the current and following exercises to write queries.



--Part I – Queries for SoftUni Database

--2.	Find All Information About Departments
--Write a SQL query to find all available information about the Departments. Submit your query statements as Prepare DB & run queries.
--Example
--DepartmentID	Name	ManagerID
--1	Engineering	12
--2	Tool Design	4
--3	Sales	273
--…	…	…
USE SoftUni
SELECT * FROM Departments


--3.	Find all Department Names
--Write SQL query to find all Department names. Submit your query statements as Prepare DB & run queries.
--Example
--Name
--Engineering
--Tool Design
--Sales
--…
SELECT Name FROM Departments


--4.	Find Salary of Each Employee
--Write SQL query to find the first name, last name and salary of each employee. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName	Salary
--Guy	Gilbert	12500.00
--Kevin	Brown	13500.00
--Roberto	Tamburello	43300.00
--…	…	…
SELECT FirstName, LastName, Salary FROM Employees


--5.	Find Full Name of Each Employee
--Write SQL query to find the first, middle and last name of each employee. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	MiddleName	LastName
--Guy	R	Gilbert
--Kevin	F	Brown
--Roberto	NULL	Tamburello
--…	…	…
SELECT FirstName, MiddleName, LastName FROM Employees


--6.	Find Email Address of Each Employee
--Write a SQL query to find the email address of each employee. (by his first and last name). Consider that the email domain is softuni.bg. Emails should look like “John.Doe@softuni.bg". The produced column should be named "Full Email Address". Submit your query statements as Prepare DB & run queries.
--Example
--Full Email Address
--Guy.Gilbert@softuni.bg
--Kevin.Brown@softuni.bg
--Roberto.Tamburello@softuni.bg
--…
SELECT FirstName + '.' + LastName + '@softuni.bg'  AS [Full Email Address] FROM Employees


--7.	Find All Different Employee’s Salaries
--Write a SQL query to find all different employee’s salaries. Show only the salaries. Submit your query statements as Prepare DB & run queries.
--Example
--Salary
--9000.00
--9300.00
--9500.00
--…
SELECT DISTINCT Salary FROM Employees


--8.	Find all Information About Employees
--Write a SQL query to find all information about the employees whose job title is “Sales Representative”. Submit your query statements as Prepare DB & run queries.
--Example
--ID	First
--Name	Last
--Name	Middle
--Name	Job Title	DeptID	Mngr
--ID	HireDate	Salary	AddressID
--275	Michael	Blythe	G	Sales Representative	3	268	…	23100.00	60
--276	Linda	Mitchell	C	Sales Representative	3	268	…	23100.00	170
--277	Jillian	Carson	NULL	Sales Representative	3	268	…	23100.00	61
--…	…	…	…	…	…	…	…	…	…
SELECT * FROM Employees
WHERE JobTitle = 'Sales Representative'


--9.	Find Names of All Employees by Salary in Range
--Write a SQL query to find the first name, last name and job title of all employees whose salary is in the range [20000, 30000]. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName	JobTitle
--Rob	Walters	Senior Tool Designer
--Thierry	D'Hers	Tool Designer
--JoLynn	Dobney	Production Supervisor
--…	…	…
SELECT FirstName, LastName, JobTitle FROM Employees
WHERE Salary BETWEEN 20000 AND 30000


--10.	 Find Names of All Employees 
--Write a SQL query to find the full name of all employees whose salary is 25000, 14000, 12500 or 23600. Full Name is combination of first, middle and last name (separated with single space) and they should be in one column called “Full Name”. Submit your query statements as Prepare DB & run queries.
--Example
--Full Name
--Guy R Gilbert
--Thierry B D'Hers
--JoLynn M Dobney
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS [Full Name] FROM Employees
WHERE Salary IN(25000, 14000, 12500, 23600)


--11.	 Find All Employees Without Manager
--Write a SQL query to find first and last names about those employees that does not have a manager. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Ken	Sanchez
--Svetlin	Nakov
--…	…
SELECT FirstName, LastName FROM Employees
WHERE ManagerID IS NULL


--12.	 Find All Employees with Salary More Than 50000
--Write a SQL query to find first name, last name and salary of those employees who has salary more than 50000. Order them in decreasing order by salary. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName	Salary
--Ken	Sanchez	125500.00
--James	Hamilton	84100.00
--…	…	…
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary >= 50000
ORDER BY Salary DESC


--13.	 Find 5 Best Paid Employees.
--Write SQL query to find first and last names about 5 best paid Employees ordered descending by their salary. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Ken	Sanchez
--James	Hamilton
--…	…
SELECT TOP 5 FirstName, LastName FROM Employees
ORDER BY Salary DESC


--14.	Find All Employees Except Marketing
--Write a SQL query to find the first and last names of all employees whose department ID is different from 4. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Guy	Gilbert
--Roberto	Tamburello
--Rob	Walters
SELECT FirstName, LastName FROM Employees
WHERE NOT (DepartmentID = 4)


--15.	Sort Employees Table
--Write a SQL query to sort all records in the Employees table by the following criteria: 
--•	First by salary in decreasing order
--•	Then by first name alphabetically
--•	Then by last name descending
--•	Then by middle name alphabetically
--Submit your query statements as Prepare DB & run queries.
--Example
--ID	First
--Name	Last
--Name	Middle
--Name	Job Title	DeptID	Mngr
--ID	HireDate	Salary	AddressID
--109	Ken	Sanchez	J	Chief Executive Officer	16	NULL	…	125500.00	177
--148	James	Hamilton	R	Vice President of Production	7	109	…	84100.00	158
--273	Brian	Welcker	S	Vice President of Sales	3	109	…	72100.00	134
--…	…	…	…	…	…	…	…	…	…
SELECT * FROM Employees
ORDER BY Salary DESC, FirstName ASC, LastName DESC, MiddleName ASC


--16.	 Create View Employees with Salaries
--Write a SQL query to create a view V_EmployeesSalaries with first name, last name and salary for each employee. Submit your query statements as Run skeleton, run queries & check DB.
--Example
--FirstName	LastName	Salary
--Guy	Gilbert	12500.00
--Kevin	Brown	13500.00
--…	…	…
CREATE VIEW V_EmployeesSalaries AS
SELECT FirstName, LastName, Salary FROM Employees

SELECT * FROM V_EmployeesSalaries


--17.	Create View Employees with Job Titles
--Write a SQL query to create view V_EmployeeNameJobTitle with full employee name and job title. When middle name is NULL replace it with empty string (‘’). Submit your query statements as Run skeleton, run queries & check DB.
--Example
--Full Name	Job Title
--Guy R Gilbert	Production Technician
--Kevin F Brown	Marketing Assistant
--Roberto  Tamburello	Engineering Manager
--…	…
CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName + ' ' + COALESCE (MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle AS [Job Title] FROM Employees

SELECT * FROM V_EmployeeNameJobTitle


--18.	 Distinct Job Titles
--Write a SQL query to find all distinct job titles. Submit your query statements as Prepare DB & run queries.
--Example
--JobTitle
--Accountant
--Accounts Manager
--Accounts Payable Specialist
--…
SELECT DISTINCT JobTitle FROM Employees
ORDER BY JobTitle


--19.	Find First 10 Started Projects
--Write a SQL query to find first 10 started projects. Select all information about them and sort them by start date, then by name. Submit your query statements as Prepare DB & run queries.
--Example
--ID	Name	Description	StartDate	EndDate
--6	HL Road Frame	Research, design and development of HL Road …	1998-05-02 00:00:00	2003-06-01 00:00:00
--2	Cycling Cap	Research, design and development of C…	2001-06-01 00:00:00	2003-06-01 00:00:00
--5	HL Mountain Frame	Research, design and development of HL M…	2001-06-01 00:00:00	2003-06-01 00:00:00
--…	…	…	…	…
SELECT TOP 10 * FROM Projects
ORDER BY StartDate, Name ASC


--20.	 Last 7 Hired Employees
--Write a SQL query to find last 7 hired employees. Select their first, last name and their hire date. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName	HireDate
--Rachel	Valdez	2005-07-01 00:00:00
--Lynn	Tsoflias	2005-07-01 00:00:00
--Syed	Abbas	2005-04-15 00:00:00
--…	…	…
SELECT TOP 7 FirstName, LastName, HireDate FROM Employees
ORDER BY HireDate DESC


--21.	Increase Salaries
--Write a SQL query to increase salaries of all employees that are in the Engineering, Tool Design, Marketing or Information Services department by 12%. Then select Salaries column from the Employees table. After that exercise restore your database to revert those changes. Submit your query statements as Prepare DB & run queries.
--Example
--Salary
--12500.00
--15120.00
--48496.00
--33376.00
--…
UPDATE Employees
SET Salary = Salary * 1.12
WHERE DepartmentID IN(1, 2, 4, 11)

SELECT Salary FROM Employees

SELECT * FROM Departments


--Part II – Queries for Geography Database

--22.	 All Mountain Peaks
--Display all mountain peaks in alphabetical order. Submit your query statements as Prepare DB & run queries.
--Example
--PeakName
--Aconcagua
--Banski Suhodol
--Batashki Snezhnik
--…
use Geography

SELECT PeakName FROM Peaks
ORDER BY PeakName


--23.	 Biggest Countries by Population
--Find the 30 biggest countries by population from Europe. Display the country name and population. Sort the results by population (from biggest to smallest), then by country alphabetically. Submit your query statements as Prepare DB & run queries.
--Example
--CountryName	Population
--Russia	140702000
--Germany	81802257
--France	64768389
--…	…
SELECT TOP 30 CountryName, Population FROM Countries
WHERE ContinentCode = 'EU'
ORDER BY Population DESC, CountryName ASC


--24.	 *Countries and Currency (Euro / Not Euro)
--Find all countries along with information about their currency. Display the country code, country name and information about its currency: either "Euro" or "Not Euro". Sort the results by country name alphabetically. Submit your query statements as Prepare DB & run queries.
--*Hint: Use CASE … WHEN.
--Example
--CountryName	CountryCode	Currency
--Afghanistan	AF	Not Euro
--Åland	AX	Euro
--Albania	AL	Not Euro
--…	…	…
SELECT CountryName, CountryCode,(CASE CurrencyCode WHEN 'EUR' THEN 'Euro' ELSE 'Not Euro' END) AS [Currency] FROM Countries
ORDER BY CountryName


--Part III – Queries for Diablo Database

--25.	 All Diablo Characters
--Display all characters in alphabetical order. Submit for evaluation the result text comma separated with headers. Submit your query statements as Prepare DB & run queries.
--Example
--Name
--Amazon
--Assassin
--Barbarian
--…
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

