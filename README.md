# Yelp Business Intelligence (Yelp-BI)

**Status: In Progress**

Yelp-BI is a data project that turns Yelp Fusion API data into structured insights, starting with a database pipeline and evolving into BI dashboards. The focus is analyzing competition, pricing, customer behavior, and market opportunity using a real analytics workflow.

This project follows a full data lifecycle:
**API ingestion → PostgreSQL (raw + clean) → SQL analytics → Power BI dashboards**

---

## Business Questions This Project Answers
- How do ratings and review volume compare across price categories?
- Which business types dominate different cities or neighborhoods?
- Where is competition highest, and where are underserved opportunities?
- Do higher-priced businesses actually get better reviews?
- Where should a new business open based on demand and competition?

---

## What This Project Delivers
- Postgres database storing raw and cleaned data layers
- SQL views and analytical tables for reporting and dashboard use
- Power BI dashboards focused on real business decisions
- Market competition and pricing insights
- Location-based opportunity analysis
- Clear visual breakdowns designed for non-technical stakeholders

---

## Data Source
- **Yelp Fusion API**  
  https://www.yelp.com/developers

---

## System Workflow
Yelp API → Python data collection → PostgreSQL (staging + cleaned tables)
→ SQL analysis → Power BI dashboards


---

## Power BI Dashboard Plans
- **Executive Summary:** Ratings, price distribution, review volume, top categories
- **Pricing vs Satisfaction:** Rating trends across price tiers
- **Category Performance:** Best and most competitive business segments
- **Location Insights:** Geographic clustering and opportunity heatmaps
- **Strategy View:** Recommendations based on data patterns

---

## Tech Stack
- **PostgreSQL** (database, queries, transformations)
- **Python** (API ingestion and automation)
- **SQL** (analytics and KPI creation)
- **Power BI** (visualization and storytelling)
- **Yelp Fusion API** (data source)

---

## Key Metrics
- Average rating by price level
- Review count distribution
- Business density per category and location
- Competitive saturation score
- Geographic opportunity scoring
- Rating vs price trend correlations

---

## Current Progress
- API data collected
---

## Next Steps
- Connect Python to PostgreSQL for automated data loading and validation  
- Import Yelp CSV into the database using a raw staging table  
- Profile and inspect data quality (nulls, formats, inconsistencies)  
- Create cleaned and typed analytical tables from staging  
- Build reusable SQL queries and views for core KPIs  
- Validate key metrics locally with Python (EDA + summary statistics)  
- Connect Power BI to PostgreSQL as the primary data source  
- Build initial dashboard visuals (pricing, ratings, location, competition)  
- Iterate on insights and add strategic recommendations  

---

This project will continue evolving as more insights, dashboards, and features are built out.

