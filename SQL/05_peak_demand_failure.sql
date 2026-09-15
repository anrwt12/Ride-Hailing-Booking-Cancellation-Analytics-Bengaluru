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


