use BigPVFC_L02_227;

-- Question 1
select ProductID, ProductDescription 
from Product_T
where ProductDescription like '%Bookcase%';

--Question 2
select o.CustomerID, c.CustomerName
from Customer_T c, Order_T o, OrderLine_T ol full join Product_T p on p.ProductID=ol.ProductID
where ProductDescription like '%bookcase%'
group by c.CustomerName, o.CustomerID;

--Question 3
select distinct sum(p.ProductStandardPrice*ol.OrderedQuantity) [Total Sale ($)]
from Product_T p inner join OrderLine_T ol on ol.ProductID=p.ProductID, Order_T o 
where year(o.OrderDate) = 2018;

--Question 4 
select p.ProductID, p.ProductDescription
from Product_T p full join Uses_T u on u.ProductID=p.ProductID, RawMaterial_T rm
where rm.MaterialType like '%wood%'
group by p.ProductID, p.ProductDescription;

--Question 5
select p.ProductID, p.ProductDescription, sum(rm.MaterialStandardPrice*u1.QuantityRequired) [Material Cost], p.ProductStandardPrice
from Product_T p inner join Uses_T u on u.ProductID=p.ProductID, RawMaterial_T rm inner join Uses_T u1 on u1.MaterialID=rm.MaterialID
where (rm.MaterialStandardPrice*u1.QuantityRequired)<(p.ProductStandardPrice/2)
group by p.ProductID, p.ProductDescription, p.ProductStandardPrice;

--Question 6 
select c.CustomerId, c.CustomerName
from Customer_T c left join Order_T o on c.CustomerId = o.CustomerID
where o.OrderID is null;

select c.CustomerId, c.CustomerName
from Customer_T c
where CustomerId not in (select CustomerID from Order_T);

select c.CustomerId, c.CustomerName
from Customer_T c
where not exists (select * from Order_T
where CustomerID=c.CustomerId);

--Question 7
Create Procedure ListCustomerSales @y int as 
begin
	select c.CustomerId, c.CustomerName, sum(p.ProductStandardPrice*ol.OrderedQuantity) [Sales Contribution]
	from Customer_T c, Product_T p, OrderLine_T ol, Order_T o
	where c.CustomerId=o.CustomerID and o.OrderID=ol.OrderID and ol.ProductID=p.ProductID and year(o.OrderDate) = @y
	group by c.CustomerId, c.CustomerName
end
exec ListCustomerSales '2018'

--Question 8
select s.EmployeeID, s.EmployeeName, count(e.EmployeeID) [Number of Supervised Employees]
from Employee_T s left join Employee_T e on e.EmployeeSupervisor=s.EmployeeID
group by s.EmployeeID, s.EmployeeName;

--Question 9
select e.EmployeeName
from Employee_T e left join EmployeeSkills_T s on e.EmployeeSupervisor=s.EmployeeID
group by e.EmployeeName
having count(s.SkillID)>= 3;

--Question 10
select c.CustomerName, o.OrderID, o.OrderDate
from Customer_T c, Order_T o
where o.CustomerID=c.CustomerId and o.OrderDate =
	(select max(OrderDate) from Order_T o where o.CustomerID=c.CustomerID);

--Question 11
select p.ProductDescription, p.ProductStandardPrice, (p.ProductStandardPrice- t.avgprice) [Price Difference]
from Product_T p, (select AVG(p1.ProductStandardPrice) as AvgPrice
from Product_T p1) t
where p.ProductStandardPrice> t.AvgPrice;

--Question 12
select pl.ProductLineName, count(p.ProductLineID) [Number of Products] 
from ProductLine_T pl left join Product_T p on pl.ProductLineID=p.ProductLineID
group by pl.ProductLineName;

--Question 13
select o.OrderID, c.CustomerName, (csa.ShipAddress + ',' + csa.ShipCity + ',' + csa.ShipState) [Full Shipping Address]	
from Order_T o, Customer_T c, CustomerShipAddress_T csa
group by o.OrderID, c.CustomerName, (csa.ShipAddress + ',' + csa.ShipCity + ',' + csa.ShipState);

--Question 14
select top 1 s.SalespersonID, s.SalespersonName, sum(p.ProductStandardPrice*ol.OrderedQuantity) [Total Sales ($)]
from Salesperson_T s, Product_T p, OrderLine_T ol, Order_T o
where s.SalespersonID=o.SalesPersonID and o.OrderID=ol.OrderID and p.ProductID=ol.ProductID
group by s.SalespersonID, s.SalespersonName
order by [Total Sales ($)] desc;

--Question 15
select p.ProductID, p.ProductDescription
from Product_T p inner join Uses_T u on u.ProductID=p.ProductID
where u.MaterialID IN ('ADHWDI', 'FINGLS')
group by p.ProductID, p.ProductDescription; 

select p.ProductID, p.ProductDescription
	from Product_T p
	left join Uses_T u 
	on u.ProductID=p.ProductID
intersect
select p.ProductID, p.ProductDescription
	from Product_T p
	right join Uses_T u
	on u.ProductID=p.ProductID
	where u.MaterialID = 'ADHWDI' or U.MaterialID = 'FINGLS';

--Question 16
create view Temp_V as
select p.ProductID, sum(p.ProductStandardPrice*ol.OrderedQuantity) [Sale]  
from Product_T p, OrderLine_T ol
where p.ProductID=ol.ProductID and (p.ProductStandardPrice*ol.OrderedQuantity) > 0
group by p.ProductID;

select pl.ProductLineName, avg(t.Sale) [Average Sale ($)] 
from ProductLine_T pl, Product_T p, Temp_V t
where pl.ProductLineID=p.ProductLineID and p.ProductID=t.ProductID
group by pl.ProductLineName;