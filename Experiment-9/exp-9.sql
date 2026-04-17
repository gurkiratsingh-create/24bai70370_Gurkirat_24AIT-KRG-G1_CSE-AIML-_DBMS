-- EXPERIMENT 09: PL/SQL Package with Procedures and Shared Cursor

SET SERVEROUTPUT ON;

--------------------------------------------------
-- Step 1: Drop existing objects (safe execution)
--------------------------------------------------

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE employees';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP PACKAGE emp_package';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

--------------------------------------------------
-- Step 2: Create Table
--------------------------------------------------

CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

--------------------------------------------------
-- Step 3: Insert Sample Data
--------------------------------------------------

INSERT INTO employees VALUES (1, 'John', 50000);
INSERT INTO employees VALUES (2, 'Alice', 60000);
INSERT INTO employees VALUES (3, 'Bob', 55000);

COMMIT;

--------------------------------------------------
-- Step 4: Package Specification
--------------------------------------------------

CREATE OR REPLACE PACKAGE emp_package AS

    -- Shared Cursor (visible to all procedures)
    CURSOR emp_cursor IS
        SELECT emp_id, emp_name, salary FROM employees;

    -- Procedure to display all employees
    PROCEDURE display_all_employees;

    -- Procedure to fetch one employee
    PROCEDURE get_employee(p_id NUMBER);

END emp_package;
/

--------------------------------------------------
-- Step 5: Package Body
--------------------------------------------------

CREATE OR REPLACE PACKAGE BODY emp_package AS

    --------------------------------------------------
    -- Procedure 1: Display all employees using cursor
    --------------------------------------------------
    PROCEDURE display_all_employees IS
        v_id employees.emp_id%TYPE;
        v_name employees.emp_name%TYPE;
        v_salary employees.salary%TYPE;
    BEGIN
        OPEN emp_cursor;

        LOOP
            FETCH emp_cursor INTO v_id, v_name, v_salary;
            EXIT WHEN emp_cursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE(
                'ID: ' || v_id || 
                ', Name: ' || v_name || 
                ', Salary: ' || v_salary
            );
        END LOOP;

        CLOSE emp_cursor;
    END;

    --------------------------------------------------
    -- Procedure 2: Get specific employee
    --------------------------------------------------
    PROCEDURE get_employee(p_id NUMBER) IS
        v_name employees.emp_name%TYPE;
        v_salary employees.salary%TYPE;
    BEGIN
        SELECT emp_name, salary
        INTO v_name, v_salary
        FROM employees
        WHERE emp_id = p_id;

        DBMS_OUTPUT.PUT_LINE('Name: ' || v_name);
        DBMS_OUTPUT.PUT_LINE('Salary: ' || v_salary);

    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Employee Not Found');
    END;

END emp_package;
/

--------------------------------------------------
-- Step 6: Execution
--------------------------------------------------

-- Display all employees
BEGIN
    emp_package.display_all_employees;
END;
/

-- Get specific employee
BEGIN
    emp_package.get_employee(2);
END;
/