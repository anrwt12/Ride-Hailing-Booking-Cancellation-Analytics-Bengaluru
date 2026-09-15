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


