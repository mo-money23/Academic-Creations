use BigPVFC_L02_227; 

create table test1_T
(
	TestID int PRIMARY KEY,
	FirstName varchar(40) NOT NULL,
	LastName varchar(30) NOT NULL,
	[State] char(2) NULL
); --this is a single line comment

/*this is a
multiline comment
*/ 

alter table test1_T
	add country varchar (15);

alter table test1_T
	drop column state;

alter table test1_T
	add [country 2] varchar(15);

alter table test1_T
	alter column country varchar(20);

create table Test2_T
(
	LastName varchar(20) not null,
	[First Name] varchar(20) not null,
	TestID int,
	EmployeeID int not null,
	constraint UC_EmployeeID unique (EmployeeID)
)

alter table Test2_T
	add constraint FK_T2_T1 foreign key (testid) references Test1_T(testid); 

drop table test1_T;

drop table Test2_T;

alter table test1_T
	drop column [country 2];

create table TestInsert
(
	ColA int,
	ColB int,
	ColC int
);

insert into TestInsert
(ColB, ColA, ColC) values (1,2,3)

insert into TestInsert
values (1,2,3);

insert into	TestInsert
values (1,2);

insert into TestInsert
(ColA, ColC) values (1,2);

insert into TestInsert
values(1,2,null);


update TestInsert --dangerous func USE WHERE ->
set ColC=6;

update TestInsert
set ColB=6, ColC=10
where ColB=2;

select * from TestInsert

delete from TestInsert --dangerous func
where colc=10

select CustomerId, CustomerName
from Customer_T;

select Customer_T.CustomerId, Customer_T.CustomerName
from Customer_T

select customerid as [Customer ID], customername as [Customer Name] --the 'as' is optional (use it for ur understanding) but is efficient to leave out
from Customer_T as c 

select c.CustomerId, c.CustomerName
from Customer_T as c 

select *
from Employee_T e -- 'as'
where YEAR(e.EmployeeBirthDate)>1980; --searched 'year' on google

select *
from Order_T o 
where o.SalesPersonID is not null;

select * 
from Customer_T c
where c.CustomerName like '%Furniture%'; -- adding the _ returns value furnitures

select *
from sys.databases
where name like '%big%'; -- he knows

select * 
from Employee_T e
where not (YEAR(e.EmployeeBirthDate)>1980 and e.EmployeeCity='nashville');

--not > and > or (priority like bedmas)

-- A and B or C and D

select p.ProductID, p.ProductDescription, p.ProductStandardPrice*1.05 as [Price after Tax]
from Product_T p;

select c.CustomerId, c.CustomerName, c.CustomerAddress + ',' + c.CustomerCity + ',' + c.CustomerState as 'Customer Full Address'
from Customer_T c;

select p.ProductDescription, p.ProductStandardPrice
from Product_T p
where p.ProductStandardPrice between 200 and 300;

select *
from Customer_T c
where c.CustomerState not in ('fl', 'tx', 'ca', 'hi');


select avg(p.ProductStandardPrice)
from Product_T p;

select count(*)
from Order_T;

select count(o.SalesPersonID)
from Order_T o;

select top 1 *
from Employee_T e
order by e.EmployeeBirthDate;

select distinct EmployeeID
from EmployeeSkills_T;

select count(distinct EmployeeID)
from EmployeeSkills_T;

select *
from Customer_T c
order by c.CustomerName desc; -- descending sequence (asc is ascending)
