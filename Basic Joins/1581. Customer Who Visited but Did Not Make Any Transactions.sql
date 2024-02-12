-- QUESTION :

/*
Table: Visits
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| visit_id    | int     |
| customer_id | int     |
+-------------+---------+
visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.

Table: Transactions
+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |
+----------------+---------+
transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.
 
Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

Example 1:

Input: 
Visits
+----------+-------------+
| visit_id | customer_id |
+----------+-------------+
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |
+----------+-------------+
Transactions
+----------------+----------+--------+
| transaction_id | visit_id | amount |
+----------------+----------+--------+
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |
+----------------+----------+--------+
Output: 
+-------------+----------------+
| customer_id | count_no_trans |
+-------------+----------------+
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |
+-------------+----------------+
Explanation: 
Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
Customer with id = 30 visited the mall once and did not make any transactions.
Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
Customer with id = 96 visited the mall once and did not make any transactions.
As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also, user 54 visited the mall twice and did not make any transactions.
*/



-- SOLUTION (MySQL | MS SQL Server)

SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans
FROM Visits AS v
LEFT JOIN Transactions AS t
ON v.visit_id = t.visit_id
WHERE t.transaction_id IS NULL
GROUP BY v.customer_id



/*
INTUITION :
The SQL query seems to be retrieving information about the count of visits where there is no corresponding transaction.
It's selecting the customer ID and counting the number of such visits for each customer.

APPROACH :
The query uses a left join between the "Visits" table (aliased as "v") and the "Transactions" table (aliased as "t") on the "visit_id" column.
The condition in the "where" clause filters out the rows where the "transaction_id" is null, meaning there is no corresponding transaction.
The result is grouped by "customer_id," and the count of visits with no transactions is calculated for each customer.

TIME COMPLEXITY :
The time complexity can be expressed as O(N + M), where N is the number of rows in the "Visits" table and M is the number of rows in the "Transactions" table.
The dominant factors are the left join operation and the subsequent grouping.

SPACE COMPLEXITY :
The space complexity can be expressed as O(K), where K is the number of distinct customer IDs.
*/
