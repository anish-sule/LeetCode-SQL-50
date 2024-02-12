-- QUESTION :

/*
Table: Students
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| student_id    | int     |
| student_name  | varchar |
+---------------+---------+
student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.
 

Table: Subjects
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| subject_name | varchar |
+--------------+---------+
subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.
 

Table: Examinations
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| student_id   | int     |
| subject_name | varchar |
+--------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.

Example 1:

Input: 
Students table:
+------------+--------------+
| student_id | student_name |
+------------+--------------+
| 1          | Alice        |
| 2          | Bob          |
| 13         | John         |
| 6          | Alex         |
+------------+--------------+
Subjects table:
+--------------+
| subject_name |
+--------------+
| Math         |
| Physics      |
| Programming  |
+--------------+
Examinations table:
+------------+--------------+
| student_id | subject_name |
+------------+--------------+
| 1          | Math         |
| 1          | Physics      |
| 1          | Programming  |
| 2          | Programming  |
| 1          | Physics      |
| 1          | Math         |
| 13         | Math         |
| 13         | Programming  |
| 13         | Physics      |
| 2          | Math         |
| 1          | Math         |
+------------+--------------+
Output: 
+------------+--------------+--------------+----------------+
| student_id | student_name | subject_name | attended_exams |
+------------+--------------+--------------+----------------+
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |
+------------+--------------+--------------+----------------+
Explanation: 
The result table should contain all students and all subjects.
Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
Alex did not attend any exams.
John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
*/



-- SOLUTION (MySQL | MS SQL Server)

SELECT s.student_id, s.student_name, sub.subject_name, COUNT(e.student_id) AS attended_exams
FROM Students AS s
CROSS JOIN Subjects AS sub
LEFT JOIN Examinations AS e
    ON s.student_id = e.student_id
    AND sub.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, sub.subject_name
ORDER BY s.student_id, sub.subject_name;



-- EXPLANATION :

/*
let's break down this SQL query block by block:

SELECT Clause:
It selects four columns: student_id and student_name from the Students table (s alias), subject_name from the Subjects table (sub alias), and the count of student_id from the Examinations table (e alias) as attended_exams.

FROM Clause:
It specifies the tables involved in the query: Students table aliased as s, and Subjects table aliased as sub.

CROSS JOIN:
It performs a cross join between the Students table (s) and the Subjects table (sub). This creates a cartesian product between the two tables, meaning every row in the first table is matched with every row in the second table.

LEFT JOIN:
It performs a left join between the result of the cross join and the Examinations table (e).
The join condition is based on matching student_id from the Students table (s) with student_id from the Examinations table (e), and subject_name from the Subjects table (sub) with subject_name from the Examinations table (e).
This left join ensures that all rows from the cross join are included in the result, along with matching rows from the Examinations table. If there's no match, NULL values are returned for the columns from the Examinations table.

GROUP BY Clause:
It groups the result set by student_id, student_name, and subject_name.
This grouping ensures that the count of attended exams is calculated for each unique combination of student and subject.

ORDER BY Clause:
It orders the result set first by student_id and then by subject_name.
Overall, the query retrieves the count of attended exams for each student in each subject. It ensures that even if a student hasn't attended an exam in a particular subject, there will still be a row for that student and subject with a count of 0 attended exams.
*/