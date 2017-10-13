CREATE DATABASE Bakery

USE Bakery

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
    PhoneNumber NVARCHAR(10),
    CountryId INT,

	CONSTRAINT CH_Gender CHECK(Gender = 'M' OR Gender = 'F'),
	CONSTRAINT FK_CustomersCountries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

CREATE TABLE Distributors(
	Id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(25) UNIQUE,
    AddressText NVARCHAR(30),
    Summary NVARCHAR(200),
    CountryId INT,

	CONSTRAINT FK_DistributorsCoutries FOREIGN KEY (CountryId) REFERENCES Countries(Id)
)

CREATE TABLE Ingredients(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(30),
	Description NVARCHAR(200),
	OriginCountryId INT,
	DistributorId INT,

	CONSTRAINT FK_Ingredients_Countries FOREIGN KEY (OriginCountryId) REFERENCES Countries(Id),
	CONSTRAINT FK_Ingredients_Distributors FOREIGN KEY (DistributorId) REFERENCES Distributors(Id)
)

CREATE TABLE Products(
	Id INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(25) UNIQUE,
	Description NVARCHAR(250),
	Recipe NVARCHAR(MAX),
	Price DECIMAL(38,2) 

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
	Id INT PRIMARY KEY,
	Description NVARCHAR(255),
	Rate DECIMAL(10,2),
	ProductId INT,
	CustomerId INT,

	CONSTRAINT CH_Rate CHECK(Rate BETWEEN 0 AND 10),
	CONSTRAINT FK_Feedbacks_Products FOREIGN KEY (ProductId) REFERENCES Products(Id),
	CONSTRAINT FK_Feedbacks_Customers FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
)

