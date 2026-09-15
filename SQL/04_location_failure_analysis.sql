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
