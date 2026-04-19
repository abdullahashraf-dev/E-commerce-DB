-- 1- Daily Revenue Calculation
SELECT 
    '2025-04-18' AS revenue_date, 
    SUM(total_amount) AS daily_revenue
FROM `E-commerce-DB`.orders 
WHERE order_date >= '2025-04-18' AND order_date < '2025-04-19';

-- 2- Top Selling Products
SELECT 
p.name,
sum(od.quantity) AS total_quantity
FROM products p 
JOIN order_details od on p.product_id = od.product_id
JOIN orders o on  od.order_id = o.order_id
WHERE o.order_date >= '2025-04-01'
  AND o.order_date < '2025-05-01'
  group by od.product_id
  order by total_quantity DESC

-- 3- Customers Who Spent More Than $500 in the Last Month
SELECT 
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    SUM(o.total_amount) AS total_spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL 1 MONTH
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING total_spent > 500
ORDER BY total_spent DESC;