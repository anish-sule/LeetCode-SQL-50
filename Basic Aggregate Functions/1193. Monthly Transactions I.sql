-- QUESTION :

/*

Table: Transactions
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.
Return the result table in any order.

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+

*/



-- SOLUTION (MS SQL Server)

SELECT
    FORMAT(trans_date, 'yyyy-MM') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY country, FORMAT(trans_date, 'yyyy-MM');



-- EXPLANATION :

/*

# Intuition
the goal is to retrieve information about the number and total amount of transactions, as well as the number and total amount of approved transactions, for each month and country.

# Approach
- formatting date:
the FORMAT function is used to extract the year and month from the trans_date column in the 'yyyy-MM' format.

- grouping data:
group the results by both the extracted month and the country.

- aggregating data:
1. COUNT(id) gives the total number of transactions (trans_count) for each group.

2. SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) gives the count of approved transactions (approved_count).

3. SUM(amount) gives the total amount of all transactions (trans_total_amount).

4. SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) gives the total amount of approved transactions (approved_total_amount).

*/
