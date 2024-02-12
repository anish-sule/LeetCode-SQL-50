-- QUESTION :

/*
Table: Employee
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+
*/



-- SOLUTION (MySQL | MS SQL Server)

SELECT e1.name
FROM Employee AS e1
INNER JOIN Employee AS e2
ON e1.id = e2.managerId
GROUP BY e2.managerId, e1.name
HAVING COUNT(e2.managerId) >= 5



-- EXPLANATION :

/*
let's break down this SQL query:

SELECT Clause:
It selects the name column from the Employee table and aliases it as e1.

FROM Clause:
It specifies the table involved in the query: Employee table aliased as e1.

INNER JOIN:
It performs an inner join of the Employee table with itself, aliased as e2.
The join condition is e1.id = e2.managerId, meaning it matches each employee (e1) with their corresponding manager (e2) based on the manager's ID.

GROUP BY Clause:
It groups the result set by e2.managerId and e1.name.
This grouping ensures that each employee's name is grouped by their manager's ID.

HAVING Clause:
It filters the grouped results, retaining only those groups where the count of e2.managerId is greater than or equal to 5.
This means it only selects employees who have at least 5 subordinates.

Overall, the query retrieves the names of employees who are managers (have subordinates) with at least 5 employees reporting to them.
It achieves this by joining the Employee table with itself to match each employee with their manager and then filtering the results based on the count of subordinates.
*/