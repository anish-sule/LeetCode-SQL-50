-- QUESTION :

/*
Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| customer_id | int     |
| product_key | int     |
+-------------+---------+
This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.

Table: Product
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_key | int     |
+-------------+---------+
product_key is the primary key (column with unique values) for this table.

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

Example 1:

Input: 
Customer table:
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
Product table:
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
Output: 
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
Explanation: 
The customers who bought all the products (5 and 6) are customers with IDs 1 and 3.
*/



-- SOLUTION (MS SQL Server | MySQL | Oracle | PostgreSQL)

SELECT c.customer_id
FROM Customer AS c
GROUP BY c.customer_id
HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(product_key) FROM Product)



-- EXPLANATION

/*
step 1 :
- GROUP BY c.customer_id

- first, group the records based on unique customer IDs

step 2 :
- HAVING COUNT(DISTINCT c.product_key) = (SELECT COUNT(product_key) FROM Product)

- then, include only those customer IDs where the count of distinct product keys associated with each customer is equal to the total count of product keys in the "Product" table.
*/