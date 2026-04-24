SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TRIGGER trg_customers_pk';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE seq_customers_pk';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE customers_trigger_demo';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE customers_trigger_demo (
    customer_id NUMBER PRIMARY KEY,
    customer_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50),
    created_on DATE DEFAULT SYSDATE
);

CREATE SEQUENCE seq_customers_pk
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE OR REPLACE TRIGGER trg_customers_pk
BEFORE INSERT ON customers_trigger_demo
FOR EACH ROW
BEGIN
    IF :NEW.customer_id IS NULL THEN
        SELECT seq_customers_pk.NEXTVAL
        INTO :NEW.customer_id
        FROM dual;
    END IF;
END;
/

INSERT INTO customers_trigger_demo (customer_name, city)
VALUES ('Aarav Sharma', 'Delhi');

INSERT INTO customers_trigger_demo (customer_name, city)
VALUES ('Simran Kaur', 'Chandigarh');

INSERT INTO customers_trigger_demo (customer_name, city)
VALUES ('Rohan Mehta', 'Mumbai');

INSERT INTO customers_trigger_demo (customer_name, city)
VALUES ('Priya Verma', 'Bengaluru');

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Generated customer records:');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');

    FOR rec IN (
        SELECT customer_id, customer_name, city, created_on
        FROM customers_trigger_demo
        ORDER BY customer_id
    ) LOOP
        DBMS_OUTPUT.PUT_LINE(
            'ID: ' || rec.customer_id ||
            ', Name: ' || rec.customer_name ||
            ', City: ' || rec.city ||
            ', Created On: ' || TO_CHAR(rec.created_on, 'DD-MON-YYYY')
        );
    END LOOP;
END;
/