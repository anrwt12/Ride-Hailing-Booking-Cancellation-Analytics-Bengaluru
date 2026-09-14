-- Q1: Overall Booking Performance and Success Rate 

-- -- Business Question: 
-- What is the company's overall booking performance and success rate? 

-- -- Objective: 
-- Analyze total bookings, successful rides, cancellations, 
-- driver-not-found bookings, success rate, failure rate, 
-- total booking value, and average booking value. 

-- 1. Total Bookings 
-- Find the total number of ride bookings.
SELECT COUNT(booking_id) AS total_bookings 
FROM rides;


-- 2. Successful Rides
-- Find the number of bookings that resulted in successful rides.
SELECT booking_status ,
COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Success'
GROUP BY booking_status

  
-- 3. Customer Cancellations 
-- Find the number of bookings canceled by customers.
SELECT booking_status ,
COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Canceled by Customer'
GROUP BY booking_status

  
-- 4. Driver Cancellations 
-- Find the number of bookings canceled by drivers.
SELECT booking_status ,COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Canceled by Driver'
GROUP BY booking_status

  
-- 5. Driver Not Found
-- Find the number of bookings where no driver was found.
SELECT booking_status ,COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Driver Not Found'
GROUP BY booking_status

-- 6. Success Rate 
-- Calculate the percentage of total bookings that became successful rides.
SELECT 
 ROUND
 (COUNT(*) FILTER(WHERE booking_status = 'Success')*100.0
 /COUNT(*),2) AS Success_Rate
FROM rides

-- 7. Failure Rate
-- Calculate the percentage of bookings that did not become successful rides.
SELECT 
 ROUND(COUNT(*) FILTER(WHERE booking_status !='Success')*100.0
 /COUNT(*),2) AS Failure_Rate
FROM rides


-- 8. Total Booking Value 
-- Calculate the total value of all bookings.
SELECT ROUND(SUM(booking_value),2) AS Total_Booking_Value
FROM rides

  
-- 9. Average Booking Value 
-- Calculate the average value per booking.
SELECT ROUND(AVG(booking_value),2) AS Avg_Booking_Value
FROM rides

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q2: Booking Value at Risk from Unsuccessful Rides

-- -- Business Question: 
-- How much booking value is potentially at risk because bookings 
-- do not become successful rides? 

-- -- Objective: 
-- Compare successful and unsuccessful bookings and quantify the 
-- booking-value exposure associated with unsuccessful rides. 

-- 1. Successful Bookings 
-- Find successful booking volume, total booking value, 
-- and average booking value.

SELECT 
	booking_status,
	COUNT(*) AS Successfull_booking,
	ROUND(SUM(booking_value),2) AS total_booking_value,
	ROUND(AVG(booking_value),2) AS Avg_booking_value
FROM rides
WHERE booking_status ='Success'
GROUP BY booking_status

-- 2. Unsuccessful Bookings
-- Find total unsuccessful bookings, their booking value, 
-- average booking value, and their share of total booking value.

SELECT 
	COUNT(*) AS UnSuccessfull_booking,
	ROUND(SUM(booking_value),2) AS total_booking_value,
	ROUND(AVG(booking_value),2) AS Avg_booking_value,
	ROUND(
	    SUM(booking_value)*100.0/
	    (SELECT SUM(booking_value)FROM rides)
	    ,2)AS UnSuccessful_Booking_Value_Percent 
FROM rides
WHERE booking_status<>'Success'


-- 3. Unsuccessful Booking Breakdown 
-- Compare booking volume and booking value across 
-- different unsuccessful booking types.

SELECT booking_status,
	COUNT(*) AS Unsuccessfull_booking,
	ROUND(SUM(booking_value),2) AS Total_booking_value
FROM rides
WHERE booking_status <>'Success'
GROUP BY booking_status

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q3: Vehicle Performance Analysis

-- -- Business Question:
-- Which vehicle types have high booking demand but significantly lower
-- success rates than the company average?

-- -- Objective:
-- Identify high-demand vehicle types that underperform compared with
-- the company's overall success rate and may require operational attention.

-- 1. Vehicle Performance
-- Calculate total bookings, successful bookings, and success rate
-- for each vehicle type.


WITH vehicle_performance AS (
SELECT 
  	vehicle_type, 
	COUNT(booking_id) AS Total_booking,
	COUNT(*) FILTER(WHERE booking_status = 'Success') AS Successfull_booking,
	ROUND 
	(COUNT(*) FILTER(WHERE booking_status = 'Success') *100.0 /
	COUNT(*),
	2) AS success_rate
	FROM rides
	GROUP BY vehicle_type),

									-- 2. Company Success Rate
									-- Calculate the overall success rate across all vehicle types.
company_rate AS (SELECT 
	ROUND 
	(COUNT(*) FILTER(WHERE booking_status = 'Success') *100.0 /
	COUNT(*) ,2)AS Company_success_rate
	FROM rides)
									-- 3. Identify Underperforming High-Demand Vehicles
									-- Compare each vehicle's booking demand and success rate with
									-- company benchmarks.

	SELECT
	V.vehicle_type,
	V.Total_booking,
	V.Successfull_booking,
	V.success_rate,
	C.Company_success_rate,

CASE 
	WHEN V.Total_booking >( SELECT AVG(Total_booking)FROM vehicle_performance)
	AND 
	 V.success_rate < C.Company_success_rate THEN 'Needs Attention'
 ELSE 'Normal'
END AS Performance_Flag
	FROM vehicle_performance AS V
	CROSS JOIN company_rate AS C
	ORDER BY V.Total_booking DESC


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q4: Location Failure Analysis
	
-- -- Business Question:
-- Which pickup locations have high booking demand but unusually high
-- failure rates?
	
-- -- Objective:
-- Identify pickup locations with high booking demand and above-average
-- failure rates to highlight locations that may require operational attention.
	
-- 1. Location Performance
-- Calculate total bookings, failed bookings, and failure rate
-- for each pickup location.
WITH LOCT AS (
	SELECT 
	pickup_location,
	COUNT(booking_id) AS booking,
	  COUNT(*) FILTER (WHERE booking_status <> 'Success') AS Failed_booking,
	ROUND(
	COUNT(*) FILTER(WHERE booking_status <> 'Success') *100.0
	/COUNT(*) ,2)
	AS failure_rates
FROM rideS 
	GROUP BY pickup_location
	ORDER BY failure_rates  DESC )


					-- A location is classified as "High Priority" when:
					-- 1. Its total bookings are above the average booking volume.
					-- 2. Its failure rate is above the average failure rate. 

SELECT 
	pickup_location,
	booking,
	Failed_booking,
	failure_rates,

CASE 
	WHEN booking >(SELECT AVG(booking)  AS Avg_booking from LOCT )
	AND 
	 failure_rates >(SELECT AVG(failure_rates)  AS Avg_f_booking from LOCT )
	THEN 'High Priority'
ELSE 'Normal'
	END location_demand 

FROM LOCT 
ORDER BY  booking DESC;
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q5: Peak Demand & Failure Analysis

-- -- Business Question:
-- During which hours does booking demand peak, and does the failure rate increase during those periods? 

-- -- Objective:
-- Identify peak booking hours, measure their failure rates, and compare 
-- them with the average hourly failure rate to identify operational concerns.

-- 1. Calculate hourly booking demand and failure performance

WITH BOOK AS(
SELECT 
	EXTRACT(HOUR FROM booking_time) AS booking_hours,
	COUNT(booking_id) AS total_booking,
	COUNT(*) FILTER( WHERE booking_status<>'Success') AS failed_bookings,
	ROUND(COUNT(*) FILTER( WHERE booking_status<>'Success')*100.0/
	COUNT(*),2) AS  failure_rate
	from rides
		GROUP BY  booking_hours
	),
	
				-- 2. Rank hours by demand and calculate average hourly failure rate
Performance AS(
SELECT
    booking_hours,
    total_booking,
    failed_bookings,
    failure_rate,
    ROUND(AVG(failure_rate) OVER (), 2) AS avg_failure_rate,
	RANK() OVER (
ORDER BY total_booking DESC )AS Demand_rank
FROM Book
)
			-- 3. Classify hourly performance based on demand and failure rate
SELECT
    booking_hours,
    total_booking,
    failed_bookings,
    failure_rate,
	avg_failure_rate,
	Demand_rank,
	
CASE 
    WHEN demand_rank <= 3  AND failure_rate > avg_failure_rate
    THEN 'Peak Demand + High Failure'
    WHEN demand_rank <= 3 AND failure_rate <= avg_failure_rate
    THEN 'Peak Demand + Normal Failure'
    WHEN demand_rank > 3 AND failure_rate > avg_failure_rate
    THEN 'Lower Demand + High Failure'
    WHEN demand_rank > 3 AND failure_rate <= avg_failure_rate
    THEN 'Lower Demand + Normal Failure'

    ELSE 'Normal'
		END AS performance_flag

FROM Performance 
ORDER BY total_booking DESC;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q6: Daily Time-Series Performance Analysis

-- -- Business Question:
-- Which days show significant changes in booking value and success rate?
-- -- Objective:
-- Analyze daily booking performance, compare each day with the previous day,
-- measure changes in booking value and success rate, and identify significant
-- performance changes using predefined thresholds.

-- 1. Calculate daily booking performance


WITH Booking_date_reco AS(
SELECT 
booking_date,
	COUNT(booking_id) AS Total_bookings,
		COUNT(*) FILTER(WHERE booking_status = 'Success') AS Successful_bookings,
	ROUND(
	COUNT(*) FILTER(WHERE booking_status = 'Success')*100.0 
	/ COUNT(*),2) AS Success_rate,
		SUM(booking_value) AS Total_booking_value
FROM rides
GROUP BY booking_date
),
-- 2. Retrieve previous day's performance using LAG()
PVC_VALUE AS(
SELECT 
	booking_date,
	Total_bookings,
	Successful_bookings,
	Success_rate,
	Total_booking_value,
		LAG(Total_booking_value) OVER(
		ORDER BY  booking_date
		) AS previous_day_booking_value,
		
		LAG(Success_rate) OVER (
		    ORDER BY booking_date
		) AS previous_day_success_rate

FROM Booking_date_reco
),
-- 3. Calculate day-over-day changes
Daily_Changes AS (
SELECT 
	booking_date,
	Total_bookings,
	Successful_bookings,
	Success_rate,
	Total_booking_value,
	previous_day_booking_value,
ROUND(
	(Total_booking_value - previous_day_booking_value)*100.0
			/previous_day_booking_value ,2)
		 AS booking_value_change_pct,
ROUND(
        Success_rate - previous_day_success_rate,
        2
    ) AS success_rate_change
    FROM PVC_VALUE
)

-- 4. Identify significant daily performance changes	
SELECT 
    booking_date,
    Total_bookings,
    Successful_bookings,
    Success_rate,
    Total_booking_value,
	previous_day_booking_value,
    booking_value_change_pct,
    success_rate_change,

CASE
    WHEN ABS(success_rate_change) > 2
         AND ABS(booking_value_change_pct) > 5
    THEN 'Significant Change'

    ELSE 'Normal'
END AS performance_flag
FROM Daily_Changes
ORDER BY booking_date;


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ============================================================
-- Q7 : Which pickup-to-drop routes have high demand but poor
--    success rates, making them operationally underserved?
-- ============================================================

-- Business Objective:
-- Identify high-demand routes where the success rate is low.
-- These routes may indicate operational issues such as driver
-- availability, demand-supply imbalance, or inefficient
-- ride allocation.


WITH route_performance AS(
SELECT 
	pickup_location ,
	drop_location,
	COUNT(booking_id) AS Total_booking,
COUNT(*) FILTER (WHERE booking_status = 'Success') AS Successfull_booking,
ROUND(COUNT(*) FILTER (WHERE booking_status = 'Success')* 100.0/COUNT(*) ,2) AS Success_rate
	FROM rides
GROUP BY pickup_location ,
	drop_location
HAVING COUNT(booking_id) >=50
),
route_ranked AS(
	SELECT pickup_location ,
	drop_location,
	Total_booking,
	Successfull_booking,
	Success_rate,
		RANK() OVER(ORDER BY Total_booking DESC) AS  Booking_RANK
FROM route_performance 
)

SELECT
	pickup_location ,
drop_location,
Total_booking,
Successfull_booking,
Success_rate,
 Booking_RANK
FROM route_ranked
	WHERE booking_rank <= 10
	  AND success_rate < 70
	ORDER BY booking_rank;



------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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
ORDER BY   success_rate DESC;










