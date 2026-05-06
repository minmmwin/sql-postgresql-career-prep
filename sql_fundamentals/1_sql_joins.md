### SQL Joins (INNER, LEFT, RIGHT, FULL, WHERE vs ON)

### INNER JOIN
**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-inner-join\#sharpen-your-sql-skills

**Problem:**  
Write a query that displays player names, school names, and conferences for schools in the *FBS (Division I-A Teams)* division.

**Solution:**
```sql
SELECT  
    players.player_name,  
    players.school_name,  
    teams.conference  
FROM benn.college_football_players AS players  
JOIN benn.college_football_teams AS teams  
    ON teams.school_name = players.school_name  
WHERE teams.division = 'FBS (Division I-A Teams)';
```

**Problem:**  
Write a query that performs an inner join between the tutorial.crunchbase_acquisitions table and the tutorial.crunchbase_companies table, but instead of listing individual rows, count the number of non-null rows in each table.

**Solution:**
```sql
SELECT   
    COUNT(companies.permalink) AS companies_count,  
    COUNT(acquisitions.company_permalink) AS acquisitions_count                           
FROM tutorial.crunchbase_companies companies     
JOIN tutorial.crunchbase_acquisitions acquisitions       
    ON companies.permalink = acquisitions.company_permalink;
```

### LEFT JOIN
**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-left-join

**Problem:**  
Modify the query above to be a LEFT JOIN. Note the difference in results.

**Solution:**
```sql
SELECT   
    COUNT(companies.permalink) AS companies_count,  
    COUNT(acquisitions.company_permalink) AS acquisitions_count                  
FROM tutorial.crunchbase_companies companies     
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions       
    ON companies.permalink = acquisitions.company_permalink;
```

**Problem:**  
Count the number of unique companies (don't double-count companies) and unique acquired companies by state. Do not include results for which there is no state data, and order by the number of acquired companies from highest to lowest.

**Solution:**
```sql
SELECT   
    companies.state_code,  
    COUNT(DISTINCT companies.permalink) AS companies_unique_count,          
    COUNT(DISTINCT acquisitions.company_permalink) AS acquisitions_unique_count         
FROM tutorial.crunchbase_companies companies     
LEFT JOIN tutorial.crunchbase_acquisitions acquisitions       
    ON companies.permalink = acquisitions.company_permalink  
WHERE companies.state_code IS NOT NULL  
GROUP BY 1  
ORDER BY 3 DESC;
```

### RIGHT JOIN
**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-right-join

**Problem:**  
Rewrite the previous practice query in which you counted total and acquired companies by state, but with a RIGHT JOIN instead of a LEFT JOIN. The goal is to produce the exact same results.

**Solution:**
```sql
SELECT   
    companies.state_code,  
    COUNT(DISTINCT companies.permalink) AS companies_unique_count,          
    COUNT(DISTINCT acquisitions.company_permalink) AS acquisitions_unique_count         
FROM   tutorial.crunchbase_acquisitions acquisitions       
RIGHT JOIN tutorial.crunchbase_companies companies  
    ON companies.permalink = acquisitions.company_permalink  
WHERE companies.state_code IS NOT NULL  
GROUP BY 1  
ORDER BY 3 DESC;
```

### FULL JOIN
**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-full-outer-join\#TS-sql-editor-section

**Problem:**  
Write a query that joins tutorial.crunchbase_companies and tutorial.crunchbase_investments_part1 using a FULL JOIN. Count up the number of rows that are matched/unmatched as in the example above.

**Solution:**
```sql
SELECT  
    COUNT(  
        CASE  
            WHEN companies.permalink IS NOT NULL  
             AND investments.company_permalink IS NULL  
            THEN companies.permalink  
        END  
    ) AS companies_only,

    COUNT(  
        CASE  
            WHEN companies.permalink IS NOT NULL  
             AND investments.company_permalink IS NOT NULL  
            THEN companies.permalink  
        END  
    ) AS both_tables,

    COUNT(  
        CASE  
            WHEN companies.permalink IS NULL  
             AND investments.company_permalink IS NOT NULL  
            THEN investments.company_permalink  
        END  
    ) AS investments_only  
FROM tutorial.crunchbase_companies AS companies  
FULL JOIN tutorial.crunchbase_investments_part1 AS investments  
    ON companies.permalink = investments.company_permalink;
```

### JOIN WITH WHERE vs ON
**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-joins-where-vs-on

**Problem:**  
Write a query that shows a company's name, "status" (found in the Companies table), and the number of unique investors in that company. Order by the number of investors from most to fewest. Limit to only companies in the state of New York.

**Solution:**
```sql
SELECT   
companies.name AS companies_name,  
companies.status AS companies_status,   
COUNT(DISTINCT investments.investor_name) AS unique_investors  
FROM tutorial.crunchbase_companies companies  
LEFT JOIN tutorial.crunchbase_investments investments  
ON companies.permalink = investments.company_permalink  
WHERE companies.state_code = 'NY'  
GROUP BY 1  
ORDER BY 3 DESC;
```

**Problem:**  
Write a query that lists investors based on the number of companies in which they are invested. Include a row for companies with no investor, and order from most companies to least.

**Solution:**
```sql
SELECT  
    CASE  
        WHEN investments.investor_name IS NULL  
            THEN 'No Investors'  
        ELSE investments.investor_name  
    END AS investor_name,  
    COUNT(DISTINCT companies.permalink) AS companies_invested  
FROM tutorial.crunchbase_companies AS companies  
LEFT JOIN tutorial.crunchbase_investments AS investments  
    ON companies.permalink = investments.company_permalink  
GROUP BY 1  
ORDER BY 2 DESC;
```
