use BigPVFC_L02_227;

select Customerid, orderid,OrderDate
from Order_T;

select CustomerID, count(*) as [Number of Orders], max(o.Orderdate) [last order]
from Order_T o
group by CustomerID;

select c.CustomerState,c.CustomerCity,count(*) [Count]
from Customer_T c
group by c.CustomerState,c.CustomerCity;

--Group by clause has to include all parts of group name
select OrderID, OrderDate
from Order_T o

select YEAR(o.orderDate) [Year], COUNT(*) [Count]
from Order_T o
group by YEAR(o.OrderDate)

select concat(concat(YEAR(o.orderdate),'-'), MONTH(o.orderdate)) [Year-Month], COUNT(*) [Count]
from Order_T o 
group by YEAR(o.orderdate), MONTH(o.OrderDate);

--concat(a,b)

select ProductID, SUM(ol.orderedquantity) [Quantity]
from OrderLine_T ol
group by ProductID
having SUM(ol.OrderedQuantity)>10
order by [Quantity]

-- we cannot use column alias in HAVING, we can use column alias in ORDER BY.

select s.SalespersonName, s.SalespersonID 
from Salesperson_T s;

select o.SalesPersonID, o.OrderID, o.OrderDate 
from Order_T o;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s inner join Order_T o on o.SalesPersonID=s.SalespersonID;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s, Order_T o 
where s.SalespersonID=o.SalesPersonID;

select o.OrderID [Order ID], o.OrderDate [Order Date]
from Customer_T c, Order_T o
where c.CustomerId=o.CustomerID and c.CustomerState='NY';

select o.OrderID [Order ID], o.OrderDate [Order Date]
from (Customer_T c inner join Order_T o on c.CustomerId=o.CustomerID)
where c.CustomerState='NY'

select distinct c.CustomerId [Customer ID], c.CustomerName [Customer Name]
from Customer_T c, Order_T o 
where c.CustomerId=o.CustomerID and YEAR(o.OrderDate)=2018;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s inner join Order_T o on o.SalesPersonID=s.SalespersonID;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s left join Order_T o on o.SalesPersonID=s.SalespersonID;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s right join Order_T o on o.SalesPersonID=s.SalespersonID;

select s.SalespersonID [Left.SalespersonID], s.SalespersonName [Salesperson Name]
from Salesperson_T s left join Order_T o on o.SalesPersonID=s.SalespersonID
where OrderID is null;

select s.SalespersonName, s.SalespersonID [Left.SalespersonID], o.SalesPersonID [Right.SalespersonID], o.OrderID, o.OrderDate
from Salesperson_T s left join Order_T o on o.SalesPersonID=s.SalespersonID;

select s.SalespersonID [Salesperson ID], s.SalespersonName [Salesperson Name], COUNT(OrderID) [The number of Orders served]
from Salesperson_T s left join Order_T o on o.SalesPersonID=s.SalespersonID
group by s.SalespersonID, s.SalespersonName;

-- Count column, do not count (*)

select *
from Customer_T c, Order_T o, OrderLine_T ol, Product_T p
where c.CustomerId=o.CustomerID and o.OrderID=ol.OrderID and ol.ProductID=p.ProductID
	and p.ProductDescription like '%coffee%';

select p.ProductDescription, p.ProductStandardPrice, ol.OrderedQuantity
from Product_T p, OrderLine_T ol
where p.ProductID=ol.ProductID;

select p.ProductDescription, sum(p.ProductStandardPrice*ol.OrderedQuantity) [Sale ($)]
from Product_T p, OrderLine_T ol
where p.ProductID=ol.ProductID
group by ProductDescription;

select YEAR(o.OrderDate) [Year], sum(p.ProductStandardPrice*ol.OrderedQuantity) [Sale ($)]
from Product_T p, OrderLine_T ol, Order_T o
where p.ProductID=ol.ProductID and ol.OrderID=o.OrderID
group by YEAR(o.OrderDate);

select p.ProductDescription [Product Description], YEAR(o.OrderDate) [Year], sum(p.ProductStandardPrice*ol.OrderedQuantity) [Sale ($)]
from Product_T p, OrderLine_T ol, Order_T o
where p.ProductID=ol.ProductID and ol.OrderID=o.OrderID
group by p.ProductDescription, YEAR(o.OrderDate);

select s.EmployeeID [Supervisor ID], s.EmployeeName [Supervisor Name], e.EmployeeID [Employee ID], e.EmployeeName [Employee Name]
from Employee_T e, Employee_T s
where e.EmployeeSupervisor=s.EmployeeID and s.EmployeeName like '%rob%'

select s.EmployeeID [Supervisor ID], s.EmployeeName [Supervisor Name], count(e.EmployeeID) [Managing power]
from Employee_T s left join Employee_T e on e.EmployeeSupervisor=s.EmployeeID
group by s.EmployeeID, s.EmployeeName
order by [Managing power] desc