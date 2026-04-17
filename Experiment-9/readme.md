# 🧪 EXPERIMENT – 09

## PL/SQL Package Development: Procedures and Shared Cursors

---

## 📌 Overview

This experiment demonstrates the creation and implementation of a **PL/SQL package in Oracle** using procedures and a shared cursor. The goal is to achieve **modular, reusable, and efficient database programming**, similar to enterprise-level systems.

---

## 🎯 Aim

To design and implement a PL/SQL package that includes procedures and a shared cursor to perform structured database operations.

---

## 🛠️ Tools & Technologies

* Oracle SQL*Plus / SQL Developer
* PL/SQL

---

## 📚 Objectives

* Understand PL/SQL package structure
* Differentiate between package specification and body
* Implement shared cursors
* Perform modular database programming
* Use procedures for data retrieval
* Handle exceptions effectively

---

## 🧠 Theory

A **PL/SQL package** is a collection of related procedures, functions, and cursors grouped together.

### 🔹 Components:

* **Package Specification** → Declares cursor & procedures
* **Package Body** → Implements logic

### 🔹 Shared Cursor:

* Defined once in package specification
* Accessible by all procedures
* Improves performance and reusability

---

## ⚙️ Implementation Steps

---

### 🔹 Step 1: Create Table

* Created `employees` table with emp_id, emp_name, salary

📸 Screenshot:
![Step 1](screenshots/1.png)

---

### 🔹 Step 2: Insert Sample Data

* Inserted multiple employee records
* Committed changes

📸 Screenshot:
![Step 2](screenshots/2.png)

---

### 🔹 Step 3: Insert Additional Records & Commit

* Inserted more records
* Executed COMMIT

📸 Screenshot:
![Step 3](screenshots/3.png)

---

### 🔹 Step 4: Package Specification

* Created package `emp_package`
* Declared shared cursor
* Declared procedures

📸 Screenshot:
![Step 4](screenshots/4.png)

---

### 🔹 Step 5: Package Body

* Implemented procedures
* Used cursor to fetch all records
* Added exception handling

📸 Screenshot:
![Step 5](screenshots/5.png)

---

### 🔹 Step 6: Execution of Package

* Displayed all employees using cursor
* Retrieved specific employee using procedure

📸 Screenshot:
![Step 6](screenshots/6.png)

---

## 🔍 Detailed I/O Analysis

### ✅ Input

* SQL commands for table creation
* INSERT statements for employee records
* Package specification & body
* Shared cursor definition
* PL/SQL procedure calls
* Input parameter: emp_id

---

### ✅ Output

* Table successfully created
* Records inserted successfully
* Package compiled successfully
* Display of all employees:

  * ID, Name, Salary
* Display of specific employee details
* Proper execution messages from PL/SQL

---

## 📊 Result

The PL/SQL package was successfully implemented. The shared cursor efficiently retrieved multiple records, and procedures enabled modular access to employee data.

---

## 🎓 Learning Outcome

* Understood package-based modular programming
* Learned shared cursor usage
* Implemented reusable database logic
* Gained experience in PL/SQL procedures
* Improved understanding of enterprise database design

---

## 🚀 Conclusion

This experiment demonstrates how PL/SQL packages and shared cursors are used in real-world applications to improve performance, maintainability, and scalability of database systems.

---

## 📂 Project Structure

```
exp-9/
│── README.md
│── screenshots/
│   ├── 1.png
│   ├── 2.png
│   ├── 3.png
│   ├── 4.png
│   ├── 5.png
│   └── 6.png
```

---

## 🔥 Industry Relevance

This approach is widely used in enterprise systems such as:

* Oracle-based applications
* SAP systems
* Fintech platforms (PayPal)
* HR & payroll systems

---


## 👨‍💻 Author  

**Gurkirat SIngh Bhangoo**  
B.Tech (AI & ML)

---