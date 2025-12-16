# Machine Learning Models (Yelp-BI)

This folder contains machine learning workflows used to extend the Yelp-BI analytics
pipeline with predictive, business-facing insights. Each model is designed to produce
interpretable outputs that can be consumed by downstream BI dashboards.

---

## Models

### 1. Expected Rating Model (Completed)

Predicts the expected Yelp rating of a business based on observable characteristics,
including:

- Price level  
- Review count  
- Business category  
- Geographic location  

**Approach**
- Linear Regression used as a baseline
- Lasso Regression selected as the final model for improved robustness
- Shared preprocessing pipeline with imputation, scaling, and encoding

**Key Outputs**
- Predicted rating
- Rating Delta (actual rating minus predicted rating)

**Status**
- Model finalized
- Results exported to `data/kpi/expected_rating_results.csv`
- Ready for Power BI integration

---

### 2. Closure Risk Proxy Model (In Progress)

Estimates relative business closure risk using observable Yelp signals associated
with business fragility and survivability.

This model reframes the problem from outcome prediction to risk identification,
producing interpretable risk scores and risk buckets rather than binary
classification when true closure labels are unavailable.

**Status**
- In development
- Notebook: `ClosureRiskModel.ipynb`
