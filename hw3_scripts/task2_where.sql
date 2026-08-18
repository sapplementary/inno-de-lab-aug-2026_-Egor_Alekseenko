/*
 * Выведите все заказы, у которых сумма (amount) больше 1000.
 */
SELECT
  *
FROM
  orders o
WHERE
  o.amount > 1000