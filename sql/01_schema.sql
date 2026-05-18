-- ============================================================
-- Hospital Management Database System
-- Author  : Prasoon Kumar
-- College : Galgotias University
-- Tool    : MySQL Workbench
-- ============================================================

-- Step 1: Create and select the database
CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- ============================================================
-- TABLE 1: Departments
-- ============================================================
CREATE TABLE Departments (
    dept_id     INT PRIMARY KEY AUTO_INCREMENT,
    dept_name   VARCHAR(100) NOT NULL,
    dept_head   VARCHAR(100),
    location    VARCHAR(100),
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE 2: Doctors
-- ============================================================
CREATE TABLE Doctors (
    doctor_id   INT PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(100) NOT NULL,
    speciality  VARCHAR(100),
    phone       VARCHAR(15) UNIQUE,
    email       VARCHAR(100) UNIQUE,
    dept_id     INT,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE 3: Patients
-- ============================================================
CREATE TABLE Patients (
    patient_id   INT PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(100) NOT NULL,
    age          INT CHECK (age > 0 AND age < 150),
    gender       ENUM('Male', 'Female', 'Other') NOT NULL,
    phone        VARCHAR(15) UNIQUE,
    address      TEXT,
    blood_group  VARCHAR(5),
    admitted_on  DATE DEFAULT (CURDATE()),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- TABLE 4: Admissions
-- ============================================================
CREATE TABLE Admissions (
    admission_id   INT PRIMARY KEY AUTO_INCREMENT,
    patient_id     INT NOT NULL,
    doctor_id      INT NOT NULL,
    dept_id        INT,
    admission_date DATE DEFAULT (CURDATE()),
    discharge_date DATE,
    status         ENUM('admitted', 'discharged', 'under_observation')
                   DEFAULT 'admitted',
    room_no        INT,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE,
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
        ON DELETE RESTRICT,
    FOREIGN KEY (dept_id)    REFERENCES Departments(dept_id)
        ON DELETE SET NULL
);

-- ============================================================
-- TABLE 5: Billing
-- ============================================================
CREATE TABLE Billing (
    bill_id      INT PRIMARY KEY AUTO_INCREMENT,
    patient_id   INT NOT NULL,
    amount       DECIMAL(10, 2) NOT NULL CHECK (amount >= 0),
    bill_date    DATE DEFAULT (CURDATE()),
    status       ENUM('paid', 'unpaid', 'partial') DEFAULT 'unpaid',
    description  TEXT,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE
);

-- ============================================================
-- TABLE 6: Appointments
-- ============================================================
CREATE TABLE Appointments (
    appt_id      INT PRIMARY KEY AUTO_INCREMENT,
    patient_id   INT NOT NULL,
    doctor_id    INT NOT NULL,
    appt_date    DATE NOT NULL,
    appt_time    TIME NOT NULL,
    status       ENUM('scheduled', 'completed', 'cancelled')
                 DEFAULT 'scheduled',
    notes        TEXT,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id)
        ON DELETE CASCADE,
    FOREIGN KEY (doctor_id)  REFERENCES Doctors(doctor_id)
        ON DELETE RESTRICT
);
