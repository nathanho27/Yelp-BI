# Yelp Business Intelligence (Yelp-BI)

**Status: In Progress**

Yelp-BI is a data project that turns Yelp Fusion API data into structured insights, starting with a database pipeline and evolving into BI dashboards. The focus is on analyzing competition, pricing, customer behavior, and market opportunity using a real analytics workflow.

This project follows a full lifecycle:
**API ingestion → PostgreSQL (raw + analytics) → SQL metrics → Power BI dashboards → Machine Learning**

---

## Business Questions This Project Answers
- How do ratings and review volume compare across price categories?
- Which business types dominate different cities or neighborhoods?
- Where is competition highest, and where are underserved opportunities?
- Do higher-priced businesses actually get better reviews?
- Where should a new business open based on demand and competition?
- Which businesses are **overperforming** or **underperforming** compared to expectations?
- Can we predict which businesses are **at risk of closure** based on historical and contextual signals?

---

## What This Project Delivers
- PostgreSQL database storing structured Yelp business data
- SQL views and analytical tables used for KPI reporting
- Power BI dashboards focused on real business and location strategy
- Competitive landscape breakdowns and pricing insights
- Interactive geographic analysis to identify market opportunities
- **Machine learning enhancements for predictive insights**

---

## Machine Learning Add-On (Phase 2)
After the dashboard foundation is complete, ML models will be integrated to create predictive analytics:

### Planned Models
- **Expected Rating Model (Regression):** Predict expected rating based on price, category mix, location, review volume, and hours.  
  → Identify **overperformers** and **hidden gems** using residual analysis.

- **Closure Risk Model (Classification):** Predict `p_closed` using business features and historical performance.  
  → Surface high-risk businesses for strategic recommendations.

- **Clustering / Segmentation:** Discover location-based and category similarity groups for competitive positioning.

### ML Stack
- **TensorFlow / Keras** (deep learning regression & classification)
- **Scikit-Learn** (baseline comparison models)
- **PostgreSQL storage** for model outputs and versioning
- **Power BI** visualization of predictions & cluster outcomes

---

## System Workflow
Yelp API → Python ingestion → PostgreSQL (staging + analytics)  
→ SQL KPI modeling → Power BI dashboards  
→ **TensorFlow ML outputs written back to PostgreSQL → BI visualization**

---

## Power BI Dashboard Plans
- **Executive Summary:** Price, rating, review volume, competitive density
- **Pricing vs Satisfaction:** Rating trends across price tiers
- **Category Performance:** Best and most competitive segments
- **Location Insights:** Opportunity heatmaps & business clusters
- **Strategic Recommendations:** Based on data patterns and ML predictions
- **Predictive Analytics:** Overperformers, closure risk, cluster segmentation

---

## Tech Stack
- **PostgreSQL**
- **Python**
- **SQL**
- **Power BI**
- **TensorFlow / Scikit-Learn** *(Phase 2)*
- **Yelp Fusion API**

---

## Key Metrics
- Average rating by price level
- Review count distribution
- Business density per category and location
- Competitive saturation score
- Geographic opportunity scoring
- Rating vs Price correlation insights
- **Predicted closure probability (planned)**
- **Rating expected vs actual residuals (planned)**

---

## Current Progress
- API data collection completed for sample region
- First raw dataset generated and validated
- PostgreSQL is connected, and the dataset is cleaned
- Load dataset into PostgreSQL
- Build staging → cleaned analytics tables

---

## Next Steps
- Create SQL views for KPI metrics
- Connect Power BI to PostgreSQL
- Build initial dashboard visuals
- Add strategic insights and storytelling layer
- Begin ML feature engineering phase
- Train baseline models (regression + classification)
- Write predictions back to SQL for Power BI
- Build a report for machine learning models

---

This project will continue evolving as more data, insights, and machine learning components are added.


