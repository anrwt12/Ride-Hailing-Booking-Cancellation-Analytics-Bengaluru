# 📊 Business Insights

This document summarizes the key business findings from the **Ride-Hailing Booking & Cancellation Analytics** project.

The analysis focuses on:

* Booking performance
* Cancellation and failure reasons
* Vehicle performance
* Location performance
* Peak-hour demand
* Daily trends
* Route performance
* Customer loyalty

---

# 1️⃣ Overall Booking Performance

### 📌 Key Metrics

| Metric                |  Result |
| --------------------- | ------: |
| Total Bookings        | 103,024 |
| Successful Rides      |  63,967 |
| Unsuccessful Bookings |  39,057 |
| Success Rate          |  62.09% |
| Failure Rate          |  37.91% |
| Total Booking Value   | ₹56.53M |
| Average Booking Value | ₹548.75 |

### 🔍 What does this mean?

Out of every **100 bookings**:

* ✅ Around **62 bookings** become successful rides.
* ❌ Around **38 bookings** are unsuccessful.

### 📊 Booking Outcome

```text
                    103,024 BOOKINGS
                           │
              ┌────────────┴────────────┐
              ▼                         ▼
        ✅ SUCCESSFUL              ❌ UNSUCCESSFUL
          63,967                      39,057
           62.09%                      37.91%
```

### 💡 Key Insight

* The overall success rate is **62.09%**.
* The failure rate is relatively high at **37.91%**.
* A large amount of existing demand is not converting into successful rides.
* Improving ride conversion is therefore a major business opportunity.

---

# 2️⃣ Booking Value at Risk

### 📌 Key Metrics

| Booking Type |    Bookings | Booking Value |
| ------------ | ----------: | ------------: |
| Successful   |      63,967 |       ₹35.08M |
| Unsuccessful |      39,057 |       ₹21.45M |
| **Total**    | **103,024** |   **₹56.53M** |

Unsuccessful bookings represent approximately **37.95% of total booking value**.

### 💰 Unsuccessful Booking Value Breakdown

```text
             ❌ ₹21.45M Unsuccessful Value
                         │
          ┌──────────────┼──────────────┐
          ▼              ▼              ▼
     Driver Cancel   Customer Cancel   Driver Not Found
       ₹10.18M          ₹5.77M            ₹5.50M
```

### 📌 Cancellation Categories

* 🚨 **Driver cancellations:** ₹10.18M
* ⚠️ **Customer cancellations:** ₹5.77M
* ⚠️ **Driver not found:** ₹5.50M

### 💡 Key Insight

* Driver cancellations create the **largest booking-value exposure**.
* Driver-side operational issues should therefore be investigated first.
* Improving driver availability and reducing driver cancellations could help convert more bookings into successful rides.

---

# 3️⃣ Vehicle Performance

### 📌 Success Rate by Vehicle Type

| Vehicle Type | Success Rate | Status             |
| ------------ | -----------: | ------------------ |
| Prime Sedan  |       63.04% | ✅ Highest          |
| Bike         |       62.30% | Normal             |
| Auto         |       62.13% | Normal             |
| Mini         |       62.09% | Normal             |
| eBike        |       61.96% | ⚠️ Needs Attention |
| Prime Plus   |       61.71% | Normal             |
| Prime SUV    |       61.39% | Lowest             |

Company average success rate: **62.09%**

### 📊 Vehicle Performance

```text
Vehicle Type
     │
     ├── Prime Sedan → 63.04% ✅
     ├── Bike        → 62.30%
     ├── Auto        → 62.13%
     ├── Mini        → 62.09%
     ├── eBike       → 61.96% ⚠️
     ├── Prime Plus  → 61.71%
     └── Prime SUV   → 61.39% ⚠️
```

### 💡 Key Insights

* **Prime Sedan** has the highest success rate at **63.04%**.
* **Prime SUV** has the lowest success rate at **61.39%**.
* **eBike** is slightly below the company average.
* The difference between vehicle types is relatively small.
* Vehicle type alone may not explain the overall failure problem.
* Location, timing, and driver availability should also be investigated.

---

# 4️⃣ Location Failure Analysis

The analysis identifies pickup locations where:

* Booking volume is high
* Failure rate is above the overall benchmark of **37.91%**

### 📍 High-Priority Locations

| Location      | Bookings | Failure Rate |
| ------------- | -------: | -----------: |
| Vijayanagar   |    2,113 |       40.18% |
| Langford Town |    2,079 |       39.87% |
| Hosur Road    |    2,074 |       39.83% |
| Tumkur Road   |    2,105 |       39.71% |
| Kengeri       |    2,083 |       39.65% |
| Peenya        |    2,069 |       38.71% |
| Sarjapur Road |    2,070 |       38.50% |

### 🔎 Priority Logic

```text
             High Booking Volume
                     │
                     ▼
            Above-Average Failure?
                 /          \
               YES           NO
                │             │
                ▼             ▼
          🚨 HIGH PRIORITY   Normal
```

### 💡 Key Insights

* **Vijayanagar** has the highest failure rate among the listed high-demand locations at **40.18%**.
* Several other locations are also above the **37.91%** benchmark.
* High-demand locations with high failure rates should receive priority attention.
* Driver availability and cancellation patterns should be investigated in these locations.

---

# 5️⃣ Peak Demand & Failure Analysis

### 📌 Top 3 Demand Hours

| Hour  | Bookings | Failure Rate | Performance                    |
| ----- | -------: | -----------: | ------------------------------ |
| 12:00 |    4,408 |       38.77% | 🚨 High Demand + High Failure  |
| 15:00 |    4,376 |       36.97% | ✅ High Demand + Normal Failure |
| 08:00 |    4,374 |       38.71% | 🚨 High Demand + High Failure  |

### ⏰ Peak-Hour Analysis

```text
                    PEAK DEMAND
                        │
          ┌─────────────┼─────────────┐
          ▼             ▼             ▼
        08:00         12:00         15:00
          │             │             │
          ▼             ▼             ▼
       38.71%        38.77%        36.97%
       Failure       Failure       Failure
          │             │             │
          ▼             ▼             ▼
         🚨             🚨             ✅
```

### 💡 Key Insights

* **08:00 and 12:00** combine high demand with above-average failure rates.
* These periods may require better supply planning.
* **15:00** also has high demand but a lower failure rate.
* This indicates that high demand does not automatically result in high failure.
* Driver availability and operational conditions may influence ride success.

---

# 6️⃣ Daily Performance Analysis

Daily performance was generally stable across the analyzed period.

### 📌 Important Observations

* Most days were classified as **Normal**.
* **July 19** showed a significant change under the project's defined threshold.
* **July 19 success rate:** 63.60%
* Success rate increased by **2.12 percentage points**.
* Booking value decreased by **6.43%**.
* **July 31** had the largest observed booking-value decline of **9.90%**.

### 📊 July 19 Change

```text
Success Rate

62.00% ─────────────────► 63.60%
                           📈 +2.12 pp


Booking Value

₹1.87M ─────────────────► ₹1.75M
                           📉 -6.43%
```

### 💡 Key Insight

* Daily performance was mostly stable.
* Unusual changes should still be monitored.
* A change in booking value does not always move in the same direction as success rate.
* Monitoring both metrics together gives a better view of daily performance.

---

# 7️⃣ Route Performance

The analysis identifies high-demand routes where the success rate is below **70%**.

### 📍 Examples of Low-Success Routes

| Pickup → Drop              | Bookings | Success Rate |
| -------------------------- | -------: | -----------: |
| Ulsoor → Bellandur         |       59 |       61.02% |
| KR Puram → Electronic City |       59 |       61.02% |
| Cox Town → JP Nagar        |       59 |       61.02% |
| Nagarbhavi → Nagarbhavi    |       60 |       66.67% |
| Magadi Road → Vijayanagar  |       60 |       66.67% |
| Hebbal → Bannerghatta Road |       59 |       66.10% |
| Yelahanka → Frazer Town    |       59 |       66.10% |

### 🔎 Route Analysis

```text
             High-Demand Route
                    │
                    ▼
            Success Rate < 70%?
                /          \
              YES           NO
               │             │
               ▼             ▼
         🚨 Investigate     Normal
```

### 💡 Key Insights

* Several high-demand routes have success rates between **61% and 69%**.
* The lowest success rate among the listed routes is **61.02%**.
* These routes have demand but are not converting that demand efficiently.
* Driver availability and route-level operational issues should be investigated.

---

# 8️⃣ Customer Loyalty Analysis

The analysis identifies customers with:

* Repeat bookings
* High success rates
* Potentially higher booking value

### ⭐ Example Customers

| Customer  | Bookings | Successful | Success Rate | Booking Value |
| --------- | -------: | ---------: | -----------: | ------------: |
| CID268274 |        4 |          4 |         100% |        ₹1,777 |
| CID329193 |        4 |          4 |         100% |        ₹1,560 |
| CID266327 |        4 |          4 |         100% |        ₹1,400 |
| CID635963 |        4 |          4 |         100% |        ₹2,841 |
| CID836942 |        4 |          4 |         100% |        ₹6,019 |

### 👥 Customer Segmentation

```text
                         CUSTOMERS
                             │
              ┌──────────────┼──────────────┐
              ▼              ▼              ▼
          🆕 New         🔄 Repeat       ⭐ High-Value
         Customers      Customers         Repeat
                                             │
                                             ▼
                                      Retention Strategy
```

### 💡 Key Insights

* Some repeat customers have a **100% ride success rate**.
* Repeat customers represent an opportunity for customer retention.
* Customers with higher booking value can be considered for targeted retention strategies.
* Possible strategies include:

  * Loyalty benefits
  * Personalized offers
  * Retention campaigns
  * Better service experience

---

# 🎯 Business Recommendations

Based on the analysis, the following areas should receive priority.

## 1. 🚨 Reduce Driver Cancellations

Driver cancellations represent the largest cancellation-related booking value.

**Actions:**

* Investigate the reasons for driver cancellations.
* Monitor driver cancellations by location.
* Monitor driver cancellations by hour.
* Improve driver availability during high-demand periods.

---

## 2. 📍 Improve High-Failure Locations

Focus on locations that have both:

* High booking volume
* Above-average failure rate

**Priority examples:**

* Vijayanagar
* Kengeri
* Hosur Road
* Tumkur Road
* Langford Town

---

## 3. ⏰ Improve Peak-Hour Supply

Pay special attention to:

* **08:00**
* **12:00**

**Actions:**

* Ensure sufficient driver availability.
* Monitor cancellation rates during peak hours.
* Compare driver supply with booking demand.

---

## 4. 🛣️ Investigate Poor-Performing Routes

Focus on routes with:

* High booking demand
* Success rate below 70%

**Goal:**

Identify why customers on these routes are less likely to complete their rides.

---

## 5. ⭐ Retain Repeat Customers

Focus on customers with strong repeat-booking behavior.

**Actions:**

* Identify high-value repeat customers.
* Offer loyalty benefits.
* Monitor customer booking success.
* Encourage repeat usage through targeted offers.

---

# 🏁 Final Business Takeaway

```text
                    🚕 103,024 BOOKINGS
                            │
              ┌─────────────┴─────────────┐
              ▼                           ▼
       ✅ 63,967 SUCCESSFUL        ❌ 39,057 FAILED
           62.09%                       37.91%
              │                           │
              │                    ₹21.45M VALUE
              │                       AT RISK
              │                           │
              └─────────────┬─────────────┘
                            ▼
                 🎯 MAIN OPPORTUNITY
                            │
                            ▼
              Convert failed bookings
               into successful rides
                            │
          ┌─────────────────┼─────────────────┐
          ▼                 ▼                 ▼
     🚨 Reduce          🚗 Improve          📍 Fix
     Driver            Driver              High-Failure
     Cancellations     Availability        Areas
          │                 │                 │
          └─────────────────┼─────────────────┘
                            ▼
                 📈 Improve Ride Success
```

## 💡 Overall Conclusion

The analysis shows that the biggest opportunity is **not simply generating more bookings**.

The business already has **103,024 bookings**, but **37.91% are unsuccessful**.

The key focus should therefore be:

1. 🚨 Reduce driver cancellations
2. 🚗 Improve driver availability
3. 📍 Fix high-failure locations
4. ⏰ Improve supply during high-risk peak hours
5. 🛣️ Investigate low-success routes
6. ⭐ Retain valuable repeat customers

### 🎯 Business Goal

> **Convert more existing booking demand into successful rides while reducing cancellations and operational failures.**
