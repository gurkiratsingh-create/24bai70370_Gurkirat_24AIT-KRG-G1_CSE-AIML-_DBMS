
-- =========================
-- 1. DROP TABLES (SAFE RE-RUN)
-- =========================
DROP TABLE Tbl_Supply_logs CASCADE CONSTRAINTS;
DROP TABLE Tbl_Orders CASCADE CONSTRAINTS;
DROP TABLE Tbl_Suppliers CASCADE CONSTRAINTS;
DROP TABLE Tbl_Products CASCADE CONSTRAINTS;

-- =========================
-- 2. CREATE TABLES
-- =========================

-- PRODUCTS TABLE
CREATE TABLE Tbl_Products (
    prod_id NUMBER PRIMARY KEY,        -- Entity Integrity (PK unique, not null)
    prod_name VARCHAR2(100),
    category VARCHAR2(50),
    price NUMBER,
    stock_qty NUMBER
);

-- SUPPLIERS TABLE
CREATE TABLE Tbl_Suppliers (
    sup_id NUMBER PRIMARY KEY,
    sup_name VARCHAR2(100),
    city VARCHAR2(50),
    rating NUMBER
);

-- ORDERS TABLE
CREATE TABLE Tbl_Orders (
    order_id NUMBER PRIMARY KEY,
    prod_id NUMBER,
    cust_id NUMBER,
    order_date DATE,
    qty NUMBER,

    -- Referential Integrity
    CONSTRAINT fk_product FOREIGN KEY (prod_id)
    REFERENCES Tbl_Products(prod_id)
);

-- SUPPLY LOGS TABLE
CREATE TABLE Tbl_Supply_logs (
    log_id NUMBER PRIMARY KEY,
    action_type VARCHAR2(20),
    prod_id NUMBER,
    old_qty NUMBER,
    new_qty NUMBER,
    log_time TIMESTAMP,

    CONSTRAINT fk_log_product FOREIGN KEY (prod_id)
    REFERENCES Tbl_Products(prod_id)
);

-- =========================
-- 3. INSERT DATA
-- =========================

-- PRODUCTS
INSERT INTO Tbl_Products VALUES (501, 'Laptop Pro', 'Electronics', 75000, 15);
INSERT INTO Tbl_Products VALUES (502, 'Ergo Chair', 'Furniture', 15000, 8);

-- SUPPLIERS
INSERT INTO Tbl_Suppliers VALUES (701, 'NextGen Tech', 'Bangalore', 5);
INSERT INTO Tbl_Suppliers VALUES (702, 'Comfort Hub', 'Mumbai', 4);

-- ORDERS
INSERT INTO Tbl_Orders VALUES (9001, 501, 101, DATE '2026-04-20', 1);
INSERT INTO Tbl_Orders VALUES (9002, 502, 102, DATE '2026-04-21', 2);

-- SUPPLY LOGS
INSERT INTO Tbl_Supply_logs VALUES 
(1, 'UPDATE', 501, 20, 15, TIMESTAMP '2026-04-20 10:00:00');

COMMIT;

-- =========================
-- 4. VERIFY DATA
-- =========================
SELECT * FROM Tbl_Products;
SELECT * FROM Tbl_Suppliers;
SELECT * FROM Tbl_Orders;
SELECT * FROM Tbl_Supply_logs;

-- =========================================================
-- Q1: PRODUCT NAME + TOTAL ORDERS
-- =========================================================
SELECT 
    p.prod_name,
    SUM(o.qty) AS total_orders
FROM Tbl_Products p
JOIN Tbl_Orders o 
ON p.prod_id = o.prod_id
GROUP BY p.prod_name;

-- =========================================================
-- Q2: STORED PROCEDURE (SWAP SUPPLIER CITIES)
-- =========================================================
CREATE OR REPLACE PROCEDURE swap_supplier_city (
    id1 IN NUMBER,
    id2 IN NUMBER
)
IS
    temp_city VARCHAR2(50);
BEGIN

    SELECT city INTO temp_city
    FROM Tbl_Suppliers
    WHERE sup_id = id1;
    UPDATE Tbl_Suppliers
    SET city = (SELECT city FROM Tbl_Suppliers WHERE sup_id = id2)
    WHERE sup_id = id1;

    UPDATE Tbl_Suppliers
    SET city = temp_city
    WHERE sup_id = id2;

    COMMIT;
END;
/

BEGIN
    swap_supplier_city(701, 702);
END;
/

SELECT * FROM Tbl_Suppliers;