SET SERVEROUTPUT ON;

-- Drop existing objects (to avoid ORA-00955)

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

-- Step 1: Create Table
CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

-- Step 2: Package Specification
CREATE OR REPLACE PACKAGE emp_package AS
    PROCEDURE add_employee(p_id NUMBER, p_name VARCHAR2, p_salary NUMBER);
    PROCEDURE get_employee(p_id NUMBER);
    PROCEDURE update_salary(p_id NUMBER, p_salary NUMBER);
    PROCEDURE delete_employee(p_id NUMBER);
END emp_package;
/

-- Step 3: Package Body
CREATE OR REPLACE PACKAGE BODY emp_package AS

    PROCEDURE add_employee(p_id NUMBER, p_name VARCHAR2, p_salary NUMBER) IS
    BEGIN
        INSERT INTO employees VALUES (p_id, p_name, p_salary);
        DBMS_OUTPUT.PUT_LINE('Employee Added');
    END;

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

    PROCEDURE update_salary(p_id NUMBER, p_salary NUMBER) IS
    BEGIN
        UPDATE employees
        SET salary = p_salary
        WHERE emp_id = p_id;

        DBMS_OUTPUT.PUT_LINE('Salary Updated');
    END;

    PROCEDURE delete_employee(p_id NUMBER) IS
    BEGIN
        DELETE FROM employees
        WHERE emp_id = p_id;

        DBMS_OUTPUT.PUT_LINE('Employee Deleted');
    END;

END emp_package;
/

-- Step 4: Execution

BEGIN
    emp_package.add_employee(1, 'John', 50000);
END;
/

BEGIN
    emp_package.get_employee(1);
END;
/

BEGIN
    emp_package.update_salary(1, 60000);
END;
/

BEGIN
    emp_package.get_employee(1);
END;
/

BEGIN
    emp_package.delete_employee(1);
END;
/