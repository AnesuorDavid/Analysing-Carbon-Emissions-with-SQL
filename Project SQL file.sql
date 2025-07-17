-- PROJECT SQL FILE
-- Cheking availability of data
SELECT * 
FROM carbon_emissions;
-- Creating a staging table
CREATE TABLE carbon_data
LIKE carbon_emissions;

SELECT *
FROM carbon_data;

INSERT INTO carbon_data
SELECT *
FROM carbon_emissions;

SELECT *
FROM carbon_data;
-- DATA CLEANING
DELETE
FROM carbon_data
WHERE 
upstream_percent_total_pcf = 'N/a (product with insufficient stage-level data)'
AND operations_percent_total_pcf = 'N/a (product with insufficient stage-level data)'
AND downstream_percent_total_pcf = 'N/a (product with insufficient stage-level data)';
SELECT *
FROM carbon_data;
-- REMOVING % FROM THE THREE COLUMNS AND ADDING THEM TO THE NAME
UPDATE carbon_data
SET upstream_percent_total_pcf = REPLACE(upstream_percent_total_pcf, '%', ''),
    operations_percent_total_pcf = REPLACE(operations_percent_total_pcf, '%', ''),
    downstream_percent_total_pcf = REPLACE(downstream_percent_total_pcf, '%', '');
ALTER TABLE carbon_data
CHANGE COLUMN `upstream_percent_total_pcf` `upstream_percent_total_pcf (%)` TEXT(30);
ALTER TABLE carbon_data
CHANGE COLUMN `operations_percent_total_pcf` `operations_percent_total_pcf (%)` TEXT(30);
ALTER TABLE carbon_data
CHANGE COLUMN `downstream_percent_total_pcf` `downstream_percent_total_pcf (%)` TEXT(30);
SELECT *
FROM carbon_data;
-- QUESTION 1 Which industry groups have the highest total carbon footprint?
SELECT 
industry_group, SUM(carbon_footprint_pcf) AS total_emissions
FROM carbon_data
GROUP BY industry_group
ORDER BY total_emissions  DESC;
SELECT *
FROM carbon_data;
-- QUESTION 2 What is the average carbon footprint per product by industry?
SELECT 
industry_group, ROUND(AVG(carbon_footprint_pcf), 2) AS avg_emissions_per_product
FROM carbon_data
GROUP BY industry_group
ORDER BY avg_emissions_per_product  DESC;
SELECT product_name
FROM carbon_data
WHERE industry_group = 'Capital Goods';
-- QUESTION 3 Which industries have the highest emissions per kilogram of product?
SELECT 
product_name,
industry_group,
weight_kg,
carbon_footprint_pcf,
ROUND(carbon_footprint_pcf/ weight_kg, 2) As emissions_per_kg
FROM carbon_data
WHERE weight_kg >=0;
-- QUESTION 4 How are emissions distributed across upstream, operations, and downstream stages in each industry?
SELECT
industry_group,
carbon_footprint_pcf,
`upstream_percent_total_pcf (%)`,
`operations_percent_total_pcf (%)`,
`downstream_percent_total_pcf (%)`, ROUND(carbon_footprint_pcf/ weight_kg, 2) AS emissions_per_kg
FROM carbon_data
ORDER BY emissions_per_kg;
-- QUESTION 5 Which countries are associated with the highest emitting industries?
SELECT
industry_group,
carbon_footprint_pcf,
country, ROUND(carbon_footprint_pcf/ weight_kg, 2) AS emissions_per_kg
FROM carbon_data
ORDER BY emissions_per_kg;
-- QUESTION 6 What are the top 10 highest-emitting products overall?
SELECT
DISTINCT product_name,
ROUND(carbon_footprint_pcf/ weight_kg, 2) AS emissions_per_kg
FROM carbon_data
ORDER BY emissions_per_kg
LIMIT 10;

