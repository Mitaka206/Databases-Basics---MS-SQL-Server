--Problem 1.	Create Database
--You now know how to create database using the GUI of the SSMS. Now it’s time to create it using SQL queries. In that task (and the several following it) you will be required to create the database from the previous exercise using only SQL queries. Firstly, just create new database named Minions.
CREATE DATABASE Minions


--Problem 2.	Create Tables
--In the newly created database Minions add table Minions (Id, Name, Age). Then add new table Towns (Id, Name). Set Id columns of both tables to be primary key as constraint.
USE Minions

CREATE TABLE Minions (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL,
	Age INT
)


--Problem 3.	Alter Minions Table
--Change the structure of the Minions table to have new column TownId that would be of the same type as the Id column of Towns table. Add new constraint that makes TownId foreign key and references to Id column of Towns table.
USE Minions

ALTER TABLE Minions
ADD TownId INT


--Problem 4.	Insert Records in Both Tables
--Populate both tables with sample records given in the table below.
--Minions		Towns
--Id	Name	Age	TownId		Id	Name
--1	Kevin	22	1		1	Sofia
--2	Bob	15	3		2	Plovdiv
--3	Steward	NULL	2		3	Varna
--Use only SQL queries. Submit your INSERT statements as Run skeleton, run queries & check DB.
CREATE TABLE Towns (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name NVARCHAR(50) NOT NULL
)

INSERT INTO Towns (Id, Name)
VALUES (1, 'Sofia'), (2, 'Plovdiv'), (3, 'Varna')

INSERT INTO Minions(Id, Name, Age, TownId)
VALUES (1, 'Kevin', 22, 1), (2, 'Bob', 15, 3), (3, 'Steward', NULL, 2)


--Problem 5.	Truncate Table Minions
--Delete all the data from the Minions table using SQL query.
USE Minions

TRUNCATE TABLE Minions



--Problem 6.	Drop All Tables
--Delete all tables from the Minions database using SQL query.
USE Minions

DROP TABLE Minions

DROP TABLE Towns


--Problem 7.	Create Table People
--Using SQL query create table People with columns:
--•	Id – unique number for every person there will be no more than 231-1 people. (Auto incremented)
--•	Name – full name of the person will be no more than 200 Unicode characters. (Not null)
--•	Picture – image with size up to 2 MB. (Allow nulls)
--•	Height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
--•	Weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
--•	Gender – Possible states are m or f. (Not null)
--•	Birthdate – (Not null)
--•	Biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
--Make Id primary key. Populate the table with only 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.
CREATE TABLE People (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	Picture varbinary(max),
	Height DECIMAL(38,2),
	Weight DECIMAL(38,2),
	Gender VARCHAR(1) NOT NULL,
	BirthDate DATE NOT NULL,
	Biography NVARCHAR(MAX)
)

ALTER TABLE People
ADD CONSTRAINT CH_Picture CHECK (DATALENGTH(Picture) < 2000 * 1024)

ALTER TABLE People
ADD CONSTRAINT CH_Gender CHECK(Gender = 'm' OR Gender = 'f')

INSERT INTO People (Name, Gender, BirthDate)
VALUES ('Ivanka', 'f', '2000.10.10')

INSERT INTO People (Name, Gender, BirthDate)
VALUES ('Ivanka', 'f', '2000-10-10')

INSERT INTO People (Name, Gender, BirthDate)
VALUES ('Dimitar', 'm', '2000-10-10')

INSERT INTO People (Name, Gender, BirthDate)
VALUES ('Dimitar', 'm', '2000-10-10')

INSERT INTO People (Name, Gender, BirthDate)
VALUES ('Ivanka', 'f', '2000.10.10')

SELECT * FROM People


--Problem 8.	Create Table Users
--Using SQL query create table Users with columns:
--•	Id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
--•	Username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
--•	Password – password will be no longer than 26 characters (non Unicode). (Required)
--•	ProfilePicture – image with size up to 900 KB. 
--•	LastLoginTime
--•	IsDeleted – shows if the user deleted his/her profile. Possible states are true or false.
--Make Id primary key. Populate the table with exactly 5 records. Submit your CREATE and INSERT statements as Run queries & check DB.
DROP TABLE Users

CREATE TABLE Users (
	Id BIGINT IDENTITY NOT NULL,
	Username VARCHAR(30) NOT NULL,
	Password VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX),
	LastLoginTime DATE,
	IsDeleted BIT
)

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CH_PictureSize CHECK (DATALENGTH(ProfilePicture) < 900 * 1024)

ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE(Username)

INSERT INTO Users (Username, Password)
VALUES ('Ivanka', '123')

INSERT INTO Users (Username, Password)
VALUES ('Stamat', '123')

INSERT INTO Users (Username, Password)
VALUES ('Goska', '123')

INSERT INTO Users (Username, Password)
VALUES ('Penka', '123')

INSERT INTO Users (Username, Password)
VALUES ('Muncho', '123')

-- create test file for imitation ProfilePicture------------------------------------------
DECLARE @C VARCHAR(MAX) = '|'
DECLARE @ProfilePicture VARBINARY(MAX) = CONVERT(VARBINARY(MAX), REPLICATE(@C, (921599))); --900*1024=921600
INSERT INTO Users (Id, Username, Password, ProfilePicture)
VALUES (1, 'Dimitar', '123', @ProfilePicture)

DECLARE @C VARCHAR(MAX) = '/'
DECLARE @ProfilePicture VARBINARY(MAX) = CONVERT(VARBINARY(MAX), REPLICATE(@C, (921599))); --900*1024=921600
INSERT INTO Users (Id, Username, Password, ProfilePicture)
VALUES (2, 'Stamat', '456', @ProfilePicture)

SELECT * FROM Users


--Problem 9.	Change Primary Key
--Using SQL queries modify table Users from the previous task. First remove current primary key then create new primary key that would be the combination of fields Id and Username.
ALTER TABLE Users
DROP CONSTRAINT [PK_Users]

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id, Username)

ALTER TABLE Users
DROP CONSTRAINT [PK_Users]

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY (Id)

SELECT * FROM Users


--Problem 10.	Add Check Constraint
--Using SQL queries modify table Users. Add check constraint to ensure that the values in the Password field are at least 5 symbols long. 
ALTER TABLE Users
ADD CONSTRAINT CH_Password CHECK (LEN(Password) >= 5)



--Problem 11.	Set Default Value of a Field
--Using SQL queries modify table Users. Make the default value of LastLoginTime field to be the current time.
ALTER TABLE Users
ADD CONSTRAINT DF_LogDate DEFAULT GETDATE() FOR LastLoginTime



--Problem 12.	Set Unique Field
--Using SQL queries modify table Users. Remove Username field from the primary key so only the field Id would be primary key. Now add unique constraint to the Username field to ensure that the values there are at least 3 symbols long.
ALTER TABLE Users
ADD CONSTRAINT UQ_Username UNIQUE(Username)

ALTER TABLE Users
ADD CONSTRAINT CH_UsernameLen CHECK (LEN(Username) >= 3)


--Problem 13.	Movies Database
--Using SQL queries create Movies database with the following entities:
--•	Directors (Id, DirectorName, Notes)
--•	Genres (Id, GenreName, Notes)
--•	Categories (Id, CategoryName, Notes)
--•	Movies (Id, Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Rating, Notes)
--Set most appropriate data types for each column. Set primary key to each table. Populate each table with exactly 5 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
USE Movies

CREATE TABLE Directors(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	DirectorName NVARCHAR(100),
	Notes NVARCHAR(MAX)
)

CREATE TABLE Genres(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	GenreName NVARCHAR(50),
	Notes NVARCHAR(MAX)
)

CREATE TABLE Categories(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryName NVARCHAR(50),
	Notes NVARCHAR(MAX)
)

CREATE TABLE Movies(
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Title NVARCHAR(200) NOT NULL,
	DirectorId INT UNIQUE,
	CopyrightYear INT,
	Length NVARCHAR(12),
	GenreId INT UNIQUE,
	CategoryId INT UNIQUE,
	Notes NVARCHAR(MAX)
)

INSERT INTO Directors(DirectorName, Notes)
Values ('FirstName LastName', 'Some text. Some text?')
INSERT INTO Directors(DirectorName, Notes)
Values ('FirstName LastName', 'Some text. Some text?')
INSERT INTO Directors(DirectorName, Notes)
Values ('FirstName LastName', 'Some text. Some text?')
INSERT INTO Directors(DirectorName, Notes)
Values ('FirstName LastName', 'Some text. Some text?')
INSERT INTO Directors(DirectorName, Notes)
Values ('FirstName LastName', 'Some text. Some text?')

INSERT INTO Genres(GenreName, Notes)
Values ('GenreName5', 'Some text. Some text?')
INSERT INTO Genres(GenreName, Notes)
Values ('GenreName1', 'Some text. Some text?')
INSERT INTO Genres(GenreName, Notes)
Values ('GenreName2', 'Some text. Some text?')
INSERT INTO Genres(GenreName, Notes)
Values ('GenreName3', 'Some text. Some text?')
INSERT INTO Genres(GenreName, Notes)
Values ('GenreName4', 'Some text. Some text?')

INSERT INTO Categories(CategoryName, Notes)
Values ('CategorieName1', 'Some text. Some text?')
INSERT INTO Categories(CategoryName, Notes)
Values ('CategorieName2', 'Some text. Some text?')
INSERT INTO Categories(CategoryName, Notes)
Values ('CategorieName3', 'Some text. Some text?')
INSERT INTO Categories(CategoryName, Notes)
Values ('CategorieName4', 'Some text. Some text?')
INSERT INTO Categories(CategoryName, Notes)
Values ('CategorieName5', 'Some text. Some text?')

INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Notes)
Values ('Movietitle', '1', 2000, '01:15:25 h', '1', '1', 'Some text. Some text?')
INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Notes)
Values ('Movietitle', '2', 2000, '01:15:25 h', '2', '2', 'Some text. Some text?')
INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Notes)
Values ('Movietitle', '3', 2000, '01:15:25 h', '3', '3', 'Some text. Some text?')
INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Notes)
Values ('Movietitle', '4', 2000, '01:15:25 h', '4', '4', 'Some text. Some text?')
INSERT INTO Movies(Title, DirectorId, CopyrightYear, Length, GenreId, CategoryId, Notes)
Values ('Movietitle', '5', 2000, '01:15:25 h', '5', '5', 'Some text. Some text?')

SELECT * FROM Movies
SELECT * FROM Directors




--Problem 14.	Car Rental Database
--Using SQL queries create CarRental database with the following entities:
--•	Categories (Id, CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
--•	Cars (Id, PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available)
--•	Employees (Id, FirstName, LastName, Title, Notes)
--•	Customers (Id, DriverLicenceNumber, FullName, Address, City, ZIPCode, Notes)
--•	RentalOrders (Id, EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus, Notes)
--Set most appropriate data types for each column. Set primary key to each table. Populate each table with only 3 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
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


--Problem 15.	
--Using SQL queries create Hotel database with the following entities:
--•	Employees (Id, FirstName, LastName, Title, Notes)
--•	Customers (AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber, Notes)
--•	RoomStatus (RoomStatus, Notes)
--•	RoomTypes (RoomType, Notes)
--•	BedTypes (BedType, Notes)
--•	Rooms (RoomNumber, RoomType, BedType, Rate, RoomStatus, Notes)
--•	Payments (Id, EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, TotalDays, AmountCharged, TaxRate, TaxAmount, PaymentTotal, Notes)
--•	Occupancies (Id, EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied, PhoneCharge, Notes)
--Set most appropriate data types for each column. Set primary key to each table. Populate each table with only 3 records. Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.

Create database Hotel

USE Hotel

CREATE TABLE Employees (
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	Title  NVARCHAR(150), 
	Notes NVARCHAR(MAX)
)

CREATE TABLE Customers (
	AccountNumber INT UNIQUE, 
	FirstName NVARCHAR(50), 
	LastName NVARCHAR(50), 
	PhoneNumber NVARCHAR(10), 
	EmergencyName NVARCHAR(50), 
	EmergencyNumber NVARCHAR(10), 
	Notes NVARCHAR(MAX)
)

CREATE TABLE RoomStatus (
	RoomStatus VARCHAR(20), 
	Notes NVARCHAR(MAX) 
)

CREATE TABLE RoomTypes (
	RoomType NVARCHAR(20), 
	Notes NVARCHAR(MAX)
)

CREATE TABLE BedTypes (
	BedType INT, 
	Notes NVARCHAR(MAX)
)

CREATE TABLE Rooms (
	RoomNumber INT, 
	RoomType NVARCHAR, 
	BedType BIT, 
	Rate NVARCHAR, 
	RoomStatus BIT, 
	Notes NVARCHAR(MAX)
)

CREATE TABLE Payments (
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	EmployeeId INT UNIQUE, 
	PaymentDate NVARCHAR(20), 
	AccountNumber INT UNIQUE, 
	FirstDateOccupied NVARCHAR(20), 
	LastDateOccupied NVARCHAR(20), 
	TotalDays INT, 
	AmountCharged NVARCHAR(10), 
	TaxRate DECIMAL(10, 2), 
	TaxAmount DECIMAL(10, 2), 
	PaymentTotal DECIMAL(10, 2), 
	Notes NVARCHAR(MAX)
)

CREATE TABLE Occupancies (
	Id INT IDENTITY PRIMARY KEY NOT NULL, 
	EmployeeId INT UNIQUE, 
	DateOccupied NVARCHAR(20) , 
	AccountNumber INT UNIQUE, 
	RoomNumber INT UNIQUE, 
	RateApplied DECIMAL(10, 2), 
	PhoneCharge BIT, 
	Notes NVARCHAR(MAX)
)

INSERT INTO Employees (FirstName) VALUES ('Stamat')
INSERT INTO Employees (FirstName) VALUES ('Stamat')
INSERT INTO Employees (FirstName) VALUES ('Stamat')

INSERT INTO Customers(AccountNumber) VALUES (1)
INSERT INTO Customers(AccountNumber) VALUES (2)
INSERT INTO Customers(AccountNumber) VALUES (3)

INSERT INTO RoomStatus(RoomStatus) VALUES ('EMPLOYED')
INSERT INTO RoomStatus(RoomStatus) VALUES ('EMPLOYED')
INSERT INTO RoomStatus(RoomStatus) VALUES ('EMPLOYED')

INSERT INTO RoomTypes(RoomType) VALUES (1)
INSERT INTO RoomTypes(RoomType) VALUES (1)
INSERT INTO RoomTypes(RoomType) VALUES (1)

INSERT INTO BedTypes(BedType) VALUES (1)
INSERT INTO BedTypes(BedType) VALUES (2)
INSERT INTO BedTypes(BedType) VALUES (1)

INSERT INTO Rooms(RoomNumber) VALUES (1)
INSERT INTO Rooms(RoomNumber) VALUES (25)
INSERT INTO Rooms(RoomNumber) VALUES (101)

INSERT INTO Payments(EmployeeId, AccountNumber) VALUES (1, 1)
INSERT INTO Payments(EmployeeId, AccountNumber) VALUES (2, 2)
INSERT INTO Payments(EmployeeId, AccountNumber) VALUES (3, 3)

INSERT INTO Occupancies(EmployeeId, AccountNumber, RoomNumber) VALUES (1, 10, 50)
INSERT INTO Occupancies(EmployeeId, AccountNumber, RoomNumber) VALUES (2, 11, 65)
INSERT INTO Occupancies(EmployeeId, AccountNumber, RoomNumber) VALUES (3, 15, 70)

truncate TABLE Customers

select * from Occupancies


--Problem 16.	Create SoftUni Database
--Now create bigger database called SoftUni. You will use same database in the future tasks. It should hold information about
--•	Towns (Id, Name)
--•	Addresses (Id, AddressText, TownId)
--•	Departments (Id, Name)
--•	Employees (Id, FirstName, MiddleName, LastName, JobTitle, DepartmentId, HireDate, Salary, AddressId)
--Id columns are auto incremented starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate data types for each column. Add primary and foreign keys as constraints for each table. Use only SQL queries. Consider which fields are always required and which are optional.



--Problem 17.	Backup Database
--Backup the database SoftUni from the previous tasks into a file named “softuni-backup.bak”. Delete your database from SQL Server Management Studio. Then restore the database from the created backup.



--Problem 18.	Basic Insert
--Use the SoftUni database and insert some data using SQL queries.
--•	Towns: Sofia, Plovdiv, Varna, Burgas
--•	Departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
--•	Employees:
--Name	Job Title	Department	Hire Date	Salary
--Ivan Ivanov Ivanov	.NET Developer	Software Development	01/02/2013	3500.00
--Petar Petrov Petrov	Senior Engineer	Engineering	02/03/2004	4000.00
--Maria Petrova Ivanova	Intern	Quality Assurance	28/08/2016	525.25
--Georgi Teziev Ivanov	CEO	Sales	09/12/2007	3000.00
--Peter Pan Pan	Intern	Marketing	28/08/2016	599.88



--Problem 19.	Basic Select All Fields
--Use the SoftUni database and first select all records from the Towns, then from Departments and finally from Employees table. Use SQL queries and submit them to Judge at once. Submit your query statements as Prepare DB & Run queries.



--Problem 20.	Basic Select All Fields and Order Them
--Modify queries from previous problem by sorting:
--•	Towns - alphabetically by name
--•	Departments - alphabetically by name
--•	Employees - descending by salary
--Submit your query statements as Prepare DB & Run queries.



--Problem 21.	Basic Select Some Fields
--Modify queries from previous problem to show only some of the columns. For table:
--•	Towns – Name
--•	Departments – Name
--•	Employees – FirstName, LastName, JobTitle, Salary
--Keep the ordering from the previous problem. Submit your query statements as Prepare DB & Run queries.



--Problem 22.	Increase Employees Salary
--Use SoftUni database and increase the salary of all employees by 10%. Then show only Salary column for all in the Employees table. Submit your query statements as Prepare DB & Run queries.



--Problem 23.	Decrease Tax Rate
--Use Hotel database and decrease tax rate by 3% to all payments. Then select only TaxRate column from the Payments table. Submit your query statements as Prepare DB & Run queries.



--Problem 24.	Delete All Records
--Use Hotel database and delete all records from the Occupancies table. Use SQL query. Submit your query statements as Run skeleton, run queries & check DB.

