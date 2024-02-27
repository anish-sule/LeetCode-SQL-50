-- QUESTION :

/*

Table: Delivery
+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.
The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

Example 1:

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
Explanation: 
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.

*/



-- SOLUTION (MS SQL Server | MySQL | PostgreSQL | Oracle)

SELECT
    ROUND(100.0 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(DISTINCT customer_id), 2) AS immediate_percentage
FROM Delivery d1
WHERE EXISTS (
    SELECT 1
    FROM Delivery d2
    WHERE d2.customer_id = d1.customer_id
    GROUP BY d2.customer_id
    HAVING MIN(d2.order_date) = d1.order_date
);



/*

# Approach
- Use a correlated subquery with EXISTS to check if there exists another order with the same customer_id and a minimum order date equal to the order date of the outer query. This ensures that only the first orders are considered.
- In the main query, apply the SUM and COUNT functions along with a CASE statement to calculate the percentage of immediate orders among the first orders.
- Use the ROUND function to round the result to 2 decimal places.

# Query Explanation
- SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END): Counts the number of immediate orders for each customer.
- COUNT(DISTINCT customer_id): Counts the total number of distinct customers.
- 100.0 * (SUM / COUNT): Calculates the percentage of immediate orders.
- ROUND(percentage, 2): Rounds the percentage to 2 decimal places.
The subquery ensures that only the first orders for each customer are considered in the calculation.

*/
