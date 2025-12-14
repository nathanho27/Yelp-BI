-- ===============================================
-- File: CleanData.sql
-- Description: This script creates cleaned and transformed tables
-- Purpose:
--   This file defines the schema for the cleaned Yelp businesses
--   table. This table is derived from the raw staging table and is
--   optimized for analysis by transforming and cleaning the data.
-- Notes:
--   This script assumes that the raw data has already been loaded
--   into the yelp.raw_yelp_businesses table.
-- This table feeds into further analysis and BI reporting.
--     • KPI tables
--     • Power BI dashboards
--     • Machine learning models
-- ===============================================

-- Drop clean table for reproducibility
DROP TABLE IF EXISTS yelp.businesses_clean;

-- Create cleaned table
CREATE TABLE yelp.businesses_clean AS
SELECT
    business_id,
    TRIM(name) AS name,
    TRIM(city) AS city,
    TRIM(state) AS state,
    TRIM(address) AS address,
    TRIM(postal_code) AS postal_code,

    -- Cast numeric columns
    rating::FLOAT AS rating,
    review_count::INT AS review_count,

    -- Price comes as $, $$, $$$ — keep raw but engineer numeric level
    price,
    LENGTH(price) AS price_level,

    -- Treat null as not closed
    COALESCE(is_closed, FALSE) AS is_closed,

    -- Normalize categories for grouping in BI
    LOWER(TRIM(categories_alias)) AS categories_alias,
    LOWER(TRIM(categories_title)) AS categories_title,

    -- Geo coordinates
    latitude::FLOAT AS latitude,
    longitude::FLOAT AS longitude,

    -- Metadata from the search query (useful for multi-city datasets)
    search_location,
    search_category
FROM yelp.raw_yelp_businesses;

-- Verify cleaned data
SELECT COUNT(*) FROM yelp.businesses_clean;
SELECT * FROM yelp.businesses_clean LIMIT 10;

-- Note to actually work with this cleaned data, you have to export it or connect your BI tool to the database.
\copy (
    SELECT *
    FROM yelp.businesses_clean
) TO '/Users/nathanho/Desktop/YelpBI/Yelp-BI/data/clean/austin_clean.csv'
WITH (FORMAT csv, HEADER true);
