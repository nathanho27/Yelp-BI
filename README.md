# Yelp Business Intelligence Platform (Yelp-BI)

## Status

In Progress

---

## Overview

Yelp-BI is an end-to-end business intelligence and machine learning project that transforms Yelp Fusion API data into structured, actionable insights for local businesses. The project follows a real-world analytics workflow, starting with data ingestion and cleaning, moving through KPI modeling and SQL analytics, and culminating in machine learning models and Power BI dashboards.

The goal of this project is to answer practical business questions such as pricing strategy, competitive positioning, customer perception, and market opportunity using data-driven methods.

---

## Project Architecture

Yelp Fusion API → Python (Ingestion & Cleaning) → PostgreSQL / CSV (Modeled Data)  
→ SQL KPIs → Machine Learning → Power BI Dashboards

---

## Machine Learning Models

The machine learning layer is built on top of a cleaned and modeled business-level dataset. Models are designed to produce interpretable, business-facing signals that BI dashboards can directly consume.

### Expected Rating Model (Completed)

**Objective**  
Predict the expected Yelp rating of a business based on observable attributes such as price level, review volume, business category, and geographic location.

**Why This Matters**  
Comparing a business’s actual rating to its expected rating enables identification of:

- Overperforming businesses that exceed expectations  
- Underperforming businesses relative to comparable peers  
- Normalized performance patterns across categories and locations  

**Model Type**  
Regression

**Approach**
- Linear Regression used as a baseline model  
- Lasso Regression selected as the final model for improved robustness  
- Shared preprocessing pipeline with imputation, scaling, and encoding  

**Key Output Metric**
- Rating Delta = actual rating − predicted rating  

Model outputs are written back to the analytics layer and exported to
`data/kpi/expected_rating_results.csv` for Power BI consumption.

### Closure Risk Proxy Model (In Progress)

**Objective**  
Estimate the relative business closure risk using observable Yelp signals related to
engagement, momentum, performance versus expectations, and competitive context.

**Model Type**  
Risk scoring/proxy model

**Output**
- Continuous closure risk score  
- Risk buckets (Low Risk, Medium Risk, High Risk)

This model reframes the problem from outcome prediction to relative risk
identification, producing interpretable risk signals for business intelligence
and dashboard-driven analysis when true closure labels are unavailable.

## Folder Structure

- data/
  - raw: Raw Yelp API responses  
  - clean: Cleaned and modeled datasets used for analytics and ML  
  - kpi: KPI and model output tables for BI consumption  

- SQLQueries/
  - SQL scripts used to generate KPI and analytics tables  

- MachineLearning/
  - ExpectedRatingModel.ipynb  
  - ClosureRiskModel.ipynb  
  - README.md  

- YelpData.py
  - Python script for Yelp API ingestion and preprocessing  

---

## Tools & Technologies

- Python (pandas, numpy, scikit-learn)  
- SQL (PostgreSQL-style analytics)  
- Power BI  
- Yelp Fusion API  
- Git & GitHub  

---

## Next Steps

---

## Next Steps

- Integrate Expected Rating results into Power BI dashboards  
- Explore KPIs in Power BI  
- Complete exploratory analysis for the Closure Risk Proxy Model  
- Construct and validate a closure risk proxy score using engagement, momentum,
  performance versus expectations, and competitive pressure signals  
- Incorporate closure risk scores and risk buckets into Power BI dashboards  

---

This project is designed to mirror how analytics and machine learning are applied in a
real business intelligence environment, with an emphasis on clarity, reproducibility,
and business relevance.

