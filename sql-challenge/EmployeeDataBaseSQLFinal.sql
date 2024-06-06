--DATA ENGINEERING --

-- Drop Tables List
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

-- Creating Tables and Importing CSV Files
-- Exporting from QuickDBB

-- TABLE FOR DEPARTMENTS CSV

SELECT * FROM departments;

CREATE TABLE departments (
    dept_no VARCHAR(250) NOT NULL,
    dept_name VARCHAR(250) NOT NULL,
    CONSTRAINT prim_key_departments PRIMARY KEY (
	dept_no
	)
);

-- TABLE FOR DEPT_EMP CSV

SELECT * FROM dept_emp;

CREATE TABLE dept_emp (
	emp_no INT NOT NULL,
	dept_no VARCHAR(250) NOT NULL,
	CONSTRAINT prim_key_dept_emp PRIMARY KEY (
	emp_no, dept_no
	)
);

-- TABLE FOR DEBT_MANAGER CSV

SELECT * FROM dept_manager;

CREATE TABLE dept_manager (
	dept_no VARCHAR(250) NOT NULL,
	emp_no INT NOT NULL,
	CONSTRAINT prim_key_dept_manager PRIMARY KEY (
	dept_no, emp_no
	)
);

-- TABLE FOR EMPLOYEES CSV

SELECT * FROM employees;

CREATE TABLE employees (
	emp_no INT NOT NULL,
	emp_title_id VARCHAR(250) NOT NULL,
	birth_data DATE NOT NULL,
	first_name VARCHAR(250) NOT NULL,
	last_name VARCHAR(250) NOT NULL,
	sex VARCHAR(250) NOT NULL,
	hire_date DATE NOT NULL,
	CONSTRAINT prim_key_employees PRIMARY KEY (
	emp_no, emp_title_id
	)
);

-- TABLE FOR SALARIES CSV

SELECT * FROM salaries;

CREATE TABLE salaries (
	emp_no INT NOT NULL,
	salary INT NOT NULL,
	CONSTRAINT prim_key_salaries PRIMARY KEY (
	emp_no, salary
	)
);

-- TABLE FOR TITLES CSV

SELECT * FROM titles

CREATE TABLE titles (
	title_id VARCHAR(250) NOT NULL,
	title VARCHAR(250) NOT NULL,
	CONSTRAINT prim_key_titles PRIMARY KEY (
	title_id
	)
);

-- FOREIGN KEY LIST

-- DEPT_EMP CON: EMP_NO REF: EMPLOYEES
ALTER TABLE dept_emp ADD CONSTRAINT "for_key_emp_no" FOREIGN KEY (emp_no)
REFERENCES employees (emp_no);

-- DEPT_EMPT CON: DEPT_NO REF: EMPLOYEES
ALTER TABLE dept_emp ADD CONSTRAINT "for_key_dept_no" FOREIGN KEY (dept_no)
REFERENCES departments (dept_no);

-- DEPT_MANAGER CON: DEPT_NO REF: DEPARTMENTS
ALTER TABLE dept_manager ADD CONSTRAINT "for_key_manager_dept_no" FOREIGN KEY (dept_no)
REFERENCES departments (dept_no);

-- DEPT_MANAGER CON: EMP_NO REF: EMPLOYEES
ALTER TABLE dept_manager ADD CONSTRAINT "for_key__manager_emp_no" FOREIGN KEY (emp_no)
REFERENCES employees (emp_no);

-- EMPLOYEES CON: EMP_TITLE_ID REF: TITLES
ALTER TABLE employees ADD CONSTRAINT "for_key_employees_emp_title_id" FOREIGN KEY(emp_title_id)
REFERENCES titles (title_id);

-- SALARIES CON: EMP_NO REF: EMPLOYEES
ALTER TABLE salaries ADD CONSTRAINT "for_key_salaries_emp_no" FOREIGN KEY (emp_no)
REFERENCES employees (emp_no);

-- DATA ANALYSIS --

-- LISTING EMPLOYEE NUMBER, LAST NAME, FIRST NAME, SEX, SALARY

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
JOIN salaries
ON employees.emp_no = salaries.emp_no;

-- LISTING FIRST NAME, LAST NAME, HIRE DATE - FOR EMPLOYEES HIRED IN 1986

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date >= '1986-01-01'
AND hire_date <= '1986-12-31';

-- LISTING MANAGERS OF DEPARTMENTS BY DEPARTMENT NUMBER, DEPARTMENT NAME, EMPLOYEE NUMBER, LAST NAME, FIRST NAME

SELECT dept_manager.dept_no, department.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
JOIN department
ON dept_manager.dept_no = department.dept_no
JOIN employees
ON dept_manager.emp_no = employees.emp_no;

-- LISTING EMPLOYEES OF DEPARTMENTS BY EMPLOYEE NUMBER, LAST NAME, FIRST NAME, AND DEPARTMENT NAME

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no;

-- LISTING FIRST NAME, LAST NAME, AND SEX OF EMPLOYEES NAMED HERCULES B.

SELECT first_name, last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%';

-- LISTING SALES DEPARTMENT EMPLOYEES BY EMPLOYEE NUMBER, LAST NAME, AND FIRST NAME

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emo
ON dept_emp.emp_no = departments.dept_no
WHERE dept_name = 'Sales';

-- LISTINg EMPLOYEES IN SALES AND DEVELOPMENT DEPARTMENT BY EMPLOYEE NUMBER, LAST NAME, FIRST NAME, DEPARTMENT NAME

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM employees
JOIN dept_emp
ON dept_emp.emp_no = employees.emp_no
JOIN departments
ON dept_emp.dept_no = departments.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development';

-- LISTING FREQUENCY COUNTS IN DECENDING ORDER OF EMPLOYEE LAST NAMES

SELECT last_name, COUNT(last_name) AS "freq_count_of_last_names"
FROM employees
GROUP BY last_name
ORDER BY "freq_count_of_last_names" DESC;