# Analysing-Carbon-Emissions-with-SQL
To identify which industries and products contribute the most to global emissions and analyze their emissions intensity based on weight and production stage.
📁 Dataset Overview
The dataset includes over 1,000 records of Product Carbon Footprints (PCFs) with the following key fields:

product_name, company, country, industry_group

weight_kg – Weight of the product

carbon_footprint_pcf – Total emissions in kg CO₂e

upstream_percent_total_pcf, operations_percent_total_pcf, downstream_percent_total_pcf – Emission distribution across the supply chain

🔧 Steps Performed
Data Upload – Imported .csv file into MySQL using Workbench

Data Cleaning – Removed invalid rows, handled missing values, and converted percentage columns from text to float

Normalization – Renamed and restructured columns for clarity and precision

Aggregation & Analysis – Used SQL to summarize emissions by:

Industry group

Product type

Country of origin

Emissions per kg

Life cycle stage distribution

❓ Key Questions Explored
Which industries have the highest total carbon footprint?

What is the average carbon footprint per product by industry?

Which industries emit the most per kilogram of product?

How are emissions distributed between upstream, operational, and downstream processes?

Which countries are associated with the highest emitting industries?

What are the top 10 highest-emitting products?

📈 Tools Used
MySQL

MySQL Workbench

Excel (for preprocessing)

PDF documentation from the source study
