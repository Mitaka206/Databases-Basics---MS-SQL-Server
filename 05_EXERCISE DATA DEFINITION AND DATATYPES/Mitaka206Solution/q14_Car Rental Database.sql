USE [Car Rental]

CREATE TABLE Categories (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryName NVARCHAR(20),
	DailyRate INT,
	WeeklyRate INT, 
	MonthlyRate INT, 
	WeekendRate INT
)

CREATE TABLE Cars (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	PlateNumber NVARCHAR(20),
	Manufacturer NVARCHAR(100), 
	Model NVARCHAR(50), 
	CarYear INT, 
	CategoryId INT, 
	Doors INT, 
	Picture VARBINARY(MAX), 
	Condition BIT, 
	Available BIT,
)

CREATE TABLE Employees(
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	Title NVARCHAR(100), 
	Notes NVARCHAR(MAX)
)

CREATE TABLE Customers(
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	DriverLicenceNumber NVARCHAR(50), 
	FullName NVARCHAR(100), 
	Address NVARCHAR(150), 
	City VARCHAR(50), 
	ZIPCode INT, 
	Notes NVARCHAR(MAX)
)

CREATE TABLE RentalOrders (
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	EmployeeId INT UNIQUE, 
	CustomerId INT UNIQUE, 
	CarId INT UNIQUE, 
	TankLevel NVARCHAR(20), 
	KilometrageStart DECIMAL(10, 2), 
	KilometrageEnd DECIMAL(10, 2), 
	TotalKilometrage DECIMAL(10, 2), 
	StartDate NVARCHAR(20), 
	EndDate NVARCHAR(20), 
	TotalDays INT, 
	RateApplied BIT, 
	TaxRate DECIMAL(10, 2), 
	OrderStatus BIT, 
	Notes NVARCHAR(MAX)
)

INSERT INTO Categories (CategoryName) VALUES ('Category1')
INSERT INTO Categories (CategoryName) VALUES ('Category1')
INSERT INTO Categories (CategoryName) VALUES ('Category1')

INSERT INTO Cars(PlateNumber) VALUES ('CA0000TX')
INSERT INTO Cars(PlateNumber) VALUES ('CA0000TX')
INSERT INTO Cars(PlateNumber) VALUES ('CA0000TX')

INSERT Employees(FirstName) VALUES ('Gosho')
INSERT Employees(FirstName) VALUES ('Gosho')
INSERT Employees(FirstName) VALUES ('Gosho')

INSERT Customers(FullName) VALUES ('Gosho Stamatov')
INSERT Customers(FullName) VALUES ('Gosho Stamatov')
INSERT Customers(FullName) VALUES ('Gosho Stamatov')

INSERT RentalOrders(EmployeeId, CustomerId, CarId) VALUES (1, 2, 3)
INSERT RentalOrders(EmployeeId, CustomerId, CarId) VALUES (3, 1, 2)
INSERT RentalOrders(EmployeeId, CustomerId, CarId) VALUES (2, 3, 1)