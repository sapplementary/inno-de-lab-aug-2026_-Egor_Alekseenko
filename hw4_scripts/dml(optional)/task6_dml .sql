/*
* Task 6: DML (Optional)
* 1 action
* . Найти ProjectName всех проектов, в которых 'Bob Johnson'
работал более 150 часов
*/
SELECT
  (e.firstname || ' ' || e.lastname) AS full_name,
  p.projectname,
  e2.hoursworked
FROM
  employees e
  JOIN employeeprojects e2 ON e.employeeid = e2.employeeid
  JOIN projects p ON e2.projectid = p.projectid
WHERE
  e.firstname = 'Bob'
  AND e.lastname = 'Johnson'
  AND e2.hoursworked >= 150

/*
 * 2 action
 *  Увеличить Budget всех проектов на 10%, если к ним назначен хотя
бы один сотрудник из отдела 'IT'
*/
UPDATE projects p
SET budget = budget * 1.10
WHERE EXISTS (
    SELECT 1
    FROM employeeprojects ep
    JOIN employees e
        ON ep.employeeid = e.employeeid
    WHERE ep.projectid = p.projectid
      AND e.department = 'Senior IT'
)

/*
 * 3 action
 * Для любого проекта, у которого еще нет EndDate (EndDate IS
NULL), установить EndDate на один год позже его StartDate.
*/

UPDATE projects
SET enddate = (startdate + INTERVAL '1 year')::date
WHERE enddate IS NULL

/*
 * 4 action
 * Вставить нового сотрудника и немедленно назначить его на проект
'Website Redesign' с 80 отработанными часами, все в рамках одной
транзакции. Использовать предложение RETURNING, чтобы получить
EmployeeID вновь вставленного сотрудника.
 */
BEGIN;

WITH new_employee AS (
    INSERT INTO employees (
        firstname,
        lastname,
        department,
        salary,
        email
    )
    VALUES (
        'Gleb',
        'Golubin',
        'IT',
        5000.00,
        'ddead_dynasty@gmail.com'
    )
    RETURNING employeeid
)
INSERT INTO employeeprojects (
    employeeid,
    projectid,
    hoursworked
)
SELECT
    ne.employeeid,
    p.projectid,
    80
FROM new_employee ne
JOIN projects p
    ON p.projectname = 'Website Redesign'
RETURNING employeeid;

COMMIT;
