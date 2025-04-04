--Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;
 
--Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;
 
--Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;
 
--Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales;
 
--Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT (DISTINCT order_id) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;
 

-- Daily Trend for Total Pizzas Sold
SELECT DATENAME(DW, order_date) AS order_day,
	   COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

-- Hourly Trend for Total Pizzas Sold
SELECT  DATEPART(HOUR, order_time) AS order_hour,
		SUM(quantity) AS Total_pizzas_sold
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)
 
-- Weekly Trend for Total Orders
SELECT DATEPART(ISO_WEEK, order_date) AS week_number, 
	   YEAR(order_date) AS Order_year,
	   COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
ORDER BY DATEPART(ISO_WEEK, order_date), YEAR(order_date)
 
-- Percentage of Sales by Pizza Category
SELECT pizza_category,
	   SUM(total_price) AS Total_Sales,
	   SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT_Sales
FROM pizza_sales 
GROUP BY pizza_category
  
--Percentage of Sales by Pizza Size
SELECT pizza_size,
	   CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_Sales,
	   CAST(SUM(total_price) * 100 /
	   (SELECT SUM(total_price) FROM pizza_sales WHERE DATEPART(quarter, order_date) = 1) AS DECIMAL(10, 2)) AS PCT_sales
FROM pizza_sales
WHERE DATEPART(quarter, order_date) = 1
GROUP BY pizza_size
ORDER BY PCT_sales DESC 
 
-- Total Pizzas Sold by Pizza Category
SELECT pizza_category,
	   SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
WHERE MONTH(order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC
	
--Top 5 Best Sellers by Revenue
SELECT TOP 5 pizza_name,
	   SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
 
--Lowest 5 by Revenue
SELECT TOP 5 pizza_name,
	   SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue ASC
 
--Top 5 Sellers by Quantity
SELECT TOP 5 pizza_name,
	   SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
 
--Lowest 5 Pizzas by Quantity
SELECT TOP 5 pizza_name,
	   SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC

--Top 5 Sellers by Total Orders
SELECT TOP 5 pizza_name,
	   COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC
 
--Lowest 5 Pizzas by Total Orders
SELECT TOP 5 pizza_name,
	   COUNT(DISTINCT order_id) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC
