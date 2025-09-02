-- These queries will give summary reports at employee and department level, using GROUP BY and HAVING.

/*Monthly Attendance Summary (Present, Late, Absent count per Employee)*/
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    SUM(CASE WHEN a.status = 'Late' THEN 1 ELSE 0 END) AS late_days,
    SUM(CASE WHEN a.status = 'Absent' THEN 1 ELSE 0 END) AS absent_days
FROM employee e
LEFT JOIN attendance a ON e.emp_id = a.emp_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 8
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.emp_id, employee_name
ORDER BY employee_name;

/*Employees with More Than 5 Late Days (Using HAVING)*/
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    COUNT(*) AS late_count
FROM employee e
JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.status = 'Late'
  AND EXTRACT(MONTH FROM a.attendance_date) = 8
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.emp_id, employee_name
HAVING COUNT(*) > 5
ORDER BY late_count DESC;

/*Department-Wise Attendance Report*/
SELECT 
    d.dept_name,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS total_present,
    COUNT(CASE WHEN a.status = 'Late' THEN 1 END) AS total_late,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS total_absent
FROM department d
JOIN employee e ON d.dept_id = e.dept_id
JOIN attendance a ON e.emp_id = a.emp_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 8
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY d.dept_name
ORDER BY d.dept_name;

/*Top Performers (Employees with >90% Present Days)*/
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS attendance_percentage
FROM employee e
JOIN attendance a ON e.emp_id = a.emp_id
WHERE EXTRACT(MONTH FROM a.attendance_date) = 8
  AND EXTRACT(YEAR FROM a.attendance_date) = 2025
GROUP BY e.emp_id, employee_name
HAVING (SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) > 90
ORDER BY attendance_percentage DESC;