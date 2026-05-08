**PostgreSQL Window Functions — Core Concepts**

**Build a Simple Dataset**  
Create a table with employees + departments + salaries.
```sql
CREATE TABLE employees (  
    emp_id SERIAL PRIMARY KEY,  
    emp_name TEXT,  
    department TEXT,  
    salary INTEGER  
);
```
**Insert Sample Data (12 Rows)**
```sql
INSERT INTO employees (emp_name, department, salary) VALUES  
('Alice',   'Engineering', 90000),  
('Bob',     'Engineering', 85000),  
('Charlie', 'Engineering', 85000),  
('Diana',   'Engineering', 80000),

('Eve',     'Sales',       70000),  
('Frank',   'Sales',       72000),  
('Grace',   'Sales',       70000),

('Heidi',   'HR',          60000),  
('Ivan',    'HR',          62000),

('Judy',    'Marketing',   65000),  
('Ken',     'Marketing',   67000),  
('Laura',   'Marketing',   65000);
```
**Window Functions**

**ROW_NUMBER (No PARTITION BY)**
```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num  
FROM employees;
```
**Observation:** 

* Rows are assigned unique numbers
* Rows with the same salary still receive different row numbers


**ROW_NUMBER + PARTITION BY**
```sql  
SELECT  
    emp_name,  
    department,  
    salary,  
    ROW_NUMBER() OVER (  
        PARTITION BY department  
        ORDER BY salary DESC  
    ) AS dept_row_num  
FROM employees;
```
**Observation:** 

* Employees are ranked within each department by salary
* Row numbers reset for each department  
* Rows with the same salary still receive different row numbers

**RANK()**
```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    RANK() OVER (  
        PARTITION BY department  
        ORDER BY salary DESC 
    ) AS dept_rank  
FROM employees;
```
**Observation:** 

* Rows with same salary share the same rank  
* Rank values may skip numbers (e.g., 1, 2, 2, 4)

**DENSE_RANK()**
```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    DENSE_RANK() OVER (  
        PARTITION BY department  
        ORDER BY salary DESC  
    ) AS dept_dense_rank  
FROM employees;
```
**Observation:** 

* Rows with the same salary share the same rank  
* Rank values do not skip numbers


