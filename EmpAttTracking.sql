/*Create Database*/
CREATE DATABASE employee_attendance_tracker;

/*Create Schema*/
CREATE SCHEMA emp_attendance_tracker;

/*Create table Department(dept)*/
CREATE TABLE emp_attendance_tracker.dept (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

/*Create table Roles(roles)*/
CREATE TABLE emp_attendance_tracker.roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

/*Create table Employee(emp)*/
CREATE TABLE emp_attendance_tracker.emp (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    dept_id INT REFERENCES emp_attendance_tracker.dept(dept_id) ON DELETE SET NULL,
    role_id INT REFERENCES emp_attendance_tracker.roles(role_id) ON DELETE SET NULL,
    join_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(30) DEFAULT 'Active'
);

/*Create table Attendance(attendance)*/
CREATE TABLE emp_attendance_tracker.attendance (
    attendance_id SERIAL PRIMARY KEY,
    emp_id INT REFERENCES emp_attendance_tracker.emp(emp_id) ON DELETE CASCADE,
    check_in TIMESTAMP NOT NULL,
    check_out TIMESTAMP,
    status VARCHAR(30) DEFAULT 'Present'
);

/*Query for show all tables in schema*/
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'emp_attendance_tracker';

/*Insert records in dept table*/
INSERT INTO emp_attendance_tracker.dept (dept_name)
VALUES 
('HR'),
('Finance'),
('IT'),
('Operations'),
('Marketing'),
('Product'),
('Sales'),
('Development'),
('DevOps'),
('Data Analyst');

select * from emp_attendance_tracker.dept;


/*Insert records in dept table*/
INSERT INTO emp_attendance_tracker.roles (role_name)
VALUES 
('CEO'),
('Manager'),
('Team Lead'),
('Developer'),
('Tester'),
('Intern'),
('Database Administrator'),
('HR Excecutive'),
('Finance Analyst'),
('Sales Excecutive'),
('DevOps Engineer');

select * from emp_attendance_tracker.roles;

INSERT INTO emp_attendance_tracker.emp 
(first_name, last_name, email, dept_id, role_id, join_date, status)
VALUES
('Sanika', 'Sharma', 'sanika.sharma@example.com', 1, 8, '2023-06-01', 'Active'),
('Rahul', 'Verma', 'rahul.verma@example.com', 3, 4, '2023-07-15', 'Inactive'),
('Ananya', 'Gupta', 'ananya.gupta@example.com', 5, 10, '2023-08-01', 'Active'),
('Vikram', 'Singh', 'vikram.singh@example.com', 6, 10, '2023-09-10', 'Inactive'),
('Priya', 'Nair', 'priya.nair@example.com', 9, 11, '2023-10-05', 'Active');

select * from emp_attendance_tracker.emp;

INSERT INTO emp_attendance_tracker.emp 
(first_name, last_name, email, dept_id, role_id, join_date, status)
VALUES
('Rita', 'Purbe', 'ritapurbe@gmail.com', 3, 6, '2024-05-02', 'Active'),
('Tejas', 'Patil', 'tejas@gmail.com', 10, 6, '2022-04-06', 'Inactive'),
('Kunika', 'Jadhaw', 'kunikaj@gmail.com', 6,7, '2022-05-01', 'Inactive'),
('Riyansh', 'Kurhe', 'Kurher@gmail.com', 1,9, '2024-01-01', 'Active'),
('Manish', 'Mane', 'manemanish@gmail.com', 3,5, '2025-01-02', 'Active'),
('Rita', 'Ratane', 'ritaratane@gmail.com', 3,11, '2021-04-06', 'Active'),
('Piyush', 'Dakhode', 'piyushd@gmail.com', 7,7, '2024-06-04', 'Active'),
('Seema', 'Shende', 'seemashende@gmail.com', 10,9, '2025-06-03', 'Active'),
('Kajal', 'Rakhe', 'Kajalrakhe@gmail.com', 8,6, '2022-08-07', 'Inactive');

commit;

/*Writing 200 dummy records*/
INSERT INTO emp_attendance_tracker.emp 
(first_name, last_name, email, dept_id, role_id, join_date, status)
SELECT 
    'FirstName' || gs AS first_name,
    'LastName' || gs AS last_name,
    'user' || gs || '@example.com' AS email,
    ((gs % 5) + 1) AS dept_id,         -- departments 1–5
    ((gs % 4) + 1) AS role_id,         -- roles 1–4
    CURRENT_DATE - (gs || ' days')::interval AS join_date,
    CASE WHEN gs % 2 = 0 THEN 'Active' ELSE 'Inactive' END AS status
FROM generate_series(1,200) AS gs;


/*Insert records in attendance table*/
INSERT INTO emp_attendance_tracker.attendance 
(emp_id, check_in, check_out, status)
VALUES
(1, '2025-08-01 09:05:00', '2025-08-01 17:30:00', 'Present'),
(2, '2025-08-01 09:45:00', '2025-08-01 18:00:00', 'Late'),
(3, '2025-08-01 09:20:00', '2025-08-01 17:15:00', 'Present'),
(4, '2025-08-01 00:00:00', NULL, 'Absent'),
(5, '2025-08-01 10:05:00', '2025-08-01 16:45:00', 'Late'),

(1, '2025-08-02 09:10:00', '2025-08-02 17:40:00', 'Present'),
(2, '2025-08-02 09:50:00', '2025-08-02 18:10:00', 'Late'),
(3, '2025-08-02 09:25:00', '2025-08-02 17:20:00', 'Present'),
(4, '2025-08-02 09:00:00', '2025-08-02 17:00:00', 'Present'),
(5, '2025-08-02 10:15:00', '2025-08-02 16:30:00', 'Late'),

(1, '2025-08-03 09:05:00', '2025-08-03 17:25:00', 'Present'),
(2, '2025-08-03 09:35:00', '2025-08-03 18:00:00', 'Late'),
(3, '2025-08-03 09:22:00', '2025-08-03 17:05:00', 'Present'),
(4, '2025-08-03 00:00:00', NULL, 'Absent'),
(5, '2025-08-03 09:55:00', '2025-08-03 16:55:00', 'Late'),

(1, '2025-08-04 09:15:00', '2025-08-04 17:45:00', 'Present'),
(2, '2025-08-04 09:48:00', '2025-08-04 18:05:00', 'Late'),
(3, '2025-08-04 09:28:00', '2025-08-04 17:35:00', 'Present'),
(4, '2025-08-04 09:05:00', '2025-08-04 17:00:00', 'Present'),
(5, '2025-08-04 10:20:00', '2025-08-04 16:50:00', 'Late');

commit;

select * from emp_attendance_tracker.attendance;














