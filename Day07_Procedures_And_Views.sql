
-- Create and use the database
CREATE DATABASE IF NOT EXISTS company_procedures_views;
USE company_procedures_views;

-- Create sample tables

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY AUTO_INCREMENT,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

--  Insert sample data

INSERT INTO Departments (DepartmentName) VALUES
('Software Development'),
('Human Resources'),
('Finance'),
('Data Science');

INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary) VALUES
('Alice', 'Johnson', 1, 60000),
('Bob', 'Smith', 2, 45000),
('Charlie', 'Brown', 3, 55000),
('Diana', 'Miller', 1, 70000),
('Ethan', 'Williams', 4, 80000);

--  Question 1 — Stored Procedure
-- Scenario: HR wants to fetch employee details by ID
-- ================================================================
DELIMITER $$

CREATE PROCEDURE GetEmployeeByID (IN emp_id INT)
BEGIN
    SELECT 
        e.EmployeeID,
        CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
        d.DepartmentName,
        e.Salary
    FROM Employees e
    JOIN Departments d ON e.DepartmentID = d.DepartmentID
    WHERE e.EmployeeID = emp_id;
END $$

DELIMITER ;

-- ✅ Test the procedure
CALL GetEmployeeByID(3);

--  SQL Question 2 — Simple View
-- Scenario: Management wants employee name and department

CREATE VIEW EmployeeDepartmentView AS
SELECT 
    CONCAT(FirstName, ' ', LastName) AS EmployeeName,
    DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- ✅ Test the simple view
SELECT * FROM EmployeeDepartmentView;

-- SQL Question 3 — Complex View
-- Scenario: Create a view joining Employees, Departments, and Salaries
-- ================================================================
-- (Here Salary is already in Employees, so we’ll simulate a Salaries table)

CREATE TABLE Salaries (
    SalaryID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    Bonus DECIMAL(10,2),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

INSERT INTO Salaries (EmployeeID, Bonus) VALUES
(1, 5000),
(2, 3000),
(3, 4000),
(4, 6000),
(5, 7000);

CREATE VIEW EmployeeFullDetails AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS FullName,
    d.DepartmentName,
    e.Salary,
    s.Bonus,
    (e.Salary + s.Bonus) AS TotalCompensation
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
JOIN Salaries s ON e.EmployeeID = s.EmployeeID;

-- ✅ Test the complex view
SELECT * FROM EmployeeFullDetails;

