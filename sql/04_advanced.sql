-- ============================================================
-- Hospital Management Database — Advanced SQL
-- Author  : Prasoon Kumar | Galgotias University
-- Covers  : Views, Stored Procedures, Triggers
-- ============================================================

USE HospitalDB;

-- ============================================================
-- SECTION 1: VIEWS
-- ============================================================

-- View 1: Department revenue summary
CREATE OR REPLACE VIEW dept_revenue_summary AS
SELECT
    dep.dept_name,
    COUNT(DISTINCT a.patient_id)  AS total_patients,
    COUNT(DISTINCT d.doctor_id)   AS total_doctors,
    SUM(b.amount)                 AS total_revenue,
    AVG(b.amount)                 AS avg_bill
FROM Departments dep
LEFT JOIN Doctors d     ON dep.dept_id  = d.dept_id
LEFT JOIN Admissions a  ON d.doctor_id  = a.doctor_id
LEFT JOIN Billing b     ON a.patient_id = b.patient_id
GROUP BY dep.dept_id, dep.dept_name;

-- Use the view:
SELECT * FROM dept_revenue_summary ORDER BY total_revenue DESC;

-- View 2: Currently admitted patients
CREATE OR REPLACE VIEW current_admissions AS
SELECT
    p.name          AS patient_name,
    p.age,
    p.blood_group,
    d.name          AS doctor_name,
    dep.dept_name,
    a.room_no,
    a.admission_date,
    a.status
FROM Admissions a
JOIN Patients p     ON a.patient_id = p.patient_id
JOIN Doctors d      ON a.doctor_id  = d.doctor_id
JOIN Departments dep ON d.dept_id   = dep.dept_id
WHERE a.status IN ('admitted', 'under_observation');

-- Use the view:
SELECT * FROM current_admissions;

-- ============================================================
-- SECTION 2: STORED PROCEDURES
-- ============================================================

-- Procedure 1: Admit a new patient
DELIMITER //
CREATE PROCEDURE AdmitPatient(
    IN p_name       VARCHAR(100),
    IN p_age        INT,
    IN p_gender     ENUM('Male','Female','Other'),
    IN p_phone      VARCHAR(15),
    IN p_blood      VARCHAR(5),
    IN p_doctor_id  INT,
    IN p_room_no    INT
)
BEGIN
    DECLARE v_patient_id INT;
    DECLARE v_dept_id    INT;

    -- Get dept_id from doctor
    SELECT dept_id INTO v_dept_id
    FROM Doctors WHERE doctor_id = p_doctor_id;

    -- Insert patient
    INSERT INTO Patients (name, age, gender, phone, blood_group)
    VALUES (p_name, p_age, p_gender, p_phone, p_blood);

    SET v_patient_id = LAST_INSERT_ID();

    -- Create admission record
    INSERT INTO Admissions (patient_id, doctor_id, dept_id, room_no)
    VALUES (v_patient_id, p_doctor_id, v_dept_id, p_room_no);

    SELECT CONCAT('Patient admitted successfully. ID: ', v_patient_id) AS result;
END//
DELIMITER ;

-- Call the procedure:
-- CALL AdmitPatient('Rahul Verma', 35, 'Male', '9911112222', 'A+', 1, 105);

-- Procedure 2: Get patient full report
DELIMITER //
CREATE PROCEDURE GetPatientReport(IN p_id INT)
BEGIN
    -- Patient info
    SELECT name, age, gender, blood_group, admitted_on
    FROM Patients WHERE patient_id = p_id;

    -- Admission history
    SELECT a.admission_date, a.discharge_date, a.status,
           d.name AS doctor, dep.dept_name
    FROM Admissions a
    JOIN Doctors d ON a.doctor_id = d.doctor_id
    JOIN Departments dep ON d.dept_id = dep.dept_id
    WHERE a.patient_id = p_id;

    -- Billing summary
    SELECT SUM(amount) AS total_billed,
           SUM(CASE WHEN status='paid' THEN amount ELSE 0 END) AS paid,
           SUM(CASE WHEN status='unpaid' THEN amount ELSE 0 END) AS pending
    FROM Billing WHERE patient_id = p_id;
END//
DELIMITER ;

-- Call: CALL GetPatientReport(1);

-- ============================================================
-- SECTION 3: TRIGGERS
-- ============================================================

-- Trigger 1: Auto-log when patient is discharged
CREATE TABLE IF NOT EXISTS Audit_Log (
    log_id      INT PRIMARY KEY AUTO_INCREMENT,
    patient_id  INT,
    action      VARCHAR(50),
    action_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    remarks     TEXT
);

DELIMITER //
CREATE TRIGGER after_patient_discharge
AFTER UPDATE ON Admissions
FOR EACH ROW
BEGIN
    IF NEW.status = 'discharged' AND OLD.status != 'discharged' THEN
        INSERT INTO Audit_Log (patient_id, action, remarks)
        VALUES (
            NEW.patient_id,
            'DISCHARGED',
            CONCAT('Discharged from room ', NEW.room_no, ' on ', CURDATE())
        );
    END IF;
END//
DELIMITER ;

-- Trigger 2: Prevent billing amount from being negative
DELIMITER //
CREATE TRIGGER before_billing_insert
BEFORE INSERT ON Billing
FOR EACH ROW
BEGIN
    IF NEW.amount < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Billing amount cannot be negative.';
    END IF;
END//
DELIMITER ;
