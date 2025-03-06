
-- Sum of total Price
SELECT SUM(total_price) AS Sum_Of_TotalPrice FROM PizzaDB.pizza_sales;

-- Average Order value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Order_value FROM PizzaDB.pizza_sales;

-- Total Pizza Sold

SELECT SUM(quantity) AS Total_Pizza_Sold FROM PizzaDB.pizza_sales;

-- Total Order

SELECT COUNT(DISTINCT order_id) AS Total_Order FROM PizzaDB.pizza_sales;

-- Average Pizza Per Order

SELECT CAST(SUM(quantity)/COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Pizza_per_Order FROM PizzaDB.pizza_sales;

-- Hourly trend for pizza sold

SELECT HOUR(order_time) AS Order_Hour, SUM(quantity) AS Pizza_Sold FROM PizzaDB.pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);

-- Weekly trend for total orders

SELECT WEEK(order_time, 3) AS Week_Number, YEAR(order_time) AS Order_Year,COUNT(DISTINCT order_id) AS Pizza_Order FROM PizzaDB.pizza_sales
GROUP BY YEAR(order_time), WEEK(order_time, 3)
ORDER BY YEAR(order_time), WEEK(order_time, 3);

-- Percentage of Sales by Pizza Category
ALTER TABLE PizzaDB.pizza_sales 
ADD COLUMN temp_order_date DATE;

UPDATE PizzaDB.pizza_sales 
SET temp_order_date = STR_TO_DATE(order_date, '%d-%m-%Y');  

SELECT order_date 
FROM PizzaDB.pizza_sales 
WHERE temp_order_date IS NULL 
  AND order_date IS NOT NULL;
  
  SELECT * FROM PizzaDB.pizza_sales ;
  

SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) FROM PizzaDB.pizza_sales 
WHERE temp_order_date  BETWEEN '2015-01-01' AND '2015-01-31') AS PCT
FROM PizzaDB.pizza_sales
WHERE temp_order_date  BETWEEN '2015-01-01' AND '2015-01-31'
GROUP BY pizza_category;	

-- Percentage of Sales by Pizza Size

SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_sales, CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM PizzaDB.pizza_sales WHERE EXTRACT(QUARTER FROM temp_order_date) = 1)
 AS DECIMAL(10,2)) AS PCT
FROM PizzaDB.pizza_sales
WHERE EXTRACT(QUARTER FROM temp_order_date) = 1
GROUP BY pizza_size
ORDER BY pizza_size;

-- Top 5 Best Sellers by Revenue, Total Quantity and Total Orders

SELECT pizza_name, SUM(quantity) AS Pizza_quantity, COUNT(DISTINCT order_id) AS Order_number, SUM(total_price) AS total_price 
FROM PizzaDB.pizza_sales
GROUP BY pizza_name
ORDER BY total_price DESC LIMIT 5
	











