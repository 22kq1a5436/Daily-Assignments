create database daytwo;
use daytwo;
create table departments(deptid int primary key,deptname varchar(50));
insert into departments values(1,'HR'),(2,'IT'),(3,'Sales');
create table employees(empid int primary key,empname varchar(50),deptid int,salary int,hiredate date,
foreign key(deptid) references departments(deptid));
insert into employees values(10,'John',1,50000,'2018-02-12'),(102,'Alice',2,60000,'2019-07-10'),
(103,'Bob',1,55000,'2020-05-05'),(104,'Carol',3,45000,'2017-09-20');

#Display employees whose names start with 'A'
select *from employees where empname like 'A%';

# Find employees whose salary is between 45000 and 60000
select *from employees where salary>=45000 and salary<=60000

#Show the department name of each employee(JOIN query)
select e.empname,d.deptname from employees e join departments d on e.deptid=d.deptid;

#find the number of employees in each department
select deptid,count(*) as Numofemployees from employees group by deptid;

#display all employees,including those without a department(left join)
select e.*,d.deptname from employees e left join departments d on e.deptid =d.deptid;