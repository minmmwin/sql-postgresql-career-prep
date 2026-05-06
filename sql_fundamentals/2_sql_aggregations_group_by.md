### **SQL AGGREGATIONS/GROUP BY**

**COUNT**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-count

**Problem:**  
Write a query that determines counts of every single column. With these counts, can you tell which column has the most null values?

**Solution:**
```sql
SELECT   
    COUNT(date) AS date,   
    COUNT(year) AS year,   
    COUNT(month) AS month,   
    COUNT(open) AS open,   
    COUNT(high) AS high,   
    COUNT(low) AS low, 
    COUNT(close) AS close,   
    COUNT(volume) AS volume,   
    COUNT(id) AS id  
FROM tutorial.aapl_historical_stock_price;
```

**SUM**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-sum

**Problem:**  
Write a query to calculate the average opening price (hint: you will need to use both COUNT and SUM, as well as some simple arithmetic.).

**Solution:**
```sql
SELECT   
    SUM(open)/COUNT(open) AS average_open_price  
FROM tutorial.aapl_historical_stock_price;
```

**MIN/MAX**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-min-max

**Problem:**  
What was the highest single-day increase in Apple's share value?

**Solution:**
```sql
SELECT   
    MAX(close-open) AS highest_single_day_increase  
FROM tutorial.aapl_historical_stock_price;
```

**Problem:**  
What was Apple's lowest stock price (at the time of this data collection)?

**Solution:**
```sql
SELECT   
    MIN(low) AS lowest_stock_price  
FROM tutorial.aapl_historical_stock_price;
```

**AVG**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-avg

**Problem:**  
Write a query that calculates the average daily trade volume for Apple stock.

**Solution:**
```sql
SELECT   
    AVG(volume) AS average_daily_volume  
FROM tutorial.aapl_historical_stock_price;
```

**GROUP BY**

**Practice source:**  
Mode Analytics / ThoughtSpot SQL Tutorial  
https://www.thoughtspot.com/sql-tutorial/sql-group-by

**Problem:**  
Calculate the total number of shares traded each month. Order your results chronologically.

**Solution:**
```sql
SELECT   
    year,   
    month,   
    SUM(volume) AS total_volume   
FROM tutorial.aapl_historical_stock_price  
GROUP BY 1, 2  
ORDER BY 1, 2;
```

**Problem:**  
Write a query to calculate the average daily price change in Apple stock, grouped by year.

**Solution:**
```sql
SELECT   
    year,    
    AVG(close-open) AS average_daily_change   
FROM tutorial.aapl_historical_stock_price  
GROUP BY 1  
ORDER BY 1;
```

**Problem:**  
Write a query that calculates the lowest and highest prices that Apple stock achieved each month.

**Solution:**
```sql
SELECT   
    year,   
    month,    
    MIN(low) AS lowest_price,   
    MAX(high) AS highest_price  
FROM tutorial.aapl_historical_stock_price  
GROUP BY 1, 2  
ORDER BY 1, 2;
```

