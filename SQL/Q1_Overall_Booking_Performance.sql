--Q1 What is the company's overall booking performance and success rate?
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



