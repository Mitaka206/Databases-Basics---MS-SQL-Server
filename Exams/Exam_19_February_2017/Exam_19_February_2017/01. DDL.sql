CREATE DATABASE Bakery


CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) UNIQUE
)

CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(25),
    LastName VARCHAR(25),
    Gender CHAR(1),
    Age INT ,
    PhoneNumber VARCHAR(10),
    CountryId INT,

	CONSTRAINT CH_Gender CHECK(Gender = 'M' OR Gender = 'F'),
	CONSTRAINT FK_Customers_Countries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

CREATE TABLE Distributors(
	Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25) UNIQUE,
    AddressText VARCHAR(30),
    Summary VARCHAR(200),
    CountryId INT,

	CONSTRAINT FK_Distributors_Coutries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(30),
	Description VARCHAR(200),
	OriginCountryId INT,
	DistributorId INT,

	CONSTRAINT FK_Ingredients_Countries FOREIGN KEY (OriginCountryId) REFERENCES Countries(Id),
	CONSTRAINT FK_Ingredients_Distributors FOREIGN KEY (DistributorId) REFERENCES Distributors(Id)
)

CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name VARCHAR(25) UNIQUE,
	Description VARCHAR(250),
	Recipe VARCHAR(MAX),
	Price DECIMAL(38,2), 

	CONSTRAINT CH_Price CHECK (PRICE >= 0)
)

CREATE TABLE ProductsIngredients(
	ProductId INT,
	IngredientId INT,

	CONSTRAINT PK_ProductsIngredients PRIMARY KEY (ProductId, IngredientId),
	CONSTRAINT FK_ProductsIngredients_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_ProductsIngredients_Ingredient FOREIGN KEY (IngredientId) REFERENCES Ingredients(Id)
)

CREATE TABLE Feedbacks(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Description VARCHAR(255),
	Rate DECIMAL(2,0),
	ProductId INT,
	CustomerId INT,

	CONSTRAINT CH_Rate CHECK(Rate BETWEEN 0 AND 10),
	CONSTRAINT FK_Feedbacks_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)

