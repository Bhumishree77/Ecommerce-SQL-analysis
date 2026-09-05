USE ecommerce;

SHOW TABLES;

SELECT * FROM customers LIMIT 5;

SELECT * FROM orders LIMIT 5;

SELECT * FROM items LIMIT 5;

USE ecommerce;

SELECT *
FROM customers
LIMIT 10;

SELECT
    customer_id,
    customer_city,
    customer_state
FROM customers
LIMIT 10;

SELECT
    customer_id,
    customer_city,
    customer_state
FROM customers
WHERE customer_state = 'SP'
LIMIT 10;

SELECT
    customer_id,
    customer_city,
    customer_state
FROM customers
ORDER BY customer_city
LIMIT 20;

SELECT
    customer_state,
    COUNT(*) AS total_customers
FROM customers
GROUP BY customer_state
ORDER BY total_customers DESC;

SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    SUM(price) AS total_sales
FROM items;

SELECT
    AVG(price) AS average_product_price
FROM items;

SELECT
    order_id,
    SUM(price) AS order_value
FROM items
GROUP BY order_id
ORDER BY order_value DESC
LIMIT 10;

USE ecommerce;

SELECT
    o.order_id,
    o.order_status,
    c.customer_city,
    c.customer_state
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
LIMIT 20;

USE ecommerce;

SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
LIMIT 20;

USE ecommerce;

SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_id,
    o.order_status
FROM customers c
RIGHT JOIN orders o
    ON c.customer_id = o.customer_id
LIMIT 20;

USE ecommerce;

SELECT
    order_id,
    SUM(price) AS order_value
FROM items
GROUP BY order_id
HAVING SUM(price) > (
    SELECT AVG(order_total)
    FROM (
        SELECT
            order_id,
            SUM(price) AS order_total
        FROM items
        GROUP BY order_id
    ) AS order_values
)
ORDER BY order_value DESC
LIMIT 20;

SELECT
    customer_id,
    customer_city,
    customer_state
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

USE ecommerce;

CREATE VIEW customer_order_summary AS
SELECT
    c.customer_id,
    c.customer_city,
    c.customer_state,
    COUNT(o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
GROUP BY
    c.customer_id,
    c.customer_city,
    c.customer_state;
    
    SELECT *
FROM customer_order_summary
LIMIT 20;

USE ecommerce;

CREATE INDEX idx_orders_customer_id
ON orders(customer_id);

SHOW INDEX FROM orders;

EXPLAIN
SELECT
    o.order_id,
    o.order_status,
    c.customer_city
FROM orders o
JOIN customers c
    ON o.customer_id = c.customer_id
WHERE o.customer_id = '...';

SELECT customer_id
FROM orders
LIMIT 1;

USE ecommerce;

SELECT
    order_id,
    order_status,
    order_delivered_customer_date
FROM orders
WHERE order_delivered_customer_date IS NULL
LIMIT 20;

SELECT
    order_id,
    order_status,
    COALESCE(order_delivered_customer_date, 'Not Delivered') AS delivery_date
FROM orders
LIMIT 20;
