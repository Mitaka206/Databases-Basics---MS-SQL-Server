USE [Car Rental]

CREATE TABLE Categories (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	CategoryName NVARCHAR(20),
	DailyRate INT,
	WeeklyRate INT, 
	MonthlyRate INT, 
	WeekendRate INT
)

