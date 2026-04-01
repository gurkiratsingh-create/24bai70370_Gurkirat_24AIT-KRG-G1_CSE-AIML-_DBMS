-- Enable output
SET SERVEROUTPUT ON;

-- Drop table if exists (optional)
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employee';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- Create table
CREATE TABLE Employee (
    EmpID NUMBER PRIMARY KEY,
    EmpName VARCHAR2(50),
    Salary NUMBER,
    DeptID NUMBER
);

-- Insert data
INSERT INTO Employee VALUES (1, 'Rahul', 50000, 10);
INSERT INTO Employee VALUES (2, 'Aman', 60000, 20);
INSERT INTO Employee VALUES (3, 'Simran', 55000, 10);

COMMIT;

-- Create procedure
CREATE OR REPLACE PROCEDURE ProcessEmployee (
    p_empid IN NUMBER,
    p_bonus OUT NUMBER,
    p_salary IN OUT NUMBER,
    p_status OUT VARCHAR2
)
IS
BEGIN
    -- Fetch salary
    SELECT Salary INTO p_salary
    FROM Employee
    WHERE EmpID = p_empid;

    -- Calculate bonus
    p_bonus := p_salary * 0.10;

    -- Update salary
    p_salary := p_salary + p_bonus;

    UPDATE Employee
    SET Salary = p_salary
    WHERE EmpID = p_empid;

    p_status := 'SUCCESS';

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_status := 'EMPLOYEE NOT FOUND';
    WHEN OTHERS THEN
        p_status := 'ERROR OCCURRED';
END;
/

-- Execute procedure
DECLARE
    v_salary NUMBER := 0;
    v_bonus NUMBER;
    v_status VARCHAR2(50);
BEGIN
    ProcessEmployee(1, v_bonus, v_salary, v_status);

    DBMS_OUTPUT.PUT_LINE('Updated Salary: ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('Bonus: ' || v_bonus);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_status);
END;
/