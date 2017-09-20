CREATE TABLE People (
	Id INT IDENTITY PRIMARY KEY NOT NULL,
	Name NVARCHAR(200) NOT NULL,
	Picture varbinary(max) CHECK(DATALENGTH(Picture) < 2000 * 1024),
	Height DECIMAL(38,2),
	Weight DECIMAL(38,2),
	Gender VARCHAR(1) CHECK(Gender = 'm' or Gender = 'f') NOT NULL,
	BirthDate DATE NOT NULL,
	Biography NVARCHAR(MAX) NOT NULL
	
)

drop table People

select * from People