 Employee Performance Mapping Project using MYSQL

Employee Database Management
This repository contains SQL scripts and queries for managing and analyzing an employee database. The database includes tables such as emp_record_table, data_science_team, and proj_table. The following tasks are accomplished through these queries:

Database Structure
Employee Record Table: Stores the details of employees including their ID, first name, last name, gender, department, role, salary, experience, rating, and more.

Data Science Team Table: Contains specific information related to employees in the data science team.

Project Table: Holds information about projects assigned to employees.

Tasks and Queries
Entity-Relationship Diagram: Create an ER diagram for the employee database to visualize the relationships between different tables.

Fetching Employee Details:

Query to retrieve EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT.

Additional filters to fetch employee details based on their EMP_RATING (less than 2, greater than 4, and between 2 and 4).

Concatenating Names: Combine FIRST_NAME and LAST_NAME for employees in the Finance department and display the result as NAME.

Union of Departments: List all employees from the healthcare and finance departments using UNION.

Grouping by Department: List employee details grouped by department, including their ratings and the maximum rating in the department.

Salary Calculations: Calculate the minimum and maximum salary for employees in each role.

Experience-Based Ranking: Assign ranks to employees based on their experience.

Views:

Create a view displaying employees in various countries with a salary of more than six thousand.

Nested Queries: Find employees with experience of more than ten years.

Stored Procedures:

Create a stored procedure to retrieve the details of employees with more than three years of experience.

Average Salary Distribution: Calculate the average salary distribution based on continent and country.

Bonus Calculation: Calculate the bonus for employees based on their ratings and salaries.

Indexing: Create an index to improve the performance of queries for employees whose FIRST_NAME is ‘Eric’.

Stored Functions:

Create a function to check whether the job profile assigned to each employee in the data science team matches the organization's set standards based on their experience.

Usage
Import Data: Import data_science_team.csv, proj_table.csv, and emp_record_table.csv into the employee database.

Run Queries: Execute the provided SQL queries to perform various operations such as fetching data, calculating salaries, creating views, and more.

Performance Optimization: Use indexes to optimize query performance.

Stored Procedures and Functions: Utilize stored procedures and functions to streamline repetitive tasks and enforce data integrity.

Conclusion
This repository provides a comprehensive set of SQL queries and scripts to efficiently manage and analyze employee data. The queries cover a wide range of tasks from basic data retrieval to advanced calculations and performance optimization.
