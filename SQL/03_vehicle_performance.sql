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


