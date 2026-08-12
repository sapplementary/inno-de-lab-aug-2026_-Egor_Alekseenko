SELECT
  o.order_id,
  o.customer_id,
  o.item,
  o.amount,
  SUM(o.amount) OVER (
    PARTITION BY
      o.customer_id
  ) AS total_customer_amount
FROM
  Orders o
  JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY
  o.order_id