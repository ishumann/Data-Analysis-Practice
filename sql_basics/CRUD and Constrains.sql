                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 # test

/*

SQL create Databases
SQL  drop Databases
SQL create tables
SQL Insert Into Table
SQL Drop Table


SQL Null Values
SQL update Statement
SQL Delete Statement
SQl alter Statement


Not Null
Unique
Primary Key
Foregin
check table
Default 
Index

*/ 

CREATE DATABASE customer;


# show - to show all the databases or tables
show databases;

# to select any database to work with
use customer;


# Creating Table
CREATE TABLE customer_info(id INTEGER, first_name varchar(25),
last_name VARCHAR(25),
age INTEGER); 
show tables;


# show Schema of Database
desc customer_info;

# inserting data into table 
insert into customer_info(id,first_name, last_name,age) values(1, 'ishuman', 'agarwal',28);

select * from customer_info;

drop table customer_info;

show tables;

# droping Database
drop database customer; 



##############################
create  database customer;
use customer;
create table customer_info(id integer, 
first_name varchar(25), 
last_name varchar(25), 
age int);

insert into customer_info(id, first_name, last_name, age) 
values(1,'ishuman','agarwal',28);
alter table customer_info modify salary integer;

desc customer_info;
select * from customer_info;

# inserting rows into the column
insert into customer_info(id, first_name, last_name, age) 
values
(1,'ishuman','agarwal',28),
(2,'ishu','agarwal',20),
(3,'ishuman','agarwal',1);
# adding new table into customer_info
ALTER TABLE customer_info ADD salary INT;
# retriving null values
Select * from customer_info where salary is null;

# add  data  to exsting row 
insert into customer_info(id, first_name, last_name, age, salary) 
values
(5,'ishuman','agarwal',29, 80000);


# updating data in salary column
UPDATE customer_info SET salary =0
where age<28;

# finding null VALUES
SELECT * FROM customer_info where salary  != NULL;
 
 
 
# delete statement
DELETE from customer_info where age=1;
select * from customer_info;

ALTER table customer_info ADD dob date;
alter table customer_info drop column age; 
 
 
/*
Not Null
Unique
Primary Key
Foregin
check table
Default 
Index
 */

create table student(
id INT AUTO_INCREMENT NOT null Primary KEY, 
first_name varchar(30) not null,
last_name VARCHAR(25) not null, 
age int NOT NULL, 
grade int);

SELECT * from student;
DESC student;
alter table student MODIFY id int AUTO_INCREMENT UNIQUE not null;
alter table student MODIFY first_name varchar(30) UNIQUE not null;

create table person(
id INT AUTO_INCREMENT NOT null, 
first_name varchar(30) not null,
last_name VARCHAR(25) not null, 
age int not null,
CONSTRAINT pk_person Primary KEY(id, first_name));

show tables;


# adding unique constraint

alter table person add CONSTRAINT test UNIQUE(first_name, last_name); 

insert into person (id, first_name, last_name, age) values (2,"ishu", "mann",22);
desc person;
SELECT * from person;

show index FROM person;

alter table person drop CONSTRAINT test;
drop table person;

######################################

/*
primary key

*/
create table person(id int AUTO_INCREMENT UNIQUE,
first_name varchar(25) not null,last_name varchar(24) not null,
age int,
CONSTRAINT pk_person primary key(first_name, last_name));
desc person;
SELECT * from person;

alter TABLE person
drop primary KEY;
drop table person;
 ########################################################
/*

forign key
check constraint
default constraint
*/ 

############ Forign key ################


create table person(id int AUTO_INCREMENT UNIQUE PRIMARY KEY,
first_name varchar(25) not null,last_name varchar(24) not null,
age int,
salary int);
desc person;
SELECT * from person;

create table dept(id int not null,
dept_id int not null, 
dept_name varchar(50) not null,
primary key(dept_id),
constraint fk_persondepartment foreign key(id) references person(id));  	
desc dept;

##### add foreign key afer creating table ############# 

drop table dept;
create table dept(id int not null,
dept_id int not null, 
dept_name varchar(50) not null,
primary key(dept_id));

alter table dept add CONSTRAINT fk_persondept FOREIGN KEY(id) REFERENCES person(id);
  	
desc dept;

###################################

######## check constraints ###############

drop table dept, person;


create table person(id int AUTO_INCREMENT UNIQUE PRIMARY KEY,
first_name varchar(25) not null,last_name varchar(24) not null,
age int,
salary int,
check(salary<50000));

desc person;

INSERT into person values (1,'ishuman','agarwal', 28,40000);


SELECT * from person;



create table dept(id int not null,
dept_id int not null, 
dept_name varchar(50) not null,
primary key(dept_id));



######### default Constraints ##################

create table person(id int, first_name varchar(24), 
last_name(35), age int, salary int,
city_name varchar(40) default 'jaipur',
primary key(id)
);

##############################

use customer;
show tables;

select * from person;

ALTER TABLE person ADD COLUMN (city_name varchar(50));

CREATE index index_city_name
on person(city_name);
desc person;
show  INDEX from person;

drop table student;

CREATE TABLE student(id int NOT null,
first_name varchar(30) NOT null,
last_name varchar(30),
age int,
PRIMARY KEY(id,first_name));
select * from Student;
desc student;

CREATE index index_age on
student(age);
show index from student;

CREATE index index_age_first_name on
student(age, first_name);
show index from student;


alter TABLE student
drop index index_age_first_name;

drop table student;

#############################################

/*
Views
*/


use customer;
drop table student, department;
CREATE TABLE student(
    studentid INT NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30),
    age INT,
    PRIMARY KEY(studentid)
);

ALTER TABLE student MODIFY id INT AUTO_INCREMENT;

INSERT INTO student (studentid, first_name, last_name, age)
VALUES 
(1, 'ishuman','agarwal', 28),
(2,'krish', 'naik', 34), 
(3, 'sachin', 'yadav', 28);


CREATE TABLE department(
    studentid INT AUTO_INCREMENT,
    dept_name VARCHAR(20) NOT NULL,
    FOREIGN KEY(studentid) REFERENCES student(studentid)
);

INSERT INTO department (dept_name)
VALUES 
('CS'),
('ME'),
('CE');


SELECT * FROM student;
SELECT * FROM department;
 
 
create view student_info as 
select first_name, last_name, age from student inner join department
using (studentid);


select * from Student_info;

drop view student_info;











