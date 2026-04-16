-- Enable output
SET SERVEROUTPUT ON;

--------------------------------------------------
-- 1. DROP TABLE (if already exists)
--------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employee';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

--------------------------------------------------
-- 2. CREATE TABLE
--------------------------------------------------
CREATE TABLE employee (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    working_hours NUMBER,
    perhour_salary NUMBER,
    total_payable_amount NUMBER
);

--------------------------------------------------
-- 3. CREATE TRIGGER
--------------------------------------------------
CREATE OR REPLACE TRIGGER cal_payable_amount
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
    -- Calculate total payable amount
    :NEW.total_payable_amount := :NEW.perhour_salary * :NEW.working_hours;

    -- Apply constraint
    IF :NEW.total_payable_amount > 25000 THEN
        RAISE_APPLICATION_ERROR(-20001, 'AMOUNT IS GREATER THAN 25000');
    END IF;
END;
/

--------------------------------------------------
-- 4. INSERT VALID RECORD (LESS THAN 25000)
--------------------------------------------------
BEGIN
    INSERT INTO employee(emp_id, emp_name, working_hours, perhour_salary)
    VALUES (1, 'AKASH', 10, 250);

    DBMS_OUTPUT.PUT_LINE('Record inserted successfully');
END;
/

--------------------------------------------------
-- 5. DISPLAY TABLE DATA
--------------------------------------------------
BEGIN
    FOR rec IN (SELECT * FROM employee) LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.emp_id || ' | ' ||
            rec.emp_name || ' | ' ||
            rec.working_hours || ' | ' ||
            rec.perhour_salary || ' | ' ||
            rec.total_payable_amount
        );
    END LOOP;
END;
/

--------------------------------------------------
-- 6. INSERT INVALID RECORD (MORE THAN 25000)
--------------------------------------------------
BEGIN
    INSERT INTO employee(emp_id, emp_name, working_hours, perhour_salary)
    VALUES (2, 'AKASH', 10, 250000);

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

--------------------------------------------------
-- 7. FINAL TABLE CHECK
--------------------------------------------------
BEGIN
    DBMS_OUTPUT.PUT_LINE('Final Table Data:');
    FOR rec IN (SELECT * FROM employee) LOOP
        DBMS_OUTPUT.PUT_LINE(
            rec.emp_id || ' | ' ||
            rec.emp_name || ' | ' ||
            rec.working_hours || ' | ' ||
            rec.perhour_salary || ' | ' ||
            rec.total_payable_amount
        );
    END LOOP;
END;
/