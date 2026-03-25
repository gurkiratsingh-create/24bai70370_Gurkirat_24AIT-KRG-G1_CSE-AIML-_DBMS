-- Enable output
SET SERVEROUTPUT ON;

---------------------------------------------------
-- STEP 0: DROP OBJECTS (IGNORE ERRORS IF NOT EXISTS)
---------------------------------------------------
BEGIN
    EXECUTE IMMEDIATE 'DROP MATERIALIZED VIEW mv_employee';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW complex_view';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP VIEW simple_view';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Employee';
EXCEPTION WHEN OTHERS THEN NULL;
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
INSERT INTO Employee VALUES (5, 'Rahul', 60000, 20);
INSERT INTO Employee VALUES (6, 'Priya', 45000, 10);

COMMIT;

---------------------------------------------------
-- STEP 3: CREATE SIMPLE VIEW
---------------------------------------------------
CREATE OR REPLACE VIEW simple_view AS
SELECT EmpID, EmpName, Salary
FROM Employee;

---------------------------------------------------
-- STEP 4: CREATE COMPLEX VIEW
---------------------------------------------------
CREATE OR REPLACE VIEW complex_view AS
SELECT DeptID,
       COUNT(*) AS total_emp,
       AVG(Salary) AS avg_salary
FROM Employee
GROUP BY DeptID;

---------------------------------------------------
-- STEP 5: CREATE MATERIALIZED VIEW
---------------------------------------------------
CREATE MATERIALIZED VIEW mv_employee
BUILD IMMEDIATE
REFRESH COMPLETE
AS
SELECT DeptID,
       COUNT(*) AS total_emp,
       AVG(Salary) AS avg_salary
FROM Employee
GROUP BY DeptID;

---------------------------------------------------
-- STEP 6: EXECUTE QUERIES (FOR COMPARISON)
---------------------------------------------------

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- SIMPLE VIEW OUTPUT ---');
END;
/

SELECT * FROM simple_view;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- COMPLEX VIEW OUTPUT ---');
END;
/

SELECT * FROM complex_view;

BEGIN
    DBMS_OUTPUT.PUT_LINE('--- MATERIALIZED VIEW OUTPUT ---');
END;
/

SELECT * FROM mv_employee;

---------------------------------------------------
-- STEP 7: PERFORMANCE CHECK (BASIC)
---------------------------------------------------
SET TIMING ON;

SELECT * FROM simple_view;
SELECT * FROM complex_view;
SELECT * FROM mv_employee;

SET TIMING OFF;

---------------------------------------------------
-- STEP 8: REFRESH MATERIALIZED VIEW
---------------------------------------------------
BEGIN
    DBMS_MVIEW.REFRESH('MV_EMPLOYEE');
END;
/