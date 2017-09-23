
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