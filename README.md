# Yelp Business Intelligence Platform (Yelp-BI)

---

## Overview

Yelp-BI is an end-to-end business intelligence and machine learning project that
transforms Yelp Fusion API data into structured, actionable insights for local
businesses. The project follows a real-world analytics workflow, starting with
data ingestion and cleaning, moving through KPI modeling and SQL analytics, and
culminating in machine learning models and Power BI dashboards.

The goal of this project is to answer practical business questions related to
pricing strategy, competitive positioning, customer perception, and market
opportunity using data-driven methods.

---

## Project Architecture

Yelp Fusion API → Python (Ingestion & Cleaning) → PostgreSQL / CSV (Modeled Data)  
→ SQL KPIs → Machine Learning → Power BI Dashboards

---

## Machine Learning Models

The machine learning layer is built on top of a cleaned and modeled business-level
dataset. Models are designed to produce **interpretable, business-facing signals**
that can be directly consumed by downstream BI dashboards.

---

### Expected Rating Model

**Objective**  
Predict the expected Yelp rating of a business based on observable attributes such as
as price level, review volume, business category, and geographic location.

**Why This Matters**  
Comparing a business’s actual rating to its expected rating enables identification
of:

- Overperforming businesses that exceed expectations  
- Underperforming businesses relative to comparable peers  
- Normalized performance patterns across categories and locations  

**Model Type**  
Regression

**Approach**
- Linear regression used as a baseline model  
- Lasso regression selected as the final model for improved robustness  
- Shared preprocessing pipeline with imputation, scaling, and encoding  

**Key Output Metric**
- Rating Delta = actual rating − predicted rating  

**Outputs**
- Exported to `data/kpi/expected_rating_results.csv`  
- Designed for direct Power BI integration  

---

### Closure Risk Proxy Model

**Objective**  
Estimate **relative business closure risk** using observable Yelp signals related
to customer engagement, customer perception, pricing strategy, and competitive
market context.

**Model Type**  
Risk scoring/proxy modeling

**Approach**
- Interpretable risk components derived from engagement, rating quality, pricing,
  and market density
- Standardized closure risk proxy score
- Risk buckets (Low Risk, Medium Risk, High Risk)
- K-means clustering to identify distinct risk profiles
- Component-level risk decomposition to explain dominant risk drivers
- Market-level aggregation to surface structural risk patterns
- Optional proxy classification (logistic regression and random forest) used as an
  internal consistency check, clearly documented as exploratory

Because true closure outcomes are not consistently available through the Yelp
Fusion API, this model does **not** perform binary closure prediction. Instead, it
identifies businesses that appear more or less vulnerable relative to peers.

**Key Outputs**
- Closure risk score  
- Risk bucket and risk profile  
- Primary risk driver and component-level contributions  

**Outputs**
- Exported to `data/kpi/closure_risk_results.csv.`  
- Designed for Power BI dashboarding and market analysis  

---

## Folder Structure

- `data/`
  - `raw/` – Raw Yelp API responses  
  - `clean/` – Cleaned and modeled datasets used for analytics and ML  
  - `kpi/` – KPI and model output tables for BI consumption  

- `SQLQueries/`
  - SQL scripts used to generate KPI and analytics tables  

- `MachineLearning/`
  - `ExpectedRatingModel.ipynb`  
  - `ClosureRiskModel.ipynb`  
  - `README.md`  

- `YelpData.py`
  - Python script for Yelp API ingestion and preprocessing  

---

## Tools & Technologies

- Python (pandas, numpy, scikit-learn)  
- SQL (PostgreSQL-style analytics)  
- Power BI  
- Yelp Fusion API  
- Git & GitHub  

---

## Dashboards

### Austin Market Overview (Power BI)
An executive-level dashboard summarizing the Austin Yelp market, with a focus on pricing and customer perception. This view illustrates the relationship between price tiers, average ratings, review engagement, and overall market composition.

**Primary audience:** Recruiters, hiring managers, non-technical stakeholders  
**Purpose:** High-level market understanding and business context

---

### Performance vs Expected Rating (Power BI)
An analytical dashboard built on top of a machine learning–based expected rating model. This view compares actual ratings to model-estimated expectations to identify businesses that over- or underperform relative to their peers.

**Primary audience:** Data and analytics practitioners  
**Purpose:** Model-driven performance diagnostics and competitive insight 

---

This project is designed to mirror how analytics and machine learning are applied
In a real business intelligence environment, with an emphasis on interpretability,
reproducibility, and business relevance.

