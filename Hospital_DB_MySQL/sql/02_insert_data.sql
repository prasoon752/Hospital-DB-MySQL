-- ============================================================
-- Hospital Management Database — Sample Data
-- Author  : Prasoon Kumar | Galgotias University
-- ============================================================

USE HospitalDB;

-- ── Departments ──────────────────────────────────────────────
INSERT INTO Departments (dept_name, dept_head, location) VALUES
('Cardiology',     'Dr. Meena Kapoor',  'Block A, Floor 2'),
('Neurology',      'Dr. Suresh Rao',    'Block B, Floor 1'),
('Orthopaedics',   'Dr. Anjali Mehta',  'Block C, Floor 3'),
('General Medicine','Dr. Rajesh Gupta', 'Block A, Floor 1'),
('Oncology',       'Dr. Priya Sharma',  'Block D, Floor 2');

-- ── Doctors ──────────────────────────────────────────────────
INSERT INTO Doctors (name, speciality, phone, email, dept_id) VALUES
('Dr. Meena Kapoor',  'Cardiologist',      '9876500001', 'meena@hospital.com',  1),
('Dr. Suresh Rao',    'Neurologist',       '9876500002', 'suresh@hospital.com', 2),
('Dr. Anjali Mehta',  'Orthopaedic',       '9876500003', 'anjali@hospital.com', 3),
('Dr. Rajesh Gupta',  'General Physician', '9876500004', 'rajesh@hospital.com', 4),
('Dr. Priya Sharma',  'Oncologist',        '9876500005', 'priya@hospital.com',  5),
('Dr. Arjun Verma',   'Cardiologist',      '9876500006', 'arjun@hospital.com',  1),
('Dr. Neha Singh',    'Neurologist',       '9876500007', 'neha@hospital.com',   2);

-- ── Patients ─────────────────────────────────────────────────
INSERT INTO Patients (name, age, gender, phone, address, blood_group) VALUES
('Ravi Sharma',    45, 'Male',   '9900001001', 'Delhi',       'O+'),
('Priya Singh',    32, 'Female', '9900001002', 'Noida',       'A+'),
('Amit Kumar',     58, 'Male',   '9900001003', 'Gurgaon',     'B+'),
('Sunita Devi',    41, 'Female', '9900001004', 'Ghaziabad',   'AB+'),
('Rohit Jain',     27, 'Male',   '9900001005', 'Faridabad',   'O-'),
('Kavita Mishra',  63, 'Female', '9900001006', 'Lucknow',     'A-'),
('Deepak Tiwari',  38, 'Male',   '9900001007', 'Kanpur',      'B-'),
('Anjali Yadav',   29, 'Female', '9900001008', 'Agra',        'AB-'),
('Vikas Pandey',   52, 'Male',   '9900001009', 'Meerut',      'O+'),
('Meena Agarwal',  47, 'Female', '9900001010', 'Mathura',     'A+');

-- ── Admissions ───────────────────────────────────────────────
INSERT INTO Admissions (patient_id, doctor_id, dept_id, admission_date, status, room_no) VALUES
(1,  1, 1, '2026-03-01', 'discharged',         101),
(2,  2, 2, '2026-03-05', 'discharged',         201),
(3,  1, 1, '2026-03-10', 'discharged',         102),
(4,  3, 3, '2026-03-12', 'admitted',           301),
(5,  4, 4, '2026-03-15', 'under_observation',  401),
(6,  5, 5, '2026-03-18', 'admitted',           501),
(7,  2, 2, '2026-03-20', 'discharged',         202),
(8,  1, 1, '2026-03-22', 'admitted',           103),
(9,  6, 1, '2026-03-25', 'admitted',           104),
(10, 7, 2, '2026-03-28', 'under_observation',  203);

-- ── Billing ──────────────────────────────────────────────────
INSERT INTO Billing (patient_id, amount, bill_date, status, description) VALUES
(1,  15000.00, '2026-03-10', 'paid',    'Cardiology consultation + ECG'),
(2,  22000.00, '2026-03-15', 'paid',    'Neurology tests + MRI'),
(3,  18000.00, '2026-03-20', 'unpaid',  'Cardiac monitoring 10 days'),
(4,   8500.00, '2026-03-22', 'partial', 'Orthopaedic X-ray + cast'),
(5,   5000.00, '2026-03-25', 'unpaid',  'General checkup + blood tests'),
(6,  45000.00, '2026-03-28', 'unpaid',  'Oncology treatment cycle 1'),
(7,  12000.00, '2026-03-30', 'paid',    'Neurology follow-up + medicines'),
(8,  20000.00, '2026-04-01', 'unpaid',  'Cardiac surgery pre-op'),
(9,  16500.00, '2026-04-02', 'partial', 'Angioplasty consultation'),
(10,  9000.00, '2026-04-03', 'unpaid',  'Neurology observation 5 days');

-- ── Appointments ─────────────────────────────────────────────
INSERT INTO Appointments (patient_id, doctor_id, appt_date, appt_time, status) VALUES
(1, 1, '2026-04-10', '09:00:00', 'completed'),
(2, 2, '2026-04-11', '10:30:00', 'completed'),
(3, 1, '2026-04-12', '11:00:00', 'scheduled'),
(4, 3, '2026-04-13', '14:00:00', 'scheduled'),
(5, 4, '2026-04-14', '09:30:00', 'cancelled'),
(6, 5, '2026-04-15', '16:00:00', 'scheduled'),
(7, 2, '2026-04-16', '10:00:00', 'completed'),
(8, 1, '2026-04-17', '11:30:00', 'scheduled'),
(9, 6, '2026-04-18', '13:00:00', 'scheduled'),
(10,7, '2026-04-19', '15:00:00', 'scheduled');
