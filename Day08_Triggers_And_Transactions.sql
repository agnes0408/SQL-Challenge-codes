-- Create and use the database
CREATE DATABASE IF NOT EXISTS company_triggers_transactions;
USE company_triggers_transactions;

--  Create base tables

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    ProductName VARCHAR(100),
    Amount DECIMAL(10,2),
    OrderDate DATE
);

CREATE TABLE Order_History (
    HistoryID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    CustomerName VARCHAR(100),
    ProductName VARCHAR(100),
    Amount DECIMAL(10,2),
    OrderDate DATE,
    DeletedOn TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO Orders (CustomerName, ProductName, Amount, OrderDate) VALUES
('Alice', 'Laptop', 75000, '2024-12-10'),
('Bob', 'Keyboard', 2500, '2024-12-12'),
('Charlie', 'Mouse', 1200, '2024-12-14');

-- SQL Question 1 — Trigger
-- Scenario: Log every deletion in the Orders table

DELIMITER $$

CREATE TRIGGER after_order_delete
AFTER DELETE ON Orders
FOR EACH ROW
BEGIN
    INSERT INTO Order_History (OrderID, CustomerName, ProductName, Amount, OrderDate)
    VALUES (OLD.OrderID, OLD.CustomerName, OLD.ProductName, OLD.Amount, OLD.OrderDate);
END $$

DELIMITER ;

-- ✅ Test the trigger
DELETE FROM Orders WHERE OrderID = 2;

-- Verify that the deleted row is logged
SELECT * FROM Order_History;

-- SQL Question 2 — DCL Commands
-- Scenario: Grant reporting access to junior analysts
-- ================================================================
-- Note: These commands are for demonstration; they require user privileges to execute.

-- Create a sample user
CREATE USER IF NOT EXISTS 'junior_analyst'@'localhost' IDENTIFIED BY 'password123';

-- Grant SELECT access (read-only/reporting access)
GRANT SELECT ON company_triggers_transactions.* TO 'junior_analyst'@'localhost';

-- Check privileges
SHOW GRANTS FOR 'junior_analyst'@'localhost';

-- Revoke access if needed
-- REVOKE SELECT ON company_triggers_transactions.* FROM 'junior_analyst'@'localhost';

-- SQL Question 3 — TCL Commands
-- Scenario: Ensure atomicity during bank transfer
-- ================================================================
CREATE TABLE BankAccounts (
    AccountID INT PRIMARY KEY AUTO_INCREMENT,
    AccountHolder VARCHAR(100),
    Balance DECIMAL(10,2)
);

INSERT INTO BankAccounts (AccountHolder, Balance) VALUES
('John', 10000.00),
('Mary', 5000.00);

-- ✅ Start transaction
START TRANSACTION;

SET SQL_SAFE_UPDATES = 0;

-- Debit from John
UPDATE BankAccounts
SET Balance = Balance - 2000
WHERE AccountHolder = 'John';

SET SQL_SAFE_UPDATES = 1;

SET SQL_SAFE_UPDATES = 0;

-- Credit to Mary
UPDATE BankAccounts
SET Balance = Balance + 2000
WHERE AccountHolder = 'Mary';

SET SQL_SAFE_UPDATES = 1;

-- Use SAVEPOINT for testing
SAVEPOINT before_check;

-- Check balances (simulate issue)
SELECT * FROM BankAccounts;

-- If everything is fine:
COMMIT;

-- If there’s any issue, use:
-- ROLLBACK TO before_check;

-- Verify final data
SELECT * FROM BankAccounts;

