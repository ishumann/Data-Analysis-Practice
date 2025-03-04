create database company;
create table employee(empid int auto_increment Primary key,
first_name varchar(30),
last_name varchar(30),
salary int,
joining_date date,
department_name varchar(30)
);

insert into employee values
(1,'krish','naik', 50000, '2014-12-11', 'Development'),
(2,'sudhanshu','kumar', 60000, '2014-12-11', 'Development'),
(3,'sachin','yadav', 70000, '2014-12-11', 'Development'),
(4,'nitish','singh', 30000, '2014-12-11', 'HR'),
(5,'srikant','dube', 50000, '2014-01-10', 'Accountent'),
(6,'neal','smith', 120000, '2017-01-10', 'Excutive');

select * from employee;




# 1. Write an sql query to retreive all details where first name from employee
# table which starts with 'k'
select * from employee where employee.first_name like "K%";



# 2. Write an Sql query to print all details of the employees whose salary
# between 10000 to 35000
# approch 1
select * from employee WHERE salary between 10000 and 35000;
# approch 2
select * from employee WHERE salary >= 10000 and salary <= 35000;


##fetch Employee name

select concat(first_name,' ', last_name) as employee_name, 
concat('$ ',salary) as salary 
from employee where empid in
(select empid from employee WHERE 
salary between 10000 and 55000);



# SQL query to retrieve details of the employees who have joined on a date
select * from employee WHERE  year(joining_date) = 2014 and month(joining_date) = 1;


# 4. SQL query to fetch number of employees in every department
select count(*) from employee group by
department_name;
## fetch specific department name

select * from employee where department_name = 'Excutive';
	




#lntermediate

#5. SQL query to print details of the employee who are also Executives




#6. SQL query to clone a new table from another table








