-- 1. Display the first name and last name of all employees.
SELECT first_name, last_name FROM employees;

-- 2. List all departments along with their locations.
SELECT department_name, location FROM departments;

-- 3. Display the project names along with their budgets.
SELECT project_name, budget FROM projects;

-- 4. Show the first name, last name, and salary of all employees in the 'Engineering' department.
SELECT first_name, last_name, salary
FROM employees NATURAL JOIN departments
WHERE department_name = 'Engineering';

-- 5. List the project names and their corresponding start dates.
SELECT project_name, start_date FROM projects;

-- 6. Display the first name, last name, and department name of all employees.
SELECT first_name, last_name, department_name
FROM employees NATURAL JOIN departments;

-- 7. Show the project names with budgets greater than $90000.
SELECT project_name FROM projects WHERE budget > 90000;

-- 8. Write a SQL query to calculate the total budget allocated to projects.
SELECT SUM(budget) AS total_budget FROM projects;

-- 9. Display the first name, last name, and salary of employees earning more than $60000.
SELECT first_name, last_name, salary FROM employees WHERE salary > 60000;

-- 10. List the project names and their corresponding end dates.
SELECT project_name, end_date FROM projects;

-- 11. Show the department names with locations in 'North India' (Delhi or nearby regions).
SELECT department_name, location
FROM departments
WHERE location="New Delhi";

-- 12. Write a SQL query to calculate the average salary of all employees.
SELECT AVG(salary) AS average_salary FROM employees;

-- 13. Display the first name, last name, and department name of employees in the 'Finance' department.
SELECT first_name, last_name, department_name
FROM employees NATURAL JOIN departments
WHERE department_name = 'Finance';

-- 14. List the project names with budgets between $70000 and $100000.
SELECT project_name FROM projects WHERE budget BETWEEN 70000 AND 100000;

-- 15. Show the department names along with the count of employees in each department.
SELECT department_name, COUNT(emp_id) AS employee_count
FROM employees NATURAL JOIN departments
GROUP BY department_name;
