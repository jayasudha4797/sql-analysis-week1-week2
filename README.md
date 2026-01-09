🧠 SQL Learning – Week 1 & Week 2
📌 Project Overview

This repository contains SQL practice queries from Week 1 and Week 2, designed to build a strong foundation in SQL for data analysis.

Week 1 focuses on basic SQL concepts

Week 2 focuses on intermediate SQL concepts and business-style queries

🛠 Tools & Technologies

SQL (MySQL)

MySQL Workbench

Git & GitHub

📂 Project Structure
sql-learning/
│
├── sql/
│   ├── week_1.sql     # Basic SQL queries
│   ├── week_2.sql     # Intermediate SQL queries
│
└── README.md

📘 Topics Covered
✅ Week 1 – SQL Basics

SELECT statements

DISTINCT

WHERE clause

Filtering using AND / OR

ORDER BY

LIMIT

Aggregate functions:

COUNT()

SUM()

AVG()

MIN()

MAX()

GROUP BY

✅ Week 2 – Intermediate SQL

JOINS:

INNER JOIN

LEFT JOIN

Subqueries:

Subqueries in SELECT

Subqueries in WHERE

Conditional logic:

CASE WHEN

Date functions:

YEAR()

MONTH()

DATE()

Business problem-based SQL queries.
▶️ How to Use This Repository

Clone the repository:

git clone https://github.com/jayasudha4797/sql-learning.git


Open the .sql files in MySQL Workbench

Run queries on the sample database

Modify queries to practice further

🎯 Learning Outcomes

Strong understanding of SQL fundamentals

Ability to analyze data using SQL

Experience writing business-oriented SQL queries

Improved problem-solving skills using SQL


# 📊 Power BI Dashboard 

## 📌 Project Overview

This project showcases an **interactive Power BI dashboard** built to analyze business performance and customer behavior. The dashboard enables stakeholders to monitor key metrics, identify trends, and make data-driven decisions efficiently.

The dashboard was developed as part of a data analytics / internship project and follows best practices in data modeling, DAX, and visualization.

---

## 🎯 Objectives

* Provide a single source of truth for business metrics
* Enable quick analysis using interactive visuals
* Support decision-making through KPIs and trends
* Ensure data accuracy using a clean star schema model

---

## 📂 Files in This Repository

* `week 3 dashboard.pbix` – Power BI dashboard file
* `README.md` – Project documentation

---

## 🗂️ Data Model

* **Fact Table**: Orders / Sales
* **Dimension Tables**:

  * Customers
  * Products
  * Date
  * Region / Location

**Model Design**:

* Star schema
* One-to-Many relationships (Dimension → Fact)
* Single-direction cross filtering
* Active relationships enabled

---

## 📈 Key Dashboard Features

* 📌 KPI Cards (Total Sales, Revenue, Orders, Customers)
* 📊 Trend Analysis (Month-over-Month / Year-over-Year)
* 🧩 Customer Segmentation (RFM / Category-based insights)
* 🌍 Regional Performance Analysis
* 🎛️ Interactive Filters & Slicers (Date, Region, Product)

---

## 🧮 DAX Measures Used

* Total Sales
* Total Orders
* Average Order Value (AOV)
* Month-over-Month Growth
* Year-over-Year Growth
* Customer Count

*All measures are written using optimized DAX for performance.*

---

## 🔐 Security

* **Row-Level Security (RLS)** implemented
* Regional managers can view only their respective region data

---

## 🛠️ Tools & Technologies

* Power BI Desktop
* DAX
* SQL (for data extraction & cleaning)
* Excel / CSV (if applicable)

---

## ▶️ How to Use This Dashboard

1. Clone or download this repository
2. Open `week 3 dashboard.pbix` using **Power BI Desktop**
3. Refresh the data (if source is available)
4. Use slicers and filters to explore insights

---

## 📌 Insights & Outcomes

* Identified high-performing regions and products
* Highlighted customer segments contributing maximum revenue
* Enabled faster reporting compared to manual analysis

---

## 🚀 Future Enhancements

* Add drill-through pages
* Integrate live database connection
* Improve visual storytelling
* Add forecasting using time-series analysis

---
# 📊 Consumer360 Analytics Dashboard & Pipeline

## 📌 Project Overview

This internship project demonstrates an **end-to-end analytics solution** combining a **Python analytics pipeline**, **SQL data warehouse**, and an **interactive Power BI dashboard**.

The goal is to convert raw transactional data into **actionable business insights** such as customer segmentation, sales trends, and product associations.

---

## 🎯 Business Objectives

* Understand customer behavior using **RFM analysis**
* Identify high-value customer segments
* Discover product associations using **Market Basket Analysis**
* Track weekly sales performance
* Present insights through an interactive Power BI dashboard

---

## 🗂️ Repository Structure

```
├── weekly_pipeline.py        # Automated Python analytics pipeline
├── powerbi_data/             # CSV outputs used in Power BI
│   ├── rfm_customer_scores.csv
│   ├── market_basket_rules.csv
│   └── weekly_sales_summary.csv
├── week 3 dashboard.pbix     # Power BI dashboard file
└── README.md                 # Project documentation
```

---

## 🧱 Data Architecture

**Source → Processing → Visualization**

* **MySQL Data Warehouse** (Fact & Dimension tables)
* **Python Pipeline** for analytics & feature engineering
* **Power BI** for reporting and visualization

The data model follows a **star schema** with fact_sales as the central fact table and customer, product, time, and region as dimensions.

---

## ⚙️ Python Analytics Pipeline

The `weekly_pipeline.py` script performs the following steps:

1. Connects to the MySQL data warehouse
2. Extracts sales, customer, region, and item data
3. Performs **RFM Analysis** (Recency, Frequency, Monetary)
4. Segments customers into:

   * Champion
   * Loyal
   * Potential
   * Hibernating
5. Executes **Market Basket Analysis** using Apriori
6. Generates **weekly sales summaries**
7. Exports clean CSV files for Power BI consumption
8. Logs each step for monitoring and debugging

---

## 📈 Power BI Dashboard Features

* 📌 KPI Cards (Total Revenue, Orders, Customers)
* 📊 Weekly & Monthly Sales Trends
* 🧩 Customer Segmentation (RFM-based)
* 🌍 Region-wise Performance Analysis
* 🛒 Market Basket Insights (Top product combinations)
* 🎛️ Interactive slicers (Date, Region, Segment)

---

## 🧮 Key Metrics & Measures

* Total Revenue
* Total Orders
* Average Order Value (AOV)
* Customer Count
* Week-over-Week Growth
* Segment-wise Revenue Contribution

---

## 🔐 Security & Best Practices

* Clean star schema modeling
* Optimized DAX measures
* Single-direction filtering
* Scalable pipeline design
* Ready for Row-Level Security (RLS) implementation

---

## ▶️ How to Run the Project

1. Set up MySQL data warehouse
2. Update database credentials in `weekly_pipeline.py`
3. Run the Python pipeline
4. Open `week 3 dashboard.pbix` in Power BI Desktop
5. Refresh data and explore insights

---

## 📌 Key Insights Generated

* Identification of high-value customers (Champions)
* Clear visibility into weekly sales performance
* Strong product association rules for cross-selling
* Region-wise contribution to revenue

---

## 🚀 Future Enhancements

* Schedule pipeline using Airflow / Cron
* Add predictive sales forecasting
* Implement full Row-Level Security
* Deploy dashboard to Power BI Service

---

👤 Author

Jayasudha MVS
Aspiring Data Analyst
Data Analyst | Power BI | SQL | Python | DAX
