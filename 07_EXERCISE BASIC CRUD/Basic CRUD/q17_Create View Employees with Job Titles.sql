CREATE VIEW V_EmployeeNameJobTitle AS
SELECT FirstName + ' ' + COALESCE (MiddleName, '') + ' ' + LastName AS [Full Name], JobTitle AS [Job Title] FROM Employees

SELECT * FROM V_EmployeeNameJobTitle