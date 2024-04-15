DELIMITER //

-- 1

CREATE TRIGGER IncreaseSalaryTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary < 60000 THEN
        SET NEW.salary = NEW.salary * 1.1;
    END IF;
END //

-- 2
CREATE TRIGGER PreventDepartmentDeleteTrigger
BEFORE DELETE ON departments
FOR EACH ROW
BEGIN
    DECLARE emp_count INT;
    SELECT COUNT(*) INTO emp_count FROM employees WHERE department_id = OLD.department_id;
    IF emp_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot delete department with assigned employees';
    END IF;
END //

-- 3
CREATE TRIGGER SalaryUpdateAuditTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO salary_audit (emp_id, old_salary, new_salary, employee_name, update_date)
    VALUES (OLD.emp_id, OLD.salary, NEW.salary, CONCAT(OLD.first_name, ' ', OLD.last_name), NOW());
END //

-- 4
CREATE TRIGGER AssignDepartmentTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.salary <= 60000 THEN
        SET NEW.department_id = 3; 
    END IF;
END //



-- 5
CREATE TRIGGER UpdateManagerSalaryTrigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    UPDATE employees
    SET salary = NEW.salary
    WHERE emp_id = (
        SELECT manager_id
        FROM departments
        WHERE department_id = NEW.department_id
    );
END //


-- 6
CREATE TRIGGER PreventDepartmentUpdateTrigger
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
    DECLARE project_count INT;
    SELECT COUNT(*) INTO project_count FROM works_on WHERE emp_id = OLD.emp_id;
    IF project_count > 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot update department for employee with project history';
    END IF;
END //



-- 7
CREATE TRIGGER UpdateAverageSalaryTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    SET average_salary = (
        SELECT AVG(salary)
        FROM employees
        WHERE department_id = d.department_id
    )
    WHERE d.department_id = NEW.department_id;
END //


-- 8

CREATE TRIGGER DeleteWorksOnTrigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    DELETE FROM works_on WHERE emp_id = OLD.emp_id;
END //



-- 9
CREATE TRIGGER PreventSalaryInsertTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    DECLARE min_salary DECIMAL(10,2);
    SELECT MIN_salary INTO min_salary FROM departments WHERE department_id = NEW.department_id;
    IF NEW.salary < min_salary THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Employee salary cannot be less than department minimum';
    END IF;
END //



-- 10
CREATE TRIGGER UpdateTotalBudgetTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    UPDATE departments d
    SET total_salary_budget = (
        SELECT SUM(salary)
        FROM employees
        WHERE department_id = d.department_id
    )
    WHERE d.department_id = NEW.department_id;
END //



-- 11
CREATE TRIGGER NewEmployeeEmailTrigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    CALL SendEmailToHR(NEW.emp_id, NEW.first_name, NEW.last_name);
END //


-- 12
CREATE TRIGGER PreventDepartmentInsertTrigger
BEFORE INSERT ON departments
FOR EACH ROW
BEGIN
    IF NEW.location IS NULL OR NEW.location = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Department location cannot be null';
    END IF;
END //



-- 13
CREATE TRIGGER UpdateEmployeeDepartmentNameTrigger
AFTER UPDATE ON departments
FOR EACH ROW
BEGIN
    UPDATE employees
    SET department_name = NEW.department_name
    WHERE department_id = NEW.department_id;
END //



-- 14
CREATE TRIGGER EmployeeInsertAuditTrigger
AFTER INSERT ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action_type, action_date)
    VALUES (NEW.emp_id, 'INSERT', NOW());
END //

CREATE TRIGGER EmployeeUpdateAuditTrigger
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action_type, action_date)
    VALUES (NEW.emp_id, 'UPDATE', NOW());
END //

CREATE TRIGGER EmployeeDeleteAuditTrigger
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
    INSERT INTO employee_audit (emp_id, action_type, action_date)
    VALUES (OLD.emp_id, 'DELETE', NOW());
END //



-- 15
CREATE TRIGGER GenerateEmployeeIDTrigger
BEFORE INSERT ON employees
FOR EACH ROW
BEGIN
    IF NEW.emp_id IS NULL THEN
        SET NEW.emp_id = NEXTVAL('employee_id_seq');
    END IF;
END //

DELIMITER ;
