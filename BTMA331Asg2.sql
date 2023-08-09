-- Question 1 Tables

create table Banquet
(
	Banquet_ID int PRIMARY KEY,
	Nbr_of_Guests int not null,
	StartTimeDate varchar(30) not null,
	EndTimeDate varchar(30) not null
);

create table Room
(
	Room_Nbr int PRIMARY KEY,
	Nbr_of_Seats int not null,
	Rtable_Rating varchar(30) not null
);

create table Assignment
(
	StartTimeDate varchar(30) PRIMARY KEY,
	EndTimeDate varchar(30) not null,
	TipsEarned varchar(30) not null
);

create table Employee
(
	Employee_ID int PRIMARY KEY,
	Emp_Lname varchar(40) not null,
	Emp_Fname varchar(40) not null
);

create table Waiter
(
	Employee_ID int PRIMARY KEY,
	Hourly_Wage varchar(30) not null
);

create table Manager 
(
	Employee_ID int PRIMARY KEY,
	Monthly_Salary varchar(30) not null,
	[Rank] varchar(30) not null
);

-- Question 2 Tables

create table Editor
(
	Editor_ID int PRIMARY KEY,
	Editor_Lname varchar(40) not null,
	Editor_Fname varchar(40) not null,
	Editor_Institution varchar(30) not null
);

create table Book
(
	Book_Nbr int PRIMARY KEY,
	Book_ISBN varchar(30) not null,
	Book_Title varchar(30) not null,
	Book_price varchar(30) not null
);

create table Author
(
	Author_ID int PRIMARY KEY,
	Auth_Name varchar(50) not null,
	Auth_Phone varchar(20) not null,
	Auth_Email varchar(30) not null,
	Auth_Expertise varchar(30) not null
);

create table [Order Line]
(
	OrderLine_Nbr int PRIMARY KEY,
	OL_Price varchar(30) not null,
	OL_discount varchar(30) not null,
	OL_Quantity varchar(30) not null
);

create table [Order]
(
	Order_ID int PRIMARY KEY,
	Order_Date varchar(30) not null,
	OrderDeliveryDate varchar(40) not null
);

create table Seller
(
	Seller_ID int PRIMARY KEY,
	Seller_Name varchar(50) NOT NULL
);

create table Account
(
	Acct_Nbr int PRIMARY KEY,
	Acct_Description varchar(30) not null
);

-- Question 1 creating refrential constraints

alter table Waiter
	add foreign key (Employee_ID) References Employee(Employee_ID);	

alter table Manager
	add foreign key (Employee_ID) References Employee(Employee_ID);

alter table Assignment
	add Banquet_ID int not null;

alter table Assignment
	add Room_Nbr int not null;

alter table Assignment
	add foreign key (Banquet_ID) References Banquet(Banquet_ID);

alter table Assignment 
	add foreign key (Room_Nbr) References Room(Room_Nbr);

alter table Waiter
	add Waiter_ID int not null;

alter table Manager 
	add Manager_ID int not null;

alter table Assignment 
	add Waiter_ID int not null;


