**CASE logic in SELECT** 

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

**CASE with numeric ranges (salary bands)**

**Problem:**  
Write a query that uses a CASE expression to create a new column called salary_band that classifies each employee into a salary range based on their salary.

**Solution:**

```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    CASE  
        WHEN salary < 70000 THEN 'Below 70K'  
        WHEN salary BETWEEN 70000 AND 80000 THEN 'Between 70K and 80K'  
        ELSE 'Above 80K'  
    END AS salary_band  
FROM employees;
```

**Observation:**   
CASE expressions allow numeric values to be categorized into meaningful ranges directly in the SELECT clause.

**CASE for categorization (department labels)**

**Problem:**  
Write a query that uses a CASE expression to categorize employees into a new column called department_group based on their department.

**Solution:**

```sql
SELECT  
    emp_name,  
    department,  
    salary,  
    CASE  
        WHEN department = 'Engineering' THEN 'Tech'  
        WHEN department IN ('Sales', 'Marketing') THEN 'Business'  
        WHEN department = 'HR' THEN 'People Ops'  
        ELSE 'Other'  
    END AS department_group  
FROM employees;
```

**Observation:**   
CASE expressions can be used to map detailed values into higher-level categories for reporting and analysis.

**CASE + aggregation (counts by category)**  
**Problem:**  
Write a query that returns one row per department and includes the following counts:

* the number of employees in that department with salary >= 80000  
* the number of employees in that department with salary < 80000

**Solution:**

```sql
SELECT  
    department,  
    COUNT(CASE WHEN salary >= 80000 THEN 1 END) AS num_salary_ge_80000,  
    COUNT(CASE WHEN salary < 80000 THEN 1 END) AS num_salary_lt_80000  
FROM employees  
GROUP BY department;
```

**Observation:**   
CASE expressions inside aggregate functions allow conditional counting within grouped results.

**CASE + window function**  
**Problem:**  
Write a query that uses a window function to rank employees by salary within each department, and then uses a CASE expression to label each employee as either:

* 'Top earner' (if the employee is ranked #1 in their department, including ties)  
* 'Not top earner' (otherwise)

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
    dept_rank,  
    CASE  
        WHEN dept_rank = 1 THEN 'Top earner'  
        ELSE 'Not top earner'  
    END AS earner_label  
FROM ranked_dept  
ORDER BY department, dept_rank, salary DESC, emp_name;
```

**Observation:**   
Using DENSE_RANK() ensures tied highest salaries are all labeled as top earners within each department.

**CASE + window + aggregation**  
**Problem:**  
Write a query that calculates the percentage of employees in each department who are labeled as 'High salary', where 'High salary' means salary >= 80000.

**Solution:**

```sql
WITH labeled_salary AS (  
    SELECT  
        emp_name,  
        department,  
        salary,  
        CASE  
            WHEN salary >= 80000 THEN 'High salary'  
            ELSE 'Low salary'  
        END AS salary_label  
    FROM employees  
)  
SELECT DISTINCT  
    department,  
    COUNT(*) OVER (PARTITION BY department) AS total_employees,  
    COUNT(  
        CASE  
            WHEN salary_label = 'High salary' THEN 1  
        END  
    ) OVER (PARTITION BY department) AS total_high_salary,  
    COUNT(  
        CASE  
            WHEN salary_label = 'High salary' THEN 1  
        END  
    ) OVER (PARTITION BY department) * 100.0  
    / COUNT(*) OVER (PARTITION BY department) AS percent_high_salary  
FROM labeled_salary  
ORDER BY percent_high_salary DESC;
```

**Observation:**   
Window functions allow percentage calculations per group without collapsing rows, unlike GROUP BY aggregation.
