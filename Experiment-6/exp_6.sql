-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------
-- STEP 0: DROP TABLE (IGNORE ERROR IF NOT EXISTS)
---------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employee';
EXCEPTION
    WHEN OTHERS THEN
        NULL;
END;
/

---------------------------------------------------
-- STEP 1: CREATE TABLE
---------------------------------------------------
CREATE TABLE Employee (
    EmpID NUMBER PRIMARY KEY,
    EmpName VARCHAR2(50),
    Salary NUMBER,
    DeptID NUMBER
);

---------------------------------------------------
-- STEP 2: INSERT DATA
---------------------------------------------------
INSERT INTO Employee VALUES (1, 'Aman', 30000, 10);
INSERT INTO Employee VALUES (2, 'Riya', 40000, 20);
INSERT INTO Employee VALUES (3, 'Karan', 50000, 10);
INSERT INTO Employee VALUES (4, 'Neha', 35000, 30);

COMMIT;

---------------------------------------------------
-- PROGRAM 1: IMPLICIT CURSOR
---------------------------------------------------
BEGIN
    UPDATE Employee
    SET Salary = Salary * 1.10
    WHERE DeptID = 10;

    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Rows Updated: ' || SQL%ROWCOUNT);
    ELSE
        DBMS_OUTPUT.PUT_LINE('No rows updated');
    END IF;
END;
/

---------------------------------------------------
-- PROGRAM 2: EXPLICIT CURSOR
---------------------------------------------------
DECLARE
    CURSOR emp_cursor IS
        SELECT EmpID, EmpName, Salary FROM Employee;

    v_id Employee.EmpID%TYPE;
    v_name Employee.EmpName%TYPE;
    v_salary Employee.Salary%TYPE;

BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO v_id, v_name, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('ID: ' || v_id ||
                             ' Name: ' || v_name ||
                             ' Salary: ' || v_salary);
    END LOOP;

    CLOSE emp_cursor;
END;
/

---------------------------------------------------
-- PROGRAM 3: BUSINESS LOGIC USING CURSOR
---------------------------------------------------
DECLARE
    CURSOR emp_cursor IS
        SELECT EmpID, Salary FROM Employee;

    v_id Employee.EmpID%TYPE;
    v_salary Employee.Salary%TYPE;

BEGIN
    OPEN emp_cursor;

    LOOP
        FETCH emp_cursor INTO v_id, v_salary;
        EXIT WHEN emp_cursor%NOTFOUND;

        IF v_salary < 40000 THEN
            UPDATE Employee
            SET Salary = Salary + 5000
            WHERE EmpID = v_id;

            DBMS_OUTPUT.PUT_LINE('Bonus added to EmpID: ' || v_id);
        END IF;

    END LOOP;

    CLOSE emp_cursor;
END;
/

---------------------------------------------------
-- PROGRAM 4: %ISOPEN ATTRIBUTE
---------------------------------------------------
DECLARE
    CURSOR emp_cursor IS SELECT * FROM Employee;
BEGIN
    OPEN emp_cursor;

    IF emp_cursor%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is open');
    END IF;

    CLOSE emp_cursor;
END;
/