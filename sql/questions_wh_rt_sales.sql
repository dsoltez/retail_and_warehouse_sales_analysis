SELECT *
FROM wh_and_rt_sales_clean;

-- Question: What are the total sales of each type?
-- 		- What are the retail sales of each item type?
-- 		- What are the warehouse sales of each item type?
-- 		- Answer each category and sale by either warehouse or retail



-- What are the total sales of each item type?
SELECT item_type,
	SUM(retail_sales + warehouse_sales) AS total_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('WINE', 'BEER', 'LIQUOR')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the retail sales of each item type?
SELECT item_type,
	SUM(retail_sales) AS retail_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('WINE', 'BEER', 'LIQUOR')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the warehouse sales of each item type?
SELECT item_type,
	SUM(warehouse_sales) AS warehouse_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('WINE', 'BEER', 'LIQUOR')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the warehouse sales of beer?
SELECT item_type,
	SUM(warehouse_sales) AS beer_wh_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('BEER')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the warehouse sales of wine?
SELECT item_type,
	SUM(warehouse_sales) AS wine_wh_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('WINE')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the warehouse sales of liquor?
SELECT item_type,
	SUM(warehouse_sales) AS liquor_wh_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('LIQUOR')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the retail sales of beer?
SELECT item_type,
	SUM(retail_sales) AS beer_rt_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('BEER')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the retail sales of wine?
SELECT item_type,
	SUM(retail_sales) AS wine_rt_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('WINE')
GROUP BY item_type
ORDER BY item_type DESC;

-- What are the retail sales of liquor?
SELECT item_type,
	SUM(retail_sales) AS liquor_rt_sales
FROM wh_and_rt_sales_clean
WHERE item_type IN ('LIQUOR')
GROUP BY item_type
ORDER BY item_type DESC;