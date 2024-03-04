-- QUESTION :

/*
Table: Employee
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

Table: Department
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.
Return the result table in any order.

Example 1:

Input: 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
Output: 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
Explanation: 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees
*/



-- SOLUTION (MS SQL Server | PostgreSQL)

SELECT d.name AS Department, e.name AS Employee, e.salary 
FROM Employee AS e
INNER JOIN Department AS d
ON d.id = e.departmentId
WHERE (
    SELECT
    COUNT(DISTINCT(salary))
    FROM Employee
    WHERE salary > e.salary
    AND DepartmentId = e.DepartmentId        
) < 3;



-- SOLUTION (MySQL)

SELECT D.Name as Department, E.Name as Employee, E.Salary 
FROM Department D, Employee E, Employee E2  
WHERE D.ID = E.DepartmentId and E.DepartmentId = E2.DepartmentId and 
E.Salary <= E2.Salary
group by D.ID,E.Name having count(distinct E2.Salary) <= 3
order by D.Name, E.Salary desc



-- EXPLANATION :

/*
1. Main Query:
   - The main query selects 3 columns from two tables: `name` from the `Department` table (aliased as `d`), `name` and `salary` from the `Employee` table (aliased as `e`).
   - It uses an `INNER JOIN` to combine rows from the `Employee` and `Department` tables based on the `id` and `departmentId` columns, respectively.

2. Subquery:
   - Inside the `WHERE` clause, there's a subquery:
     - The subquery counts the number of distinct salaries (`COUNT(DISTINCT(salary))`) for employees within the same department who earn more than the salary of the current employee (`e.salary`).
     - It restricts the count to only consider employees in the same department as the current employee (`DepartmentId = e.DepartmentId`).
     - This subquery checks how many distinct salaries are higher than the salary of the current employee within the same department.

3. Filtering:
   - The `WHERE` clause of the main query checks if the count obtained from the subquery is less than 3 (`< 3`), meaning there are fewer than three distinct salaries higher than the salary of the current employee within the same department.
   - If the count is less than 3, it means the current employee is among the top three highest earners in their department.
*/
