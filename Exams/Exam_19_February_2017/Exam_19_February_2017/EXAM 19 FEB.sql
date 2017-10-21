CREATE DATABASE Bakery
USE Bakery
GO
-------------------------
--01. CREATE 7 TABLES
CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) UNIQUE
)

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(25),
    LastName VARCHAR(25),
	Age INT ,
    Gender CHAR(1) CHECK(Gender = 'M' OR Gender = 'F'),
    PhoneNumber NVARCHAR(10),
    CountryId INT REFERENCES Countries(Id)
)

CREATE TABLE Distributors(
	Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25) UNIQUE,
	CountryId INT REFERENCES Countries(Id),
    AddressText NVARCHAR(30),
    Summary NVARCHAR(200)
)

CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name VARCHAR(25) UNIQUE,
	Description NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price DECIMAL(38,2) CHECK (PRICE >= 0)
)

CREATE TABLE Feedbacks(
	Id INT PRIMARY KEY IDENTITY (1,1),
	ProductId INT,
	CustomerId INT,
	Rate DECIMAL(4,2),
	Description NVARCHAR(255),
	
	CONSTRAINT CH_Rate CHECK(Rate BETWEEN 0 AND 10),
	CONSTRAINT FK_Feedbacks_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)

CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(30),
	OriginCountryId INT REFERENCES Countries(Id),
	Description NVARCHAR(200),
	DistributorId INT REFERENCES Distributors(Id)
)

CREATE TABLE ProductsIngredients(
	ProductId INT,
	IngredientId INT,

	CONSTRAINT PK_ProductsIngredients PRIMARY KEY (ProductId, IngredientId),
	CONSTRAINT FK_ProductsIngredients_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_ProductsIngredients_Ingredient FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)
----------------------------------------------------------------------------------
--TEST

SELECT COUNT(*)
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_CATALOG = DB_NAME()

----------------------------------------------------------------------------------
--02. INSERT
INSERT INTO Distributors(Name, CountryId, AddressText, Summary)
VALUES
('Deloitte & Touche', '2', '6 Arch St #9757', 'Customizable neutral traveling'),
('Congress Title', '13', '58 Hancock St', 'Customer loyalty'),
('Kitchen People', '1', '3 E 31st St #77', 'Triple-buffered stable delivery'),
('General Color Co Inc', '21', '6185 Bohn St #72', 'Focus group'),
('Beck Corporation', '23', '21 E 64th Ave', 'Quality-focused 4th generation hardware')

INSERT INTO Customers(FirstName, LastName, Age, Gender, PhoneNumber, CountryId)
VALUES
('Francoise', 'Rautenstrauch', 15, 'M', '0195698399',5),
('Kendra', 'Loud',	22,	'F', '0063631526', 11),
('Lourdes', 'Bauswell',	50,	'M', '0139037043', 8),
('Hannah', 'Edmison',18, 'F', '0043343686', 1),
('Tom', 'Loeza', 31,'M', '0144876096', 23),
('Queenie', 'Kramarczyk', 30,'F', '0064215793', 29),
('Hiu', 'Portaro', 25, 'M', '0068277755', 16),
('Josefa', 'Opitz', 43,'F', '0197887645', 17)


---------------------------------------------------
--03. UPDATE
UPDATE Ingredients
SET DistributorId = 35
WHERE NAME IN ('Bay Leaf', 'Paprika', 'Poppy')

UPDATE Ingredients
SET OriginCountryId = 14
WHERE OriginCountryId = 8


---------------------------------------------------
--04. DELETE
DELETE FROM Feedbacks
WHERE CustomerId = 14 OR ProductId = 5


---------------------------------------------------
--05. PRODUCT BY PRICE
SELECT Name, Price, Description FROM Products
ORDER BY Price DESC, Name

---------------------------------------------------
--06. INGREDIENTS
SELECT Name, Description, OriginCountryId FROM Ingredients
WHERE OriginCountryId IN (1, 10, 20)
ORDER BY Id

--------------------------------------------------
--07. INGREDIENS FROM BG AND GRE
SELECT TOP 15 I.Name, I.Description, C.Name FROM Ingredients AS I
JOIN Countries AS C ON C.Id = I.OriginCountryId
WHERE C.Name = 'Greece' OR C.Name = 'Bulgaria'
ORDER BY I.Name, C.Name


--------------------------------------------------
--08. BEST RATE
SELECT TOP 10 P.Name, P.Description, AVG(F.Rate) AS AverageRate, COUNT(*) AS FeedbacksAmount FROM Products AS P
JOIN Feedbacks AS F ON F.ProductId = P.Id 
GROUP BY P.Id, P.Name, P.Description
ORDER BY AverageRate DESC, FeedbacksAmount DESC


--------------------------------------------------
--09. NEGATIVE FEEDBACK
SELECT F.ProductId, F.Rate, F.Description, F.CustomerId, C.Age, C.Gender FROM Feedbacks AS F
JOIN Customers AS C ON C.Id = F.CustomerId 
WHERE F.Rate < 5
ORDER BY ProductId DESC, Rate


---------------------------------------------------
--10. WITHOUT FEEDBACK
SELECT CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, C.PhoneNumber, C.Gender FROM Customers AS C
LEFT JOIN Feedbacks AS F ON F.CustomerId = C.Id
WHERE F.Id IS NULL
ORDER BY C.Id


----------------------------------------------------
--11. HONORABLE MENTIONS
  SELECT ProductId, CONCAT(C.FirstName, ' ', C.LastName) AS CustomerName, F.Description AS FeedbackDescription FROM Feedbacks AS F
    JOIN Customers AS C ON C.Id  = F.CustomerId
   WHERE C.Id IN(SELECT CustomerId FROM Feedbacks AS f
   			   GROUP BY CustomerId
   			     HAVING COUNT(f.Id) >= 3)
ORDER BY ProductId, CustomerName, F.Id


----------------------------------------------------
--12. Customers by Criteria
SELECT FirstName, Age, PhoneNumber FROM Customers
JOIN Countries AS C ON C.Id = Customers.CountryId
WHERE (FirstName LIKE '%an%' OR PhoneNumber LIKE '%38') AND Age>= 21 AND C.Name <> 'Greece'
ORDER BY FirstName, Age DESC


----------------------------------------------------
--13. Middle Range Distributors
 
SELECT D.Name AS DistributorName, I.Name AS IngredientName, P.Name AS ProductName, AVG(F.Rate) AS AverageRate 
  FROM Ingredients AS I
  JOIN Distributors AS D ON D.Id = I.DistributorId
  JOIN ProductsIngredients AS PII ON PII.IngredientId = I.Id
  JOIN Feedbacks AS F ON F.ProductId = PII.ProductId
  JOIN Products AS P ON P.Id = F.ProductId
GROUP BY D.Name, I.Name, P.Name
HAVING AVG(F.Rate) BETWEEN 5 AND 8
ORDER BY D.Name, I.Name, P.Name

---------------------------------------------------------
--14. The Most Positive Country

SELECT TOP 1 WITH TIES CO.Name, AVG(F.Rate) AS FeedbackRate FROM Customers AS C
JOIN Feedbacks AS F ON F.CustomerId = C.Id
JOIN Countries AS CO ON CO.Id = C.CountryId
GROUP BY CO.Name
ORDER BY FeedbackRate DESC


---------------------------------------------------------
--15. Country Representative