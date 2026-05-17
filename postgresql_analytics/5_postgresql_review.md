**Integration / Review (PostgreSQL)**

**Window function + CASE**

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

**CASE + Window Function**

**Problem:**  
Write a query that uses a window function to calculate the average salary per department, and then uses a CASE expression to label each employee as:

* 'Above department average'  
* 'Below department average'  
* 'Equal to department average'

**Solution:**

```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary,  
    CASE  
        WHEN salary > AVG(salary) OVER (PARTITION BY department)  
            THEN 'Above department average'  
        WHEN salary < AVG(salary) OVER (PARTITION BY department)  
            THEN 'Below department average'  
        ELSE 'Equal to department average'  
    END AS salary_label  
FROM employees  
ORDER BY department, salary DESC, emp_name;
```

**Observation:**   
Window functions allow comparisons against group-level metrics without collapsing rows, unlike GROUP BY.

**CTE + Window Function**

**Problem:**  
Write a query that uses a CTE and a window function to return the top 2 highest-paid employees per department, including ties.

Requirements:

* Use a WITH clause (CTE)  
* Use a window function to rank employees by salary within each department  
* Include ties correctly  
* Filter results in the outer query  
* Return employee name, department, salary, and rank

**Solution:**

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
WHERE dept_rank <= 2  
ORDER BY department, dept_rank, salary DESC, emp_name;
```

**Observation:**   
Using DENSE_RANK() ensures all employees tied within the top two salaries per department are included.

**Compare GROUP BY vs Window Results**  
**Problem:**  
Using the employees table:  
Write two queries that both compute, for each department:

* total number of employees  
* average salary

Requirements:

* Query A (GROUP BY): return one row per department using GROUP BY  
* Query B (Window): return one row per employee using window functions (COUNT() OVER, AVG() OVER) so the department metrics repeat on each employee row  
* Return results ordered by department, then salary descending

**Solution:**  
**A - GROUP BY**

```sql
SELECT  
    department,  
    COUNT(*) AS num_employees,  
    AVG(salary) AS avg_salary  
FROM employees  
GROUP BY department  
ORDER BY department, avg_salary DESC;
```

**B - window functions**

```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    COUNT(*) OVER (PARTITION BY department) AS num_employees,  
    AVG(salary) OVER (PARTITION BY department) AS avg_salary  
FROM employees  
ORDER BY department, salary DESC, emp_name;
```

**Observation:**   
GROUP BY collapses rows to one per department, while window functions preserve one row per employee and add department-level metrics as extra columns.  

