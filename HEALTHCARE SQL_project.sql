use healthcare_db;
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    DateOfBirth DATE,
    Gender VARCHAR(20)
);
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    DoctorName VARCHAR(100),
    Specialization VARCHAR(100)
);
CREATE TABLE Visits (
    VisitID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    VisitDate DATE,
    ReasonForVisit VARCHAR(255),
    Diagnosis VARCHAR(255),
    FollowUpRequired VARCHAR(10)
);
CREATE TABLE Treatments (
    TreatmentID INT PRIMARY KEY,
    VisitID INT,
    MedicationPrescribed VARCHAR(255),
    TreatmentCost DECIMAL(10,2)
);
CREATE TABLE LabResults (
    LabResultID INT PRIMARY KEY,
    VisitID INT,
    TestName VARCHAR(100),
    Result VARCHAR(50)
);

SHOW TABLES;
SELECT COUNT(*) FROM Patients;
SELECT COUNT(*) FROM Doctors;
SELECT COUNT(*) FROM Visits;
SELECT COUNT(*) FROM Treatments;
SELECT COUNT(*) FROM LabResults;

SHOW TABLES;

use healthcare_db;

SELECT 'patients' AS table_name, COUNT(*) AS row_count
FROM patients

UNION ALL

SELECT 'doctors', COUNT(*)
FROM doctors

UNION ALL

SELECT 'labresults', COUNT(*)
FROM labresults

UNION ALL

SELECT 'treatments', COUNT(*)
FROM treatments

UNION ALL

SELECT 'visits', COUNT(*)
FROM visits;


LOAD DATA LOCAL INFILE
"C:/Users/AMMIJAAN/Downloads/Patient.csv"
INTO TABLE Patients
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
..............................
--KPI 1
...............................
SELECT COUNT(*) AS Total_Patients
FROM Patients;

..............................
--KPI 2
...............................

USE healthcare_db;
SELECT * FROM Doctors
LIMIT 10;

SELECT COUNT(DoctorID) AS Total_Doctors
FROM Doctors;

..............................
--KPI 3
...............................

USE healthcare_db;

SELECT COUNT(VisitID) AS Total_Visits
FROM Visits;

..............................
--KPI 4
...............................
SELECT AVG(TIMESTAMPDIFF(YEAR, DateOfBirth, CURDATE())) AS Average_Age
FROM Patients;

..............................
--KPI 5
...............................
SELECT 
    Diagnosis,
    COUNT(*) AS Diagnosis_Count
FROM Visits
GROUP BY Diagnosis
ORDER BY Diagnosis_Count DESC
LIMIT 5;

..............................
--KPI 6
...............................
SELECT 
    COUNT(CASE 
        WHEN FollowUpRequired = 'Yes' THEN 1 
    END) * 100.0 / COUNT(VisitID) AS Follow_Up_Rate
FROM Visits;

..............................
--KPI 7
...............................
SELECT 
    AVG(TreatmentCost) AS Average_Treatment_Cost
FROM Treatments;

..............................
--KPI 8
...............................

SELECT COUNT(LabResultID) AS Total_Lab_Tests
FROM LabResults;

..............................
--KPI 9
...............................
SELECT 
    COUNT(CASE 
        WHEN Result = 'Abnormal' THEN 1 
    END) * 100.0 / COUNT(LabResultID) AS Abnormal_Lab_Percentage
FROM LabResults;

..............................
--KPI 10
...............................
SELECT 
    COUNT(VisitID) * 1.0 / COUNT(DISTINCT DoctorID) AS Avg_Patients_Per_Doctor
FROM Visits;