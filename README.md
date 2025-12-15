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

The machine learning layer builds on top of a cleaned, modeled business-level dataset. Models are designed to produce interpretable, business-facing signals that can be directly consumed by BI dashboards.

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

---

### Closure Risk Model (In Progress)

**Objective**  
Estimate the probability that a business is closed based on engagement, reviews,
pricing, category, and competitive context.

**Model Type**  
Classification

**Target Variable**
- is_closed

This model reframes the problem from performance benchmarking to risk estimation
and will focus on probabilistic outputs and classification metrics.

---

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

- Integrate Expected Rating results into Power BI dashboards  
- Begin exploratory analysis for the Closure Risk Model  
- Train and evaluate classification models for closure risk  
- Expand analysis beyond Austin to additional cities  

---

This project is designed to mirror how analytics and machine learning are applied in a
real business intelligence environment, with an emphasis on clarity, reproducibility,
and business relevance.

