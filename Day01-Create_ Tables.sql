-- SQL Daily Challenge  Day-1

CREATE DATABASE hospital;

USE hospital;

/* SQL Question 1: CREATE Table
Scenario:
 You are a data analyst at City Hospital. Management wants to create a new table to store patient details.
Task:
 Write a SQL command to create a table named Patients with fields (PatientID, PatientName, Age, Gender, AdmissionDate) */

CREATE TABLE Patients(
PatientID INT PRIMARY KEY,
PatientName VARCHAR(50) UNIQUE NOT NULL,
Age INT,
Gender VARCHAR(10),
AdmissionDate DATE
);

/* SQL Question 2: ALTER – Add Column
Scenario:
 Later, the hospital decides to store the doctor assigned to each patient.
Task:
 Write a SQL command to add a new column DoctorAssigned VARCHAR(50) to the Patients table */
 
ALTER TABLE Patients 
ADD COLUMN DoctorAssigned VARCHAR(50);

/* SQL Question 3: ALTER – Modify Column
Scenario:
 The hospital realizes that some patient names are longer than 50 characters.
Task:
 Write a SQL command to modify the column PatientName from VARCHAR(50) to VARCHAR(100)*/
 
ALTER TABLE Patients
MODIFY COLUMN PatientName VARCHAR(100);

/* SQL Question 4: RENAME Table
Scenario:
 For better clarity, the hospital wants to rename Patients to Patient_Info.
Task:
 Write a SQL command to rename the table */
 
 RENAME TABLE Patients TO Patients_info;

/* SQL Question 5: TRUNCATE vs DROP
Scenario:
 At year-end, they want to delete all patient records but keep the table. Later, they want to remove it permanently.
Task:
 Write SQL commands for TRUNCATE and DROP operations */

TRUNCATE TABLE Patients_Info;

DROP DATABASE hospital;
