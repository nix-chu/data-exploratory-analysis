DROP DATABASE IF EXISTS retail_sample;
CREATE DATABASE retail_sample;

-- Restart by dropping tables
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS retail_sample.district;
DROP TABLE IF EXISTS retail_sample.item;
DROP TABLE IF EXISTS retail_sample.times;
DROP TABLE IF EXISTS retail_sample.store;
DROP TABLE IF EXISTS retail_sample.sales;
SET FOREIGN_KEY_CHECKS = 1;

-- Creating tables

CREATE TABLE retail_sample.district (
	district_id INTEGER NOT NULL,
    district TEXT,
    district_manager TEXT,
    PRIMARY KEY (district_id)
);

LOAD DATA LOCAL INFILE 'C:/Users/JohnN/Documents/TheStuffOnHere/Projects/Sales_Return_Sample/CSV/District.csv' INTO TABLE retail_sample.district
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE retail_sample.item (
	item_id INTEGER NOT NULL,
    category TEXT,
    PRIMARY KEY (item_id)
);

LOAD DATA LOCAL INFILE 'C:/Users/JohnN/Documents/TheStuffOnHere/Projects/Sales_Return_Sample/CSV/Item.csv' INTO TABLE retail_sample.item
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE retail_sample.times (
	reporting_period INTEGER NOT NULL,
    period INTEGER(1) NOT NULL,
    fiscal_year INTEGER(4) NOT NULL,
    fiscal_month TEXT(3) NOT NULL,
    PRIMARY KEY (reporting_period)
);

LOAD DATA LOCAL INFILE 'C:/Users/JohnN/Documents/TheStuffOnHere/Projects/Sales_Return_Sample/CSV/Time.csv' INTO TABLE retail_sample.times
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE retail_sample.store (
	location_id INTEGER NOT NULL,
    city_name TEXT,
    territory TEXT(2),
    postal_code INTEGER(5),
    store_name TEXT,
    store_type TEXT,
    industry_chain TEXT,
    district_id INTEGER NOT NULL,
    open_year INTEGER(4),
    open_month TEXT(3),
    PRIMARY KEY (location_id),
    FOREIGN KEY (district_id) REFERENCES retail_sample.district(district_id)
);

LOAD DATA LOCAL INFILE 'C:/Users/JohnN/Documents/TheStuffOnHere/Projects/Sales_Return_Sample/CSV/Store.csv' INTO TABLE retail_sample.store
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

CREATE TABLE retail_sample.sales (
	sales_id INTEGER NOT NULL,
    month_id INTEGER(6),
    item_id INTEGER NOT NULL,
    location_id INTEGER NOT NULL,
    reporting_period INTEGER NOT NULL,
    sum_gross_margin_amount DECIMAL(6, 2),
    sum_regular_sales_dollars DECIMAL(6, 2),
    sum_markdown_sales_dollars DECIMAL(6, 2),
    sum_regular_sales_units BOOL,
    sum_markdown_sales_units BOOL,
    PRIMARY KEY (sales_id),
    FOREIGN KEY (item_id) REFERENCES retail_sample.item(item_id),
    FOREIGN KEY (location_id) REFERENCES retail_sample.store(location_id),
    FOREIGN KEY (reporting_period) REFERENCES retail_sample.times(reporting_period)
);

LOAD DATA LOCAL INFILE 'C:/Users/JohnN/Documents/TheStuffOnHere/Projects/Sales_Return_Sample/CSV/Sales2.csv' INTO TABLE retail_sample.sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;
