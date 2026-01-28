SET SERVEROUTPUT ON;

DECLARE
    num1 NUMBER := 10;
    num2 NUMBER := 20;
    sum_result NUMBER;
BEGIN
    sum_result := num1 + num2;

    DBMS_OUTPUT.PUT_LINE('Number 1: ' || num1);
    DBMS_OUTPUT.PUT_LINE('Number 2: ' || num2);
    DBMS_OUTPUT.PUT_LINE('Sum: ' || sum_result);
END;
/