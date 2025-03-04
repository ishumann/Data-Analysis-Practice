
--Create Table EmployeeDemographics 
--(EmployeeID int, 
--FirstName varchar(50), 
--LastName varchar(50), 
--Age int, 
--Gender varchar(50)
--)

----Table 2 Query:
--Create Table EmployeeSalary 
--(EmployeeID int, 
--JobTitle varchar(50), 
--Salary int
--)



----Table 1 Insert:
--Insert into EmployeeDemographics VALUES
--(1001, 'Jim', 'Halpert', 30, 'Male'),
--(1002, 'Pam', 'Beasley', 30, 'Female'),
--(1003, 'Dwight', 'Schrute', 29, 'Male'),
--(1004, 'Angela', 'Martin', 31, 'Female'),
--(1005, 'Toby', 'Flenderson', 32, 'Male'),
--(1006, 'Michael', 'Scott', 35, 'Male'),
--(1007, 'Meredith', 'Palmer', 32, 'Female'),
--(1008, 'Stanley', 'Hudson', 38, 'Male'),
--(1009, 'Kevin', 'Malone', 31, 'Male')

----Table 2 Insert:
--Insert Into EmployeeSalary VALUES
--(1001, 'Salesman', 45000),
--(1002, 'Receptionist', 36000),
--(1003, 'Salesman', 63000),
--(1004, 'Accountant', 47000),
--(1005, 'HR', 50000),
--(1006, 'Regional Manager', 65000),
--(1007, 'Supplier Relations', 41000),
--(1008, 'Salesman', 48000),
--(1009, 'Accountant', 42000)



/* where statement 
=, <>, ,<, >, and, or, like, null ,not null,In
*/

--SELECT *
--FROM EmployeeDemographics
--WHERE Age <= 32 and Gender = 'male'

--select * from EmployeeDemographics
--where LastName LIKE 's%c%ott%'


--select * from EmployeeDemographics
--WHERE FirstName in ('jim', 'michael')


/* 
Group By, Order By (ASC, DESC)
*/

--SELECT Gender, Age, COUNT(Gender)
--FROM EmployeeDemographics
--group by Gender, Age


--SELECT Gender, COUNT(Gender) as CountGender
--FROM EmployeeDemographics
--where age > 31
--group by Gender
--order by CountGender desc
----order by CountGender asc



SELECT *
FROM EmployeeDemographics
--Order by Age Desc, Gender desc


--SELECT *
--FROM EmployeeDemographics
--Order by 4 Desc, 1 Desc