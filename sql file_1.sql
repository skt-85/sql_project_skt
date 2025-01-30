use employee;
/*Create a database named employee, then import data_science_team.csv proj_table.csv 
and emp_record_table.csv into the employee database from the given resources.

⦁	Create an ER diagram for the given employee database*/
/*⦁	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT
 from the employee record table, and make a list of employees and details of their department.*/
 select * from emp_record_table;
 select  EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT from emp_record_table;
/*⦁	Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING 
if the EMP_RATING is: 
⦁	less than two
⦁	greater than four 
⦁	between two and four*/
SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM
    emp_record_table
WHERE
    EMP_RATING < 2;
    SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM
    emp_record_table
WHERE
    EMP_RATING > 4 ;
 SELECT 
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    GENDER,
    DEPT,
    EMP_RATING
FROM
    emp_record_table
WHERE
    EMP_RATING between 2 and 4;
    
    /*⦁	Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees 
    in the Finance department from the employee table and then give the resultant
    column alias as NAME.*/

select * from emp_record_table;

SELECT 
    CONCAT(FIRST_NAME,' ', LAST_NAME) AS NAME 
FROM
    emp_record_table
WHERE
    DEPT = 'FINANCE';

select * from data_science_team ;
select * from proj_table;
SELECT manager_id, count(emp_id) 
FROM emp_record_table 
WHERE manager_id IS NOT NULL 
GROUP BY manager_id ORDER BY manager_id ASC;


/*⦁	Write a query to list down all the employees from the healthcare and finance departments
 using union. Take data from the employee record table.*/
 
SELECT 
    *
FROM
    emp_record_table
WHERE
    dept = 'healthcare' 
UNION SELECT 
    *
FROM
    emp_record_table
WHERE
    dept = 'finance' ;
    
/*⦁	Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE,
 DEPARTMENT, and EMP_RATING grouped by dept. Also include the respective
 employee rating along with the max emp rating for the department.*/   

SELECT emp_id, first_name, last_name, role, dept, 
max(emp_rating) over(partition by dept) as max_rating
FROM employee.emp_record_table
order by emp_id, emp_rating desc;


/*⦁	Write a query to calculate the minimum and the maximum salary of the employees in each role.
 Take data from the employee record table.*/
 
 select emp_id, concat(first_name," ",last_name) as fullname, role, max(salary) over (partition by role),min(salary) over (partition by role)
 from employee.emp_record_table
 order by SALARY desc;
 
 /*Write a query to assign ranks to each employee based on their experience.
 Take data from the employee record table.*/
 
 
 select emp_id, concat(first_name," ",last_name) as fullname , exp, rank() over(order by exp desc)
 from employee.emp_record_table;
 
 /* Write a query to create a view that displays employees in various countries whose salary
 is more than six thousand. Take data from the employee record table.*/
 
 
CREATE VIEW emp_country_view AS
    SELECT 
        emp_id,
        CONCAT(first_name, ' ', last_name) AS fullname,
        country,
        salary
    FROM
        employee.emp_record_table
    WHERE
        salary > 6000
    ORDER BY country , emp_id;

 select * from emp_country_view;
 
 /* ⦁	Write a nested query to find employees with experience of more than ten years. 
 Take data from the employee record table.*/
 
 SELECT 
    emp_id, CONCAT(first_name, ' ', last_name) AS fullname, exp
FROM
    (SELECT 
        *
    FROM
        employee.emp_record_table
    WHERE
        exp > 10
    ORDER BY exp) AS exp_greater_ten;
 
 /*⦁	Write a query to create a stored procedure to retrieve the details of the employees
 whose experience is more than three years.
 Take data from the employee record table*/
 
    delimiter //
    create procedure employee_details()
    begin 
    select  *
    FROM
        employee.emp_record_table
    WHERE
        exp > 3
	order by exp;
    end//
    delimiter //;

call employee_details();
 
/*Write a query to calculate the average salary distribution based on the continent and country.
 Take data from the employee record table.*/
 
SELECT 
    country, continent, AVG(salary)
FROM
    employee.emp_record_table
GROUP BY continent , country; 

/*Write a query to calculate the bonus for all the employees, 
 based on their ratings and salaries (Use the formula: 5% of salary * employee rating).*/
 
SELECT 
    emp_id,
    CONCAT(first_name, ' ', last_name) AS fullname,
    salary,
    emp_rating,
    salary * 0.05 * emp_rating AS bonus
FROM
    employee.emp_record_table
ORDER BY emp_rating DESC; 
/*Create an index to improve the cost and performance of the query to find the employee
 whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.*/
 
select * from employee.emp_record_table where first_name = "Eric";
create index f_index on employee.emp_record_table(first_name(10));
show index from employee.emp_record_table;

/*Write a query using stored functions in the project table to check whether the 
job profile assigned to each employee in the data science team matches 
the organization’s set standard.
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.*/


 delimiter $$
CREATE FUNCTION check_job_role(exp integer)
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
DECLARE chck VARCHAR(40);
if exp < 2 THEN SET chck = "JUNIOR DATA SCIENTIST";
elseif exp >=2 AND exp < 5 THEN SET chck = "ASSOCIATE DATA SCIENTIST";
elseif exp >=5 AND exp < 10 THEN SET chck = "SENIOR DATA SCIENTIST";
elseif exp >= 10 AND exp < 12 THEN SET chck = "LEAD DATA SCIENTIST";
elseif exp >= 12 THEN SET chck = "MANAGER";
end if; RETURN (chck);
END $$
delimiter ;
 
 
 SELECT 
    emp_id,
    CONCAT(first_name, ' ', last_name) AS fullname,
    CHECK_JOB_ROLE(exp)
FROM
    employee.data_science_team