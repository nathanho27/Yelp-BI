# Yelp Business Intelligence Platform (Yelp-BI)

## Status

In Progress

---

## Overview

Yelp-BI is an end-to-end business intelligence and machine learning project that transforms Yelp Fusion API data into structured, actionable insights for local businesses. The project follows a real-world analytics workflow, starting with data ingestion and cleaning, moving through KPI modeling and SQL analytics, and culminating in machine learning models and Power BI dashboards.

The goal of this project is to answer practical business questions such as pricing strategy, competitive positioning, customer perception, and market opportunity using data-driven methods.

---

## Project Architecture

Yelp Fusion API → Python (Ingestion & Cleaning) → PostgreSQL / CSV (Modeled Data) → SQL KPIs → Machine Learning → Power BI Dashboards

---

## Current Focus: Machine Learning Models

The machine learning layer builds on top of a cleaned, modeled business-level dataset. Models are designed to produce interpretable, business-facing signals that can be directly consumed by BI dashboards.

### Expected Rating Model (In Progress)

**Objective**
Predict the expected Yelp rating of a business based on observable attributes such as price level, review volume, categories, city-level competition, and other engineered features.

**Why This Matters**
Comparing a business’s actual rating to its expected rating allows us to identify:

* Overperforming businesses that exceed expectations
* Underperforming businesses that may have improvement opportunities
* Category- and city-level patterns in customer satisfaction

**Model Type**
Regression

**Target Variable**

* Yelp rating

**Example Features**

* Review count
* Price level
* Business category
* City and location signals
* Competitive density

**Key Output Metric**

* Rating delta = actual rating minus predicted rating

This output is designed to be written back to the analytics layer and visualized in Power BI.

---

### Closure Risk Model (Planned)

**Objective**
Estimate the likelihood that a business is closed based on engagement, reviews, pricing, and competitive context.

**Model Type**
Classification

**Target Variable**

* is_closed

This model is intended to support risk monitoring and early warning signals for businesses.

---

## Folder Structure

* data/

  * raw: Raw Yelp API responses
  * clean: Cleaned and modeled datasets used for analytics and ML
  * kpi: KPI outputs generated from SQL queries

* SQLQueries/

  * SQL scripts used to generate KPI and analytics tables

* MachineLearning/

  * ExpectedRatingModel.ipynb
  * ClosureRiskModel.ipynb
  * README.md

* YelpData.py

  * Python script for Yelp API ingestion and preprocessing

---

## Tools & Technologies

* Python (pandas, numpy, scikit-learn)
* SQL (PostgreSQL-style analytics)
* Power BI
* Yelp Fusion API
* Git & GitHub

---

## Next Steps

* Complete feature engineering for the Expected Rating Model
* Train and evaluate baseline regression models
* Persist model predictions for BI consumption
* Integrate model outputs into Power BI dashboards
* Expand analysis beyond Austin to additional cities

---

This project is designed to mirror how analytics and machine learning are applied in a real business intelligence environment, with an emphasis on clarity, reproducibility, and business relevance.
