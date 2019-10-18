-- create departments table
CREATE TABLE departments (
	dept_no VARCHAR PRIMARY KEY,
	dept_name VARCHAR 
);

--display the departments table
SELECT * FROM departments;


-- create dept_emp table
CREATE TABLE dept_emp(
	emp_no INT ,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
	dept_no VARCHAR,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
	from_date DATE,
	to_date DATE,
	PRIMARY KEY (emp_no, dept_no)	
);


-- display dept_emp table
SELECT * FROM dept_emp;

-- create dept_manager table
CREATE TABLE dept_manager (
	dept_no VARCHAR,
	emp_no INT,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);


-- display dept_manager table
SELECT * FROM dept_manager;

-- create employees table
CREATE TABLE employees(
	emp_no INT PRIMARY KEY,
	birth_date DATE,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	hire_date DATE
);

-- display the employees table 
SELECT * FROM employees;

-- create salaries table
CREATE TABLE salaries (
	emp_no INT PRIMARY KEY,
	salary INT,
	from_date DATE,
	to_date DATE
);

-- display the salaries table
SELECT * FROM salaries;

-- create titles table
CREATE TABLE titles(
	emp_no INT,
	title VARCHAR,
	from_date DATE,
	to_date DATE,
	FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- display the titles table
SELECT * FROM titles;

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT e.emp_no, e.last_name, e.first_name, e.gender, s.salary
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no;

--2. List employees who were hired in 1986.
SELECT * FROM employees
WHERE hire_date >= '1986-10-01' AND hire_date <= '1986-12-31';

-- 3. List the manager of each department with the following information: department number, department name,
--the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name, dm.from_date, dm.to_date
FROM dept_manager AS dm
LEFT JOIN departments AS d
ON d.dept_no = dm.dept_no
LEFT JOIN employees AS e
ON dm.emp_no = e.emp_no;


--4. List the department of each employee with the following information: employee number, last name, first name,
--and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON de.dept_no=d.dept_no;


--5. List all employees whose first name is "Hercules" and last names begin with "B."
SELECT * FROM employees
WHERE first_name = 'Hercules' AND last_name = 'B.%';

--6. List all employees in the Sales department, including their employee number, last name, first name,
--and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

--7. List all employees in the Sales and Development departments, including their employee number, last name,
--first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees AS e
LEFT JOIN dept_emp AS de
ON e.emp_no = de.emp_no
LEFT JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE dept_name IN ('Sales', 'Development');

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "last_name_count"
FROM employees 
GROUP BY last_name
ORDER BY last_name_count DESC;



