# 🍕 Pizza Sales Data Analysis (SQL Project)

## 📌 Project Overview
This project performs end-to-end relational database management and data analysis for a pizza restaurant chain using MySQL. It covers database schema setup, data cleaning, and key business metric extraction—ranging from basic aggregation to advanced analytical queries like window functions and Common Table Expressions (CTEs).

---

## 🗄️ Database Schema & Structure

The analysis is conducted on the `pizzaa` database, consisting of 4 interconnected tables:

1. **`orders`**: Tracks order dates and times (`order_id`, `orderDate`, `orderTime`).
2. **`order_details`**: Contains item-level order detail (`order_details_id`, `order_id`, `pizza_id`, `quantity`).
3. **`pizzas`**: Stores pizza variant pricing and sizes (`pizza_id`, `pizza_type_id`, `size`, `price`).
4. **`pizza_types`**: Stores pizza categorical metadata (`pizza_type_id`, `name`, `category`, `ingredients`).

```sql
CREATE DATABASE pizzaa;
USE pizzaa;

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    orderDate DATE,
    orderTime TIME
);
```

---

## 📊 Business Questions Analyzed

### 🔴 Basic Queries
1. **Total Orders:** Retrieve the total count of orders placed.
2. **Total Revenue:** Calculate total revenue generated from all pizza sales.
3. **Max Pricing:** Identify the highest-priced pizza item on the menu.
4. **Popular Size:** Find the most commonly ordered pizza size.
5. **Top 5 Items:** Identify the top 5 most ordered pizza types by quantity sold.

### 🟡 Intermediate Queries
6. **Category Breakdown:** Calculate total quantity ordered for each pizza category.
7. **Hourly Traffic:** Analyze order distribution across hours of the day to identify peak sales hours.
8. **Menu Diversity:** Count the distinct pizza options per category.
9. **Daily Averages:** Calculate the average number of pizzas ordered per day.
10. **Revenue Leaders:** Identify the top 3 pizza types driving total revenue.

### 🟢 Advanced Queries
11. **Category Revenue Contribution:** Calculate the percentage revenue contribution of each pizza category.
12. **Cumulative Revenue Over Time:** Analyze cumulative sales trajectory using SQL window functions (`SUM() OVER`).
13. **Top 3 Pizzas Per Category:** Rank the top 3 highest-revenue pizzas within each category using CTEs and `ROW_NUMBER()`.

---

## 🚀 Key SQL Concepts Demonstrated
* **DDL & DML Commands:** Database creation, table setup, and schema alteration (`ALTER TABLE`).
* **Joins:** Inner joining multiple tables (`pizzas`, `orders`, `order_details`, `pizza_types`).
* **Aggregations:** `SUM()`, `COUNT()`, `AVG()`, `MAX()`, and `GROUP BY` logic.
* **Date & Time Functions:** Extracting temporal metrics using `HOUR()`.
* **Advanced Analytics:** 
  * Subqueries & Nested Aggregations.
  * CTEs (Common Table Expressions).
  * Window Functions (`ROW_NUMBER() OVER()`, `SUM() OVER()`).

---

## 🛠️ How to Run the Queries
1. Clone or copy the SQL file from this repository.
2. Open your preferred SQL workbench (e.g., MySQL Workbench).
3. Import the required dataset tables (`orders`, `pizzas`, `order_details`, `pizza_types`).
4. Execute the schema setup script followed by the analysis queries sequentially.