use BigPVFC_L02_227;

select c.CustomerName, c.CustomerAddress
from Customer_T c, Order_T o
where o.CustomerID=c.CustomerId and o.OrderID=34;

select c.CustomerName, c.CustomerAddress
from Customer_T c
where c.CustomerId=(select CustomerID
from Order_T o
where o.OrderID=34);


select *
from Employee_T e
where e.EmployeeSupervisor=(select e1.EmployeeSupervisor
from Employee_T e1
where e1.EmployeeName like '%laura%')

select *
from Product_T p
where p.ProductStandardPrice>(select AVG(p1.ProductStandardPrice)
from Product_T p1)

select c.CustomerName, c.CustomerAddress
from Customer_T c
where c.CustomerId in (select CustomerID
from Order_T
where year(OrderDate)=2018)
order by c.CustomerName

select distinct c.CustomerName, c.CustomerAddress
from Customer_T c, Order_T o
where c.CustomerId=o.CustomerID and year(o.orderdate)=2018
order by c.CustomerName

select c.CustomerId, c.CustomerName
from Customer_T c
where CustomerId not in (select CustomerID from Order_T)

select c.CustomerId, c.CustomerName
from Customer_T c left join Order_T o on c.CustomerId = o.CustomerID
where o.OrderID is null;

select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=3 and o.OrderID in (select OrderID
	from OrderLine_T
	where ProductID=4)

select t3.OrderID,t3.OrderDate
from (select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=3) t3, 
(select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=4) t4
where t3.OrderID=t4.OrderID;

select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=3;   --T3


select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=4;   --T4

select *
from Product_T p
where p.ProductStandardPrice>(select AVG(p1.ProductStandardPrice)
from Product_T p1)

select p.ProductID,p.ProductDescription,p.ProductStandardPrice, t.AvgPrice
from Product_T p, (select AVG(p1.ProductStandardPrice) as AvgPrice
from Product_T p1) t
where p.ProductStandardPrice> t.AvgPrice

select OrderID
from OrderLine_T ol
where exists (select * from Product_T where ProductID=ol.ProductID and ProductFinish='Oak')

select orderID
from OrderLine_T ol
where ol.ProductID in (select productid
from Product_T p
where p.ProductFinish='Oak'
)

select ol.OrderID
from OrderLine_T ol, Product_T p
where ol.ProductID=p.ProductID and p.ProductFinish='oak'

select *
from Employee_T s
where exists (select * from Employee_T e where e.EmployeeSupervisor=s.EmployeeID)

select *
from Product_T p
where p.ProductStandardPrice = (select Max(p1.ProductStandardPrice)
from product_T p1
where p1.ProductLineID=p.ProductlineID)/*the max price of the most expensive product in the current productline*/

select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=3 --T3
except
select o.OrderID, o.OrderDate
from Order_T o, OrderLine_T ol
where o.OrderID=ol.OrderID and ol.ProductID=4 --T4

drop view Sales_V;

create view Sales_V as 
select s.SalespersonName, p.ProductDescription, sum(ol.orderedquantity) as quanity
from Salesperson_T s, Order_T o, OrderLine_T ol, Product_T p
where s.SalespersonID=o.SalesPersonID and o.OrderID=ol.OrderID and p.ProductID=ol.ProductID
group by s.SalespersonName, p.ProductDescription

select * from Sales_V

select * from sales_V where quanity>3

create procedure MyProc as
begin
	select * from Customer_T;
	select * from Product_T;
end

Create Procedure MyProCWIthP @state varchar(50) as
begin
	select * from Customer_T where CustomerState= @state
end

exec MyProCWIthP 'FL'

select * from sys.objects
where type_desc='User_Table'

select *
from INFORMATION_SCHEMA.TABLES






