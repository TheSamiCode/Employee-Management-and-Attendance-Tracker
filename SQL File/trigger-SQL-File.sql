/*Trigger: Auto-set created_at & updated_at timestamps
modify the attendance table to include timestamp columns:*/

-- Add timestamp columns
ALTER TABLE attendance
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

/*trigger function:*/
-- Function to auto-update timestamps
CREATE OR REPLACE FUNCTION set_attendance_timestamps()
RETURNS TRIGGER AS $$
BEGIN
    -- On insert, created_at is automatically set by default
    -- On update, update the updated_at field
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*trigger: 
This ensures every row in attendance keeps track of when it was created and last updated.*/
-- Trigger to update updated_at
CREATE TRIGGER trg_attendance_timestamps
BEFORE INSERT OR UPDATE ON attendance
FOR EACH ROW
EXECUTE FUNCTION set_attendance_timestamps();

/*Trigger: Auto-set status based on check-in & check-out
Instead of manually inserting status, let’s auto-calculate it: */

-- Function to auto-assign status
CREATE OR REPLACE FUNCTION set_attendance_status()
RETURNS TRIGGER AS $$
BEGIN
    -- If no check-in and check-out => Absent
    IF NEW.check_in IS NULL AND NEW.check_out IS NULL THEN
        NEW.status := 'Absent';
    -- If check-in after 09:15 => Late
    ELSIF NEW.check_in > TIME '09:15' THEN
        NEW.status := 'Late';
    -- If work hours less than 4 hours => Half-day
    ELSIF NEW.check_out - NEW.check_in < INTERVAL '4 hours' THEN
        NEW.status := 'Half-day';
    ELSE
        NEW.status := 'Present';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*trigger:
Now whenever you insert/update attendance, PostgreSQL will auto-calculate Present, Late, Absent, or Half-day based on timings.*/

-- Trigger to auto-set attendance status
CREATE TRIGGER trg_set_status
BEFORE INSERT OR UPDATE ON attendance
FOR EACH ROW
EXECUTE FUNCTION set_attendance_status();

/*Add timestamp columns to employee*/
ALTER TABLE employee
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

/*Create trigger function for timestamps*/
-- Function to auto-update employee timestamps
CREATE OR REPLACE FUNCTION set_employee_timestamps()
RETURNS TRIGGER AS $$
BEGIN
    -- created_at is auto set by default
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*Create trigger for employee table*/
-- Trigger for employee timestamps
CREATE TRIGGER trg_employee_timestamps
BEFORE INSERT OR UPDATE ON employee
FOR EACH ROW
EXECUTE FUNCTION set_employee_timestamps();








