-- QUESTION :

/*
Table: Customer
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).
Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.
Return the result table ordered by visited_on in ascending order.

Example 1:

Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86
*/



-- SOLUTION (MS SQL Server)

SELECT visited_on, 
    SUM(SUM(amount)) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS 'amount',
    ROUND(CAST(SUM(SUM(amount)) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS FLOAT)/7.0 ,2) AS 'average_amount' 
FROM Customer 
GROUP BY visited_on
ORDER BY visited_on
OFFSET 6 ROWS



-- EXPLANATION :

/*
This SQL query calculates the total amount spent by customers over a rolling period of 7 days, as well as the average amount spent during that period. Here's a breakdown of each part of the query:

1. SELECT visited_on:
This selects the column `visited_on` from the `Customer` table, which likely represents the date when a customer visited.

2. SUM(SUM(amount)) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS 'amount':
This part calculates the rolling sum of the `amount` column over a window of the current row and the preceding 6 rows, ordered by `visited_on`. It sums up the `amount` for the current row and the preceding 6 rows, effectively giving the total amount spent by customers in the past 7 days.

3. ROUND(CAST(SUM(SUM(amount)) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS FLOAT)/7.0 ,2) AS 'average_amount':
This calculates the average amount spent by customers over the same rolling 7-day period. It divides the total amount calculated in step 2 by 7, and rounds the result to 2 decimal places.

4. FROM Customer:
This specifies the source table for the data, which is likely named `Customer`.

5. GROUP BY visited_on:
This groups the results by the `visited_on` date, so that the calculations are performed for each unique date.

6. ORDER BY visited_on:
This sorts the results by the `visited_on` date in ascending order.

7. OFFSET 6 ROWS:
This skips the first 6 rows of the result set. It's likely used to ensure that the rolling window calculation starts from the 7th row, as the rolling window requires at least 7 rows to calculate.
*/
