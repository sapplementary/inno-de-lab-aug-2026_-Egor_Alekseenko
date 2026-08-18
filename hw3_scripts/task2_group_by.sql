/*
 * Посчитайте общее количество заказов и среднюю сумму по каждому товару.
 */
SELECT
  o.item,
  COUNT(o.item),
  AVG(o.amount) AS avg_amount
FROM
  orders o
GROUP BY
  o.item