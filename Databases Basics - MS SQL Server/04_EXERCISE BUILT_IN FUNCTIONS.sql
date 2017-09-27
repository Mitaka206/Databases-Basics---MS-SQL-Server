
--Part I – Queries for SoftUni Database
--Problem 1.	Find Names of All Employees by First Name
--Write a SQL query to find first and last names of all employees whose first name starts with “SA”. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Sariya	Harnpadoungsataya
--Sandra	Reategui Alayo
--…	…
USE SoftUni

SELECT FirstName, LastName FROM Employees
WHERE LEFT(FirstName, 2) = 'SA'


--Problem 2.	  Find Names of All employees by Last Name 
--Write a SQL query to find first and last names of all employees whose last name contains “ei”. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Kendall	Keil
--Christian	Kleinerman
--…	…
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'


--Problem 3.	Find First Names of All Employees
--Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is between 1995 and 2005 inclusive. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName
--Deborah
--Wendy
--Candy
--…
SELECT * FROM Employees
WHERE DepartmentId IN(3, 10) AND DepartmentId BETWEEN 1995 AND 2005
ORDER BY HireDate


--Problem 4.	Find All Employees Except Engineers
--Write a SQL query to find the first and last names of all employees whose job titles does not contain “engineer”. Submit your query statements as Prepare DB & run queries.
--Example
--FirstName	LastName
--Guy	Gilbert
--Kevin	Brown
--Rob	Walters
--…	…
SELECT FirstName, LastName FROM Employees
WHERE JobTitle NOT LIKE'%engineer%'


--Problem 5.	Find Towns with Name Length
--Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name. Submit your query statements as Prepare DB & run queries.
--Example
--Name
--Berlin
--Duluth
--Duvall
--…
SELECT Name FROM Towns
WHERE LEN(Name) BETWEEN 5 AND 6
ORDER BY Name


--Problem 6.	 Find Towns Starting With
--Write a SQL query to find all towns that start with letters M, K, B or E. Order them alphabetically by town name. Submit your query statements as Prepare DB & run queries.
--Example
--TownID	Name
--5	Bellevue
--31	Berlin
--30	Bordeaux
--…	…
SELECT * FROM Towns
WHERE LEFT(Name, 1) LIKE '%M%'
   OR LEFT(Name, 1) LIKE '%K%' 
   OR LEFT(Name, 1) LIKE '%B%' 
   OR LEFT(Name, 1) LIKE '%E%'
ORDER BY Name


--Problem 7.	 Find Towns Not Starting With
--Write a SQL query to find all towns that does not start with letters R, B or D. Order them alphabetically by name. Submit your query statements as Prepare DB & run queries.
--Example
--TownID	Name
--2	Calgary
--23	Cambridge
--15	Carnation
--…	…
SELECT * FROM Towns
WHERE LEFT(Name, 1) NOT LIKE '%R%'
  AND LEFT(Name, 1) NOT LIKE '%B%'
  AND LEFT(Name, 1) NOT LIKE '%D%'
ORDER BY Name


--Problem 8.	Create View Employees Hired After 2000 Year
--Write a SQL query to create view V_EmployeesHiredAfter2000 with first and last name to all employees hired after 2000 year. Submit your query statements as Run skeleton, run queries & check DB.
--Example
--FirstName	LastName
--Steven	Selikoff
--Peter	Krebs
--Stuart	Munson
--...	...
CREATE VIEW v_EmployeesHiredAfter2000 AS
SELECT FirstName, LastName FROM Employees
WHERE YEAR(HireDate) > 2000

SELECT * FROM v_EmployeesHiredAfter2000


--Problem 9.	Length of Last Name
--Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
--Example
--FirstName	LastName
--Kevin	Brown
--Terri	Duffy
--Jo	Brown
--Diane	Glimp
--…	…
SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5


--Part II – Queries for Geography Database 

--Problem 10.	Countries Holding ‘A’ 3 or More Times
--Find all countries that holds the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code. Display the country name and ISO code. Submit your query statements as Prepare DB & run queries.
--Example
--CountryName	ISO Code
--Afghanistan	AFG
--Albania	ALB
--…	…
USE Geography

SELECT CountryName, IsoCode FROM Countries
WHERE (len(CountryName) - len(replace(CountryName, 'a', ''))) >= 3
ORDER BY IsoCode


--Problem 11.	 Mix of Peak and River Names
--Combine all peak names with all river names, so that the last letter of each peak name is the same like the first letter of its corresponding river name. Display the peak names, river names, and the obtained mix (mix should be in lowercase). Sort the results by the obtained mix. Submit your query statements as Prepare DB & run queries.
--Example
--PeakName	RiverName	Mix
--Aconcagua	Amazon	aconcaguamazon
--Aconcagua	Amur	aconcaguamur
--Banski Suhodol	Lena	banski suhodolena
--…	…	…
SELECT PeakName , RiverName, LOWER( CONCAT(SUBSTRING(PeakName, 1, LEN(PeakName)-1), RiverName)) AS Mix
    FROM Peaks, Rivers
   WHERE (SUBSTRING(PeakName,  LEN(PeakName), LEN(PeakName)) = SUBSTRING(RiverName, 1,1))
ORDER BY Mix;


--Part III – Queries for Diablo Database

--Problem 12.	Games from 2011 and 2012 year
--Find the top 50 games ordered by start date, then by name of the game. Display only games from 2011 and 2012 year. Display start date in the format “yyyy-MM-dd”. Submit your query statements as Prepare DB & run queries.
--Example
--Name	Start
--Rose Royalty	2011-01-05
--London	2011-01-13
--Broadway	2011-01-16
--…	…
use Diablo

SELECT TOP (50) Name, FORMAT(Start,'yyyy-MM-dd') AS Start FROM Games
WHERE YEAR(Start) = 2011 OR YEAR(Start) = 2012
ORDER BY Start


--Problem 13.	 User Email Providers
--Find all users along with information about their email providers. Display the username and email provider. Sort the results by email provider alphabetically, then by username. Submit your query statements as Prepare DB & run queries.
--Example
--Username	Email Provider
--Pesho	abv.bg
--monoxidecos	astonrasuna.com
--bashsassafras	balibless
--…	…
SELECT Username, RIGHT(Email, LEN(Email) - CHARINDEX('@',Email)) AS 'Email Provider' FROM Users
ORDER BY RIGHT(Email, LEN(Email) - CHARINDEX('@',Email)), Username ASC


--Problem 14.	 Get Users with IPAdress Like Pattern
--Find all users along with their IP addresses sorted by username alphabetically. Display only rows that IP address matches the pattern: “***.1^.^.***”. Submit your query statements as Prepare DB & run queries.
--Legend: * - one symbol, ^ - one or more symbols
--Example
--Username	IP Address
--bindbawdy	192.157.20.222
--evolvingimportant	223.175.227.173
--inguinalself	255.111.250.207
--…	…
SELECT Username, IpAddress FROM Users
WHERE IpAddress LIKE '___.1%.%.___'
ORDER BY Username


--Problem 15.	 Show All Games with Duration and Part of the Day
--Find all games with part of the day and duration sorted by game name alphabetically then by duration (alphabetically, not by the timespan) and part of the day (all ascending). Parts of the day should be Morning (time is >= 0 and < 12), Afternoon (time is >= 12 and < 18), Evening (time is >= 18 and < 24). Duration should be Extra Short (smaller or equal to 3), Short (between 4 and 6 including), Long (greater than 6) and Extra Long (without duration). Submit your query statements as Prepare DB & run queries.
--Example
--Game	Part of the Day	Duration
--Ablajeck	Morning	Long
--Ablajeck	Afternoon	Short
--Abregado Rae	Afternoon	Long
--Abrion	Morning	Extra Short
--Acaeria	Evening	Long
--…	…	…
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
--You are given a table Orders(Id, ProductName, OrderDate) filled with data. Consider that the payment for that order must be accomplished within 3 days after the order date. Also the delivery date is up to 1 month. Write a query to show each product’s name, order date, pay and deliver due dates. Submit your query statements as Prepare DB & run queries.
--Original Table
--Id	ProductName	OrderDate
--1	Butter	2016-09-19 00:00:00.000
--2	Milk	2016-09-30 00:00:00.000
--3	Cheese	2016-09-04 00:00:00.000
--4	Bread	2015-12-20 00:00:00.000
--5	Tomatoes	2015-12-30 00:00:00.000
--…	…	…
--Output
--ProductName	OrderDate	Pay Due	Deliver Due
--Butter	2016-09-19 00:00:00.000	2016-09-22 00:00:00.000	2016-10-19 00:00:00.000
--Milk	2016-09-30 00:00:00.000	2016-10-03 00:00:00.000	2016-10-30 00:00:00.000
--Cheese	2016-09-04 00:00:00.000	2016-09-07 00:00:00.000	2016-10-04 00:00:00.000
--Bread	2015-12-20 00:00:00.000	2015-12-23 00:00:00.000	2016-01-20 00:00:00.000
--Tomatoes	2015-12-30 00:00:00.000	2016-01-02 00:00:00.000	2016-01-30 00:00:00.000
--…	…	…	…
--Problem 17.	 People Table
--Create a table People(Id, Name, Birthdate). Write a query to find age in years, months, days and minutes for each person for the current time of executing the query.
--Original Table
--Id	Name	Birthdate
--1	Victor	2000-12-07 00:00:00.000
--2	Steven	1992-09-10 00:00:00.000
--3	Stephen	1910-09-19 00:00:00.000
--4	John	2010-01-06 00:00:00.000
--…	…	…
--Example Output
--Name	Age in Years	Age in Months	Age in Days	Age in Minutes
--Victor	16	189	5754	8286787
--Steven	24	288	8764	12621187
--Stephen	106	1272	38706	55737667
--John	6	80	2437	3510307
--…	…	…	…	…


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




