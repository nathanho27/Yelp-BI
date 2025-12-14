-- ===============================================
-- File: RawSetup.sql
-- Description: This script sets up the raw data tables for Yelp BI analysis.
-- Purpose:
--   This file defines the schema for the raw Yelp businesses
--   table. This table acts as the staging layer for the
--   analytics pipeline and stores API-ingested JSON data in a
--   flattened relational format.
-- Notes:
--   Data is ingested using the Yelp Fusion API via Python.
--   Loading the CSV is performed in the psql terminal using the \copy command.
-- Example command:
--   \copy business FROM '/path/to/business.csv' DELIMITER ',' CSV HEADER;
-- ===============================================

-- Drop table if resetting the dataset (this is usesful because I was testing a lot)
DROP TABLE IF EXISTS yelp.raw_yelp_businesses;

-- Create the raw staging table
CREATE TABLE yelp.raw_yelp_businesses (
    search_location TEXT,
    search_category TEXT,
    business_id TEXT PRIMARY KEY,
    name TEXT,
    city TEXT,
    state TEXT,
    postal_code TEXT,
    address TEXT,
    latitude FLOAT,
    longitude FLOAT,
    rating FLOAT,
    review_count INT,
    price TEXT,
    phone TEXT,
    display_phone TEXT,
    categories_alias TEXT,
    categories_title TEXT,
    hours TEXT,
    photos TEXT,
    biz_url TEXT,
    is_closed BOOLEAN
);

-- Note: Actual data loading is performed outside of this script using the psql \copy command.
-- \copy yelp.raw_yelp_businesses 
-- FROM '/Users/nathanho/Desktop/YelpBI/Yelp-BI/data/raw/austin__tx_restaurants_businesses.csv'
-- WITH (FORMAT csv, HEADER true);

-- Verify data load
SELECT COUNT(*) FROM yelp.raw_yelp_businesses;
SELECT * FROM yelp.raw_yelp_businesses LIMIT 10;
