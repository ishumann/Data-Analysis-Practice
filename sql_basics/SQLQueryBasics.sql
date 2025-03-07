drop table if exists EmployeeDemographics
Create Table EmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 2 Query:
Create Table EmployeeSalary 
(EmployeeID int, 
JobTitle varchar(50), 
Salary int
)



--Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Angela', 'Martin', 31, 'Female'),
(1005, 'Toby', 'Flenderson', 32, 'Male'),
(1006, 'Michael', 'Scott', 35, 'Male'),
(1007, 'Meredith', 'Palmer', 32, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Kevin', 'Malone', 31, 'Male')

--Table 2 Insert:
Insert Into EmployeeSalary VALUES
(1001, 'Salesman', 45000),
(1002, 'Receptionist', 36000),
(1003, 'Salesman', 63000),
(1004, 'Accountant', 47000),
(1005, 'HR', 50000),
(1006, 'Regional Manager', 65000),
(1007, 'Supplier Relations', 41000),
(1008, 'Salesman', 48000),
(1009, 'Accountant', 42000)



/* where statement 
=, <>, ,<, >, and, or, like, null ,not null,In
*/

SELECT *
FROM EmployeeDemographics
WHERE Age <= 32 and Gender = 'male'

select * from EmployeeDemographics
where LastName LIKE 's%c%ott%'


select * from EmployeeDemographics
WHERE FirstName in ('jim', 'michael')


/* 
Group By, Order By (ASC, DESC)
*/

SELECT Gender, Age, COUNT(Gender)
FROM EmployeeDemographics
group by Gender, Age


SELECT Gender, COUNT(Gender) as CountGender
FROM EmployeeDemographics
where age > 31
group by Gender
order by CountGender desc
--order by CountGender asc



SELECT *
FROM EmployeeDemographics
--Order by Age Desc, Gender desc


SELECT *
FROM EmployeeDemographics
Order by 4 Desc, 1 Desc


/*
Inner/full/left/right/outer joins
*/
Table 1 Insert:
Insert into EmployeeDemographics VALUES
(1011, 'Ryan', 'Howard', 26, 'Male'),
(NULL, 'Holly', 'Flax', NULL, NULL),
(1013, 'Darryl', 'Philbin', NULL, 'Male')

--Table 3 Query:
Create Table WareHouseEmployeeDemographics 
(EmployeeID int, 
FirstName varchar(50), 
LastName varchar(50), 
Age int, 
Gender varchar(50)
)

--Table 3 Insert:
Insert into WareHouseEmployeeDemographics VALUES
(1013, 'Darryl', 'Philbin', NULL, 'Male'),
(1050, 'Roy', 'Anderson', 31, 'Male'),
(1051, 'Hidetoshi', 'Hasagawa', 40, 'Male'),
(1052, 'Val', 'Johnson', 31, 'Female')

select * 
from sqltutorial.dbo.employeedemographics

select *
from Sqltutorial.dbo.Employeesalary

select *
from sqltutorial.dbo.EmployeeDemographics
right outer join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


select *
from sqltutorial.dbo.EmployeeDemographics
left outer join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


select *
from sqltutorial.dbo.EmployeeDemographics
full outer join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeDemographics left join  SQLTutorial.dbo.EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeDemographics full join  SQLTutorial.dbo.EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary
FROM SQLTutorial.dbo.EmployeeDemographics inner join  SQLTutorial.dbo.EmployeeSalary
on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where FirstName <> 'Michael'
order by Salary Desc



SELECT Jobtitle, avg(Salary)
from SQLTutorial.dbo.EmployeeDemographics
Inner Join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
where JobTitle = 'Salesman'
group by JobTitle


SELECT * 
from SQLtutorial.dbo.EmployeeDemographics
Full Outer Join SQLTutorial.dbo.WareHouseEmployeeDemographics
on EmployeeDemographics.EmployeeID=
	WareHouseEmployeeDemographics.EmployeeID

/* Union, Union All */

select *
from SQLtutorial.dbo.EmployeeDemographics
UNION ALL
SELECT *
FROM SQLtutorial.dbo.WareHouseEmployeeDemographics



select EmployeeID, FirstName, Age
from SQLtutorial.dbo.EmployeeDemographics
Union
SELECT EmployeeID, JobTitle, Salary
FROM SQLtutorial.dbo.EmployeeSalary
Order by EmployeeID


/* Case Statement */


select FirstName, LastName, Age,
CASE
	When age = 38 then 'stanley'
	WHEN Age > 30 then 'Old'
	WHEN Age between 27 and  30 then 'Young'
	else 'Baby'
END
FROM SQLTutorial.dbo.EmployeeDemographics
where Age is not Null
ORDER BY Age

select *
From Sqltutorial.dbo.EmployeeDemographics
Join Sqltutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


SELECT FirstName, LastName, Age, JobTitle, Salary,
CASE
	when JobTitle = 'Salesman' then Salary + (Salary*.20)
	when JobTitle = 'Accountant' then Salary + (Salary*.10)
	when JobTitle = 'HR' then Salary + (Salary*.5)
	else Salary + (Salary*.01)
END as SalaryWithBonus
From SQLTutorial.dbo.EmployeeDemographics
Join SQLTutorial.dbo.EmployeeSalary
	on EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID


/*

Topic: Having Clause
*/

-- SELECT JobTitle, COUNT(JobTitle) as JobCount
SELECT JobTitle, AVG(Salary) as AvgSalary
From SQLTutorial.dbo.EmployeeDemographics
Join SQLTutorial.dbo.EmployeeSalary
	ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
Group by JobTitle
ORDER By AVG(Salary)
-- HAVING COUNT(JobTitle) > 1


/*

Topic: Updating/deleting data
*/


SELECT *
FROM SQLTutorial.dbo.EmployeeDemographics

UPDATE SQLTutorial.dbo.EmployeeDemographics
SET EmployeeID = 1012
WHERE FirstName = 'Holly' AND LastName = 'Flax'


UPDATE SQLTutorial.dbo.EmployeeDemographics
SET AGE = 31, Gender = 'Female'
WHERE EmployeeID = 1012

-- Wrong way to delete
-- Delete From SQLTutorial.dbo.EmployeeDemographics
-- Where EmployeeID = 1005

/**
first use select statement to check the data you want to delete.
*/

SELECT *
From SQLTutorial.dbo.EmployeeDemographics
Where EmployeeID = 1005

-- Delete From SQLTutorial.dbo.EmployeeDemographics
-- Where EmployeeID = 1005


/*
Topic: Aliasing
		ALiasing is used to give a table or column a temporary name.
		aliasing column name
		aliasing table name
*/

SELECT FirstName + ' ' + LastName AS FullName
From [SQLTutorial].[dbo].[EmployeeDemographics]

Select AVG(Age) as AVGAge
From [SQLTutorial].[dbo].[EmployeeDemographics]	


Select Demo.EmployeeID, Sal.salary
From [SQLTutorial].[dbo].[EmployeeDemographics]	as Demo
join [SQLTutorial].[dbo].[EmployeeSalary] as sal
	on Demo.EmployeeID = sal.EmployeeID


/*

	Partition By
		Partition By is used to divide the result set into partitions and perform a function on each partition.

*/

select FirstName, LastName, Gender, Salary, Count(Gender) over (PARTITION BY Gender) as TotalGender


select FirstName, LastName, Gender, Salary, Count(Gender)
over (PARTITION BY Gender) as TotalGender
from SQLTutorial..EmployeeDemographics demo
Join SQLTutorial..EmployeeSalary sal 
 on demo.EmployeeID = sal.EmployeeID

-- achive the same result using group by


select Gender, Count(Gender)
from SQLTutorial..EmployeeDemographics demo
Join SQLTutorial..EmployeeSalary sal 
 on demo.EmployeeID = sal.EmployeeID
 group BY Gender



/*
topic: CTEs
what is CTE? CTE stands for Common Table Expression. It is a temporary result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement.

*/





WITH CTE_Employee AS
(Select FirstName, LastName, Gender, Salary, 
Count(Gender) over (PARTITION by Gender) as TotalGender, 
AVG(Salary) over (PARTITION by Gender) as AVGSalary
from SQLTutorial..EmployeeDemographics demo
join SQLTutorial..EmployeeSalary sal
	on demo.EmployeeID = sal.EmployeeID
where Salary > '45000'
) Select FirstName, AvgSalary from CTE_Employee


/*
Topic: Temp Tables
WHAT IS TEMP TABLE?
A temporary table is a table that is created on the fly and exists for the duration of a database session.
*/

CREATE TABLE #TempEmployee
(
	EmployeeID int,
	JobTitle varchar(100),
	Salary int
)


Select * from #TempEmployee

INSERT Into #TempEmployee Values (
'1001', 'Salesman', '45000'
)


INSERT INTO #TempEmployee
Select *
from SQLTutorial..EmployeeSalary


-- Method 2 for temporary table
Drop Table If exists #TempEmployee2
CREATE TABLE #TempEmployee2
(
	JobTitle varchar(50),
	EmployeesPerJob int,
	AvgAge int,
	AvgSalabry int)

insert into #TempEmployee2
select JobTitle, Count(JobTitle), AVG(Age), AVG(Salary)
from SQLTutorial..EmployeeDemographics emp
Join SQLTutorial..EmployeeSalary sal
	on emp.EmployeeID = sal.EmployeeID
group by JobTitle

select * from #TempEmployee2


/* topic: String Functions 

String Functions - trim, ltrim, rtrim, replace, substring, upper, loewr

*/

Drop Table If exists EmployeeErrors

Create Table EmployeeErrors(
	EmployeeID Varchar(50),
	FirstName Varchar(50),
	LastName Varchar(50),

)


Insert into EmployeeErrors Values
('  1001', 'Jimbo', 'Halbert'),
('1002  ', 'Pam', 'Beasley'),
('1003', 'Dwight', 'Schrute'),
('1004', 'Angela', 'Martin'),
('1005', 'TOby', 'Flenderson - fired'),
('1006', 'Michael', 'Scoooott'),
('1007', 'Meredith', 'Palmer'),
('1008', 'Stanley', 'Hudson'),
('1009', 'Kevin', 'Malone')



-- Using Trim, LTirm, RTrim

Select EmployeeID, Trim(EMployeeID) as TrimEmployeeID
from EmployeeErrors

Select EmployeeID, LTrim(EMployeeID) as TrimEmployeeID
from EmployeeErrors

Select EmployeeID, RTrim(EMployeeID) as TrimEmployeeID
from EmployeeErrors


--  Using Replace
Select LastName, Replace(lastName, '- Fired', '') as LastNameFIxed
FROM EmployeeErrors


-- Using Substring its like slicing in python
Select Substring(FirstName, 1, 3) as SubFirstName
from EmployeeErrors

--  fuzzy matching


Select substring(err.FirstName, 1,3) , substring(demo.FirstName, 1,3)
from EmployeeErrors as err
join EmployeeDemographics demo
	on  substring(err.FirstName, 1,3) = substring(demo.FirstName, 1,3)

/*
Dont filter on FirstName only,

-- Last Name
-- Gender
-- AGE
-- DOB
*/


-- Using Upper and Lower

Select FirstName, Lower(FirstName) as LowerFirstName
from EmployeeErrors

