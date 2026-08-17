/*
 task 5: functions and representations
функция: создать функцию postgresql с именем
calculateannualbonus, которая принимает employee_id и
salary в качестве входных данных и возвращает рассчитанную
сумму бонуса (10 % от salary) для этого сотрудника. используйте
pl/pgsql для тела функции.
*/
CREATE OR REPLACE FUNCTION CalculateAnnualBonus(
    employee_id INT,
    salary DECIMAL
)
RETURNS DECIMAL
LANGUAGE plpgsql
AS $$
DECLARE
    bonus_empl DECIMAL;
BEGIN
    bonus_empl := salary * 0.10;
    RETURN bonus_empl;
END;
$$;


/*
2 action
Использовать эту функцию в операторе SELECT, чтобы увидеть
потенциальный бонус для каждого сотрудника.
*/
SELECT
  e.employeeid,
  e.salary,
  CalculateAnnualBonus (e.employeeid, e.salary) AS bonus
FROM
  employees e
  
  /*
  3 action
  Представление (View): Создать представление с именем
IT_Department_View, которое показывает EmployeeID,
FirstName, LastName и Salary только для сотрудников из отдела
'IT'.
   */
CREATE OR REPLACE VIEW IT_Department_View as
select EmployeeID,
	FirstName,
	LastName,
	Salary
from employees у
where department = 'Senior IT'

/*
 * 4 action
 * Выбрать данные из вашего представления IT_Department_View
*/
SELECT * FROM IT_Department_View





