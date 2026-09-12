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



