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

