CREATE DATABASE IF NOT EXISTS company_functions;
USE company_functions;


/* -----------------------------------------------------------
   🧩 SQL Question 1: String Functions
   Scenario:
   Clean up employee names for reporting.
   Task:
   Write queries using UPPER, LOWER, SUBSTRING, CONCAT.
   Expected Output:
   Formatted name outputs are displayed.
   ----------------------------------------------------------- */

-- Create employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Insert sample data
INSERT INTO employees (first_name, last_name) VALUES
('aarav', 'sharma'),
('Riya', 'PATEL'),
('NEHA', 'kumar'),
('karan', 'MEHTA');

-- Query: Demonstrate String Functions
SELECT 
    first_name,
    last_name,
    UPPER(first_name) AS upper_name,
    LOWER(last_name) AS lower_name,
    CONCAT(UPPER(SUBSTRING(first_name, 1, 1)), LOWER(SUBSTRING(first_name, 2))) AS proper_case_first,
    CONCAT(first_name, ' ', last_name) AS full_name
FROM employees;

/* -----------------------------------------------------------
   🗓️ SQL Question 2: Date Functions
   Scenario:
   Calculate employee tenure in years.
   Task:
   Use DATE functions like YEAR(), DATEDIFF(), NOW().
   Expected Output:
   Employee tenure is calculated correctly.
   ----------------------------------------------------------- */

-- Create employee_details table with join date
CREATE TABLE employee_details (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100),
    join_date DATE
);

-- Insert sample data
INSERT INTO employee_details (emp_name, join_date) VALUES
('Aarav Sharma', '2018-05-10'),
('Riya Patel', '2020-01-15'),
('Neha Kumar', '2022-07-01'),
('Karan Mehta', '2019-03-20');

-- Query: Calculate tenure in years
SELECT
    emp_name,
    join_date,
    YEAR(NOW()) - YEAR(join_date) AS tenure_in_years,
    DATEDIFF(NOW(), join_date) AS total_days_in_company
FROM employee_details;

/* -----------------------------------------------------------
   🧠 SQL Question 3: User-defined Function (UDF)
   Scenario:
   Create a reusable function to return full name of a student.
   Task:
   Write and test a UDF combining FirstName + LastName.
   Expected Output:
   Full name is returned when function is called.
   ----------------------------------------------------------- */

-- Create students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50)
);

-- Insert sample data
INSERT INTO students (first_name, last_name) VALUES
('Diya', 'Rao'),
('Vikram', 'Singh'),
('Tina', 'Verma');

-- Drop function if exists (for reruns)
DROP FUNCTION IF EXISTS getFullName;

-- Create User Defined Function
DELIMITER $$
CREATE FUNCTION getFullName(f_name VARCHAR(50), l_name VARCHAR(50))
RETURNS VARCHAR(120)
DETERMINISTIC
BEGIN
    RETURN CONCAT(f_name, ' ', l_name);
END$$
DELIMITER ;

-- Test the function
SELECT 
    student_id, 
    getFullName(first_name, last_name) AS full_name
FROM students;
