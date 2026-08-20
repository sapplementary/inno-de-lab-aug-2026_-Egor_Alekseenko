
/*
 * Найдите всех клиентов из страны 'USA'
, которым больше 25 лет.
 */
SELECT
  c.first_name,
  c.last_name,
  c.age,
  c.country
FROM
  customers c
WHERE
  c.country = 'USA'
  AND c.age > 25