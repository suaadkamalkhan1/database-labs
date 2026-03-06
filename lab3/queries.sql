SELECT COUNT(*) AS total_orders,
       SUM(total_amount) AS total_revenue,
       ROUND(AVG(total_amount), 2) AS avg_order_value,
       MAX(total_amount) AS largest_order
FROM orders
WHERE status = 'delivered';

SELECT p.category,
       COUNT(DISTINCT oi.order_id) AS orders_containing,
       SUM(oi.quantity * oi.unit_price) AS category_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category
ORDER BY category_revenue DESC;

SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
       COUNT(*) AS num_orders,
       SUM(total_amount) AS monthly_revenue
FROM orders
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

SELECT c.city,
       COUNT(DISTINCT c.customer_id) AS customers,
       COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING COUNT(o.order_id) > 2
ORDER BY total_orders DESC;

SELECT device,
       COUNT(*) AS total_sessions,
       ROUND(AVG(duration_mins), 2) AS avg_duration,
       SUM(CASE WHEN converted THEN 1 ELSE 0 END) AS conversions,
       ROUND(
           100.0 * SUM(CASE WHEN converted THEN 1 ELSE 0 END) / COUNT(*),
           1
       ) AS conversion_rate_pct
FROM user_sessions
GROUP BY device
HAVING COUNT(*) >= 5
   AND AVG(duration_mins) > 15
ORDER BY conversion_rate_pct DESC;

SELECT customer_id,
       order_id,
       order_date,
       total_amount,
       ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY total_amount DESC
       ) AS rank_within_customer
FROM orders
ORDER BY customer_id, rank_within_customer;

WITH ranked_orders AS (
    SELECT customer_id,
           order_id,
           total_amount,
           ROW_NUMBER() OVER (
               PARTITION BY customer_id
               ORDER BY total_amount DESC
           ) AS rank_within_customer
    FROM orders
)
SELECT *
FROM ranked_orders
WHERE rank_within_customer = 1;


SELECT order_id,
       customer_id,
       total_amount,
       RANK() OVER (ORDER BY total_amount DESC) AS rank,
       DENSE_RANK() OVER (ORDER BY total_amount DESC) AS dense_rank
FROM orders
ORDER BY total_amount DESC
LIMIT 15;


