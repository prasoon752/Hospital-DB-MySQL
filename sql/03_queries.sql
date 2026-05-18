-- ============================================================
-- Hospital Management Database — Queries
-- Author  : Prasoon Kumar | Galgotias University
-- Covers  : SELECT, WHERE, ORDER BY, JOIN, GROUP BY,
--           HAVING, Subqueries, Aggregate Functions
-- ============================================================

USE HospitalDB;

-- ============================================================
-- SECTION 1: BASIC SELECT QUERIES
-- ============================================================

-- Q1: Get all patients
SELECT * FROM Patients;

-- Q2: Get patients above age 40 sorted by age
SELECT name, age, gender, blood_group
FROM Patients
WHERE age > 40
ORDER BY age DESC;

-- Q3: Get all admitted (not discharged) patients
SELECT p.name, a.admission_date, a.room_no, a.status
FROM Patients p
JOIN Admissions a ON p.patient_id = a.patient_id
WHERE a.status != 'discharged'
ORDER BY a.admission_date;

-- Q4: Get all unpaid bills
SELECT p.name, b.amount, b.bill_date, b.description
FROM Patients p
JOIN Billing b ON p.patient_id = b.patient_id
WHERE b.status = 'unpaid'
ORDER BY b.amount DESC;

-- ============================================================
-- SECTION 2: JOIN QUERIES
-- ============================================================

-- Q5: Patient name + their doctor + department (3-table JOIN)
SELECT
    p.name          AS patient_name,
    d.name          AS doctor_name,
    d.speciality,
    dep.dept_name   AS department,
    a.status        AS admission_status
FROM Patients p
INNER JOIN Admissions a    ON p.patient_id  = a.patient_id
INNER JOIN Doctors d       ON a.doctor_id   = d.doctor_id
INNER JOIN Departments dep ON d.dept_id     = dep.dept_id
ORDER BY dep.dept_name, p.name;

-- Q6: All doctors with their department (even if no patients)
SELECT
    d.name        AS doctor_name,
    d.speciality,
    dep.dept_name AS department,
    dep.location
FROM Doctors d
LEFT JOIN Departments dep ON d.dept_id = dep.dept_id
ORDER BY dep.dept_name;

-- Q7: Patients who have NO appointments yet
SELECT p.name, p.age, p.phone
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.appt_id IS NULL;

-- ============================================================
-- SECTION 3: AGGREGATE FUNCTIONS + GROUP BY
-- ============================================================

-- Q8: Count patients per department
SELECT
    dep.dept_name,
    COUNT(a.patient_id)          AS total_patients,
    COUNT(DISTINCT d.doctor_id)  AS total_doctors
FROM Departments dep
LEFT JOIN Doctors d     ON dep.dept_id   = d.dept_id
LEFT JOIN Admissions a  ON d.doctor_id   = a.doctor_id
GROUP BY dep.dept_name
ORDER BY total_patients DESC;

-- Q9: Total and average billing per department
SELECT
    dep.dept_name,
    COUNT(b.bill_id)    AS total_bills,
    SUM(b.amount)       AS total_revenue,
    AVG(b.amount)       AS avg_bill,
    MAX(b.amount)       AS highest_bill,
    MIN(b.amount)       AS lowest_bill
FROM Departments dep
JOIN Doctors d      ON dep.dept_id   = d.dept_id
JOIN Admissions a   ON d.doctor_id   = a.doctor_id
JOIN Billing b      ON a.patient_id  = b.patient_id
GROUP BY dep.dept_name
ORDER BY total_revenue DESC;

-- Q10: Doctors with more than 1 patient (HAVING clause)
SELECT
    d.name          AS doctor_name,
    d.speciality,
    COUNT(a.patient_id) AS patient_count
FROM Doctors d
JOIN Admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.name, d.speciality
HAVING patient_count > 1
ORDER BY patient_count DESC;

-- Q11: Count patients by gender
SELECT
    gender,
    COUNT(*)     AS total_patients,
    AVG(age)     AS avg_age,
    MIN(age)     AS youngest,
    MAX(age)     AS oldest
FROM Patients
GROUP BY gender;

-- ============================================================
-- SECTION 4: SUBQUERIES
-- ============================================================

-- Q12: Patients whose bill is above average
SELECT p.name, b.amount
FROM Patients p
JOIN Billing b ON p.patient_id = b.patient_id
WHERE b.amount > (
    SELECT AVG(amount) FROM Billing
)
ORDER BY b.amount DESC;

-- Q13: Department with the highest number of patients
SELECT dept_name
FROM Departments
WHERE dept_id = (
    SELECT dept_id
    FROM Admissions
    GROUP BY dept_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Q14: Patients admitted in the last 30 days
SELECT name, age, gender, admitted_on
FROM Patients
WHERE admitted_on >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
ORDER BY admitted_on DESC;

-- ============================================================
-- SECTION 5: UPDATE & DELETE
-- ============================================================

-- Q15: Discharge a patient
UPDATE Admissions
SET status = 'discharged',
    discharge_date = CURDATE()
WHERE patient_id = 4 AND status = 'admitted';

-- Q16: Mark a bill as paid
UPDATE Billing
SET status = 'paid'
WHERE patient_id = 3 AND status = 'unpaid';

-- Q17: Cancel an appointment
UPDATE Appointments
SET status = 'cancelled'
WHERE appt_id = 5;

-- Q18: Delete a cancelled appointment (safe delete)
DELETE FROM Appointments
WHERE status = 'cancelled'
AND appt_date < CURDATE();
