--What is the company's overall booking performance and success rate?
--Analyze total bookings, successful rides, cancellations, driver-not-found bookings,
-- success rate, failure rate, 
--total booking value, and average booking value. what to do


-- Total Bookings
SELECT COUNT(booking_id) AS total_bookings 
FROM rides;


--Successful Rides
SELECT booking_status ,
COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Success'
GROUP BY booking_status

  
--Customer Cancellations
SELECT booking_status ,
COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Canceled by Customer'
GROUP BY booking_status

  
-- Driver Cancellations
SELECT booking_status ,COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Canceled by Driver'
GROUP BY booking_status

  
--Driver Not Found
SELECT booking_status ,COUNT(*) AS total_rides
FROM rides
WHERE booking_status = 'Driver Not Found'
GROUP BY booking_status


--Success Rate
SELECT 
 ROUND
 (COUNT(*) FILTER(WHERE booking_status = 'Success')*100.0
 /COUNT(*),2) AS Success_Rate
FROM rides

  
--Failure Rate
SELECT 
 ROUND(COUNT(*) FILTER(WHERE booking_status !='Success')*100.0
 /COUNT(*),2) AS Failure_Rate
FROM rides


--Total Booking Value
SELECT ROUND(SUM(booking_value),2) AS Total_Booking_Value
FROM rides

  
--Average Booking Value
SELECT ROUND(AVG(booking_value),2) AS Avg_Booking_Value
FROM rides


