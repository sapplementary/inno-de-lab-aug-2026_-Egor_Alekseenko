/*
 * Выведите список доставок со статусом и именем клиента.
 */
SELECT
  s.status,
  c.first_name,
  c.last_name
FROM
  customers c
  JOIN shippings s ON c.customer_id = s.customer