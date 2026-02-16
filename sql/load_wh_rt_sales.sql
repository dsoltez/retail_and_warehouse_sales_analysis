-- This dataset is originally a TSV (tab‑separated) file.
-- Excel will corrupt it if you open/save it directly, so we load it
-- into a raw table first. This avoids BOM issues, delimiter problems,
-- extra columns, and row truncation during import.


-- 1. Create a raw table to store the dataset
CREATE TABLE wh_and_rt_sales_raw
(
    year VARCHAR(50),
    month VARCHAR(50),
    supplier VARCHAR(255),
    item_code VARCHAR(255),
    item_description VARCHAR(255),
    item_type VARCHAR(50),
    retail_sales VARCHAR(50),
    retail_transfers VARCHAR(50),
    warehouse_sales VARCHAR(50)
);


-- 2. Load the dataset into the raw table you just created.
--    This is the most important step.
--    Make sure to unhide your 'ProgramData' folder if it is hidden.
--    This is the only place where MySQL can automatically load files.
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Warehouse_and_Retail_Sales.csv'
INTO TABLE wh_and_rt_sales_raw
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
IGNORE 1 ROWS
(
    year,
    month,
    supplier,
    item_code,
    item_description,
    item_type,
    retail_sales,
    retail_transfers,
    warehouse_sales
);


-- 3. Create a view on top of the raw table
CREATE OR REPLACE VIEW wh_and_rt_sales AS
SELECT
    CAST(REPLACE(year, 'ï»¿', '') AS UNSIGNED) AS year,
    CAST(month AS UNSIGNED) AS month,
    TRIM(supplier) AS supplier,
    TRIM(item_code) AS item_code,
    TRIM(item_description) AS item_description,
    TRIM(item_type) AS item_type,
    CAST(retail_sales AS DECIMAL(10,2)) AS retailsales,
    CAST(retail_transfers AS DECIMAL(10,2)) AS retail_transfers,
    CAST(warehouse_sales AS DECIMAL(10,2)) AS warehouse_sales
FROM wh_and_rt_sales_raw;


-- 4. Query to make sure everything is working properly
SELECT *
FROM wh_and_rt_sales
LIMIT 50;