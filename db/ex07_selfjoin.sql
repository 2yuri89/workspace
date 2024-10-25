CREATE TABLE employees ( 
    employee_id INT PRIMARY KEY, 
    employee_name VARCHAR(50), 
    manager_id INT, 
    FOREIGN KEY (manager_id) REFERENCES employees(employee_id) 
); 

INSERT INTO employees VALUES (1, 'John', NULL); 
INSERT INTO employees VALUES (2, 'Jane', 1); 
INSERT INTO employees VALUES (3, 'Bob', 2); 
INSERT INTO employees VALUES (4, 'Alice', 1); 
INSERT INTO employees VALUES (5, 'Charlie', 3); 

SELECT * FROM employees;

-- 사원 정보 조회 : 아이디, 이름, 매니저이름
-- 자기참조 테이블에서 JOIN할 때, SELF JOIN이다.
SELECT e1.employee_id, e1.employee_name, e2.employee_name
FROM employees e1				-- employee table
LEFT OUTER JOIN employees e2	-- manager table
ON e1.manager_id = e2.employee_id;




