** PostgreSQL CTEs (WITH clauses) **

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
**Basic CTE**

**Problem:**  
Write a query that uses a CTE to calculate the average salary per department, and then selects only the departments whose average salary is greater than 75,000.

**Solution:**
```sql
WITH department_avg_salary AS (  
    SELECT  
        department,  
        AVG(salary) AS avg_salary_per_dept  
    FROM employees  
    GROUP BY department  
)  
SELECT  
    department,  
    avg_salary_per_dept  
FROM department_avg_salary  
WHERE avg_salary_per_dept > 75000;
```
**CTE Replacing a Subquery**

**Problem:**  
Write a query that returns the names and salaries of employees whose salary is higher than the average salary across all employees.

**Solution:**

**Subquery version (baseline)**
```sql
SELECT  
    emp_name,  
    salary  
FROM employees  
WHERE salary > (  
    SELECT AVG(salary)  
    FROM employees  
);
```
**CTE version (preferred)**
```sql
WITH avg_salary AS (  
    SELECT  
        AVG(salary) AS average_salary  
    FROM employees  
)  
SELECT  
    e.emp_name,  
    e.salary  
FROM employees e  
CROSS JOIN avg_salary  
WHERE e.salary > avg_salary.average_salary;
```
**CTE + Aggregation**

**Problem:**  
Write a query that uses a CTE to calculate the number of employees per department, and then returns only departments with more than 2 employees.

**Solution:**
```sql
WITH department_employee_counts AS (  
    SELECT  
        department,  
        COUNT(*) AS num_employees_per_dept  
    FROM employees  
    GROUP BY department  
)  
SELECT  
    department,  
    num_employees_per_dept  
FROM department_employee_counts  
WHERE num_employees_per_dept > 2;
```
**CTE + Window Function**

**Problem:**  
Write a query that uses a CTE and a window function to rank employees by salary within each department, and then returns only the top 2 highest-paid employees per department, including ties.

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
