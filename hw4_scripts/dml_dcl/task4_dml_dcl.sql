/*
 * task 4 dml
 * 1 action
 * Увеличить Salary всех сотрудников в отделе 'HR' на 10%.
 */
UPDATE employees e
SET
  salary = salary * 1.1
WHERE
  e.department = 'HR'

  
  /*
  * 2 action
  * Обновить Department любого сотрудника с Salary выше 70000.00
  на 'Senior IT'.
  */
UPDATE employees e
SET
  Department = 'Senior IT'
WHERE
  e.employeeid IN (
    SELECT
      e.employeeid
    FROM
      Employees
    WHERE
      e.salary > 70000.00
    LIMIT
      1
  );


/*
3 action
Удалить всех сотрудников, которые не назначены ни на один проект в
таблице EmployeeProjects. Подсказка: Используйте подзапрос NOT
EXISTS или LEFT JOIN
*/
DELETE FROM employees e
WHERE
  NOT EXISTS (
    SELECT
      1
    FROM
      employeeprojects e2
    WHERE
      e.employeeid = e.employeeid
  );


/*
4 action
В рамках одной транзакции, вставить новый проект и назначить на
него двух существующих сотрудников с определенным количеством
HoursWorked в EmployeeProjects.
*/
BEGIN;


WITH
  new_project AS (
    INSERT INTO
      projects (ProjectName, StartDate)
    VALUES
      ('New Project', CURRENT_DATE)
    RETURNING
      ProjectID
  )
INSERT INTO
  EmployeeProjects (EmployeeID, ProjectID, HoursWorked)
SELECT
  1,
  ProjectID,
  20
FROM
  new_project
UNION ALL
SELECT
  2,
  ProjectID,
  15
FROM
  new_project;


COMMIT;
