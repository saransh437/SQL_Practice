-- ------------------------------------------ from database Rmd----------------------------------------------------------------
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2)
);
-- 1 Show all orders with the customer name.
select o.order_id , c.name from orders as o inner join customers as c on o.customer_id = c.customer_id; 
-- 2 Show customers who have placed orders.
select distinct c.name from orders as o inner join customers as c on o.customer_id = c.customer_id;
-- 3 Show all customers and their orders (include customers with no orders).
select c.name ,o.order_id,o.order_amount from customers as c left join orders as o on o.customer_id = c.customer_id;
-- 4 List customer name, city, and order amount for orders greater than 300.
select c.name , c.city , o.order_id , o.order_amount from customers c inner join orders o on c.customer_id = o.customer_id
where o.order_amount > 300;
-- 5 Show all orders where the customer does NOT exist in the customers table. 
select o.order_id , c.name ,c.customer_id from orders as o left join customers as c on o.customer_id = c.customer_id 
where c.customer_id is null;   
-- 6 Find total amount spent by each customer.
select c.customer_id ,c.name ,sum(o.order_amount) from customers as c inner join orders as o
on  c.customer_id = o.customer_id group by c.customer_id,c.name;
-- 7 Show customers who have not placed any orders.
select c.name , o.order_id from customers as c left join orders as o 
on c.customer_id = o.customer_id where o.order_id is null;
-- 8 Find the average order amount per customer
select c.customer_id, c.name, avg(o.order_amount)
from customers c
inner join orders o
on c.customer_id = o.customer_id
group by c.customer_id, c.name;

-- 9 Show the customer who placed the highest single order.
select c.customer_id, c.name, o.order_amount
from customers c
join orders o
on c.customer_id = o.customer_id
order by o.order_amount desc
limit 1;

-- 10 Count how many orders each customer placed.
select  c.name ,  c.customer_id , count(o.order_id) from customers as c inner join orders as o on c.customer_id = o.customer_id group by c.customer_id,c.name ; 

-- 11 Show customers who placed 2 or more orders.
select  c.name ,  c.customer_id , count(o.order_id) 
from customers as c inner join orders as o 
on c.customer_id = o.customer_id 
group by c.customer_id,c.name having count(o.order_id)>=2; 

-- 12 Find customers whose total spending is greater than 400.
select  c.name ,  c.customer_id , sum(o.order_amount) 
from customers as c inner join orders as o 
on c.customer_id = o.customer_id 
group by c.customer_id, c.name having sum(o.order_amount)>400; 
-- 13 Show all customers along with:
--     total orders
--     total spending
--     (Even if they placed zero orders.)
select c.customer_id,c.name ,count(o.order_id) , sum(o.order_amount) 
from customers as c left join orders as o 
on o.customer_id = c.customer_id group by c.customer_id , c.name ;
-- 14. Find customers who placed orders, but their total spending is less than the average spending of all customers.

-- 15. Show invalid orders (orders linked to non-existent customers).
select * from orders as o left join customers as c on o.customer_id = c.customer_id where c.customer_id is null;
-- -----------------------------------------------------------------------------------------------------------------------------------
-- 1. Find the total salary paid per department.
select department,sum(salary) from employees group by department;
-- 2. Find the number of employees in each department.
select department,count(emp_id) from employees group by department;
-- 3. first 3 characters of each employee name in capital letters
select upper(left(emp_name,3)) from employees ;
-- 4. Find the employee who have more than 6 character in their name
select emp_name from employees group by emp_id having length(emp_name)>6;
-- 5. Find employees who joined after November 2020.
SELECT emp_name
FROM employees
WHERE YEAR(join_date) > 2020
   OR (YEAR(join_date) = 2020 AND MONTH(join_date) > 11);
use company_db;   
-- 6. Display the number of years since joining (assuming current year = 2025).
select emp_name,
       2025 - YEAR(join_date)
FROM employees;
-- 7. Display salary rounded to nearest thousand.
select round(salary,-3) from employees;
-- 8. Find cities having more than 2 employees.
select city from employees group by city having count(emp_id) >2;
-- 9. Find cities where the average salary is between 60,000 and 75,000.
select city from employees group by city having AVG(salary) between 60000 and 75000;
-- 10.Find the department and city combination where the average salary is highest.
SELECT department, city, AVG(salary)
FROM employees
GROUP BY department, city
ORDER BY AVG(salary) DESC
LIMIT 1;
-- 11. Display departments where more than one city is present.
select department,count(city) from employees group by department having count(city) > 1; 
