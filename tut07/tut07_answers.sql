DELIMITER //

-- 1. Calculate the average salary of employees in a given department
CREATE PROCEDURE AvgSalary(IN department_id_param INT)
BEGIN
    SELECT AVG(salary) AS average_salary
    FROM employees
    WHERE department_id = department_id_param;
END //

-- 2. Update the salary of an employee by a specified percentage
CREATE PROCEDURE NewSalary(
    IN emp_id_param INT,
    IN percentage DECIMAL(5,2)
)
BEGIN
    UPDATE employees
    SET salary = salary * (1 + percentage / 100)
    WHERE emp_id = emp_id_param;
END //

-- 3. List all employees in a given department
CREATE PROCEDURE ListEmployeesInDepartment(IN department_id_param INT)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = department_id_param;
END //

-- 4. Calculate the total budget allocated to a specific project
CREATE PROCEDURE CalculateProjectBudget(IN project_id_param INT)
BEGIN
    SELECT budget
    FROM projects
    WHERE project_id = project_id_param;
END //

-- 5. Find the employee with the highest salary in a given department
CREATE PROCEDURE FindHighestPaidEmployee(IN department_id_param INT)
BEGIN
    SELECT *
    FROM employees
    WHERE department_id = department_id_param
    ORDER BY salary DESC
    LIMIT 1;
END //

-- 6. List all projects that are due to end within a specified number of days
CREATE PROCEDURE ListProjectsEndingSoon(IN days_param INT)
BEGIN
    SELECT *
    FROM projects
    WHERE end_date <= CURDATE() + INTERVAL days_param DAY;
END //

-- 7. Calculate the total salary expenditure for a given department
CREATE PROCEDURE CalculateDepartmentSalaryExpenditure(IN department_id_param INT)
BEGIN
    SELECT SUM(salary) AS total_salary_expenditure
    FROM employees
    WHERE department_id = department_id_param;
END //

-- 8. Generate a report listing all employees along with their department and salary details
CREATE PROCEDURE GenerateEmployeeReport()
BEGIN
    SELECT e.*, d.department_name
    FROM employees e
    JOIN departments d ON e.department_id = d.department_id;
END //

-- 9. Find the project with the highest budget
CREATE PROCEDURE FindProjectWithHighestBudget()
BEGIN
    SELECT *
    FROM projects
    ORDER BY budget DESC
    LIMIT 1;
END //

-- 10. Calculate the average salary of employees across all departments
CREATE PROCEDURE CalculateOverallAverageSalary()
BEGIN
    SELECT AVG(salary) AS overall_average_salary
    FROM employees;
END //

-- 11. Assign a new manager to a department and update the manager_id in the departments table
CREATE PROCEDURE AssignNewManager(
    IN department_id_param INT,
    IN new_manager_id INT
)
BEGIN
    UPDATE departments
    SET manager_id = new_manager_id
    WHERE department_id = department_id_param;
END //

-- 12. Calculate the remaining budget for a specific project
CREATE PROCEDURE CalculateRemainingBudget(IN project_id_param INT)
BEGIN
    SELECT budget - SUM(salary) AS remaining_budget
    FROM projects p
    LEFT JOIN employees e ON p.project_id = e.project_id
    WHERE p.project_id = project_id_param;
END //

-- 13. Generate a report of employees who joined the company in a specific year
CREATE PROCEDURE GenerateEmployeeJoinReport(IN join_year INT)
BEGIN
    SELECT *
    FROM employees
    WHERE YEAR(join_date) = join_year;
END //

-- 14. Update the end date of a project based on its start date and duration
CREATE PROCEDURE UpdateProjectEndDate(
    IN project_id_param INT,
    IN duration INT
)
BEGIN
    UPDATE projects
    SET end_date = start_date + INTERVAL duration DAY
    WHERE project_id = project_id_param;
END //

-- 15. Calculate the total number of employees in each department
CREATE PROCEDURE CalculateEmployeeCountPerDepartment()
BEGIN
    SELECT d.department_name, COUNT(e.emp_id) AS employee_count
    FROM departments d
    LEFT JOIN employees e ON d.department_id = e.department_id
    GROUP BY d.department_id;
END //

DELIMITER ;
