# 🏬 Zudio Retail Store Business Analysis (SQL Project)

## 📌 Overview

This project is a complete end-to-end business analysis of a multi-state retail clothing chain using **MySQL**.

Instead of just running basic queries, this analysis focuses on answering **real executive-level business questions**:

* What actually drives revenue — location or category?
* Are longer operating hours improving profitability?
* Are large stores more efficient?
* Is the business dependent on the top 20% of stores?
* Where are we losing margins?

This project contains **70 structured business insights**, covering revenue, customers, operations, profitability, and strategic expansion decisions.

---

## 🗂 Dataset Overview

The dataset contains:

* 📍 State & City information
* 🏪 Store details (type, size, manager, staff, security)
* 🧾 Order-level data
* 👤 Customer data
* 👕 Product & category data
* 💰 Price, quantity, and sales profit
* ⏰ Operating hours (feature engineered)

Key columns:

```
State, City, Category, Clothing Type,
Store Number, Store Type,
Selling Area Size (sq ft), Staff Count,
Order ID, Order Date, Month,
Customer ID, Product ID,
Price, Quantity, Sales Profit,
Opening_time, Closing_Time, Operating_hrs
```

---

## 🛠 Feature Engineering

One important enhancement performed:

### 🔹 Operating Hours Split & Optimization

Original column:

```
"10 AM - 9 PM"
```

Converted into:

* `Opening_time`
* `Closing_Time`
* `Operating_hrs`

This enabled:

* Revenue per hour analysis
* Profit per hour efficiency ranking
* Long-hour vs short-hour performance comparison
* Operational productivity insights

---

# 📊 Analysis Structure (70 Business Questions)

---

## 1️⃣ Revenue & Profitability Analysis

* Revenue & profit by state
* Profit margins by category
* Most profitable clothing types
* Store-level profitability ranking
* Margin leakage detection
* High revenue but low margin stores

---

## 2️⃣ Store Performance & Efficiency

* Owned vs rented store comparison
* Revenue per sq ft
* Revenue per staff
* Profit per sq ft
* Parking & security impact
* Underperforming large stores
* Highly efficient small stores

---

## 3️⃣ Product & Category Insights

* Best-selling categories
* Seasonal category trends
* Profit per unit analysis
* Category revenue share
* High margin but low sales opportunities
* Expansion candidates

---

## 4️⃣ Customer Intelligence

* Top 10 high-value customers
* Repeat customer count
* Customer lifetime value
* Order size distribution
* Pareto analysis (Top 20% revenue contribution)
* Customer spending by state

---

## 5️⃣ Time-Based Insights

* Monthly revenue & profit trends
* Month-over-month growth
* Best & worst performing months
* Seasonal spikes
* Revenue by store age

---

## 6️⃣ Operational Efficiency

* Revenue per operating hour
* Profit per operating hour
* Revenue density per state
* Store size vs profitability relationship
* Staff impact on revenue

---

## 7️⃣ Executive-Level Strategy Questions

* What happens if bottom 10% stores are closed?
* Which 3 states deserve expansion?
* Is business location-driven or category-driven?
* Revenue concentration risk (Pareto analysis)
* Where are margins being lost?

---

# 📈 Key Business Findings (Example Insights)

> ⚡ Top 20% of stores contribute a disproportionate share of total revenue (Pareto effect observed).
> ⚡ Some large stores generate lower profit per sq ft than smaller stores.
> ⚡ Certain categories show strong margins but weak sales — untapped opportunity.
> ⚡ Longer operating hours do not always translate to higher profitability.
> ⚡ Revenue concentration suggests potential dependency risk.

(Replace with your actual findings after running queries.)

---

# 🧠 Skills Demonstrated

* Advanced SQL (MySQL 8)
* Window Functions (`LAG`, `NTILE`)
* CTEs
* Revenue modelling
* Profit margin analysis
* Operational efficiency metrics
* Business storytelling
* Executive-level thinking

---

# 📦 Tools Used

* MySQL 8
* Feature Engineering (Pandas)
* GitHub for documentation

---

# 🚀 Why This Project Stands Out

Most SQL projects:

> “Find total sales by state.”

This project:

> “Should we expand into a new state or optimise existing stores?”

It moves from **descriptive analysis → strategic decision-making.**

---

# 📬 Connect With Me

If you found this project insightful or want to discuss business analytics:

📩 Feel free to connect with me on LinkedIn.

---

# ⭐ If You Like This Project

Give it a ⭐ and let’s connect!
