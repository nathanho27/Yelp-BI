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

Estimates **relative business closure risk** using observable Yelp signals related
to customer engagement, pricing, and competitive market context.

Because true closure outcomes are not consistently available through the Yelp
Fusion API, this model does not perform binary classification. Instead, it
produces an interpretable risk score, risk buckets, and risk profiles that
identify businesses that appear more or less vulnerable relative to peers.

**Status**
- In development  
- Notebook: `ClosureRiskModel.ipynb`
