**PostgreSQL Window Functions — Applied**

**Build a Simple Dataset**  
Create a table with employees + departments + salaries.
```sql
CREATE TABLE employees (  
    emp_id SERIAL PRIMARY KEY,  
    emp_name TEXT,  
    department TEXT,  
    salary INTEGER);
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
**GROUP BY**
```sql
SELECT  
    department,  
    COUNT(*) AS num_employees,  
    AVG(salary) AS avg_salary  
FROM employees  
GROUP BY department  
ORDER BY avg_salary DESC;
```
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
### Window Functions vs GROUP BY
**Comparison:** 

* GROUP BY returns one row per department (collapsed)  
* Window query returns one row per employee

**Row counts:**

* GROUP BY department → 4 rows (Engineering, Sales, HR, Marketing)  
* RANK() query → 12 rows (all employees)

**Output structure:**

* GROUP BY → summary table (aggregated)  
* Window → detailed table + extra analytic column

**Top-N per group with DENSE_RANK()**
```sql
WITH ranked_dept AS (  
    SELECT  
        emp_name,  
        department,  
        salary,  
        DENSE_RANK() OVER (  
            PARTITION BY department  
            ORDER BY salary DESC  
        ) AS dept_rank  
    FROM employees  
)  
SELECT  
    emp_name,  
    department,  
    salary,  
    dept_rank  
FROM ranked_dept  
WHERE dept_rank <= 3  
ORDER BY department, dept_rank, salary DESC, emp_name;
```

**Observation:**   
DENSE_RANK() lets you return the top-3 salaries per department while keeping all tied employees.
