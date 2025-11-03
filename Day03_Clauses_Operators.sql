-- Clauses & Operators

create database university;
use university;

create table Students(
Student_ID int primary key,
Student_Name varchar(100),
Email varchar(100),
Course_Taken varchar(100),
Gender enum('m', 'F'),
gpa decimal(10,2),
course_id int
);

insert into 
Students (Student_ID,Student_Name,Email,Course_Taken,Gender,gpa,course_id)
values
(1, 'Aarav', 'aarav.kumar@email.com', 'Data Science', 'M', 9.1, 301),
(2, 'Diya', 'diya.verma@email.com', 'Business Analytics', 'F', 8.7, 302),
(3, 'Rahul', NULL, 'Cyber Security', 'M', 8.5, 303),
(4, 'Sneha', 'sneha.menon@email.com', 'Graphic Design', 'F', 9.3, 304),
(5, 'Karthik', NULL, 'Artificial Intelligence', 'M', 9.6, 305);

-- 1 Distinct and where
select distinct Course_Taken
from Students;

select distinct Course_Taken
from Students
where course_id=302;

-- 2 with null and without null
select Student_ID,Student_Name from Students where email is null;

select Student_ID,Student_Name from Students where email is not null;

-- in, between, not between
select Student_ID,Student_Name from Students where course_id in(301, 304);

select Student_ID,Student_Name gpa from Students where gpa between 8.2 and 9.5;

select Student_ID,Student_Name gpa from Students where gpa not between 9.0 and 9.8;








