# 🏥 Hospital Management Database System

A fully normalized relational database for a Hospital Management System, designed and implemented using **MySQL Workbench**.

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?style=flat-square&logo=mysql)
![SQL](https://img.shields.io/badge/SQL-Intermediate-green?style=flat-square)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen?style=flat-square)
![License](https://img.shields.io/badge/License-MIT-yellow?style=flat-square)

---

## 📌 Overview

This project models a real-world hospital management system with 6 fully normalized tables covering patients, doctors, departments, admissions, billing, and appointments — connected using primary and foreign keys.

---

## 🗂️ Project Structure

```
Hospital_DB_MySQL/
├── sql/
│   ├── 01_schema.sql       ← Create all 6 tables
│   ├── 02_insert_data.sql  ← Sample data (10 patients, 7 doctors)
│   ├── 03_queries.sql      ← 18 queries (SELECT, JOIN, GROUP BY)
│   └── 04_advanced.sql     ← Views, Stored Procedures, Triggers
└── README.md
```

---

## 🗄️ Database Schema

```
Departments ──< Doctors ──< Admissions >── Patients
                                              │
                                           Billing
                                              │
                                        Appointments
```

| Table | Description | Key Columns |
|---|---|---|
| Departments | Hospital departments | dept_id, dept_name, dept_head |
| Doctors | Doctor details | doctor_id, speciality, dept_id (FK) |
| Patients | Patient records | patient_id, age, gender, blood_group |
| Admissions | Patient-Doctor link | patient_id (FK), doctor_id (FK) |
| Billing | Bills per patient | patient_id (FK), amount, status |
| Appointments | Scheduled visits | patient_id (FK), doctor_id (FK) |

---

## 📋 SQL Concepts Covered

### Basic
- `CREATE DATABASE`, `CREATE TABLE`
- `PRIMARY KEY`, `FOREIGN KEY`, `AUTO_INCREMENT`
- `NOT NULL`, `UNIQUE`, `CHECK`, `DEFAULT`
- `INSERT`, `SELECT`, `UPDATE`, `DELETE`
- `WHERE`, `ORDER BY`, `LIMIT`

### Intermediate
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`
- `GROUP BY`, `HAVING`
- `COUNT()`, `SUM()`, `AVG()`, `MAX()`, `MIN()`
- Subqueries
- `ENUM`, `DECIMAL`, `TIMESTAMP`

### Advanced
- `CREATE VIEW`
- `STORED PROCEDURE` with `IN` parameters
- `TRIGGER` (AFTER UPDATE, BEFORE INSERT)
- `DELIMITER`
- `SIGNAL SQLSTATE` for custom error handling

---

## 🚀 How to Run

### Prerequisites
- MySQL Server 8.0+
- MySQL Workbench (recommended)

### Steps

**1. Open MySQL Workbench and connect to your local server**

**2. Run files in order:**
```sql
-- Step 1: Create tables
SOURCE sql/01_schema.sql;

-- Step 2: Insert sample data
SOURCE sql/02_insert_data.sql;

-- Step 3: Run queries
SOURCE sql/03_queries.sql;

-- Step 4: Create views, procedures, triggers
SOURCE sql/04_advanced.sql;
```

**Or copy-paste each file directly into the MySQL Workbench query editor.**

---

## 📊 Sample Query Output

**Patients per Department:**
| dept_name | total_patients | total_doctors |
|---|---|---|
| Cardiology | 3 | 2 |
| Neurology | 3 | 2 |
| Orthopaedics | 1 | 1 |

**Revenue by Department:**
| dept_name | total_revenue | avg_bill |
|---|---|---|
| Oncology | ₹45,000 | ₹45,000 |
| Neurology | ₹43,000 | ₹14,333 |
| Cardiology | ₹69,500 | ₹17,375 |

---

## 👤 Author

**Prasoon Kumar**
B.Tech CSE · Galgotias University
GitHub: [prasoon752](https://github.com/prasoon752)

---

## 📄 License

MIT License — free to use for educational purposes.
