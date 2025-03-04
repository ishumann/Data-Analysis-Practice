create table EMPLOYEEDEMOGRAPHICS
(EmployeeID int,
FirstName varchar(50),
LastName varchar(50),
Age int,
Gender varchar(50)
)

CREATE TABLE EMPLOYEESALARY
(EmployeeID int,
JobTitle varchar(50),
Salary int)


insert into EMPLOYEEDEMOGRAPHICS VALUES
(1001, 'Donald', 'Trump', 80, 'Male'),
(1002, 'Elon', 'Musk', 55, 'Male'),
(1003, 'alex', 'doe', 30, 'Male'),
(1004, 'john', 'doe', 21, 'Male'),
(1005, 'will', 'smith', 58, 'Male')


insert into EMPLOYEESALARY Values
(1001, 'Excutive', 4500000),
(1002, 'CEO', 50000000),
(1003, 'Manger', 100000),
(1004, 'Associate', 50000),
(1005, 'Accountatnt', 50000)



select count(LastName) as LastNameCount from EmployeeDemographic

select MAX(Salary)
from EMPLOYEESALARY


select Min(Salary)
from EMPLOYEESALARY