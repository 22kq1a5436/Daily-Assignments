create database dayone;
use dayone;
create table departments(deptid int primary key,deptname varchar(50));
insert into departments values(1,'HR'),(2,'IT'),(3,'Sales');
create table employees(empid int primary key,empname varchar(50),deptid int,salary int,hiredate date,
foreign key(deptid) references departments(deptid));
insert into employees values(10,'John',1,50000,'2018-02-12'),(102,'Alice',2,60000,'2019-07-10'),
(103,'Bob',1,55000,'2020-05-05'),(104,'Carol',3,45000,'2017-09-20');

#Display all the records from the employees table
select *from employees;

#Display only empname and Salary of all employees
select empname,salary from employees;

#Find all employees who belong to the IT department
select empname from employees where deptid=(select deptid from departments where deptname='IT');

#list employees whose salary is greater than 50,000
select *from employees where salary>50000;

#find employees hired before 2020-01-01
select *from employees where hiredate<'2021-01-01';

#display employees in descending order of salary
select *from employees order by salary desc;

#count total number of employees
select count(*) from employees;

#find the average salary of all employees
select Avg(salary) from employees;

#find the maximum salary in each department
select  deptid,max(salary) from employees group by deptid;

#find departments having more than 1 employee
select deptid from employees group by deptid having count(empid)>1;


