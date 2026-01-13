-- Library Management System (Oracle SQL)
-- Author: Gurkirat Singh
-- DBMS Lab | Oracle Live SQL
-- -------------------------------------

-- CLEANUP
DROP TABLE book_issue CASCADE CONSTRAINTS;
DROP TABLE library_visitors CASCADE CONSTRAINTS;
DROP TABLE book_s CASCADE CONSTRAINTS;
DROP ROLE librarian;

-- BOOK TABLE
CREATE TABLE book_s (
    id NUMBER PRIMARY KEY,
    name VARCHAR2(50) NOT NULL,
    author_name VARCHAR2(50) NOT NULL,
    book_count NUMBER CHECK (book_count >= 1)
);

-- VISITORS TABLE
CREATE TABLE library_visitors (
    user_id NUMBER PRIMARY KEY,
    user_name VARCHAR2(20) NOT NULL,
    age NUMBER CHECK (age >= 18) NOT NULL,
    email VARCHAR2(40) UNIQUE NOT NULL
);

-- BOOK ISSUE TABLE
CREATE TABLE book_issue (
    book_issue_id NUMBER PRIMARY KEY,
    book_id NUMBER NOT NULL,
    user_id NUMBER NOT NULL,
    book_issue_date DATE NOT NULL,
    CONSTRAINT fk_book FOREIGN KEY (book_id) REFERENCES book_s(id),
    CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES library_visitors(user_id)
);

-- INSERT DATA
INSERT INTO book_s VALUES (1, 'Harry Potter', 'J.K. Rowling', 1);
INSERT INTO library_visitors VALUES (101, 'Robert', 20, 'robert@gmail.com');
INSERT INTO book_issue VALUES (1234, 1, 101, DATE '2026-01-07');

-- ROLE & PRIVILEGES
CREATE ROLE librarian;

GRANT SELECT, INSERT, UPDATE, DELETE ON book_s TO librarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON library_visitors TO librarian;
GRANT SELECT, INSERT, UPDATE, DELETE ON book_issue TO librarian;

REVOKE SELECT, INSERT, UPDATE, DELETE ON book_s FROM librarian;
