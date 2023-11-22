# ScienceQtech Employee Performance Mapping

## Introduction

ScienceQtech is a startup specializing in Data Science, working on projects like fraud detection, market basket analysis, self-driving cars, and more. The HR department seeks insights into employee performance for the annual appraisal cycle. As a Junior Database Administrator, I've been tasked to handle the database and generate reports based on employee details, their performance, and project data.

## Database Setup

- **Database Name**: `employee`
- **Tables**:
  - `emp_record_table`: Employee details
  - `proj_table`: Project information
  - `data_science_team`: Data science team details

## Tasks Completed

1. **Database Creation**: 
   - Created the `employee` database.
   - Imported CSV data for tables.
2. **ER Diagram**: 
   ![ER](https://github.com/Divya-Pardeshi/ScienceQtech-Employee-Performance-Mapping/assets/114762794/f522eae9-a76d-414d-8399-1cd586036600)
3. **Employee Details**:
   - Fetched `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPARTMENT`.
4. **Employee Ratings**:
   - Retrieved `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `GENDER`, `DEPARTMENT`, and `EMP_RATING` based on conditions.
5. **Finance Department**:
   - Concatenated `FIRST_NAME` and `LAST_NAME` of Finance Department employees as 'NAME'.
6. **Employee Reporting**:
   - Listed employees with reporters and count, including the President.
7. **Healthcare & Finance Employees**:
   - Combined employees from healthcare and finance departments using `UNION`.
8. **Employee Details by Department**:
   - Listed `EMP_ID`, `FIRST_NAME`, `LAST_NAME`, `ROLE`, `DEPARTMENT`, and `EMP_RATING` grouped by department.
9. **Salary Analysis by Role**:
   - Calculated minimum and maximum salaries for each role.
10. **Employee Experience Ranks**:
    - Assigned ranks to employees based on experience.
11. **Salary View Creation**:
    - Created a view of employees with salaries over $6000 in different countries.
12. **Experience Filter**:
    - Queried employees with experience over ten years.
13. **Stored Procedure Creation**:
    - Built a procedure for employees with experience over three years.
14. **Stored Functions**:
    - Used functions to check job profiles in the data science team.
15. **Index Creation**:
    - Improved the performance of a query searching for employees by their first name.
16. **Bonus Calculation**:
    - Calculated bonuses for employees based on ratings and salaries.
17. **Salary Distribution**:
    - Analyzed average salary distribution based on continent and country.

## How to Use

1. **Database Setup**:
   - Download CSV files from the course resource section and import into the database.
2. **Executing Queries**:
   - Use MySQL or any compatible tool to execute the provided SQL queries.

## Thank You
Thank you for visiting this project. Your support and interest are greatly appreciated.

Please ⭐️ this repo and share it with others.
