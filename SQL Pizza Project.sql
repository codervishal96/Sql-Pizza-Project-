create database pizzaa;
use pizzaa;

SELECT * FROM orders;
desc orders;

drop table orders;

CREATE TABLE orders (
    orderID INT,
    orderDate DATE,
    orderTime TIME
);

drop table orders;

-- Rename the column

ALTER TABLE orders 
RENAME COLUMN orderID TO order_id;

-- Query the tables
SELECT * FROM orders;
SELECT * FROM pizzas;
SELECT * FROM order_details;
SELECT * FROM pizza_types;

---------------------------------------------------------------------------------------------------------------------

-- basic ---------------------
-- 1Retrive the total number of orders placed.

SELECT COUNT(order_id) FROM orders;

---------------------------------------------------------------------------------------------------

-- 2 Calculate the total revenue generated from pizza sales.

SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details AS od
JOIN pizzas AS p ON od.pizza_id = p.pizza_id;

----------------------------------------------------------------------------------------------------------

-- 3 Identify the highest-priced pizza.
SELECT MAX(price) AS max_price
FROM pizzas;
-------------------------------------------------------------------------------------------------

-- 4 Identify the most commonly ordered pizza size.

SELECT p.size, COUNT(od.order_details_id) AS order_count
FROM pizzas AS p
JOIN order_details AS od ON p.pizza_id = od.pizza_id
GROUP BY p.size
ORDER BY order_count DESC
LIMIT 1;

--------------------------------------------------------------------------------------------------

-- 5 List the top 5 most ordered pizza types along with their quantities. ----
SELECT 
    pt.name, SUM(od.quantity) AS total_quantity
FROM
    pizza_types pt
        JOIN
    pizzas p ON pt.pizza_type_id = p.pizza_type_id
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

---------------------------------------------------------------------------------------------------

-- Intermediate----
-- 6 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM pizza_types as pt
JOIN pizzas ON pt.pizza_type_id = pizzas.pizza_type_id
JOIN order_details as od ON od.pizza_id = pizzas.pizza_id
GROUP BY pt.category;

---------------------------------------------------------------------------------------------------
    
-- 7 Determine the distribution of orders by hour of the day.


SELECT 
    HOUR(orderTime) AS hour_of_day,
    COUNT(orderID) AS order_count
FROM
    orders
GROUP BY hour_of_day;


---------------------------------------------------------------------------------------------------
    
-- 8 Join relevant tables to find the category-wise distribution of pizzas.

SELECT category, COUNT(name) AS pizza_count
FROM pizza_types
GROUP BY category;

--------------------------------------------------------------------------------------------------
    
-- 9 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT ROUND(AVG(total_pizzas), 0) AS avg_pizzas_per_day
FROM (SELECT orders.orderDate, SUM(order_details.quantity) AS total_pizzas
FROM orders
JOIN order_details ON orders.orderID = order_details.order_id
GROUP BY orders.orderDate) AS daily_totals;

---------------------------------------------------------------------------------------------------

-- 10. Determine the top 3 most ordered pizza types based on revenue.

SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;


-- 11. Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    SUM(order_details.quantity * pizzas.price)
                FROM
                    order_details
                        JOIN
                    pizzas ON order_details.pizza_id = pizzas.pizza_id) * 100,
            2) AS revenue_percentage
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

---------------------------------------------------------------------------------------------------


-- 12 Analyze the cumulative revenue generated over time.

SELECT 
    date, 
    SUM(daily_revenue) OVER (ORDER BY date) AS cum_revenue
FROM (
    SELECT 
        o.orderDate AS date, 
        SUM(od.quantity * p.price) AS daily_revenue
    FROM order_details od
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    JOIN orders o ON od.order_id = o.order_id
    GROUP BY o.orderDate
) AS sales_summary;

---------------------------------------------------------------------------------------------------------


-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza category.

WITH ranked AS (
  SELECT pt.category, pt.name, SUM(od.quantity * p.price) revenue,
  ROW_NUMBER() OVER(PARTITION BY pt.category ORDER BY SUM(od.quantity * p.price) DESC) rn
  FROM order_details od JOIN pizzas p ON od.pizza_id = p.pizza_id
  JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
  GROUP BY pt.category, pt.name
)
SELECT category, name, revenue
FROM ranked WHERE rn <= 3
ORDER BY category, revenue DESC;


