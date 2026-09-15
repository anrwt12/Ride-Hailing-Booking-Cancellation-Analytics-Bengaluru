-- Q8: Customer Loyalty & Repeat Booking Analysis 

-- Business Question: 
-- Which customers have the highest successful-ride conversion 
-- and repeat-booking behavior?

-- -- Business Objective: 
-- Identify highly loyal and reliable customers based on their
-- booking frequency, successful-ride conversion, repeat bookings, 
-- and total booking value.

-- -- SQL Concepts: 
-- CTE, COUNT(DISTINCT), FILTER, SUM, HAVING/WHERE, 
-- RANK(), PARTITION BY, aggregate functions 

-- Step 1: Calculate customer-level booking performance 
WITH customer_summary AS(
SELECT
customer_id AS cust_id,
COUNT( DISTINCT booking_id) AS Total_booking,
COUNT(DISTINCT booking_id) FILTER(WHERE booking_status = 'Success') AS successfull_rides,
SUM(booking_value) AS Total_booking_value
FROM rides
GROUP BY cust_id
),
 -- Step 2: Calculate customer loyalty metrics 
customer_loyalty AS (
SELECT
cust_id,
Total_booking,
successfull_rides,
 Total_booking_value,
-- Bookings after the customer's first booking 
 Total_booking - 1
            AS repeat_booking_count,

-- Successful ride conversion rate 

	successfull_rides/Total_booking 
	* 100.0 AS success_rate
-- Keep only customers who booked more than once 
FROM customer_summary
WHERE 
Total_booking> 1
),
	
 -- Step 3: Rank customers within each repeat-booking group 
Customer_Rank AS(
SELECT
  cust_id,
        total_booking,
        successfull_rides,
        total_booking_value,
        repeat_booking_count,
        success_rate,
RANK() OVER (
  PARTITION BY repeat_booking_count
ORDER BY  success_rate DESC ) AS success_rank
FROM customer_loyalty
)
-- Step 4: Identify highly loyal and reliable customers 

SELECT
    cust_id,
    total_booking,
    successfull_rides,
    success_rate,
    repeat_booking_count,
    total_booking_value,
    success_rank
FROM Customer_Rank 
WHERE  repeat_booking_count >= 2 AND success_rate >= 70
ORDER BY   success
