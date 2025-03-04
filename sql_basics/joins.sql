/*
joins
inner joins
left join
right join
full join
natural join
cross join
*/
use customer;
drop table student; 
drop tables department;
DROP view student_info;



create table student(
studentid int AUTO_INCREMENT,
first_name VARCHAR(25) not null,
last_name VARCHAR(25) not null,
age int,
PRIMARY KEY(studentid));

insert into student(first_name, last_name, age) values
('ishuman', 'agarwal',28),
('krish', 'naik',34),
('sachin','yadav',28);
SELECT * from student;

CREATE table department(
studentid int AUTO_INCREMENT,
department_name varchar(30),
FOREIGN KEY(studentid) REFERENCES student(studentid)
);

insert into student(first_name, last_name, age) values
('vishal', 'a',20);

insert into department values
(1,'CS'),(2,'MS'),(3,'EE');
insert into department(studentid, department_name) values
(3,'mae');

desc department;
show INDEX from department;
select * from student;
select * from department;

create view student_info as 
SELECT first_name, last_name, age from student inner join department 
USING (studentid);

select * from student_info;
select * from department;
select * from student;

########### INNER JOIN #############

select student.first_name, student.last_name, 
student.age, department.department_name from student inner join department
on student.studentid = department.studentid;

########### left JOIN #############

select student.first_name, student.last_name, student.age, department.department_name
from student LEFT join department on 
student.studentid = department.studentid;

########## right Join ############

SELECT student.first_name, student.last_name, student.age, department.department_name
from student right join department on
student.studentid = department.studentid;


########### FUll Outer ##############


select student.first_name, student.last_name, student.age, department.department_name
from student LEFT join department on 
student.studentid = department.studentid
union
SELECT student.first_name, student.last_name, student.age, department.department_name
from student right join department on
student.studentid = department.studentid;


######### cross join ############


SELECT student.first_name, student.last_name, student.age, department.department_name
from student cross join department;

############## natural join ############3

SELECT * from student NATURAL join department;

