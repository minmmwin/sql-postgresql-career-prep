### **SUBQUERIES**

**Subquery basics** 

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-subquery

**Problem:**  
Write a query that selects all Warrant Arrests from the tutorial.sf_crime_incidents_2014_01 dataset, then wrap it in an outer query that only displays unresolved incidents.

**Solution:**
```sql
SELECT  
    sub.*  
FROM (  
    SELECT  
        *  
    FROM tutorial.sf_crime_incidents_2014_01  
    WHERE descript = 'WARRANT ARREST'  
) AS sub  
WHERE sub.resolution = 'NONE';
```
**Problem:**  
Write a query that displays the average number of monthly incidents for each category.  
Hint: use tutorial.sf_crime_incidents_cleandate to make your life a little easier.

**Solution:**
```sql
SELECT  
    sub.category,  
    AVG(sub.category_count) AS average_monthly_incidents  
FROM (  
    SELECT  
        STRFTIME('%m', cleaned_date) AS month,  
        category,  
        COUNT(*) AS category_count  
    FROM tutorial.sf_crime_incidents_cleandate  
    GROUP BY 1, 2  
) AS sub  
GROUP BY 1;
```
**Joining subqueries**

**Problem:**  
Write a query that displays all rows from the three categories with the fewest incidents reported.

**Solution:**
```sql
SELECT  
    incidents.*,  
    sub.incident_count AS category_incident_count  
FROM tutorial.sf_crime_incidents_2014_01 AS incidents  
JOIN (  
    SELECT  
        category,  
        COUNT(*) AS incident_count  
    FROM tutorial.sf_crime_incidents_2014_01  
    GROUP BY 1  
    ORDER BY 2  
    LIMIT 3  
) AS sub  
    ON incidents.category = sub.category;
```
**Problem:**  
Write a query that ranks investors from the combined dataset above by the total number of investments they have made.

**Solution:**
```sql
SELECT  
    sub.investor_name,  
    COUNT(*) AS total_investments  
FROM (  
    SELECT  
        *  
    FROM tutorial.crunchbase_investments_part1

    UNION ALL

    SELECT  
        *  
    FROM tutorial.crunchbase_investments_part2  
) AS sub  
GROUP BY 1  
ORDER BY 2 DESC;
```

