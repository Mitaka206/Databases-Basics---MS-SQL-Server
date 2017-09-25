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