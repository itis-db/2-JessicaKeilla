/**
  @author
 */


INSERT INTO departments (department_name) VALUES
                                              ('Engineering'),
                                              ('Human Resources'),
                                              ('Marketing'),
                                              ('Sales'),
                                              ('Finance');
INSERT INTO employees (name, salary, department_id) VALUES
                                                        ('John Doe', 70000, 1),
                                                        ('Jane Smith', 65000, 1),
                                                        ('Alice Johnson', 55000, 2),
                                                        ('Bob Brown', 80000, 3),
                                                        ('Charlie Davis', 45000, 4);
INSERT INTO projects (project_name, start_date, end_date) VALUES
                                                              ('Project Alpha', '2023-01-01', '2023-06-30'),
                                                              ('Project Beta', '2023-02-15', NULL),
                                                              ('Project Gamma', '2023-03-01', '2023-12-31');

INSERT INTO employee_projects (employee_id, project_id) VALUES
                                                            (1, 1), -- John Doe no Project Alpha
                                                            (2, 1), -- Jane Smith no Project Alpha
                                                            (3, 2), -- Alice Johnson no Project Beta
                                                            (4, 3), -- Bob Brown no Project Gamma
                                                            (5, 3); -- Charlie Davis no Project Gamma

INSERT INTO salaries (employee_id, salary_amount, effective_date) VALUES
                                                                      (1, 70000, '2023-01-01'),
                                                                      (2, 65000, '2023-01-01'),
                                                                      (3, 55000, '2023-01-01'),
                                                                      (4, 80000, '2023-01-01'),
                                                                      (5, 45000, '2023-01-01');
-- version3.sql

WITH DepartmentAvgSalary AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM
        employees
    GROUP BY
        department_id
)
SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    e.salary,
    d.department_name
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.id
        JOIN
    DepartmentAvgSalary das ON e.department_id = das.department_id
WHERE
    e.salary > das.avg_salary;

SELECT
    id AS employee_id,
    name AS employee_name,
    salary,
    'High Salary' AS reason
FROM
    employees
WHERE
    salary > 70000
UNION
SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    e.salary,
    'Engineering Department' AS reason
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.id
WHERE
    d.department_name = 'Engineering';

SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    e.salary,
    'Salary > 60000' AS reason
FROM
    employees e
WHERE
    e.salary > 60000
UNION ALL
SELECT
    e.id AS employee_id,
    e.name AS employee_name,
    e.salary,
    'Project Alpha' AS reason
FROM
    employees e
        JOIN
    employee_projects ep ON e.id = ep.employee_id
        JOIN
    projects p ON ep.project_id = p.id
WHERE
    p.project_name = 'Project Alpha';
