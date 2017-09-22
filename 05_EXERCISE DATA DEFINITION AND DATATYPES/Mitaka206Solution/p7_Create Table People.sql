--DROP TABLE People

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