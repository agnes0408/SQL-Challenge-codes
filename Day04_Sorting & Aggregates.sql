
CREATE DATABASE IF NOT EXISTS ecommerce_system;
USE ecommerce_system;

/* -----------------------------------------------------------
   🧩 SQL Question 1: ORDER BY & LIMIT
   Scenario:
   In an e-commerce system, show the top 3 highest-priced products.
   Task:
   Write a SQL query using ORDER BY and LIMIT.
   Expected Output:
   Top 3 products by price are displayed.
   ----------------------------------------------------------- */

-- Creating the products table
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

-- Inserting sample data into products
INSERT INTO products (product_name, price) VALUES
('Laptop', 85000),
('Smartphone', 55000),
('Headphones', 2500),
('Smartwatch', 12000),
('Gaming Console', 40000),
('Monitor', 15000),
('Tablet', 30000);

-- Query: Top 3 highest-priced products
SELECT product_id, product_name, price
FROM products
ORDER BY price DESC
LIMIT 3;

/* -----------------------------------------------------------
   📊 SQL Question 2: Aggregate Functions
   Scenario:
   Management wants statistics of sales data.
   Task:
   Write queries using COUNT, SUM, AVG, MAX, MIN on Sales table.
   Expected Output:
   Aggregated results are returned.
   ----------------------------------------------------------- */

-- Creating the sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    product_id INT,
    amount DECIMAL(10,2),
    sale_date DATE
);

-- Inserting sample data into sales
INSERT INTO sales (product_id, amount, sale_date) VALUES
(1, 85000, '2025-10-01'),
(2, 55000, '2025-10-02'),
(3, 2500, '2025-10-03'),
(4, 12000, '2025-10-04'),
(5, 40000, '2025-10-05'),
(6, 15000, '2025-10-06'),
(7, 30000, '2025-10-07');

SELECT
    COUNT(*) AS total_sales_records,
    SUM(amount) AS total_sales_amount,
    AVG(amount) AS average_sale,
    MAX(amount) AS highest_sale,
    MIN(amount) AS lowest_sale
FROM sales;

/* -----------------------------------------------------------
   👥 SQL Question 3: GROUP BY & HAVING
   Scenario:
   Find departments with more than 10 employees.
   Task:
   Write a query using GROUP BY and HAVING.
   Expected Output:
   Only departments with >10 employees are returned.
   ----------------------------------------------------------- */

-- Creating departments table
CREATE TABLE departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100)
);

-- Inserting sample departments
INSERT INTO departments (department_name) VALUES
('Software Development'),
('Data Science'),
('Human Resources'),
('Marketing');

-- Creating employees table
CREATE TABLE employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Inserting sample employee data
INSERT INTO employees (employee_name, department_id) VALUES
('Aarav', 1), ('Riya', 1), ('Neha', 1), ('Karan', 1), ('Meera', 1),
('Arjun', 1), ('Sanya', 1), ('Raj', 1), ('Isha', 1), ('Dev', 1),
('Priya', 1),  -- 11 employees in department 1
('Kabir', 2), ('Diya', 2), ('Amit', 2), ('Nisha', 2), ('Anil', 2),
('Tina', 2), ('Vikram', 2), ('Ravi', 2), ('Ananya', 2); 

-- Query: Departments with more than 10 employees
SELECT 
    d.department_name, 
    COUNT(e.employee_id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 10;

