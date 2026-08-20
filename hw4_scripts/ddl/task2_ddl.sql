--task 2 ddl
/*1 action
Создать новую таблицу с именем Departments со столбцами:
DepartmentID (SERIAL PRIMARY KEY), DepartmentName
(VARCHAR(50), UNIQUE, NOT NULL), Location (VARCHAR(50)).
*/
CREATE TABLE Departments (
  DepartmentID   SERIAL PRIMARY KEY,
  DepartmentName VARCHAR(50) NOT NULL UNIQUE,
  Location       VARCHAR(50)
);

  /*2 action
  Изменить таблицу Employees, добавив новый столбец с именем
  Email (VARCHAR(100))
  */
ALTER TABLE Employees
ADD COLUMN Email VARCHAR(100)

/*3 action
Заполнить столбец Email для всех текущих сотрудников
уникальными значениями (например, через UPDATE)
*/
UPDATE Employees
SET
  Email = LOWER(FirstName || '.' || LastName || '@company.com');

/* 4 action
Добавить ограничение UNIQUE к столбцу Email в таблице
Employees
*/
ALTER TABLE Employees
ADD CONSTRAINT uqEmployeesEmail UNIQUE (Email);


/*
5 action
Переименовать столбец Location в таблице Departments в
OfficeLocation.
*/
ALTER TABLE Departments
RENAME COLUMN LOCATION TO OfficeLocation


