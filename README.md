# Retail Sales & Profitability Analysis (PostgreSQL)

A SQL practice project demonstrating data analysis skills using PostgreSQL — covering table design, joins, aggregations, and CTEs on a retail orders dataset.

---

## What This Project Covers

- Designing relational tables (Customers, Products, Orders) with foreign key relationships
- Writing analytical SQL queries to answer business questions
- Using JOINs, GROUP BY, HAVING, and CTEs (Common Table Expressions)

---

## Database Schema

Three tables connected via foreign keys:

- **customers** — customer_id, customer_name, segment, city
- **products** — product_id, category, sub_category, cost
- **orders** — order_id, order_date, customer_id, product_id, sales, discount, profit

---

## Queries & What They Answer

1. **Profit by Category** — Which product category is most/least profitable?
```sql
   SELECT p.category, SUM(o.profit) AS total_profit
   FROM orders o
   JOIN products p ON o.product_id = p.product_id
   GROUP BY p.category
   ORDER BY total_profit ASC;
```

2. **Impact of High Discounts on Profit** — Are high-discount orders hurting profitability?
```sql
   SELECT SUM(profit) AS total_profit_high_discount
   FROM orders
   WHERE discount > 0.20;
```

3. **Repeat Customers** — Which customers have placed more than one order?
```sql
   SELECT c.customer_name, COUNT(o.order_id) AS total_orders
   FROM customers c
   JOIN orders o ON c.customer_id = o.customer_id
   GROUP BY c.customer_name
   HAVING COUNT(o.order_id) > 1;
```

4. **Top Customer by Total Spend (using CTE)**
```sql
   WITH customer_sales AS (
       SELECT c.customer_id, c.customer_name, c.city, SUM(o.sales) AS total_sales
       FROM customers c
       JOIN orders o ON c.customer_id = o.customer_id
       GROUP BY c.customer_id, c.customer_name, c.city
   )
   SELECT customer_name, city, total_sales
   FROM customer_sales
   ORDER BY total_sales DESC
   LIMIT 1;
```

---

## Key Insight

The **Furniture** category showed a **negative total profit** despite generating sales — driven by a high discount (25%) on one order. This highlights how discounting strategy directly affects category-level profitability, even with healthy sales volume.

---

## Note

This is a small-scale practice dataset (manually created) used to demonstrate SQL querying technique — not a production-scale analysis. For a larger end-to-end project with a real dataset, see my [AtliQ Hardware Power BI Dashboard](https://github.com/kundan93334-hash/atliq-hardware-sales-dashboard) project, which includes PostgreSQL ETL, data modeling, and SQL-verified business insights.

---

## Files in this Repo

- `retail_project.sql` — all table creation, data, and queries
- `README.md` — this file
