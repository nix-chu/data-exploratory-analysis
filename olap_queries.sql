/* Top Performing Stores */

-- Which stores gain the most revenue?
SELECT s.location_id, l.store_name, l.store_type, l.territory, SUM(s.revenue) AS Revenue
FROM retail_sample.StoreFact s, retail_sample.LocationDim l
WHERE s.location_id = l.location_id
GROUP BY s.location_id, l.store_name, l.store_type, l.territory
ORDER BY Revenue DESC;

-- Which stores gain the most profit?
SELECT s.location_id, l.store_name, l.store_type, l.territory, SUM(s.profit) AS Profit
FROM retail_sample.StoreFact s, retail_sample.LocationDim l
WHERE s.location_id = l.location_id
GROUP BY s.location_id, l.store_name, l.store_type, l.territory
ORDER BY Profit DESC;

-- Which district is sells the most?
SELECT s.district_id, d.district_manager, SUM(s.revenue) as Revenue
FROM retail_sample.StoreFact s, retail_sample.DistrictDim d
WHERE s.district_id = d.district_id
GROUP BY s.district_id, d.district_manager
ORDER BY Revenue DESC;

/* Top Performing Items */

-- Which items are our best-sellers?
SELECT f.item_id, d.category, SUM(f.revenue) AS Revenue
FROM retail_sample.ItemFact f, retail_sample.ItemDim d
WHERE f.item_id = d.item_id
GROUP BY f.item_id, d.category
ORDER BY Revenue DESC;

-- Which items are profitable?
SELECT f.item_id, d.category, SUM(f.profit) AS Profit
FROM retail_sample.ItemFact f, retail_sample.ItemDim d
WHERE f.item_id = d.item_id
GROUP BY f.item_id, d.category
ORDER BY Profit DESC;

-- Which category is best-selling?
SELECT d.category, SUM(f.revenue) AS Revenue
FROM retail_sample.ItemFact f, retail_sample.ItemDim d
WHERE f.item_id = d.item_id
GROUP BY d.category
ORDER BY Revenue DESC;

SELECT d.category, SUM(f.profit) AS Profit
FROM retail_sample.ItemFact f, retail_sample.ItemDim d
WHERE f.item_id = d.item_id
GROUP BY d.category
ORDER BY Profit DESC;

/* General Stats */

-- How many stores per territory?
SELECT territory, COUNT(store_name) AS "Number of Stores"
FROM retail_sample.StoreFact s, retail_sample.LocationDim l
GROUP BY territory
ORDER BY COUNT(store_name) DESC;