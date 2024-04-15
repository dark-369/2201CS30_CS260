-- 1
SELECT first_name, last_name FROM employees;



-- 2
SELECT department_name, location FROM departments;


-- 3
SELECT project_name, budget FROM projects;



-- 4
SELECT first_name, last_name, salary
FROM employees NATURAL JOIN departments
WHERE department_name = 'Engineering';


-- 5
SELECT project_name, start_date FROM projects;



-- 6
SELECT first_name, last_name, department_name
FROM employees NATURAL JOIN departments;


-- 7
SELECT project_name FROM projects WHERE budget > 90000;


-- 8
SELECT SUM(budget) AS total_budget FROM projects;

-- 9
SELECT first_name, last_name, salary FROM employees WHERE salary > 60000;

-- 10
SELECT project_name, end_date FROM projects;


-- 11
SELECT department_name, location
FROM departments
WHERE location="New Delhi";


-- 12
SELECT AVG(salary) AS average_salary FROM employees;

-- 13
SELECT first_name, last_name, department_name
FROM employees NATURAL JOIN departments
WHERE department_name = 'Finance';



-- 14
SELECT project_name FROM projects WHERE budget BETWEEN 70000 AND 100000;



-- 15
SELECT department_name, COUNT(emp_id) AS employee_count
FROM employees NATURAL JOIN departments
GROUP BY department_name;
