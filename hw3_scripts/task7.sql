SELECT
  CONCAT(c.first_name, ' ', c.last_name) AS full_name,
  c.country,
  COUNT(o.order_id) AS total_orders,
  SUM(o.amount) AS total_amount
FROM
  customers c
  JOIN orders o ON c.customer_id = o.customer_id
  JOIN shippings s ON c.customer_id = s.customer
WHERE
  s.status = 'Delivered'
group BY
  c.customer_id,
  c.first_name,
  c.last_name,
  c.country
HAVING
  COUNT(o.order_id) >= 2