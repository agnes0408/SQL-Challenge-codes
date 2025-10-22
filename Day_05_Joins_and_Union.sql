
CREATE DATABASE IF NOT EXISTS university_system;
USE university_system;

/* -----------------------------------------------------------
   🎓 SQL Question 1: INNER JOIN
   Scenario:
   Show students with their enrolled course names.
   Task:
   Write a query joining Students and Courses.
   Expected Output:
   Results include only students with valid enrollments.
   ----------------------------------------------------------- */

-- Creating the Students table
CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100)
);

-- Creating the Courses table
CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100)
);

-- Creating the Enrollments table (junction table)
CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Inserting sample data
INSERT INTO students (student_name) VALUES
('Aarav'), ('Riya'), ('Neha'), ('Karan'), ('Meera');

INSERT INTO courses (course_name) VALUES
('Data Science'), ('Web Development'), ('Database Systems'), ('AI & ML');

INSERT INTO enrollments (student_id, course_id) VALUES
(1, 1), (2, 2), (3, 1), (4, 3); -- Meera not enrolled

-- Query: INNER JOIN to show only students with enrollments
SELECT 
    s.student_name, 
    c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;

/* -----------------------------------------------------------
   📋 SQL Question 2: LEFT & RIGHT JOIN
   Scenario:
   List all students and their courses, including those without matches.
   Task:
   Use LEFT JOIN and RIGHT JOIN between Students and Enrollments.
   Expected Output:
   All students/courses are shown with NULLs where no match exists.
   ----------------------------------------------------------- */

-- LEFT JOIN: Show all students, even if not enrolled
SELECT 
    s.student_name, 
    c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;

-- RIGHT JOIN: Show all courses, even if no one enrolled
SELECT 
    s.student_name, 
    c.course_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;

/* -----------------------------------------------------------
   👥 SQL Question 3: UNION vs UNION ALL
   Scenario:
   Combine lists of current and past employees.
   Task:
   Write queries demonstrating UNION and UNION ALL.
   Expected Output:
   UNION removes duplicates, UNION ALL keeps all rows.
   ----------------------------------------------------------- */

-- Creating Current Employees table
CREATE TABLE current_employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100)
);

-- Creating Past Employees table
CREATE TABLE past_employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(100)
);

-- Inserting sample data
INSERT INTO current_employees (emp_name) VALUES
('Arjun'), ('Neha'), ('Tina'), ('Ravi');

INSERT INTO past_employees (emp_name) VALUES
('Ravi'), ('Karan'), ('Neha'), ('Meera');

-- Query 1: Using UNION (removes duplicates)
SELECT emp_name FROM current_employees
UNION
SELECT emp_name FROM past_employees;

-- Query 2: Using UNION ALL (keeps duplicates)
SELECT emp_name FROM current_employees
UNION ALL
SELECT emp_name FROM past_employees;

