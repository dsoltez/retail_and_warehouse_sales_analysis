-- A. Cleaning wh_and_rt_sales

-- 1. Check for invalid numeric values
-- You are going to want to check this with any column that has a numeric value

-- Checking retail_sales
SELECT retail_sales
FROM wh_and_rt_sales_raw
WHERE retail_sales NOT REGEXP '^[0-9.-]+$';

-- Checking retail_transfers
SELECT retail_transfers
FROM wh_and_rt_sales_raw
WHERE retail_transfers NOT REGEXP '^[0-9.-]+$';

-- Checking warehouse_sales
SELECT warehouse_sales
FROM wh_and_rt_sales_raw
WHERE warehouse_sales NOT REGEXP '^[0-9.-]+$';

-- Checking month (should return only the column name)
SELECT month
FROM wh_and_rt_sales_raw
WHERE month NOT REGEXP '^[0-9]+$';

-- Checking year (should return only the column name)
SELECT year
FROM wh_and_rt_sales_raw
WHERE year NOT REGEXP '^[0-9]+$';


-- 2. Add cleaning logic directly into the VIEW
CREATE OR REPLACE VIEW wh_and_rt_sales AS
SELECT
    -- Clean year
    CAST(REPLACE(TRIM(year), 'ï»¿', '') AS UNSIGNED) AS year,

    -- Clean month
    CAST(TRIM(month) AS UNSIGNED) AS month,

    -- Clean text fields
    TRIM(supplier) AS supplier,
    TRIM(item_code) AS item_code,
    TRIM(item_description) AS item_description,
    TRIM(item_type) AS item_type,

    -- Clean numeric fields
    CAST(REGEXP_REPLACE(TRIM(retail_sales), '[^0-9.-]', '') AS DECIMAL(10,2)) AS retail_sales,
    CAST(REGEXP_REPLACE(TRIM(retail_transfers), '[^0-9.-]', '') AS DECIMAL(10,2)) AS retail_transfers,
    CAST(REGEXP_REPLACE(TRIM(warehouse_sales), '[^0-9.-]', '') AS DECIMAL(10,2)) AS warehouse_sales

FROM wh_and_rt_sales_raw;


-- 3. Create a final cleaned table
CREATE TABLE wh_and_rt_sales_clean AS
SELECT *
FROM wh_and_rt_sales;


-- 4. Cleaning Summary
-- The VIEW above performs all cleaning steps needed to make this dataset
-- usable for analysis. These include:
-- 1. Removing BOM characters
-- 2. Trimming whitespace
-- 3. Converting text numbers into DECIMAL
-- 4. Removing commas or stray characters from numeric fields
-- 5. Converting year/month into integers
--
-- Recreate the cleaned dataset yourself:
-- 1. Create the raw table
-- 2. Load the CSV with LOAD DATA INFILE
-- 3. Create the cleaning VIEW
-- 4. Query the VIEW or export a cleaned table


-- B. Checking for Duplicates

-- Let's check four columns first that shouldn't have any duplicates,
-- but always great to make sure.
SELECT
    year,
    month,
    item_code,
    COUNT(*) AS count
FROM wh_and_rt_sales_clean
GROUP BY year, month, item_code
HAVING COUNT(*) > 1;


-- C. Checking for Outliers

-- 1. Basic Distribution, checking for extreme negatives or positives
SELECT
    MIN(retail_sales) AS min_retail_sales,
    MAX(retail_sales) AS max_retail_sales,
    MIN(retail_transfers) AS min_retail_transfers,
    MAX(retail_transfers) AS max_retail_transfers,
    MIN(warehouse_sales) AS min_warehouse_sales,
    MAX(warehouse_sales) AS max_warehouse_sales
FROM wh_and_rt_sales_clean;


-- 2. Finding Hard Threshold Outliers

-- Bucket values into Quartiles
WITH ranked AS (
    SELECT
        retail_sales,
        NTILE(4) OVER (ORDER BY retail_sales) AS quartile
    FROM wh_and_rt_sales_clean
)
SELECT
    quartile,
    MIN(retail_sales) AS min_value,
    MAX(retail_sales) AS max_value
FROM ranked
GROUP BY quartile
ORDER BY quartile;

-- Identify values far outside the quartile ranges
WITH ranked AS (
    SELECT
        *,
        NTILE(4) OVER (ORDER BY retail_sales) AS quartile
    FROM wh_and_rt_sales_clean
)
SELECT *
FROM ranked
WHERE quartile = 1
   OR quartile = 4;

-- Hard threshold check
SELECT *
FROM wh_and_rt_sales_clean
WHERE retail_sales < -50 OR retail_sales > 3000
   OR retail_transfers < -100 OR retail_transfers > 2500
   OR warehouse_sales < -10000 OR warehouse_sales > 20000;


-- C. Standardizing Suppliers

SELECT DISTINCT supplier
FROM wh_and_rt_sales_clean
ORDER BY supplier;

-- Fixing known inconsistencies for each supplier

-- Updating Classic Wine Imports
UPDATE wh_and_rt_sales_clean
SET supplier = 'CLASSIC WINE IMPORTS'
WHERE supplier IN (
    'CLASSIC WINE IMPORTS INC',
    'CLASSIC WINE IMPORTS INC DBA VISION WINE'
);

-- Checking to make sure it successfully changed
SELECT *
FROM wh_and_rt_sales_clean
WHERE supplier LIKE 'CLASSIC WINE IMPORTS%';

-- Update Dogfish Head Brewery
UPDATE wh_and_rt_sales_clean
SET supplier = 'DOGFISH HEAD BREWERY LLC'
WHERE supplier IN (
    'DOGFISH HEAD CRAFT BREWERY LLC',
    'DOGFISH HEAD DISTILLERY LLC'
);

-- Checking to make sure it successfully changed
SELECT *
FROM wh_and_rt_sales_clean
WHERE supplier LIKE 'DOGFISH HEAD BREWERY LLC';

-- Update Freixenet company
UPDATE wh_and_rt_sales_clean
SET supplier = 'FREIXENET MIONETTO USA INC'
WHERE supplier = 'FREIXENET USA';

-- Updating Red Mountain Distilling and Spirits
UPDATE wh_and_rt_sales_clean
SET supplier = 'RED MOUNTAIN DISTILLING AND SPIRITS LLC'
WHERE supplier = 'RED MOUNTAIN DISTILLING & SPIRITS LLC';

-- Updating Southern Glazers W/S
UPDATE wh_and_rt_sales_clean
SET supplier = 'SOUTHERN GLAZERS WINE AND SPIRITS'
WHERE supplier = 'SOUTHERN WINE & SPIRITS OF MARYLAND';

-- Normalize the casing for supplier names (UPPERCASE)
UPDATE wh_and_rt_sales_clean
SET supplier = UPPER(supplier);