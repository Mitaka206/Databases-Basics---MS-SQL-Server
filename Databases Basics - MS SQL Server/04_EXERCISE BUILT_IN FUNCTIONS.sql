
--Part I – Queries for SoftUni Database

--Problem 1.	Find Names of All Employees by First Name
USE SoftUni

SELECT FirstName, LastName FROM Employees
WHERE LEFT(FirstName, 2) = 'SA'


--Problem 2.	  Find Names of All employees by Last Name
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'


--Problem 3.	Find First Names of All Employees
SELECT * FROM Employees
WHERE DepartmentId IN(3, 10) AND DepartmentId BETWEEN 1995 AND 2005
ORDER BY HireDate


--Problem 4.	Find All Employees Except Engineers
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE'%engineer%'


--Problem 5.	Find Towns with Name Length
SELECT Name FROM Towns
WHERE LEN(Name) BETWEEN 5 AND 6
ORDER BY Name


--Problem 6.	 Find Towns Starting With
SELECT * FROM Towns
WHERE LEFT(Name, 1) LIKE '%M%'
   OR LEFT(Name, 1) LIKE '%K%' 
   OR LEFT(Name, 1) LIKE '%B%' 
   OR LEFT(Name, 1) LIKE '%E%'
ORDER BY Name


--Problem 7.	 Find Towns Not Starting With
SELECT * FROM Towns
WHERE LEFT(Name, 1) NOT LIKE '%R%'
  AND LEFT(Name, 1) NOT LIKE '%B%'
  AND LEFT(Name, 1) NOT LIKE '%D%'
ORDER BY Name


--Problem 8.	Create View Employees Hired After 2000 Year
CREATE VIEW v_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE YEAR(HireDate) > 2000

SELECT * FROM v_EmployeesHiredAfter2000


--Problem 9.	Length of Last Name
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5


--Part II – Queries for Geography Database 

--Problem 10.	Countries Holding ‘A’ 3 or More Times
USE Geography

SELECT CountryName, IsoCode FROM Countries
WHERE (len(CountryName) - len(replace(CountryName, 'a', ''))) >= 3
ORDER BY IsoCode


--Problem 11.	 Mix of Peak and River Names
SELECT PeakName , RiverName, LOWER( CONCAT(SUBSTRING(PeakName, 1, LEN(PeakName)-1), RiverName)) AS Mix
    FROM Peaks, Rivers
   WHERE (SUBSTRING(PeakName,  LEN(PeakName), LEN(PeakName)) = SUBSTRING(RiverName, 1,1))
ORDER BY Mix;


--Part III – Queries for Diablo Database

--Problem 12.	Games from 2011 and 2012 year
use Diablo

SELECT TOP (50) Name, FORMAT(Start,'yyyy-MM-dd') AS Start FROM Games
WHERE YEAR(Start) = 2011 OR YEAR(Start) = 2012
ORDER BY Start


--Problem 13.	 User Email Providers
SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@',Email)) AS 'Email Provider' FROM Users
ORDER BY RIGHT(Email, LEN(Email) - CHARINDEX('@',Email)), Username ASC


--Problem 14.	 Get Users with IPAdress Like Pattern
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username


--Problem 15.	 Show All Games with Duration and Part of the Day
USE Diablo

  SELECT Name,
  CASE 
		WHEN DATEPART(HOUR, Start) BETWEEN 0 AND 11 THEN 'Morning'
		WHEN DATEPART(HOUR, Start) BETWEEN 12 AND 17 THEN 'Aftrnoon'
		WHEN DATEPART(HOUR, Start) BETWEEN 18 AND 23 THEN 'Evening'
 END AS [Part of the Day],
  CASE 
        WHEN Duration <=3 THEN 'Extra Short'
	    WHEN Duration BETWEEN 4 AND 6 THEN 'Short'
	    WHEN Duration > 6 THEN 'Long'
 END AS Duration
    FROM Games
ORDER BY Name


--Part IV – Date Functions Queries

--Problem 16.	 Orders Table



--Problem 17.	 People Table


--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

USE SoftUni
---- test date
SELECT CONCAT(FirstName, ' ', LastName) AS FullName, DATEDIFF(YEAR, HireDate, GETDATE()) FROM Employees

SELECT DATENAME(WEEKDAY, '11-12-2015')

SELECT FORMAT(DATEADD(MONTH, 12, '11-11-2015'),'dd-MMM-yyyy')


---- offset  and fetch

SELECT * FROM Employees	
ORDER BY EmployeeID
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY

------------ WILDcART
----------------------------------------------------
SELECT * FROM Employees
WHERE LastName LIKE '%rg'
-- % - one or more characters
-----------------------------------------------------
SELECT * FROM Employees
WHERE LastName LIKE '_____rg' -- 5x'_'
-- _ - on character
-----------------------------------------------------
SELECT * FROM Employees
WHERE FirstName LIKE '[pa]%' --start whit P or A

SELECT * FROM Employees
WHERE FirstName LIKE '[a-c]%' --start from A to C
-- [...] - character in range
-------------------------------------------------------
SELECT * FROM Employees
WHERE LastName LIKE '[^pa]%'
-- [^...] - character not in range

CREATE VIEW v_CustumerSummary
AS
SELECT CustomerID, 
	   FirstName, 
	   LastName, 
	   LEFT(PaymentNumber, 6) + REPLICATE('*', LEN(PaymentNumber) - 6)
AS PaymentNumber
FROM Customers

SELECT * FROM v_CustumerSummary

-----------------------------------------------------------------------
USE SoftUni

SELECT EmployeeID, 
	   LEFT(UPPER(FirstName), 3), -- Test -> TEST
	   RIGHT(LOWER(LastName), 3)  -- Test -> test
FROM Employees

-----------------------------------------------------------------------
USE Chinook

SELECT AlbumId
      ,REPLACE(Title, 'Blood', REPLICATE('*', LEN('BLOOD')))
      ,ArtistId
  FROM Album
 WHERE AlbumId = 193

 ------
 SELECT AlbumId
      ,RTRIM(LTRIM(REPLACE(Title, 'Blood', ''))) -- FOR CLEAR SPACES AND NULLS AND STRING EMPTY
      ,ArtistId
  FROM Album
 WHERE AlbumId = 193

 ------
 --FOREVER CLEAR SPACES AND NULLS AND STRING EMPTY
 UPDATE Track
    SET Name = RTRIM(LTRIM(Name))

 SELECT * FROM Track

 ------

	SELECT TrackId, Name 
	  FROM Track
	 WHERE LEN(Name) <> LEN(LTRIM(RTRIM(Name))) -- text LEN != TRIM text TRIM
  ---WHERE LEN(Name) != LEN(LTRIM(RTRIM(Name)))
  ---WHERE NOT LEN(Name) = LEN(LTRIM(RTRIM(Name)))

  SELECT TrackId, Name 
	FROM Track
   WHERE DATALENGTH(Name) <> DATALENGTH(LTRIM(RTRIM(Name)))

----------------------------------------------------------------------------------

USE SoftUni

   SELECT TOP (5) STUFF(FirstName, 1, 0, 'Hajji '), LastName 
    FROM Employees
ORDER BY HireDate

----------------------------------------------------------------------------------

--CATST TEST
SELECT RIGHT('000000000000000000' + CAST(25256 AS nvarchar), 10)

------------

--FORMAT TEST
SELECT FORMAT(25256, 'd10') -- SLOW

----------------------------------------------------------------------------------

SELECT FirstName, LastName FROM Employees
--WHERE LEFT(FirstName, 2) = 'Th' -- FIRST TWO LET?ERS
WHERE RIGHT(FirstName, 2) = 'Th' -- FIRST TWO LET?ERS

------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
--MATH FUNCTIONS

USE Demo

SELECT *, (A * H)/2 AS AREA FROM Triangles2




