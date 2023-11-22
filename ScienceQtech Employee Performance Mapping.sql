#Q1) Create a database named employee, then import data_science_team.csv proj_table.csv and emp_record_table.csv into the employee database from the given resources. 
-- Create the employee database if it doesn't exist
CREATE DATABASE IF NOT EXISTS employee;

-- Switch to the employee database
USE employee;

-- Show tables in the employee database
SHOW TABLES;

# Q3)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, and DEPARTMENT from the employee record table, and make a list of employees and details of their department.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT
FROM emp_record_table;







#Q4)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: a) less than two b) greater than four c) between two and four
#a) less than two: Employees with EMP_RATING less than two:

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2;




#Q4)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
#b) greater than four: Employees with EMP_RATING greater than four:
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING > 4;
#Q4)Write a query to fetch EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPARTMENT, and EMP_RATING if the EMP_RATING is: 
#b) between two and four:Employees with EMP_RATING between two and four:
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING >= 2 AND EMP_RATING <= 4;



#Q5)Write a query to concatenate the FIRST_NAME and the LAST_NAME of employees in the Finance
# department from the employee table and then give the resultant column alias as NAME.

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

#Q6) Write a query to list only those employees who have someone reporting to them. Also, show the number of reporters (including the President).
SELECT E.EMP_ID, E.FIRST_NAME, E.LAST_NAME, E.ROLE, E.EXP,
    (SELECT COUNT(*) 
     FROM emp_record_table R 
     WHERE R.MANAGER_ID = E.EMP_ID
    ) AS NUM_REPORTERS
FROM emp_record_table E
WHERE E.EMP_ID = 1 OR E.EMP_ID IN (SELECT DISTINCT MANAGER_ID FROM emp_record_table WHERE MANAGER_ID IS NOT NULL)
ORDER BY E.EMP_ID;
#Q7)Write a query to list down all the employees from the healthcare and finance departments using union. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'HEALTHCARE'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT
FROM emp_record_table
WHERE DEPT = 'FINANCE'
ORDER BY DEPT,EMP_ID;


#Q8)Write a query to list down employee details such as EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPARTMENT, and EMP_RATING grouped by dept. 
#Also include the respective employee rating along with the max emp rating for the department.

SELECT
    EMP_ID,
    FIRST_NAME,
    LAST_NAME,
    ROLE,
    DEPT,
    EMP_RATING,
    MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_DEPT_RATING
FROM
    emp_record_table
ORDER BY
    DEPT;
    
    
#Q9)Write a query to calculate the minimum and the maximum salary of the employees in each role. Take data from the employee record table.
SELECT ROLE, MAX(SALARY) AS MAX_SALARY, MIN(SALARY) AS MIN_SALARY
FROM emp_record_table
WHERE ROLE IN ('PRESIDENT', 'LEAD DATA SCIENTIST', 'SENIOR DATA SCIENTIST', 'MANAGER', 'ASSOCIATE DATA SCIENTIST', 'JUNIOR DATA SCIENTIST')
GROUP BY ROLE;
#Q10)Write a query to assign ranks to each employee based on their experience. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
       RANK() OVER (ORDER BY EXP) AS EXP_RANK
FROM emp_record_table;

DROP VIEW IF EXISTS employees_in_various_countries;


#Q11)Write a query to create a view that displays employees in various countries whose salary is more than six thousand. Take data from the employee record table.
CREATE VIEW employees_in_various_countries AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, COUNTRY, SALARY
FROM emp_record_table
WHERE SALARY > 6000;

SELECT *FROM employees_in_various_countries;

#Q12)Write a nested query to find employees with experience of more than ten years. Take data from the employee record table.
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP > 10;

#Q13) Write a query to create a stored procedure to retrieve the details of the employees whose experience is more than three years. Take data from the employee record table.                 
 DELIMITER &&
CREATE PROCEDURE get_experience_details()
BEGIN
SELECT EMP_ID,FIRST_NAME,LAST_NAME,EXP FROM emp_record_table WHERE EXP>3;
END &&
CALL get_experience_details();

#Q14) Write a query using stored functions in the project table to check whether the job profile assigned to each employee in the data science team matches the organization’s set standard.
/*
The standard being:
For an employee with experience less than or equal to 2 years assign 'JUNIOR DATA SCIENTIST',
For an employee with the experience of 2 to 5 years assign 'ASSOCIATE DATA SCIENTIST',
For an employee with the experience of 5 to 10 years assign 'SENIOR DATA SCIENTIST',
For an employee with the experience of 10 to 12 years assign 'LEAD DATA SCIENTIST',
For an employee with the experience of 12 to 16 years assign 'MANAGER'.
*/
DELIMITER //
CREATE FUNCTION Employee_ROLE(EXP INT)
RETURNS VARCHAR(40)
DETERMINISTIC
BEGIN
    DECLARE EmployeeRole VARCHAR(40);

    IF EXP <= 2 THEN
        SET EmployeeRole = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP > 2 AND EXP <= 5 THEN
        SET EmployeeRole = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP > 5 AND EXP <= 10 THEN
        SET EmployeeRole = 'SENIOR DATA SCIENTIST';
    ELSEIF EXP > 10 AND EXP <= 12 THEN
        SET EmployeeRole = 'LEAD DATA SCIENTIST';
    ELSEIF EXP > 12 AND EXP <= 16 THEN
        SET EmployeeRole = 'MANAGER';
    ELSE
        SET EmployeeRole = 'UNKNOWN';
    END IF;

    RETURN EmployeeRole;
END //

DELIMITER ;
SELECT EXP, Employee_ROLE(EXP) AS EmployeeRole
FROM data_science_team;


#Q15)Create an index to improve the cost and performance of the query to find the employee whose FIRST_NAME is ‘Eric’ in the employee table after checking the execution plan.
CREATE INDEX idx_first_name
ON emp_record_table(FIRST_NAME(20));
SELECT * FROM emp_record_table
WHERE FIRST_NAME='Eric';



#Q16)Write a query to calculate the bonus for all the employees, based on their ratings and salaries (Use the formula: 5% of salary * employee rating).
SELECT 
    EMP_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    SALARY, 
    EMP_RATING, 
    (SALARY * EMP_RATING * 0.05) AS BONUS
FROM 
    emp_record_table;
#Q17)Write a query to calculate the average salary distribution based on the continent and country. Take data from the employee record table.
SELECT 
    CONTINENT,
    COUNTRY,
    AVG(SALARY) AS AVERAGE_SALARY
FROM 
    emp_record_table
GROUP BY 
    CONTINENT, COUNTRY;





















