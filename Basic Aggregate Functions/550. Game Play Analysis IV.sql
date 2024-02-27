-- QUESTION :

/*

Table: Activity
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

*/



-- SOLUTION (MS SQL Server)

WITH v1 AS(
SELECT player_id, MIN(event_date) AS first_login
FROM activity
GROUP BY player_id
)

SELECT ROUND(
    CAST(SUM(CASE WHEN DATEDIFF(day, first_login, event_date) = 1 THEN 1 ELSE 0 END) AS float)
    / COUNT(DISTINCT v1.player_id), 2) AS fraction
FROM v1
JOIN activity AS a ON a.player_id = v1.player_id



-- EXPLANATION :

/*

1. Identify First Login Date:
- Create a temporary table (v1 CTE) to find the first login date for each player using the MIN function grouped by player_id.
 
2. Calculate Consecutive Logins:
- Use the main query to join the v1 CTE with the original Activity table (a alias).
- Use the DATEDIFF function to calculate the difference in days between the first login date (first_login) and subsequent login dates (event_date).
- Apply a CASE statement to count the number of consecutive logins where the difference is 1 day.

3. Calculate Fraction:
- Use the ROUND function to round the result to 2 decimal places.
- Calculate the fraction by dividing the sum of consecutive logins by the count of distinct player IDs in the v1 CTE.

*/
