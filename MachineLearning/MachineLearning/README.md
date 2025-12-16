# Machine Learning Models (Yelp-BI)

This folder contains machine learning workflows used to extend the Yelp-BI analytics
pipeline with predictive, business-facing insights. Each model is designed to produce
interpretable outputs that can be consumed directly by downstream BI dashboards rather
than treated as standalone prediction exercises.

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
- Linear regression used as a baseline
- Lasso regression selected as the final model for improved robustness and feature
  selection
- Shared preprocessing pipeline with imputation, scaling, and encoding

**Key Outputs**
- Predicted rating
- Rating delta (actual rating minus predicted rating)

**Status**
- Model finalized  
- Results exported to `data/kpi/expected_rating_results.csv`  
- Ready for Power BI integration  

---

### 2. Closure Risk Proxy Model (Completed)

Estimates **relative business closure risk** using observable Yelp signals related to
customer engagement, pricing strategy, customer perception, and competitive market
context.

Because true closure outcomes are not consistently available through the Yelp Fusion
API, this model does not perform binary closure prediction. Instead, it constructs an
interpretable risk framework that identifies businesses that appear more or less
vulnerable relative to peers.

**Approach**
- Standardized risk components derived from engagement, rating quality, pricing, and
  market density
- Interpretable closure risk score and risk buckets (Low, Medium, High)
- K-means clustering to identify distinct risk profiles
- Component-level risk decomposition to explain dominant drivers
- Market-level aggregation to surface structural risk patterns
- Optional proxy classification using logistic regression and random forest for internal
  validation

**Key Outputs**
- Closure risk score
- Risk bucket and risk profile
- Primary risk driver and component-level risk contributions

**Status**
- Model complete  
- Notebook: `ClosureRiskModel.ipynb`  
- Results exported for Power BI dashboarding  

---

## Notes

The machine learning models in this directory prioritize **interpretability,
contextual relevance, and downstream usability**. All outputs are designed to support
strategic analysis and visualization rather than black-box prediction, with clear
documentation of assumptions and limitations.

Future extensions may include multi-city risk modeling, temporal analysis, and
additional market-level segmentation as new data becomes available.
