-- Write a query to display employee details along with their department name and role.
SELECT e.emp_id, e.first_name, e.last_name, d.dept_name, r.role_name
FROM emp_attendance_tracker.emp e
JOIN emp_attendance_tracker.dept d  ON e.dept_id = d.dept_id
JOIN emp_attendance_tracker.roles r ON e.role_id = r.role_id;

-- Write a query to display employees along with their attendance records (check-in, check-out, and status).
SELECT e.emp_id, e.first_name, a.check_in, a.check_out, a.status
FROM emp_attendance_tracker.emp e
JOIN emp_attendance_tracker.attendance a ON e.emp_id = a.emp_id
ORDER BY a.check_in;

-- Write a query to display the number of employees in each department.
SELECT d.dept_name, COUNT(e.emp_id) AS total_employees
FROM emp_attendance_tracker.dept d
LEFT JOIN emp_attendance_tracker.emp e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Write a query to display the list of employees who arrived late (after 9:30 AM) along with their 
-- check-in date and time).
SELECT e.emp_id, e.first_name, e.last_name, a.check_in::date, a.check_in::time
FROM emp_attendance_tracker.emp e
JOIN emp_attendance_tracker.attendance a ON e.emp_id = a.emp_id
WHERE a.check_in::time > '09:30:00';

-- Write a query to display the employees who do not have any attendance records.
SELECT e.emp_id, e.first_name, e.last_name
FROM emp_attendance_tracker.emp e
LEFT JOIN emp_attendance_tracker.attendance a ON e.emp_id = a.emp_id
WHERE a.attendance_id IS NULL;


-- Display the names of employees along with the dates they were marked present.
SELECT e.emp_name, a.attendance_date 
FROM emp e JOIN attendance a ON e.emp_id = a.emp_id WHERE a.status = 'Present';


-- Write a query to generate a full employee attendance report showing employee details, department, 
-- role, attendance date, check-in & check-out times, total work hours, and status.
SELECT 
    e.emp_id,e.first_name || ' ' || e.last_name AS employee_name,d.dept_name,r.role_name,
    a.check_in::date AS attendance_date,a.check_in::time AS check_in_time,
    a.check_out::time AS check_out_time,(a.check_out - a.check_in) AS work_hours,a.status
FROM emp_attendance_tracker.emp e
JOIN emp_attendance_tracker.dept d ON e.dept_id = d.dept_id
JOIN emp_attendance_tracker.roles r ON e.role_id = r.role_id
LEFT JOIN emp_attendance_tracker.attendance a ON e.emp_id = a.emp_id
ORDER BY a.check_in DESC;













