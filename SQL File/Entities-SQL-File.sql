/*Entities*/

-- 1. Department Table
CREATE TABLE department (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

-- 2. Roles Table
CREATE TABLE roles (
    role_id SERIAL PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL
);

-- 3. Employee Table
CREATE TABLE employee (
    emp_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(15),
    hire_date DATE DEFAULT CURRENT_DATE,
    dept_id INT REFERENCES department(dept_id) ON DELETE SET NULL,
    role_id INT REFERENCES roles(role_id) ON DELETE SET NULL
);

-- 4. Attendance Table
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    emp_id INT REFERENCES employee(emp_id) ON DELETE CASCADE,
    attendance_date DATE NOT NULL DEFAULT CURRENT_DATE,
    check_in TIME,
    check_out TIME,
    status VARCHAR(20), -- Present, Absent, Late, etc.
    total_hours INTERVAL
);