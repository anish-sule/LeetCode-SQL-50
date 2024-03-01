-- QUESTION :

/*
Table: Logs
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column.

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
Explanation: 1 is the only number that appears consecutively for at least three times.
*/



-- SOLUTION (MS SQL Server | MySQL | Oracle | PostgreSQL)

WITH CTE AS
(
    SELECT
        num AS n1,
        LEAD(num,1) OVER (ORDER BY id) AS n2,
        LEAD(num,2) OVER (ORDER BY id) AS n3
    FROM Logs
)
SELECT
    DISTINCT n1 AS ConsecutiveNums
FROM CTE
WHERE n1 = n2 AND n1 = n3
