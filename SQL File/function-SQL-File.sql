/*Function: Calculate work hours for a single employee & date range*/
-- Function to calculate total work hours of an employee within a date range
CREATE OR REPLACE FUNCTION get_total_work_hours(
    p_emp_id INT,
    p_start_date DATE,
    p_end_date DATE
)
RETURNS INTERVAL AS $$
DECLARE
    total_hours INTERVAL;
BEGIN
    SELECT SUM(a.check_out - a.check_in)
    INTO total_hours
    FROM attendance a
    WHERE a.emp_id = p_emp_id
      AND a.attendance_date BETWEEN p_start_date AND p_end_date
      AND a.check_in IS NOT NULL
      AND a.check_out IS NOT NULL;

    -- If no record found, return 0
    RETURN COALESCE(total_hours, INTERVAL '0 hours');
END;
$$ LANGUAGE plpgsql;

/*This will return total hours employee 1 worked in August 2025.*/
SELECT get_total_work_hours(1, '2025-08-01', '2025-08-30');


/*Function: Monthly total work hours for all employees*/
-- Function to calculate total work hours for all employees in a month
CREATE OR REPLACE FUNCTION get_monthly_work_hours(p_month INT, p_year INT)
RETURNS TABLE (
    emp_id INT,
    total_hours INTERVAL
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        a.emp_id,
        SUM(a.check_out - a.check_in) AS total_hours
    FROM attendance a
    WHERE EXTRACT(MONTH FROM a.attendance_date) = p_month
      AND EXTRACT(YEAR FROM a.attendance_date) = p_year
      AND a.check_in IS NOT NULL
      AND a.check_out IS NOT NULL
    GROUP BY a.emp_id;
END;
$$ LANGUAGE plpgsql;

/*This gives all employees’ total work hours for August 2025.*/
SELECT * FROM get_monthly_work_hours(8, 2025);










