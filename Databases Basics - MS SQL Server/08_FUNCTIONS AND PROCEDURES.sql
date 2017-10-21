--Problem 1.	Employees with Salary Above 35000
CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000
	AS
	BEGIN
		SELECT FirstName, LastName FROM Employees
		WHERE Salary > 35000
	END

	EXEC usp_GetEmployeesSalaryAbove35000
	GO

--Problem 2.	Employees with Salary Above Number
CREATE PROC usp_GetEmployeesSalaryAboveNumber (@SuppliedNum DECIMAL(18,4))
	AS
	BEGIN
		SELECT FirstName, LastName FROM Employees
		WHERE Salary >= @SuppliedNum
	END

	EXEC usp_GetEmployeesSalaryAboveNumber 50000
	GO

--Problem 3.	Town Names Starting With
CREATE PROC usp_GetTownsStartingWith (@StartLeter VARCHAR(5))
	AS
	BEGIN
		SELECT Name AS Town FROM Towns
		WHERE Name LIKE @StartLeter + '%' --NB  -- A% --
	END

	EXEC usp_GetTownsStartingWith BO
	GO

--Problem 4.	Employees from Town
CREATE OR ALTER PROC usp_GetEmployeesFromTown (@FromTown NVARCHAR(50))
	AS
	BEGIN
		SELECT e.FirstName, e.LastName FROM Employees AS e
		JOIN Addresses AS a ON a.AddressID=e.AddressID
		JOIN Towns AS t ON t.TownID = a.TownID
		WHERE @FromTown = t.Name
	END

	EXEC usp_GetEmployeesFromTown Sofia
	GO


--Problem 5.	Salary Level Function
CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@Salary DECIMAL(18,2))
RETURNS VARCHAR(10)
AS
 BEGIN
	DECLARE @SalaryLevel VARCHAR(10)

	IF (@Salary < 30000)
		BEGIN
			SET @SalaryLevel = 'Low'
		END

	ELSE IF (@Salary >= 30000 AND @Salary < 50000)
		BEGIN
			SET @SalaryLevel = 'Average'
		END

	ELSE 
		BEGIN
			SET @SalaryLevel = 'High'
		END

	RETURN @SalaryLevel
 END
 GO


--Problem 6.	Employees by Salary Level
CREATE PROC usp_EmployeesBySalaryLevel (@SalaryLvl NVARCHAR(50))
	AS 
	BEGIN
		SELECT FirstName, 
  			   LastName
          FROM Employees
         WHERE dbo.ufn_GetSalaryLevel(Salary) = @SalaryLvl
	END

	EXEC usp_EmployeesBySalaryLevel high 
	GO


--Problem 7.	Define Function
CREATE OR ALTER FUNCTION ufn_IsWordComprised(@SetOfLetters NVARCHAR(50), @Word NVARCHAR(50))
	RETURNS BIT
	AS
	BEGIN
      	DECLARE @IsCompres BIT = 0;
        DECLARE @CurrIndex INT = 1;
        DECLARE @CurrChar CHAR;

            WHILE(@CurrIndex <= LEN(@word))
            BEGIN
              SET @CurrChar = SUBSTRING(@word, @CurrIndex, 1);
               IF(CHARINDEX(@CurrChar, @setOfLetters) = 0)

           RETURN @IsCompres;

              SET @CurrIndex += 1;
              END

           RETURN @IsCompres + 1;
    END

	

--Problem 8.	* Delete Employees and Departments


--Problem 9.	Find Full Name
USE Bank
GO
CREATE PROCEDURE usp_GetHoldersFullName 
AS
BEGIN
	SELECT CONCAT(FirstName, ' ', LastName) AS [Full Name] FROM AccountHolders
END

EXEC usp_GetHoldersFullName
GO

--Problem 10.	People with Balance Higher Than

CREATE OR ALTER PROC usp_GetHoldersWithBalanceHigherThan(@Total DECIMAL)
AS
BEGIN 
	SELECT AccountHolderId FROM Accounts
	GROUP BY AccountHolderId
	HAVING SUM(Balance) > @Total
END
EXEC usp_GetHoldersWithBalanceHigherThan 254.26


--Problem 11.	Future Value Function


--Problem 12.	Calculating Interest


--Problem 13.	*Scalar Function: Cash in User Games Odd Rows



--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

USE SoftUni
SELECT * FROM Projects

GO

CREATE OR ALTER FUNCTION udf_ProjectDurationWeeks(@StartDate DATETIME, @EndDate DATETIME)
        RETURNS INT
		AS
		BEGIN
			IF (@EndDate IS NULL)
				BEGIN
					 SET @EndDate = GETDATE();
			    END

			DECLARE @CountOfWeeks INT = DATEDIFF(WEEK, @StartDate, @EndDate);
			RETURN @CountOfWeeks
		END
GO

SELECT 
	   Name, 
	   StartDate, 
	   EndDate, 
	   dbo.udf_ProjectDurationWeeks(StartDate, EndDate) AS DurationWeeks
  FROM Projects

GO
--- LOW / AVERAGE / HIGH

CREATE OR ALTER FUNCTION ufn_GetSalaryLevel(@Salary MONEY)
RETURNS VARCHAR(10)
AS
 BEGIN
	DECLARE @SalaryLevel VARCHAR(10)
		SET @SalaryLevel = 
			CASE WHEN @Salary < 30000 THEN 'Low'
				 WHEN @Salary BETWEEN 30000 AND 50000 THEN 'Average'
				 ELSE 'High'
			END
	--IF (@Salary < 30000)
	--	BEGIN
	--		SET @SalaryLevel = 'Low'
	--	END

	--ELSE IF (@Salary >= 30000 AND @Salary < 50000)
	--	BEGIN
	--		SET @SalaryLevel = 'Average'
	--	END

	--ELSE 
	--	BEGIN
	--		SET @SalaryLevel = 'High'
	--	END

	RETURN @SalaryLevel
 END

 GO

  SELECT FirstName, 
  		 LastName, 
  		 Salary, 
  		 dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel 
    FROM Employees
ORDER BY Salary DESC

  SELECT dbo.udf_GetSalaryLevel(Salary) AS SalaryLevel ,
		 COUNT(*) AS CountLevel
    FROM Employees
GROUP BY dbo.udf_GetSalaryLevel(Salary)
ORDER BY CountLevel DESC
GO
----------------------
USE Gringotts
SELECT * FROM WizzardDeposits
GO

CREATE OR ALTER FUNCTION udf_GetAgeGroup(@Age INT)
RETURNS VARCHAR(10)
AS 
	BEGIN
		DECLARE @LowerBound INT = ((@Age - 1) / 10) * 10 + 1
		DECLARE @UpperBound INT = (@LowerBound -1) + 10

		DECLARE @EndResult VARCHAR(10) = '[' + CAST(@LowerBound AS VARCHAR(3)) + '-' + CAST(@UpperBound AS VARCHAR(3)) + ']'

		RETURN @EndResult
	END
	GO

  SELECT dbo.udf_GetAgeGroup(Age) AS AgeRange, COUNT(*) AS CountGrups
    FROM WizzardDeposits
GROUP BY dbo.udf_GetAgeGroup(Age)

--STORED PROCEDURES

USE SoftUni
GO

CREATE OR ALTER PROC dbo.usp_GetEmployeesBySeNiority (@HireYears INT = 5) -- 5 IS DEFAULT
	         	  AS 
	           BEGIN
	         		SELECT * FROM Employees
	         		WHERE DATEDIFF(YEAR, HireDate, GETDATE()) > @HireYears
	             END
	         
   	            EXEC dbo.usp_GetEmployeesBySeNiority 16