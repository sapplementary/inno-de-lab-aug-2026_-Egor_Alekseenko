/*
 * 7 action
 * Найдите клиентов, которые:
1. Сделали хотя бы 2 заказа (любых),
2. Имеют хотя бы одну доставку со статусом 'Delivered'
Для каждого такого клиента выведите:
full_name (имя + фамилия),
общее количество заказов,
общую сумму заказов,
страну проживания.
 */
SELECT
  CONCAT(c.first_name, ' ', c.last_name) AS full_name,
  c.country,
  COUNT(o.order_id) AS total_orders,
  SUM(o.amount) AS total_amount
FROM
  customers c
  JOIN orders o ON c.customer_id = o.customer_id
  WHERE c.customer_id IN (
    SELECT s.customer
    FROM shippings AS s
    WHERE s.status = 'Delivered'
)
GROUP BY
  c.customer_id,
  c.first_name,
  c.last_name,
  c.country
HAVING
  COUNT(o.order_id) >= 2