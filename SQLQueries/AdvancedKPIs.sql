-- ===============================================
-- File: AdvancedKPI.sql
-- Description:
--     This script generates advanced, strategic-level KPI tables
--     for the Yelp Business Intelligence Platform. These KPIs
--     provide deeper competitive analysis, opportunity scoring,
--     and geospatial insights.
--
-- Purpose:
--     The KPIs in this file support:
--       • City × category saturation mapping
--       • Competitive pressure modeling
--       • Opportunity detection using weighted metrics
--       • Value-for-money performance scoring
--       • Geospatial clustering for BI heatmaps
--
-- Notes:
--     All KPIs derive from yelp.businesses_clean.
-- ===============================================



-- ===============================================
-- KPI 8: City × Category Saturation Matrix
--
-- Description:
--     Creates a matrix showing how many businesses operate within
--     each (city × category) combination. Supports heatmaps and
--     competitive landscape visuals.
--
-- Outputs:
--     city, category, business_count
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_city_category_matrix;

CREATE TABLE yelp.kpi_city_category_matrix AS
SELECT
    city,
    LOWER(TRIM(category)) AS category,
    COUNT(*) AS business_count
FROM (
    SELECT
        city,
        unnest(string_to_array(categories_title, ',')) AS category
    FROM yelp.businesses_clean
) t
GROUP BY city, category
ORDER BY city, business_count DESC;



-- ===============================================
-- KPI 9: Competitive Pressure Index
--
-- Description:
--     Measures category-level competitiveness within each city.
--     Higher pressure indicates a crowded, high-volume market.
--
-- Formula:
--     pressure_index = business_count * avg_reviews / avg_rating
--
-- Outputs:
--     city, category, business_count, avg_rating,
--     avg_reviews, pressure_index
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_competitive_pressure;

CREATE TABLE yelp.kpi_competitive_pressure AS
SELECT
    city,
    LOWER(TRIM(category)) AS category,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews,
    (COUNT(*) * AVG(review_count)) / NULLIF(AVG(rating), 0) AS pressure_index
FROM (
    SELECT
        city,
        rating,
        review_count,
        unnest(string_to_array(categories_title, ',')) AS category
    FROM yelp.businesses_clean
) t
GROUP BY city, category
ORDER BY pressure_index DESC;



-- ===============================================
-- KPI 10: Weighted Opportunity Score
--
-- Description:
--     Enhanced opportunity detection combining category demand
--     (rating × review count) with geographic supply (city density).
--
-- Formula:
--     weighted_opportunity = (avg_rating * avg_reviews / business_count)
--                             * (1 / city_business_count)
--
-- Outputs:
--     city, category, weighted_opportunity_score
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_weighted_opportunity;

CREATE TABLE yelp.kpi_weighted_opportunity AS
WITH city_counts AS (
    SELECT city, COUNT(*) AS city_business_count
    FROM yelp.businesses_clean
    GROUP BY city
)
SELECT
    t.city,
    LOWER(TRIM(category)) AS category,
    (AVG(rating) * AVG(review_count) / COUNT(*))
        * (1.0 / city_counts.city_business_count) AS weighted_opportunity_score
FROM (
    SELECT
        city,
        rating,
        review_count,
        unnest(string_to_array(categories_title, ',')) AS category
    FROM yelp.businesses_clean
) t
JOIN city_counts ON t.city = city_counts.city
GROUP BY t.city, category, city_counts.city_business_count
ORDER BY weighted_opportunity_score DESC;



-- ===============================================
-- KPI 11: Market Value Score
--
-- Description:
--     Evaluates value-for-money by adjusting rating relative to
--     price level. A higher score indicates exceptional quality
--     for the price.
--
-- Formula:
--     market_value = rating / (price_level + 1)
--
-- Outputs:
--     business_id, name, rating, price_level, market_value
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_market_value;

CREATE TABLE yelp.kpi_market_value AS
SELECT
    business_id,
    name,
    rating,
    price_level,
    rating / (price_level + 1) AS market_value
FROM yelp.businesses_clean
ORDER BY market_value DESC;



-- ===============================================
-- KPI 12: Geo Cluster Approximation
--
-- Description:
--     Simulates geospatial clustering using rounded lat/lon.
--     This groups businesses into small geographic cells for
--     heatmaps and concentration visualizations.
--
-- Outputs:
--     geo_cluster_id, business_count, avg_rating, avg_reviews
-- ===============================================

DROP TABLE IF EXISTS yelp.kpi_geo_clusters;

CREATE TABLE yelp.kpi_geo_clusters AS
SELECT
    CONCAT(
        ROUND(latitude::NUMERIC, 2), '_',
        ROUND(longitude::NUMERIC, 2)
    ) AS geo_cluster_id,
    COUNT(*) AS business_count,
    AVG(rating) AS avg_rating,
    AVG(review_count) AS avg_reviews
FROM yelp.businesses_clean
GROUP BY geo_cluster_id
ORDER BY business_count DESC;
