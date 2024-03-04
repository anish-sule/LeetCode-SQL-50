-- QUESTION :

/*
Table: Insurance
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

have the same tiv_2015 value as one or more other policyholders, and
are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
Round tiv_2016 to two decimal places.

Example 1:

Input: 
Insurance table:
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
Output: 
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
Explanation: 
The first record in the table, like the last record, meets both of the two criteria.
The tiv_2015 value 10 is the same as the third and fourth records, and its location is unique.

The second record does not meet any of the two criteria. Its tiv_2015 is not like any other policyholders and its location is the same as the third record, which makes the third record fail, too.
So, the result is the sum of tiv_2016 of the first and last record, which is 45.
*/



-- SOLUTION (MS SQL Server | MySQL)

SELECT
  round(sum(tiv_2016), 2) AS tiv_2016
FROM (
  SELECT
    tiv_2016,
    count(*) OVER(PARTITION BY tiv_2015) AS 'tiv_count',
    count(*) OVER(PARTITION BY lat, lon) AS 'coord_count'
  FROM Insurance
) i1
WHERE tiv_count > 1 AND coord_count = 1



-- EXPLANATION :

  /*
1. Subquery (`i1`):
   - The subquery selects the columns `tiv_2016`, `tiv_2015`, `lat`, and `lon` from the `Insurance` table.
   - It then calculates two additional columns using window functions:
     - `tiv_count`: Counts the number of occurrences of each `tiv_2015` value using the `COUNT(*) OVER(PARTITION BY tiv_2015)` window function. This provides the count of occurrences of each `tiv_2015` value within its partition.
     - `coord_count`: Counts the number of occurrences of each unique combination of `lat` and `lon` using the `COUNT(*) OVER(PARTITION BY lat, lon)` window function. This provides the count of occurrences of each unique coordinate pair within its partition.

2. Main Query:
   - The main query selects the sum of `tiv_2016` rounded to two decimal places (`ROUND(SUM(tiv_2016), 2)`).
   - It filters the results from the subquery using a `WHERE` clause:
     - `WHERE tiv_count > 1`: This condition ensures that only rows where the count of occurrences of the `tiv_2015` value is greater than 1 are considered. In other words, it selects rows where there are multiple occurrences of the same `tiv_2015` value.
     - `AND coord_count = 1`: This condition ensures that only rows where the count of occurrences of the coordinate pair is exactly 1 are considered.
*/
