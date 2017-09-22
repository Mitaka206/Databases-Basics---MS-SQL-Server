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
------------------------------------------------------------------------------------------

SELECT * FROM Users