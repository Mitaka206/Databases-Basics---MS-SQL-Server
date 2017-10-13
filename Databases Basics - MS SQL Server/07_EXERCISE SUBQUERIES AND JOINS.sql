--Problem 1.	Employee Address



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



--Problem 4.	Employee Departments



--Problem 5.	Employees Without Project



--Problem 6.	Employees Hired After



--Problem 7.	Employees with Project



--Problem 8.	Employee 24



--Problem 9.	Employee Manager



--Problem 10.	Employee Summary



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


