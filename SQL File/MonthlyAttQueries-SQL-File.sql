/*Find All Late Arrivals (with details)
Shows exactly which employees came late, on which dates, and at what time.*/
-- Detailed late arrivals
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    a.attendance_date,
    a.check_in,
    a.check_out,
    a.status
FROM attendance a
JOIN employee e ON a.emp_id = e.emp_id
WHERE a.status = 'Late'
ORDER BY a.attendance_date DESC;

/*Count of Late Arrivals by Department
Helps identify which department has the most late employees.*/
-- Late arrivals grouped by department
SELECT 
    d.dept_name,
    COUNT(*) AS total_late_arrivals
FROM attendance a
JOIN employee e ON a.emp_id = e.emp_id
JOIN department d ON e.dept_id = d.dept_id
WHERE a.status = 'Late'
GROUP BY d.dept_name
ORDER BY total_late_arrivals DESC;

/*Monthly Attendance % (for all employees)
Calculates attendance percentage per employee, month by month.*/
-- Monthly attendance percentage
SELECT 
    e.emp_id,
    e.first_name || ' ' || e.last_name AS employee_name,
    DATE_TRUNC('month', a.attendance_date) AS month,
    ROUND(100.0 * COUNT(*) FILTER (WHERE a.status IN ('Present', 'Late', 'Half-day')) / COUNT(*), 2) AS attendance_percentage
FROM attendance a
JOIN employee e ON a.emp_id = e.emp_id
GROUP BY e.emp_id, e.first_name, e.last_name, DATE_TRUNC('month', a.attendance_date)
ORDER BY month, attendance_percentage DESC;










