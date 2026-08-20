/*
task3 dcl
1 action
Создать нового пользователя PostgreSQL (роль) с именем hr_user и
паролем.
*/
CREATE USER hr_user
WITH
  PASSWORD '12345'


/*
2 action
Предоставить hr_user право SELECT на таблицу Employees.
*/
GRANT
SELECT
  ON TABLE Employees TO hr_user

  
  /*Как пользователь-администратор, предоставить hr_user права
  INSERT и UPDATE на таблицу Employees.*/
GRANT INSERT,
UPDATE ON TABLE Employees TO hr_user