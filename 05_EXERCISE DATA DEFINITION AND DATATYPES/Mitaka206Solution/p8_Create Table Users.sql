CREATE TABLE Users (
	Id BIGINT NOT NULL,
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






-- create test file for imitation ProfilePicture------------------------------------------
DECLARE @C VARCHAR(MAX) = '|'
DECLARE @ProfilePicture VARBINARY(MAX) = CONVERT(VARBINARY(MAX), REPLICATE(@C, (921599)));

INSERT INTO Users (Id, Username, Password, ProfilePicture)
VALUES (1, 'Dimitar', '123', @ProfilePicture)
------------------------------------------------------------------------------------------