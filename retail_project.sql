-- Customers Table
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    city VARCHAR(100)
);

-- Products Table
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    category VARCHAR(50),
    sub_category VARCHAR(50),
    cost NUMERIC(10,2)
);

-- Orders Table
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    order_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    product_id INT REFERENCES products(product_id),
    sales NUMERIC(10,2),
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);

-- Insert Customers
INSERT INTO customers (customer_name, segment, city)
VALUES 
('Ravi Kumar', 'Consumer', 'Delhi'),
('Sneha Sharma', 'Corporate', 'Mumbai'),
('Amit Singh', 'Home Office', 'Bangalore');

-- Insert Products
INSERT INTO products (category, sub_category, cost)
VALUES 
('Technology', 'Laptop', 40000),
('Furniture', 'Chair', 2000),
('Office Supplies', 'Paper', 200);

-- Insert Orders
INSERT INTO orders (order_date, customer_id, product_id, sales, discount, profit)
VALUES 
('2026-06-01', 1, 1, 45000, 0.10, 5000),
('2026-06-02', 2, 2, 1800, 0.25, -200),
('2026-06-03', 3, 3, 300, 0.05, 50);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;



SELECT p.category, SUM(o.profit) AS total_profit
FROM orders o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_profit ASC;






SELECT SUM(profit) AS total_profit_high_discount
FROM orders
WHERE discount > 0.20;


SELECT c.customer_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING COUNT(o.order_id) > 1;

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

SELECT 
    c.customer_name, 
    SUM(o.sales) AS total_spent, 
    AVG(o.profit) AS avg_profit_per_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


