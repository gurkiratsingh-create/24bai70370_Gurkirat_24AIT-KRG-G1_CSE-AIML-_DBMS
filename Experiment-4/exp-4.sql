SET SERVEROUTPUT ON;

DECLARE
    num       NUMBER := 5;
    marks1    NUMBER := 82;
    marks2    NUMBER := 68;
    day_num   NUMBER := 4;
BEGIN
    ----------------------------------------------------------------
    -- 1. IF–ELSE Statement
    ----------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE('--- IF ELSE STATEMENT ---');

    IF num > 0 THEN
        DBMS_OUTPUT.PUT_LINE('The number ' || num || ' is POSITIVE');
    ELSE
        DBMS_OUTPUT.PUT_LINE('The number ' || num || ' is NON-POSITIVE');
    END IF;

    ----------------------------------------------------------------
    -- 2. IF–ELSIF–ELSE Statement (Grade Evaluation)
    ----------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- IF ELSIF ELSE STATEMENT ---');

    IF marks1 >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: A');
    ELSIF marks1 >= 75 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: B');
    ELSIF marks1 >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('Grade: C');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grade: FAIL');
    END IF;

    ----------------------------------------------------------------
    -- 3. ELSIF Ladder (Performance Status)
    ----------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- ELSIF LADDER ---');

    IF marks2 >= 85 THEN
        DBMS_OUTPUT.PUT_LINE('Performance: Excellent');
    ELSIF marks2 >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('Performance: Very Good');
    ELSIF marks2 >= 55 THEN
        DBMS_OUTPUT.PUT_LINE('Performance: Good');
    ELSIF marks2 >= 40 THEN
        DBMS_OUTPUT.PUT_LINE('Performance: Average');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Performance: Poor');
    END IF;

    ----------------------------------------------------------------
    -- 4. CASE Statement (Day Name)
    ----------------------------------------------------------------
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- CASE STATEMENT ---');

    CASE day_num
        WHEN 1 THEN DBMS_OUTPUT.PUT_LINE('Monday');
        WHEN 2 THEN DBMS_OUTPUT.PUT_LINE('Tuesday');
        WHEN 3 THEN DBMS_OUTPUT.PUT_LINE('Wednesday');
        WHEN 4 THEN DBMS_OUTPUT.PUT_LINE('Thursday');
        WHEN 5 THEN DBMS_OUTPUT.PUT_LINE('Friday');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('Saturday');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('Sunday');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Invalid Day Number');
    END CASE;

END;
/


