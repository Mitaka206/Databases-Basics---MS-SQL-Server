
--Problem 1.	One-To-One Relationship
USE DemoRelations

CREATE TABLE Persons(
	PersonID INT PRIMARY KEY IDENTITY (1,1),
	FirstName VARCHAR(50),
	Salary DECIMAL(10,2),
	PasSportID INT UNIQUE
)

CREATE TABLE Passports(
	PassportID INT PRIMARY KEY IDENTITY(101,1),
	PassportNumber NVARCHAR(8) UNIQUE
)

INSERT INTO Passports(PassportNumber) VALUES ('N34FG21B'), 
											 ('K65LO4R7'), 
											 ('ZE657QP2')

INSERT INTO Persons(FirstName, Salary, PassportID) VALUES 
															('Roberto', 43300.00, 102),
															('Tom', 56100.00, 103),
															('Yana', 60200.00, 101)


ALTER TABLE Persons 
ADD CONSTRAINT FK_Persons_Passports FOREIGN KEY (PassportID) REFERENCES Passports(PassportID)




--Problem 2.	One-To-Many Relationship
CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50),
	EstablishedOn VARCHAR(50)
)

CREATE TABLE Models(
	ModelID INT PRIMARY KEY IDENTITY (101,1),
	Name VARCHAR(50),
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Manufacturers(Name, EstablishedOn) VALUES
('BMW','07/03/1916'),
('Tesla','01/01/2003'),
('Lada','01/05/1966')


SELECT * FROM Models
INSERT INTO Models (Name, ManufacturerID) VALUES
('X1',1),
('i6',1),
('Model S',2),
('Model X',2),
('Model 3',2),
('Nova',3)



--Problem 3.	Many-To-Many Relationship
CREATE TABLE Students(
	StudentID INT PRIMARY KEY IDENTITY (1,1),
	Name VARCHAR(50)
)

CREATE TABLE Exams(
	ExamID INT PRIMARY KEY IDENTITY (101, 1),
	Name VARCHAR(50)
)

CREATE TABLE StudentsExams(
	StudentID INT,
	ExamID INT,

	CONSTRAINT PK_SudentExam PRIMARY KEY (StudentID, ExamID),

	CONSTRAINT FK_SudentExam_Sudent FOREIGN KEY (StudentID) REFERENCES Students(StudentID),

	CONSTRAINT FK_StudentExam_Exam FOREIGN KEY (ExamID) REFERENCES Exams(ExamID)
)

INSERT INTO Students(Name) VALUES ('Mila'),('Toni'),('Ron')

INSERT INTO Exams(Name) VALUES ('SpringMVC'),('Neo4j'),('Oracle11g')

INSERT INTO StudentsExams(StudentID, ExamID) VALUES 
(1,101),
(1,102),
(2,101),
(3,103),
(2,102),
(2,103)



--Problem 4.	Self-Referencing 
CREATE TABLE Teachers(
	TeacherID INT PRIMARY KEY IDENTITY (101, 1),
	Name NVARCHAR(200),
	ManagerID INT,
	CONSTRAINT FK_MID_TID FOREIGN KEY (TeacherID) REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers(Name, ManagerID) VALUES 
('John',NULL),
('Maya',106),
('Silvia',106),
('Ted',105),
('Mark',101),
('Greta',101)

SELECT * FROM Teachers



--Problem 5.	Online Store Database
CREATE DATABASE StoreDB 

USE StoreDB


CREATE TABLE Cities(
	CityID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Custumers(
	CustumerID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Birthday DATE,
	CityID INT,
	CONSTRAINT FK_Custumers_Cities FOREIGN KEY (CityID) REFERENCES Cities(CityID)
)

CREATE TABLE Orders(
	OrderID INT PRIMARY KEY,
	CustumerID INT NOT NULL,
	CONSTRAINT FK_Orders_Custumers FOREIGN KEY (CustumerID) REFERENCES Custumers(CustumerID)
)

CREATE TABLE ItemTypes(
	ItemTypeID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Items(
	ItemID INT PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	ItemTypeID INT NOT NULL,
	CONSTRAINT FK_Items_Itemtypes FOREIGN KEY (ItemTypeID) REFERENCES ItemTypes(ItemTypeID)
)

CREATE TABLE OrderItems(
	OrderID INT NOT NULL,
	ItemID INT NOT NULL,

	CONSTRAINT PK_ORD_ITM PRIMARY KEY (OrderID, ItemID),
	CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
	CONSTRAINT FK_OrderItems_Items FOREIGN KEY (ItemID) REFERENCES Items(ItemID)
)

--Problem 6.	University Database



--Problem 7.	SoftUni Design



--Problem 8.	Geography Design



--Problem 9.	*Peaks in Rila



--L-----------A-------BBB--------------
--L----------A-A------B--B---------
--L---------A---A-----BBB----------------
--L--------AAAAAAA----B---B--------
--L-------A-------A---B----B---------
--LLLLLL-A---------A--BBBBB-----------------

CREATE DATABASE Mount

DROP TABLE Peaks
DROP TABLE Mountains

--- MANY to ONE

CREATE TABLE Mountains(
	MountId INT PRIMARY KEY IDENTITY (1,1),
	MountName VARCHAR(50) NOT NULL
)

CREATE TABLE Peaks(
		PeakId INT PRIMARY KEY IDENTITY (1,1),
		PeakName VARCHAR(50) NOT NULL,
		--Elevation DECIMAL(5, 2) DEFAULT (0.00),
		MountId INT FOREIGN KEY REFERENCES Mountains(MountId) NOT NULL,
		--CONSTRAINT FK_Peaks_Mountains FOREIGN KEY (MountId) REFERENCES Mountains(MountId)
)


INSERT INTO Mountains(MountName) 
	 VALUES ('Rila'), 
		    ('Pirin'), 
			('StaraPlanina'), 
			('Rodopi'), 
			('Vitosha')

INSERT INTO Peaks(PeakName, MountId) 
	 VALUES ('Maliovitza', 1),
			('Cherni Vrah', 5),
			('Snejanka', 4),
			('Botev', 3),
			('Vihren', 2),
			('Kamen Del', 5),
			('Goliam Perelik', 4),
			('Musala', 1),
			('Todorka', 2)

SELECT * FROM Peaks


--- MANY to MANY

CREATE DATABASE DemoRelations

USE DemoRelations

CREATE TABLE Employees (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Projects(
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProjectName VARCHAR(100) NOT NULL
 )

 CREATE TABLE EmployeeProjects(
	EmployeeId INT,
	ProjectId INT,

	CONSTRAINT PK_EmloyeeProjects
	PRIMARY KEY (EmployeeId, ProjectId),

	CONSTRAINT FK_EmloyeeProjects_Employees
	FOREIGN KEY (EmployeeId) 
	REFERENCES Employees(Id) ON DELETE CASCADE,

	CONSTRAINT FK_EmloyeeProjects_Projects
	FOREIGN KEY (ProjectId) 
	REFERENCES Projects(Id)
 )

 INSERT INTO Employees (Name) 
 VALUES ('Dimitarcho Todorov'),
		('Ivan Ivanov'),
		('Samat Haralambov')

INSERT INTO Projects (ProjectName)
VALUES ('Nice project'),
	   ('Best java project'),
	   ('Microsoft hell')

	   select * from Employees
	   select * from Projects
	   select * from EmployeeProjects

INSERT INTO EmployeeProjects (EmployeeId, ProjectId)
VALUES (2,3),
	   (3,1),
	   (1,3),
	   (3,2),
	   (1,2)

DELETE FROM Employees
WHERE Id = 1

	   
SELECT e.Name, p.ProjectName FROM Employees AS e
JOIN EmployeeProjects AS ep ON ep.EmployeeId = e.Id
JOIN Projects AS p ON p.Id = ep.ProjectId

---- ONE to ONE

CREATE TABLE Drivers (
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL
)

CREATE TABLE Cars(
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50) NOT NULL,
	DriverId INT FOREIGN KEY REFERENCES Drivers(Id) UNIQUE
)

SELECT * FROM Drivers
SELECT * FROM Cars


INSERT INTO Drivers(Name) 
     VALUES ('IVAN'), ('Gosho'), ('Spas') 

INSERT INTO Cars(Name, DriverId)
     VALUES ('HONDA', 2), ('MERCEDES', 1), ('TRABANT', 3)

SELECT Drivers.Name, Cars.Name FROM Cars
JOIN Drivers ON Drivers.Id = DriverId


USE Geography

SELECT Mountains.MountainRange, Peaks.PeakName, Peaks.Elevation FROM Mountains
JOIN Peaks ON MountainId = Mountains.Id
where MountainRange = 'Rila'
ORDER BY MountainRange, Elevation desc

SELECT * FROM Mountains
SELECT * FROM Peaks


--Football Database
--Design a storage for football team information. It keeps up-to-date information 
--about each team, with its players and manager. A team can participate in many 
--leagues, both local and international. Players and managers are recorded with 
--thier first and last name and their salary.

CREATE DATABASE Football