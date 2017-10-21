
USE WMS

CREATE TABLE Clients
(
	ClientId INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Phone VARCHAR(12) NOT NULL
)

CREATE TABLE Mechanics
(
	MechanicId INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	Address VARCHAR(255) NOT NULL
)

CREATE TABLE Models
(
	ModelId INT PRIMARY KEY IDENTITY NOT NULL,
	Name VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE Jobs 
(
	JobId INT PRIMARY KEY IDENTITY NOT NULL,
	ModelId INT FOREIGN KEY REFERENCES Models(ModelId) NOT NULL,
	Status VARCHAR (11) CHECK (Status IN('Pending', 'In Progress', 'Finished')) DEFAULT 'Pending',
	ClientId INT FOREIGN KEY REFERENCES Clients(ClientId) NOT NULL,
	MechanicId INT FOREIGN KEY REFERENCES Mechanics(MechanicId),
	IssueDate DATE NOT NULL,
	FinishDate DATE
)

CREATE TABLE Orders
(
	OrderId INT PRIMARY KEY IDENTITY NOT NULL,
	JobId INT FOREIGN KEY REFERENCES Jobs(JobId) NOT NULL,
	IssueDate DATE,
	Delivered BIT DEFAULT 1
)

CREATE TABLE Vendors
(
	VendorId INT PRIMARY KEY IDENTITY NOT NULL,
	Name VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE Parts
(
	PartId INT PRIMARY KEY IDENTITY NOT NULL,
	SerialNumber VARCHAR(50) UNIQUE NOT NULL,
	Description VARCHAR(255), 
	Price DECIMAL(6,2) CHECK(Price < 10000 AND Price > 0) NOT NULL,
	VendorId INT FOREIGN KEY REFERENCES Vendors(VendorId) NOT NULL,
	StockQty INT CHECK(StockQty >= 0) DEFAULT 0
)

CREATE TABLE OrderParts
(
	OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
	PartId INT FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT CHECK(Quantity > 0) DEFAULT 1,

	CONSTRAINT PK_OrdersParts PRIMARY KEY (OrderId, PartId)
)

CREATE TABLE PartsNeeded
(
	JobId INT FOREIGN KEY REFERENCES Jobs(JobId),
	PartId INT FOREIGN KEY REFERENCES Parts(PartId),
	Quantity INT CHECK(Quantity > 0) DEFAULT 1,

	CONSTRAINT PK_PartsNeeded PRIMARY KEY (JobId, PartId)
)

-- 02 INSERT 

INSERT INTO Clients(FirstName, LastName, Phone) 
VALUES
('Teri', 'Ennaco', '570-889-5187'),
('Merlyn', 'Lawler', '201-588-7810'),
('Georgene', 'Montezuma', '925-615-5185'),
('Jettie', 'Mconnell', '908-802-3564'),
('Lemuel', 'Latzke', '631-748-6479'),
('Melodie', 'Knipp', '805-690-1682'),
('Candida', 'Corbley', '908-275-8357')

INSERT INTO Parts(SerialNumber, Description, Price, VendorId)
VALUES
('WP8182119', 'Door Boot Seal', '117.86', 2),
('W10780048', 'Suspension Rod', '42.81', 1),
('W10841140', 'Silicone Adhesive', '6.77', 4),
('WPY055980', 'High Temperature Adhesive', '13.94', 3)


--03 UPDATE

SELECT * FROM Mechanics
SELECT * FROM Jobs

UPDATE Jobs
SET Status = 'In Progress', MechanicId = 3
WHERE Status = 'Pending'

--04 DELETE

DELETE FROM OrderParts
WHERE OrderId = 19
DELETE FROM Orders
WHERE OrderId = 19

--05 CL BE NAME

SELECT FirstName, LastName, Phone FROM Clients
ORDER BY LastName, ClientId

--06 JOB STATUS

SELECT Status, IssueDate FROM Jobs
WHERE NOT Status = 'Finished'
ORDER BY IssueDate, JobId

--07 Mechanic Assignments
SELECT CONCAT(m.FirstName, ' ', m.LastName) AS Mechanic, j.Status, j.IssueDate FROM JOBS AS j
JOIN Mechanics AS m ON m.MechanicId = j.MechanicId
ORDER BY j.MechanicId, j.IssueDate, j.JobId

--08 Current Clients

SELECT * FROM Jobs
SELECT CONCAT(c.FirstName, ' ', c.LastName), DATEDIFF(DAY, j.IssueDate, '24 April 2017') AS [Days going], j.Status FROM Jobs AS j
JOIN Clients AS c ON c.ClientId = j.ClientId
WHERE NOT j.Status = 'Finished'
ORDER BY [Days going] DESC, j.ClientId

--09 Mechanic Performance

SELECT CONCAT(M.FirstName, ' ', M.LastName) AS Mechanic,
	   AVG(DATEDIFF(DAY, J.IssueDate, J.FinishDate)) AS [Average Days] 
	   FROM Jobs AS J
 LEFT JOIN Mechanics AS M ON M.MechanicId = J.MechanicId
 GROUP BY J.MechanicId, CONCAT(M.FirstName, ' ', M.LastName)
 ORDER BY J.MechanicId

 --10 Hard Earners
SELECT TOP 3 CONCAT(M.FirstName, ' ', M.LastName) AS Mechanic, COUNT(J.MechanicId) AS Jobs FROM Jobs AS J
JOIN Mechanics AS M ON M.MechanicId = J.MechanicId
WHERE NOT J.Status = 'Finished'
GROUP BY M.MechanicId, CONCAT(M.FirstName, ' ', M.LastName)
HAVING COUNT(J.MechanicId) > 1
ORDER BY COUNT(J.MechanicId) DESC, M.MechanicId


 --11 Available Mechanics

 SELECT CONCAT(FirstName, ' ', LastName) AS Available FROM Mechanics
 WHERE MechanicId NOT IN (SELECT DISTINCT MechanicId FROM Jobs
						   WHERE MechanicId IS NOT NULL AND Status <> 'Finished')


 --12 Parts Cost

 SELECT ISNULL(SUM(P.Price * OP.Quantity), 0) AS [Parts Total] FROM OrderParts AS OP
 JOIN Parts AS P ON P.PartId = OP.PartId
 JOIN Orders AS O ON O.OrderId = OP.OrderId
 WHERE DATEDIFF(DAY, O.IssueDate, '24 April 2017') <= 21


 --13 Past Expenses

 SELECT O.JobId, ISNULL(SUM(P.Price * OP.Quantity),0) AS [Total] FROM OrderParts AS OP
 JOIN Parts AS P ON P.PartId = OP.PartId
 JOIN Orders AS O ON O.OrderId = OP.OrderId
 JOIN Jobs AS J ON J.JobId = O.JobId
 WHERE J.Status = 'Finished'
 GROUP BY O.JobId
 ORDER BY Total DESC, JobId
 


 --14 Model Repair Time

   SELECT J.ModelId, M.Name, CONCAT((AVG(DATEDIFF(DAY, IssueDate, FinishDate))), ' days') AS AveRAGE
     FROM Jobs AS J
     JOIN Models AS M ON M.ModelId = J.ModelId
 GROUP BY J.ModelId, M.Name
 ORDER BY AVG(DATEDIFF(DAY, IssueDate, FinishDate))


 --15 FULL TEST MODEL

  SELECT TOP 1 
  		 M.Name, 
  		 COUNT(*) AS [Times Serviced], 
  		 (SELECT ISNULL(SUM(P.Price * OP.Quantity), 0) FROM Jobs AS J
  		    JOIN Orders AS O ON O.JobId = J.JobId
  		    JOIN OrderParts AS OP ON OP.OrderId = O.OrderId
  		    JOIN Parts AS P ON P.PartId = OP.PartId
  		   WHERE J.ModelId = M.ModelId) AS [Parts Total]
     FROM Jobs AS J
     JOIN Models AS M ON M.ModelId = J.ModelId
 GROUP BY M.ModelId, M.Name
 ORDER BY [Times Serviced] DESC
 

 --16

 SE



 --17 Cost of Order
 GO
 CREATE FUNCTION udf_GetCost(@JobID INT)
 RETURNS DECIMAL(6,2)
 AS
 BEGIN
	DECLARE @TotalSum DECIMAL(6, 2) = (SELECT ISNULL(SUM(P.Price * OP.Quantity),0) AS [Total]
										 FROM OrderParts AS OP
									     JOIN Parts AS P ON P.PartId = OP.PartId
									     JOIN Orders AS O ON O.OrderId = OP.OrderId
									     JOIN Jobs AS J ON J.JobId = O.JobId
									    WHERE J.JobId = @JobID)
	
	RETURN @TotalSum
 END

 --18 PLACE ORDER
 GO
 CREATE PROC usp_PlaceOrder (@JobID INT, @PSN VARCHAR(50), @Quantity INT)
 AS 
	BEGIN
		DECLARE @JobStatus VARCHAR(20) = (SELECT Status FROM JOBS
	WHERE JobId = @JobID)

	IF @JobStatus = 'Finished'
	BEGIN
		RAISERROR('This job is not active!', 16, 1);
		RETURN
	END

	IF @Quantity <= 0
	BEGIN 
		RAISERROR('Part quantity must be more than zero!', 16, 1);
		RETURN
	END

	IF @JobID > (SELECT TOP 1 JobId FROM Jobs
	ORDER BY JobId DESC)
	BEGIN 
		RAISERROR('Job not found!', 16, 1);
		RETURN
	END

	IF (SELECT COUNT(SerialNumber) FROM Parts WHERE SerialNumber <> @PSN) < 1
	BEGIN 
		RAISERROR('Part not found!', 16, 1);
		RETURN
	END
	
	DECLARE @PartId INT = (SELECT PartId FROM Parts WHERE SerialNumber = @PSN)
	
	DECLARE @OrderId INT = (SELECT o.OrderId FROM Orders AS o
				JOIN OrderParts AS op ON op.OrderId = o.OrderId
				JOIN Parts AS p ON p.PartId = op.PartId
				WHERE JobId = @JobId AND p.PartId = @PartId AND IssueDate IS NULL)

    -- Order does not exist -> create new order
    IF (@OrderId IS NULL)
    BEGIN
        INSERT INTO Orders (JobId, IssueDate) VALUES
        (@JobId, NULL)

        INSERT INTO OrderParts (OrderId, PartId, Quantity) 
			 VALUES (IDENT_CURRENT('Orders'), @PartId, @Quantity)
    END
    ELSE
    BEGIN
        DECLARE @PartExistsInOrder INT = (SELECT @@ROWCOUNT FROM OrderParts
                                           WHERE OrderId = @OrderId AND PartId = @PartId)
        
        IF (@PartExistsInOrder IS NULL)
        BEGIN
            -- Order exists, part does not exist in it -> add part to order      
            INSERT INTO OrderParts (OrderId, PartId, Quantity) 
				 VALUES (@OrderId, @PartId, @Quantity)
        END
        ELSE
        BEGIN
            -- Order exists, part exists -> increase part quantity in order
            UPDATE OrderParts
            SET Quantity += @Quantity
            WHERE OrderId = @OrderId AND PartId = @PartId
        END
    END
END

--19 Detect Delivery
GO
CREATE TRIGGER tr_OrderDelivered ON Orders
AFTER UPDATE
AS
BEGIN
    DECLARE @OldStatus INT = (SELECT Delivered FROM deleted)
    DECLARE @NewStatus INT = (SELECT Delivered FROM inserted)

    IF (@OldStatus = 0 AND @NewStatus = 1)
    BEGIN
        UPDATE Parts
        SET StockQty += op.Quantity
        FROM Parts AS p
        JOIN OrderParts op ON op.PartId = p.PartId
        JOIN Orders o ON o.OrderId = op.OrderId
        JOIN inserted AS i ON i.OrderId = o.OrderId
        JOIN deleted AS d ON d.OrderId = o.OrderId
        WHERE d.Delivered = 0 AND i.Delivered = 1
    END
END

BEGIN TRAN
    UPDATE Orders
    SET Delivered = 1
    WHERE OrderId = 21
ROLLBACK

--20 Vendor Preference(BONUS)
GO
WITH CTE_VendorPreference
AS
(
    SELECT m.MechanicId, v.VendorId, SUM(op.Quantity) AS ItemsFromVendor FROM Mechanics AS m
    JOIN Jobs AS j ON j.MechanicId = m.MechanicId
    JOIN Orders AS o ON o.JobId = j.JobId
    JOIN OrderParts op ON op.OrderId = o.OrderId
    JOIN Parts AS p ON p.PartId = op.PartId
    JOIN Vendors v ON v.VendorId = p.VendorId
    GROUP BY m.MechanicId, v.VendorId
)

SELECT CONCAT(m.FirstName, ' ', LastName) AS Mechanic,
       v.Name AS Vendor,
       c.ItemsFromVendor AS Parts,
	   CONCAT(CAST(CAST(ItemsFromVendor AS DECIMAL(6, 2)) / (SELECT SUM(ItemsFromVendor) FROM CTE_VendorPreference WHERE MechanicId = c.MechanicId) * 100 AS INT), '%') AS Preference
FROM CTE_VendorPreference AS c
JOIN Mechanics m ON m.MechanicId = c.MechanicId
JOIN Vendors v ON v.VendorId = c.VendorId
ORDER BY Mechanic, Parts DESC, Vendor

