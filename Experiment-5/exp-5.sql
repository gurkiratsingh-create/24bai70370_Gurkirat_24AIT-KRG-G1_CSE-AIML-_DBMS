BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employee';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

CREATE TABLE employee (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(50),
    salary NUMBER
);

INSERT INTO employee VALUES (101, 'Rahul', 50000);
INSERT INTO employee VALUES (102, 'Anita', 45001);
INSERT INTO employee VALUES (103, 'Vikram', 60000);
INSERT INTO employee VALUES (104, 'Priya', 55003);
INSERT INTO employee VALUES (105, 'Arjun', 70000);
INSERT INTO employee VALUES (106, 'Neha', 48007);

COMMIT;

SELECT
    emp_id,
    emp_name,
    salary,
    MOD(salary,2) AS remainder,
    CASE
        WHEN MOD(salary,2)=0 THEN 'Even Salary'
        ELSE 'Odd Salary'
    END AS salary_type
FROM employee;