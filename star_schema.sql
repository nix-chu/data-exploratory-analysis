-- Drop tables upon restart
DROP TABLE IF EXISTS retail_sample.ItemDim;
DROP TABLE IF EXISTS retail_sample.DistrictDim;
DROP TABLE IF EXISTS retail_sample.LocationDim;
DROP TABLE IF EXISTS retail_sample.TimeDim;
DROP TABLE IF EXISTS retail_sample.StoreFact;
DROP TABLE IF EXISTS retail_sample.ItemFact;

-- Build dimension tables
CREATE TABLE retail_sample.ItemDim AS SELECT * FROM retail_sample.item;

CREATE TABLE retail_sample.DistrictDim AS SELECT district_id, district_manager FROM retail_sample.district;

CREATE TABLE retail_sample.LocationDIm AS
	SELECT location_id, store_name, city_name, territory, store_type, open_year
    FROM retail_sample.store;

CREATE TABLE retail_sample.TimeDIm AS 
	SELECT DISTINCT month_id, period
    FROM retail_sample.sales s, retail_sample.times t
    WHERE s.reporting_period = t.reporting_period;

-- Build fact tables
CREATE TABLE retail_sample.StoreFact AS
	SELECT t.location_id,
		t.district_id,
        a.month_id,
        ROUND(SUM(A.sum_regular_sales_dollars * A.sum_regular_sales_units + A.sum_markdown_sales_dollars * A.sum_markdown_sales_dollars), 2) AS Revenue,
        SUM(A.sum_gross_margin_amount) AS Profit
	FROM retail_sample.sales a, retail_sample.store t
    WHERE a.location_id = t.location_id
    GROUP BY location_id, district_id, month_id
    ORDER BY location_id, district_id, month_id;

CREATE TABLE retail_sample.ItemFact AS
	SELECT i.item_id,
		s.location_id,
        s.month_id,
        ROUND(SUM(s.sum_regular_sales_dollars * s.sum_regular_sales_units + s.sum_markdown_sales_dollars * s.sum_markdown_sales_dollars), 2) AS Revenue,
        SUM(s.sum_gross_margin_amount) AS Profit
	FROM retail_sample.item i, retail_sample.sales s
    WHERE i.item_id = s.item_id
    GROUP BY item_id, location_id, month_id
    ORDER BY item_id, location_id, month_id;

SELECT 'district_id', 'district_manager'
UNION ALL
SELECT * FROM retail_sample.DistrictDim
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DistrictDim.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';

SELECT 'location_id', 'store_name', 'city_name', 'territory', 'store_type', 'open_year'
UNION ALL
SELECT * FROM retail_sample.LocationDim
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/LocationDim.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';

SELECT 'item_id', 'location_id', 'month_id', 'Revenue', 'Profit'
UNION ALL
SELECT * FROM retail_sample.ItemFact
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ItemFact.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';

SELECT 'item_id', 'category'
UNION ALL
SELECT * FROM retail_sample.ItemDim
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ItemDim.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';

SELECT 'month_id', 'period'
UNION ALL
SELECT * FROM retail_sample.TimeDim
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TimeDim.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';

SELECT 'location_id', 'district_id', 'month_id', 'Revenue', 'Profit'
UNION ALL
SELECT * FROM retail_sample.StoreFact
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/StoreFact.csv'
FIELDS ENCLOSED BY '"' 
TERMINATED BY ',' 
LINES TERMINATED BY '\n';