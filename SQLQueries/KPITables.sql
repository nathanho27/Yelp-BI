-- ===============================================
-- File: KPITables.sql
-- Description: This script generates all KPI (Key Performance Indicator)
--              tables used for Business Intelligence reporting.
--
-- Purpose:
--   These tables aggregate and summarize the cleaned Yelp business data
--   to support Power BI dashboards and advanced analytics.
--   Each KPI is designed to highlight different aspects of:
--     • Pricing behavior
--     • Category competitiveness
--     • Geographic density
--     • Rating distributions
--     • Market opportunities
--     • Business momentum
--
-- Notes:
--   • All KPI tables reference yelp.businesses_clean
--   • KPI outputs are exported as CSV files for BI consumption
--   • These tables serve as inputs to dashboards and ML models
-- ===============================================



-- ===============================================
-- KPI 1: Price Level Summary
--
-- Description:
--   Summarizes business performance at each price tier ($, $$, $$$).
--   Useful for understanding rating trends and review volume by price.
--
-- Outputs:
--   price_level, business_count, avg_rating, avg_reviews
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_price_summary;

CREATE TABLE yelp.kpi_price_summary AS
SELECT
    price_level,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews
FROM yelp.businesses_clean
GROUP BY price_level
ORDER BY price_level;



-- ===============================================
-- KPI 2: Category Competitiveness
--
-- Description:
--   Evaluates how competitive each business category is by analyzing:
--     • number of businesses
--     • average rating
--     • review volume
--   A derived saturation score indicates crowded market segments.
--
-- Notes:
--   categories_title is comma-separated; it is split into rows.
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_category_competitiveness;

CREATE TABLE yelp.kpi_category_competitiveness AS
SELECT
    LOWER(TRIM(category)) AS category,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews,
    COUNT(*) * AVG(review_count) AS saturation_score
FROM (
    SELECT
        rating,
        review_count,
        unnest(string_to_array(categories_title, ',')) AS category
    FROM yelp.businesses_clean
) AS t
GROUP BY category
ORDER BY business_count DESC;



-- ===============================================
-- KPI 3: Rating Buckets
--
-- Description:
--   Segments businesses into rating tiers for BI segmentation:
--     • Low performers    (< 3.0 stars)
--     • Medium performers (3.0–4.0 stars)
--     • High performers   (≥ 4.0 stars)
--
-- Outputs:
--   business_id, name, rating, rating_bucket
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_rating_buckets;

CREATE TABLE yelp.kpi_rating_buckets AS
SELECT
    business_id,
    name,
    rating,
    CASE
        WHEN rating < 3.0 THEN 'Low (1–3 stars)'
        WHEN rating < 4.0 THEN 'Medium (3–4 stars)'
        ELSE 'High (4–5 stars)'
    END AS rating_bucket
FROM yelp.businesses_clean;



-- ===============================================
-- KPI 4: City Density KPI
--
-- Description:
--   Measures business concentration at the city level. Useful for:
--     • geographic analysis
--     • oversaturation detection
--     • market opportunity assessment
--
-- Outputs:
--   city, business_count, avg_rating, avg_reviews
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_city_density;

CREATE TABLE yelp.kpi_city_density AS
SELECT
    city,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews
FROM yelp.businesses_clean
GROUP BY city
ORDER BY business_count DESC;



-- ===============================================
-- KPI 5: Price × Rating Matrix
--
-- Description:
--   Creates a two-dimensional matrix for heatmap analysis.
--   Shows how many businesses fall into each (price_level × rounded_rating)
--   combination. Enables rating/price comparison visuals in BI dashboards.
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_price_rating_matrix;

CREATE TABLE yelp.kpi_price_rating_matrix AS
SELECT
    price_level,
    ROUND(rating) AS rounded_rating,
    COUNT(*) AS business_count
FROM yelp.businesses_clean
GROUP BY price_level, rounded_rating
ORDER BY price_level, rounded_rating;



-- ===============================================
-- KPI 6: Category Opportunity Score
--
-- Description:
--   Identifies categories with high demand but limited supply.
--   High scores represent strong business opportunities.
--
-- Formula:
--   opportunity_score = (avg_rating * avg_review_count) / business_count
--
-- Outputs:
--   category, business_count, avg_rating, avg_reviews, opportunity_score
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_category_opportunity;

CREATE TABLE yelp.kpi_category_opportunity AS
SELECT
    LOWER(TRIM(category)) AS category,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews,
    (AVG(rating) * AVG(review_count)) / COUNT(*) AS opportunity_score
FROM (
    SELECT
        rating,
        review_count,
        unnest(string_to_array(categories_title, ',')) AS category
    FROM yelp.businesses_clean
) AS t
GROUP BY category
ORDER BY opportunity_score DESC;



-- ===============================================
-- KPI 7: Review Momentum (Growth Proxy)
--
-- Description:
--   Estimates business traction using:
--       momentum_score = rating * ln(review_count + 1)
--   Higher values indicate stronger momentum and faster growth.
--
-- Outputs:
--   business_id, name, rating, review_count, momentum_score
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_review_momentum;

CREATE TABLE yelp.kpi_review_momentum AS
SELECT
    business_id,
    name,
    rating,
    review_count,
    rating * LN(review_count + 1) AS momentum_score
FROM yelp.businesses_clean
ORDER BY momentum_score DESC;
