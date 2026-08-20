--task 1 dml
/*1 action
Вставить двух новых сотрудников в таблицу Employees (с любыми
отделами, кроме 'IT').
*/
INSERT INTO
  Employees (FirstName, LastName, Department, Salary)
VALUES
  ('Anna', 'Lee', 'Finance', 72000.00),
  ('Egor', 'Alekseenko', 'HR', 5000.00);

/*2 action
Выбрать всех сотрудников из таблицы Employees.
*/
SELECT
  *
FROM
  Employees;


/*3 action
Выбрать только FirstName и LastName сотрудников из отдела 'IT'.
*/
SELECT
  FirstName,
  LastName
FROM
  Employees
WHERE
  Department = 'IT';


/* 4 action
Обновить Salary 'Alice Smith' до 65000.00.
*/
UPDATE Employees
SET
  Salary = 65000.00
WHERE
  firstname = 'Alice'
  AND lastname = 'Smith'
  

  /*
  5 action
  Удалить сотрудника 'Eve Davis'.
  */
DELETE FROM employees
WHERE
  firstname = 'Eve'
  AND lastname = 'Davis'
  
  /*
  6 action
  Проверить все изменения, используя SELECT * FROM Employees
  */
SELECT
  *
FROM
  employees e
  
  
  
  