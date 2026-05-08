# Mixed SQL Practice Set (25 Queries)
**Problem:**  
Find the list of player names and their team’s conference for players whose position is “Running Back”.

**Solution:**
```sql
SELECT  
    players.player_name,  
    teams.conference  
FROM benn.college_football_players AS players  
JOIN benn.college_football_teams AS teams  
    ON teams.school_name = players.school_name  
WHERE players.position = 'RB';
```
**Problem:**  
List all players along with their school’s division (e.g., FBS, FCS), but only for schools in the “FBS (Division I-A Teams)” division.

**Solution:**
```sql
SELECT  
    players.player_name,  
    teams.division  
FROM benn.college_football_players AS players  
JOIN benn.college_football_teams AS teams  
    ON teams.school_name = players.school_name  
WHERE teams.division = 'FBS (Division I-A Teams)';
```
**Problem:**  
List all players and the name of their team’s conference — including players whose school does not appear in the teams table.

**Solution:**
```sql
SELECT  
    players.player_name,  
    teams.conference  
FROM benn.college_football_players AS players  
LEFT JOIN benn.college_football_teams AS teams  
    ON teams.school_name = players.school_name;
```  
**Problem:**  
Find all player names and their team’s division, but show “Unknown” for division if the player’s school has no entry in the teams table.

**Solution:**
```sql
SELECT  
    players.player_name,  
    COALESCE(teams.division, 'Unknown') AS division  
FROM benn.college_football_players AS players  
LEFT JOIN benn.college_football_teams AS teams  
    ON teams.school_name = players.school_name;
```
**Problem:**  
Using a RIGHT JOIN, list all records from the right table, along with any matching information from the left table.  
Your result should include rows that exist only in the right table, even if there is no matching row on the left.

**Solution:**
```sql
SELECT  
    acquisitions.*,  
    companies.*  
FROM tutorial.crunchbase_acquisitions acquisitions  
RIGHT JOIN tutorial.crunchbase_companies companies  
    ON companies.permalink = acquisitions.company_permalink;
```
**Problem:**  
Using a FULL OUTER JOIN, count how many records:

* appear only in the companies table  
* appear only in the investments table  
* appear in both tables

You should return three separate counts in the result.

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
            WHEN companies.permalink IS NULL  
             AND investments.company_permalink IS NOT NULL  
            THEN investments.company_permalink  
        END  
    ) AS investments_only,  
    COUNT(  
        CASE  
            WHEN companies.permalink IS NOT NULL  
             AND investments.company_permalink IS NOT NULL  
            THEN companies.permalink  
        END  
    ) AS both_tables  
FROM tutorial.crunchbase_companies AS companies  
FULL JOIN tutorial.crunchbase_investments_part1 AS investments  
    ON companies.permalink = investments.company_permalink;
```
**Problem:**  
How many total trading days are recorded for Apple stock in the dataset?

**Solution:**
```sql
SELECT  
    COUNT(*) AS total_trading_days  
FROM tutorial.aapl_historical_stock_price;
```
**Problem:**  
How many distinct years of Apple stock data are available in the dataset?

**Solution:**
```sql
SELECT  
    COUNT(DISTINCT year) AS num_distinct_year  
FROM tutorial.aapl_historical_stock_price;
```
**Problem:**  
What is the total volume of shares traded across the entire dataset?

**Solution:**
```sql
SELECT  
    SUM(volume) AS total_volume  
FROM tutorial.aapl_historical_stock_price;
```  
**Problem:**  
What is the average closing price of Apple stock?

**Solution:**
```sql
SELECT  
    AVG(close) AS avg_close_price  
FROM tutorial.aapl_historical_stock_price;
```
**Problem:**  
Find the single highest and lowest *opening* prices in the dataset.

**Solution:**
```sql
SELECT  
    MAX(CAST(open AS FLOAT)) AS highest_open_price,  
    MIN(CAST(open AS FLOAT)) AS lowest_open_price  
FROM tutorial.aapl_historical_stock_price;
```
**Problem:**  
For each year and month combination, calculate the average *closing* price.

**Solution:**
```sql
SELECT  
    year,  
    month,  
    AVG(close) AS avg_closing_price  
FROM tutorial.aapl_historical_stock_price  
GROUP BY year, month;
```
**Problem:**  
Write a query that returns:

* year  
* month_name  
* west


Only for rows where:

* the West region produced more than 40,000 housing units in a month

**Solution:**
```sql
SELECT  
    year,  
    month_name,  
    west  
FROM tutorial.us_housing_units  
WHERE west > 40;
```
**Problem:**  
Write a query that returns:

* year  
* month_name  
* south  
* west


Only for rows where:

* the South region produced 25,000 or more housing units, AND  
* the West region produced fewer than 30,000 housing units

**Solution:**
```sql
SELECT  
    year,  
    month_name,  
    south,  
    west  
FROM tutorial.us_housing_units  
WHERE south >= 25  
  AND west < 30;
```
**Problem:**  
Write a query that returns:

* year  
* month_name  
* midwest  
* northeast


Only for rows where:

* the Midwest region produced between 15,000 and 25,000 housing units (inclusive)

      OR

* the Northeast region produced fewer than 10,000 housing units

**Solution:**
```sql
SELECT  
    year,  
    month_name,  
    midwest,  
    northeast  
FROM tutorial.us_housing_units  
WHERE midwest BETWEEN 15 AND 25  
   OR northeast < 10;
```
**Problem:**  
Write a query that returns:

* year  
* month_name  
* west


for all rows where the West region produced more than 30,000 units.  
Your result should be ordered by west descending, so the highest production months appear first.

**Solution:**
```sql
SELECT  
    year,  
    month_name,  
    west  
FROM tutorial.us_housing_units  
WHERE west > 30  
ORDER BY west DESC;
```
**Problem:**  
Write a query that returns:

* year  
* month  
* close

for all rows in the year 2014.

Your results should be ordered by:

* year ascending  
* close descending 

**Solution:**
```sql
SELECT  
    year,  
    month,  
    close  
FROM tutorial.aapl_historical_stock_price  
WHERE year = 2014  
ORDER BY close DESC;
```
**Problem:**  
For each year in the Apple stock dataset, find the total trading volume and include only years where the total volume is greater than 500 million.  
Your result should show:

* year  
* sum of volume  
* only include years that meet the HAVING condition

**Solution:**
```sql
SELECT  
    year,  
    SUM(volume) AS total_trading_volume  
FROM tutorial.aapl_historical_stock_price  
GROUP BY year  
HAVING SUM(volume) > 500000000;
```
**Problem:**  
For each crime category, count the number of incidents and include only categories with more than 50 incidents.  
Your result should show:

* category  
* number of incidents  
* and filtered using HAVING

**Solution:**
```sql
SELECT  
    category,  
    COUNT(*) AS num_incidents  
FROM tutorial.sf_crime_incidents_2014_01  
GROUP BY category  
HAVING COUNT(*) > 50;
```
**Problem:**  
Write a query that returns

* category  
* number of incidents

Steps:

* In an inner query, count incidents per category and name the count num_incidents.  
* In the outer query, select only categories where num_incidents is greater than 100.

**Solution:**
```sql
SELECT  
    sub.category,  
    sub.num_incidents  
FROM (  
    SELECT  
        category,  
        COUNT(*) AS num_incidents  
    FROM tutorial.sf_crime_incidents_2014_01  
    GROUP BY category  
) AS sub  
WHERE sub.num_incidents > 100;
```
**Problem:**  
Write a query that returns

* category  
* total number of incidents for that category  
* the overall total number of incidents across all categories (same value repeated on every row)

Steps:

* Use a subquery in the SELECT clause to calculate the overall total incident count.  
* Use the outer query to count incidents per category.

**Solution:**
```sql
SELECT  
    category,  
    COUNT(*) AS num_incidents_per_category,  
    (  
        SELECT COUNT(*)  
        FROM tutorial.sf_crime_incidents_2014_01  
    ) AS total_incidents  
FROM tutorial.sf_crime_incidents_2014_01  
GROUP BY category;
```
**Problem:**  
Write a query that returns

* category  
* number of incidents per category

Only for categories whose incident count is greater than the average number of incidents per category.

Steps:

* Use a subquery to calculate the average incident count per category.  
* In the outer query, return only categories whose counts exceed that average.

**Solution:**
```sql
SELECT  
    category,  
    COUNT(*) AS num_incidents_per_category  
FROM tutorial.sf_crime_incidents_2014_01  
GROUP BY category  
HAVING COUNT(*) > (  
    SELECT  
        COUNT(*) / COUNT(DISTINCT category)  
    FROM tutorial.sf_crime_incidents_2014_01);
```
**Problem:**  
Write a query that returns all crime incidents that occurred on the top 5 dates with the highest total number of incidents.

Steps:

* In a subquery, find the top 5 dates with the highest incident counts.  
* Join that subquery back to the main crime table to return all incidents for those dates.

**Solution:**
```sql
SELECT  
    incidents.*,  
    sub.num_incidents_per_date  
FROM tutorial.sf_crime_incidents_2014_01 AS incidents  
JOIN (  
    SELECT  
        date,  
        COUNT(*) AS num_incidents_per_date  
    FROM tutorial.sf_crime_incidents_2014_01  
    GROUP BY date  
    ORDER BY COUNT(*) DESC  
    LIMIT 5  
) AS sub  
    ON incidents.date = sub.date;
```
**Problem:**  
Write a query that returns all crime incidents whose incident count for that category is greater than the average incident count per category.

Steps:

* For each row in the outer query, compare its category’s total incident count  
* Use a correlated subquery to calculate the average incident count per category  
* Return only rows where the category’s count exceeds the average

**Solution:**
```sql
SELECT  
    *  
FROM tutorial.sf_crime_incidents_2014_01  
WHERE category IN (  
    SELECT  
        category  
    FROM tutorial.sf_crime_incidents_2014_01  
    GROUP BY category  
    HAVING COUNT(*) > (  
        SELECT  
            COUNT(*) / COUNT(DISTINCT category)  
        FROM tutorial.sf_crime_incidents_2014_01  
    )  
);
```
**Problem:**  
Combine the two investments tables using a subquery with UNION ALL, then return:

* investor_name  
* total number of investments per investor (total_investments)

Order results by total_investments descending.

**Solution:**
```sql
SELECT  
    sub.investor_name,  
    COUNT(*) AS total_investments  
FROM (  
    SELECT  
        investor_name  
    FROM tutorial.crunchbase_investments_part1

    UNION ALL

    SELECT  
        investor_name  
    FROM tutorial.crunchbase_investments_part2  
) AS sub  
GROUP BY sub.investor_name  
ORDER BY total_investments DESC;
```
