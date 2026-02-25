SET GLOBAL local_infile = 1;

CREATE DATABASE IF NOT EXISTS walmart_db;
USE walmart_db;

drop table if exists walmart_sales;
CREATE TABLE walmart_sales (
    store INT,
    sales_date DATE,
    weekly_sales DECIMAL(12,2),
    holiday_flag INT,
    temperature FLOAT,
    fuel_price FLOAT,
    cpi FLOAT,
    unemployment FLOAT
);

LOAD DATA LOCAL INFILE 'C:/Users/Gayatri V S/Downloads/Walmart.csv'
INTO TABLE walmart_sales
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(store, @sales_date, weekly_sales, holiday_flag, temperature, fuel_price, cpi, unemployment)
SET sales_date = STR_TO_DATE(@sales_date, '%d-%m-%Y');

select*from walmart_sales
limit 5;

SELECT COUNT(*) FROM walmart_sales;

SELECT DISTINCT store FROM walmart_sales ORDER BY store;

SELECT 
  MIN(sales_date) AS start_date,
  MAX(sales_date) AS end_date
FROM walmart_sales;

SELECT * FROM walmart_sales
WHERE store = 1;

SELECT 
  DATE_FORMAT(sales_date, '%Y-%m') AS month,
  SUM(weekly_sales) AS monthly_sales
FROM walmart_sales
WHERE store = 1
GROUP BY month
ORDER BY month;

SELECT 
  YEAR(sales_date) AS year,
  SUM(weekly_sales) AS yearly_sales
FROM walmart_sales
WHERE store = 1
GROUP BY year
ORDER BY year;

SELECT 
  holiday_flag,
  AVG(weekly_sales) AS avg_sales
FROM walmart_sales
WHERE store = 1
GROUP BY holiday_flag;

SELECT 
  ROUND(AVG(cpi),2) AS avg_cpi,
  ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
WHERE store = 1;

SELECT
  YEAR(sales_date) AS year,
  ROUND(SUM(weekly_sales),2) AS yearly_sales
FROM walmart_sales
WHERE store = 1
GROUP BY year
ORDER BY year;

SELECT
  holiday_flag,
  COUNT(*) AS weeks,
  ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
WHERE store = 1
GROUP BY holiday_flag;

SELECT
  DATE_FORMAT(sales_date, '%Y-%m') AS month,
  SUM(weekly_sales) AS monthly_sales
FROM walmart_sales
WHERE store = 1
GROUP BY month
ORDER BY monthly_sales DESC
LIMIT 5;

SELECT
  store,
  ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY store
ORDER BY avg_sales DESC;

DROP VIEW IF EXISTS store1_monthly_sales;

CREATE VIEW store1_monthly_sales AS
SELECT 
  DATE_FORMAT(sales_date, '%Y-%m') AS month,
  SUM(weekly_sales) AS monthly_sales
FROM walmart_sales
WHERE store = 1
GROUP BY month;

