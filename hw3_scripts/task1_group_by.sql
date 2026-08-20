/*
 * Подсчитайте количество клиентов в каждой стране.
 */
SELECT
  c.country,
  COUNT(c.country)
FROM
  customers c
GROUP BY
  c.country