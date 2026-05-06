### **WHERE / ORDER BY / HAVING**

**WHERE**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-where  
https://www.thoughtspot.com/sql-tutorial/sql-comparison-operators

**Problem:**  
Did the West Region ever produce more than 50,000 housing units in one month?

**Solution:**
```sql
SELECT    
    year,   
    month_name,   
    west     
FROM tutorial.us_housing_units  
WHERE west > 50;
```
**Problem:**  
Did the South Region ever produce 20,000 or fewer housing units in one month?

**Solution:**
```sql
SELECT  year, month_name, south     
FROM tutorial.us_housing_units  
WHERE south <= 20;
```
**Problem:**  
Write a query that only shows rows for which the month name is February.

**Solution:**
```sql
SELECT *     
FROM tutorial.us_housing_units  
WHERE month_name = 'February';
```
**Problem:**  
Write a query that only shows rows for which the month_name starts with the letter "N" or an earlier letter in the alphabet.

**Solution:**
```sql
SELECT *     
FROM tutorial.us_housing_units  
WHERE month_name < 'O';
```
**Problem:**  
Write a query that calculates the sum of all four regions in a separate column.

**Solution:**
```sql
SELECT  
    year,  
    month,  
    west,  
    south,  
    midwest,  
    northeast,  
    west + south + midwest + northeast AS all_regions  
FROM tutorial.us_housing_units;
```
**Problem:**  
Write a query that returns all rows for which more units were produced in the West region than in the Midwest and Northeast combined.

**Solution:**
```sql
SELECT  
    year,  
    month,  
    west,  
    south,  
    midwest,  
    northeast,  
    midwest + northeast AS midwest_northeast  
FROM tutorial.us_housing_units  
WHERE west > midwest_northeast;
```
**Problem:**  
Write a query that calculates the percentage of all houses completed in the United States represented by each region. Only return results from the year 2000 and later.  
Hint: There should be four columns of percentages.

**Solution:**
```sql
SELECT  
    year,  
    month,  
    west / (west + south + midwest + northeast) * 100 AS west_percentage,  
    south / (west + south + midwest + northeast) * 100 AS south_percentage,  
    midwest / (west + south + midwest + northeast) * 100 AS midwest_percentage,  
    northeast / (west + south + midwest + northeast) * 100 AS northeast_percentage  
FROM tutorial.us_housing_units  
WHERE year >= 2000;
```
**ORDER BY**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-order-by

**Problem:**  
Write a query that returns all rows from 2012, ordered by song title from Z to A.

**Solution:**
```sql
SELECT *     
FROM tutorial.billboard_top_100_year_end  
WHERE year = 2012  
ORDER BY song_name DESC;
```
**Problem:**  
Write a query that returns all rows from 2010 ordered by rank, with artists ordered alphabetically for each song.

**Solution:**
```sql
SELECT *     
FROM tutorial.billboard_top_100_year_end  
WHERE year = 2010  
ORDER BY year_rank, artist;
```
**Problem:**  
Write a query that shows all rows for which T-Pain was a group member, ordered by rank on the charts, from lowest to highest rank (from 100 to 1).

**Solution:**
```sql
SELECT *     
FROM tutorial.billboard_top_100_year_end  
WHERE group_name ILIKE '%t-pain%'  
ORDER BY year_rank DESC;
```
**Problem:**  
Write a query that returns songs that ranked between 10 and 20 (inclusive) in 1993, 2003, or 2013\. Order the results by year and rank, and leave a comment on each line of the WHERE clause to indicate what that line does

**Solution:**
```sql
SELECT *     
FROM tutorial.billboard_top_100_year_end  
WHERE   
    year_rank BETWEEN 10 AND 20 -- ranked between 10 and 20  
    AND year IN (1993, 2003, 2013) -- year in 1993, 2003, or 2013  
ORDER BY year, year_rank;
```
**HAVING**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-having

**Problem:**  
Which years had an average daily trading volume greater than 15 million shares for Apple stock?

**Solution:**
```sql
SELECT  
    year,  
    AVG(volume) AS average_daily_volume  
FROM tutorial.aapl_historical_stock_price  
GROUP BY year  
HAVING AVG(volume) > 15000000  
ORDER BY year;
```
