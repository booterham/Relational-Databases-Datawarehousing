-- 1. Give all employees that started working as an employee in the same year as Robert King
with RobertKing(startYear) as (select year(HireDate) from Employees where FirstName = 'Robert' and LastName = 'King')
select *
from Employees
         inner join RobertKing on RobertKing.startYear = year(Employees.HireDate)


-- 2 Make a histogram of the number of orders per customer, so show how many times each number occurs.
-- E.g. in the graph below: 1 customer placed 1 order, 2 customers placed 2 orders, 7 customers placed 3
-- orders, etc.
/*
nrNumberOfCustomers
11
22
37
46
510
68
77
...
*/
with amountsOrdered(CustomerID, amountOfOrders) as (select CustomerID, count(OrderID) as amountOfOrders
                                                    from Orders
                                                    group by CustomerID)
select count(CustomerID) as NumberOfCustomers, amountOfOrders
from amountsOrdered
group by amountOfOrders
order by amountOfOrders

-- 3. Give the customers of the Country in which most customers live
with whereFrom(amount, country) as (select count(CustomerID) as amountFromCountry, Country
                                    from Customers
                                    group by Country),
     maxInhabits(amount) as (select max(amount) from whereFrom)
select Country
from whereFrom
where amount = maxInhabits.amount

-- 4. Give all employees except for the eldest. Solve this first using a subquery and afterwards using a cte


-- 5. What is the total number of customers and suppliers?


-- 6. Give per title the eldest employee


-- 7. Give per title the employee that earns most


-- 8. Give the titles for which the eldest employee is also the employee who earns most