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


