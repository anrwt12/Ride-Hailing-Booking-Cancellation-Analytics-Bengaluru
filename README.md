# Ride-hailing-booking-cancellation-analytics

## 📌 Project Overview

This project analyzes ride-hailing booking data using **PostgreSQL, SQL, and Power BI** to understand booking performance, cancellations, vehicle performance, demand patterns, route performance, customer behavior, and operational failures.

The goal is to transform raw ride-booking data into meaningful business insights that can support better decisions related to ride fulfillment, driver availability, demand management, booking value, and customer retention.

---

## 🎯 Business Objectives

* Measure overall booking performance and success rate
* Analyze customer and driver cancellations
* Identify booking value at risk from unsuccessful rides
* Analyze vehicle type performance
* Identify high-failure pickup locations
* Analyze peak booking hours and failure rates
* Track daily booking and success-rate changes
* Identify high-demand routes with poor success rates
* Analyze repeat booking and customer loyalty behavior
* Identify operational areas requiring attention

---

## 📂 Dataset

**Dataset:** Ola & Uber Ride Booking and Cancellation Dataset
**Source:** Kaggle
**Format:** CSV
**Database:** PostgreSQL

🔗 **[View Dataset on Kaggle](https://www.kaggle.com/datasets/hetmengar/ola-and-uber-ride-booking-and-cancellation-data)**

### Dataset Table

| Table   | Description                                                                              |
| ------- | ---------------------------------------------------------------------------------------- |
| `rides` | Ride booking, customer, vehicle, location, status, timing, and booking value information |

### Key Columns

| Column            | Description               |
| ----------------- | ------------------------- |
| `booking_id`      | Unique booking identifier |
| `booking_date`    | Date of booking           |
| `booking_time`    | Time of booking           |
| `booking_status`  | Status of the booking     |
| `customer_id`     | Customer identifier       |
| `vehicle_type`    | Type of vehicle booked    |
| `pickup_location` | Ride pickup location      |
| `drop_location`   | Ride drop location        |
| `booking_value`   | Value of the booking      |

---

## 🗄️ PostgreSQL Data Usage

The raw ride-hailing data is provided in CSV format and imported into PostgreSQL for analysis.

### Data Flow

```text
CSV File
    │
    ↓
PostgreSQL Database
    │
    ↓
rides table
    │
    ├── Data Quality Checks
    ├── Booking Performance Analysis
    ├── Cancellation Analysis
    ├── Vehicle Analysis
    ├── Location Analysis
    ├── Time & Demand Analysis
    ├── Route Analysis
    └── Customer Analysis
    │
    ↓
Power BI
    │
    ├── Data Modeling
    ├── DAX Measures
    ├── KPI Cards
    ├── Interactive Charts
    └── Business Dashboard
    │
    ↓
Business Insights & Recommendations
```

### How PostgreSQL Uses the CSV File

1. The CSV file contains the raw ride-booking data.
2. The data is imported into a PostgreSQL `rides` table.
3. SQL queries are used to perform:

   * Data quality checks
   * Booking performance analysis
   * Cancellation analysis
   * Vehicle performance analysis
   * Location failure analysis
   * Peak-hour analysis
   * Daily time-series analysis
   * Route performance analysis
   * Customer loyalty analysis
4. SQL results and PostgreSQL data are connected to **Power BI** for visualization.
5. Power BI is used to create measures, KPIs, charts, and interactive dashboards.
6. The analysis is converted into business insights and recommendations.

### Example: Import CSV into PostgreSQL

```sql
COPY rides
FROM '/path/rides.csv'
DELIMITER ','
CSV HEADER;
```

After importing the CSV, booking performance can be analyzed using SQL:

```sql
SELECT
    booking_status,
    COUNT(*) AS total_bookings
FROM rides
GROUP BY booking_status
ORDER BY total_bookings DESC;
```

---

## 🔗 Connecting PostgreSQL with Power BI

Power BI is connected directly to the PostgreSQL database so that the ride-hailing data analyzed in SQL can be used for interactive visualization.

### Connection Flow

```text
PostgreSQL
    │
    │ PostgreSQL Connector
    ↓
Power BI
    │
    ├── Data / Tables
    ├── Data Model
    ├── DAX Measures
    └── Visualizations
```

### Power BI Analysis

The Power BI dashboard uses the PostgreSQL `rides` table to create:

* KPI cards
* Booking and success-rate analysis
* Cancellation analysis
* Vehicle performance analysis
* Location performance
* Hourly demand analysis
* Daily trends
* Route analysis
* Customer analysis

### Dashboard Pages

**1. Overall Performance**

* Total Bookings
* Successful Rides
* Success Rate
* Cancellation Rate
* Total Booking Value
* Average Booking Value

**2. Cancellation & Operations**

* Cancellation breakdown
* Vehicle performance
* Location failure rate
* Booking value at risk

**3. Demand & Time Analysis**

* Hourly booking demand
* Hourly failure rate
* Daily booking trends
* Success-rate trends

**4. Route Analysis**

* High-demand routes
* Low-success routes
* Pickup-to-drop performance

**5. Customer Analysis**

* Repeat bookings
* Customer success rate
* Booking value
* Customer loyalty

---

## ❓ Business Questions

### Q1. Overall Booking Performance

What is the company's overall booking performance and success rate?

### Q2. Booking Value at Risk

How much booking value is potentially at risk because bookings do not become successful rides?

### Q3. Vehicle Performance

Which vehicle types have high booking demand but significantly lower success rates than the company average?

### Q4. Location Failure Analysis

Which pickup locations have high booking demand but unusually high failure rates?

### Q5. Peak Demand & Failure Analysis

During which hours does booking demand peak, and does the failure rate increase during those periods?

### Q6. Daily Time-Series Performance

Which days show significant changes in booking value and success rate?

### Q7. Route Performance

Which pickup-to-drop routes have high demand but poor success rates, making them operationally underserved?

### Q8. Customer Loyalty

Which customers have the highest successful-ride conversion and repeat-booking behavior?

---

## 📊 SQL Analysis

```text
sql/
├── 01_overall_booking_performance.sql
├── 02_booking_value_at_risk.sql
├── 03_vehicle_performance.sql
├── 04_location_failure_analysis.sql
├── 05_peak_demand_failure.sql
├── 06_daily_performance.sql
├── 07_route_performance.sql
└── 08_customer_loyalty.sql
```

---

## 📈 Power BI Dashboard

The SQL analysis is transformed into an interactive Power BI dashboard to provide a visual view of ride-hailing performance.

The dashboard focuses on:

* Overall performance
* Success and cancellation rates
* Booking value
* Vehicle performance
* Location failures
* Peak-hour demand
* Daily performance
* Route performance
* Customer loyalty

---

## 🛠️ Tools & Technologies

* **PostgreSQL** — Database & SQL analysis
* **SQL** — Business analysis
* **Power BI** — Data visualization & dashboarding
* **DAX** — Measures and KPIs
* **CSV** — Raw dataset

### SQL Concepts

* CTEs
* Aggregate Functions
* Window Functions
* `CASE`
* `FILTER`
* `RANK()`
* `LAG()`
* Subqueries
* `HAVING`

---

## 🎯 Project Outcome

```text
CSV
 ↓
PostgreSQL
 ↓
SQL Analysis
 ↓
Power BI
 ↓
Dashboard
 ↓
Business Insights
 ↓
Recommendations
```

This project demonstrates how **SQL and Power BI can be used together to analyze real-world ride-hailing operations and convert raw booking data into actionable business insights.**
