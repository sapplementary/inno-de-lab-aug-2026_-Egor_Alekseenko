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