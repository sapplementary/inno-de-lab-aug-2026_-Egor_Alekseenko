/*
 * Тест 1: В новой сессии подключиться как hr_user и попытаться
выполнить SELECT * FROM Employees.
Сработало
 */
SELECT
  *
FROM
  employees e
  
/*
Тест 3: Как hr_user, попробовать выполнить INSERT и UPDATE
сотрудника. (Теперь должно сработать).
 */
INSERT INTO
  employees (firstname, lastname, department, salary, email)
VALUES
  (
    'Egor',
    'Pharaon',
    'IT',
    100000,
    'innomail@company.com'
  )