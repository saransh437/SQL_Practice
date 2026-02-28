use sakila;
show databases; 

show tables;
-- explain table structure
desc actor;
select actor_id, concat(first_name ,' ', last_name)  from Actor;
select * from actor where first_name = 'Nick';

-- logical operator  (col > value)
select * from actor where actor_id > 3 and actor_id<7 ;
select * from actor where actor_id = 3 or actor_id=7 ;
select * from actor where first_name > 'B' ;

-- day 2
-- between range of values 
-- select value --> only for testing purpose
select * from actor where actor_id between 2 and 7;
-- in op (check the specific value)
select * from actor where actor_id in (2,7,9) ;
select * from actor where first_name in ('NICK','GRACE','JOE'); 
select * from actor where actor_id not in (2,7,9) ;
-- can also use not between


-- like (use to search the pattern)
-- % -> zero or more character
select * from actor where first_name like 'A%';
select * from actor where first_name like 'B%';
select * from actor where first_name like 'ED%';
-- Last character 
select * from actor where first_name like '%A';
select * from actor where first_name like 'S%R';
-- at any place 
select * from actor where first_name like '%A%';
-- two R at any place 
select * from actor where first_name like '%R%R%';

-- underscore (_)only one char
select * from actor where first_name like '__';
select * from actor where first_name like '_A%R_';



-- ques 1 first chr c and last second  n
select * from actor where first_name like 'C%N_';
-- ques 1 a chr 3 times
select * from actor where first_name like '%A%A%A%';
-- ques 3 last 3 chr d 
select * from actor where first_name like '%D__';
-- ques Double A together
select * from actor where first_name like '%AA%';
-- atleast 5 chr 
select * from actor where first_name like '_____%';

select first_name , lower(first_name) from actor;  -- use to lower case the chr 
select first_name , length(first_name) from actor;  -- use to get the length of char and give output in term of byte 
 -- dummy table (1 row and 1 column)
 select first_name , char_length(first_name) from actor; -- will give total number of char givven in the argument 
 
 select 'saransh' , 'soni' ,concat('saransh' , 'soni') from dual;  -- add on the string data 
 
 select first_name, last_name , actor_id , concat(first_name,' ',last_name , actor_id) from actor;
select first_name, last_name , actor_id , concat_ws(' ',first_name,last_name , actor_id) from actor; -- seperate on the basis of seperator
 
 -- substr  : help to extract a particular substr from string on the basis of sring 
 select first_name , substr(first_name, 1,1) from actor ;
 select first_name , substr(first_name, 2,2) from actor;
 
-- trim : use to remove extra spaces or extra data 
-- why does we use remove instead of replace : remove all spaces but we want to remove only leading trail spaces     
select trim('     hye   ') from dual;
select trim(leading ' ' from '     hye   ') from dual; -- trailing for last values
select trim(both 'x' from 'xxxx   hye  xxx') from dual; -- will not remove data from the middle

-- lpad : mainly used with numerical data (used to add characters to a string to make it a fixed length from left)
-- rpad : used to add characters to a string to make it a fixed length from right
select first_name , lpad(first_name,4,'#') from actor;


-- day 3 functions  with learning assignment
-- block of code which we can reusable and readable
-- pre-defined and user defined
-- predefined function - > scaler functions 
-- scaler => applied for each row and result will be given for each row 
-- string related function

select upper(first_name), lower(last_name) from actor;
select concat(upper(first_name), lower(last_name)) from actor;

select first_name , last_name , substr(last_name ,1,1) from actor; 
select first_name , last_name , substr(last_name ,-1) from actor;

select first_name  , replace(first_name , 'A' , ' ')from actor;

-- questions 

select * , concat(upper(first_name), lower(last_name)) as value from actor where concat(upper(first_name), lower(last_name)) = 'EDCHASE';
select *  from actor where concat(upper(first_name), lower(last_name)) = 'EDCHASE';
select *  from actor where concat(upper(first_name), lower(last_name)) like '%A';
select *  from actor where concat(upper(first_name), lower(last_name)) like '%A%A%';
select first_name , last_name from actor where substr(first_name ,1,1) in ( 'A', 'E');
select first_name , last_name from actor where first_name like 'A%' or first_name like 'E%';

-- trim : use to remove extra spaces or extra data 
select trim('     hye   ') from dual;
-- INSTR() : return the location of the first occurrence of a substring within a given string. (perform in-case sensitive operation)
select instr(first_name , 'i') from actor; 
-- LOCATE(): used to find the position of a substring in a string (use to perform case sensitive operation)

select * , locate('o',first_name) from actor;


-- -----------------------------------------------------------day 4-------------------------------------------------------------------

select first_name , trim( both 'E'  from first_name) from actor;
select first_name , lpad(first_name,4,'#') from actor;

-- numbers function
-- round() : used to round of the value 
select 23.68,format(3467.45,1); 
-- floor --> use same as floor div
select floor(21.7), ceil(6.0221);

-- count() -> return the number of rows
-- distinct - > return the unique value from the table 

-- --------------------------------------------------------------day-4-------------------------------------------------------------------

-- data functions
select curdate() , current_time() , current_timestamp() , now();
-- monthname() - return the name of month
select now(),adddate(now(),2);

use sakila;

select payment_date, adddate(payment_date,2) from payment;

select now(), adddate(now(),interval 4 month);

select now(), adddate(now(),interval 4 quarter);

-- subdate - used to reduce the date 
-- extract - used to extract year , month , year , time 

select now() , extract(month from now()); 
select now() , extract(month from now()); 

-- str_to_data -
-- date_format- extract date in the string format 

select payment_date, month(payment_date) , date_format(payment_date , '%y') from payment;

-- ques payment data in 5th month 

select * from payment where  extract(month from payment_date) =5;
 select * from payment where  extract(year from payment_date) =2006;
 
-- multirow function(aggregate function=> which used to perform calculation)

-- combination of amount and staff_id should be unique
select distinct customer_id , amount from payment; 

-- cant choose any column before distict 
-- Because DISTINCT is a row-level modifier, not a column-level function
-- Because SQL can’t apply DISTINCT to just one column while keeping others unchanged.
-- select customer_id , distinct amount from payemnt;
select distinct amount ,staff_id from payment;

-- sum(): 
select sum(amount) from payment;
-- count():
select count(amount) from payment;
-- max():
select max(amount) from payment;
-- min()
-- avg()
-- we cant not select non  agregated column with agregate column
select * from payment;
select count(*) from payment where extract(month from payment_date) in (5,6);
select sum(amount) ,count(payment_id)from payment where amount >5 and extract(month from payment_date) >3 ;

-- find the total customer and total no of unique cust done payment in last day of the month where the amt > 0.5
select  count(customer_id) , count(distinct customer_id) from payment where amount > 0.5 and extract(day from payment_date) = extract(day from last_day(payment_date));

-- learning assignment
-- what is group by
-- difference between group by and distinct keyword 

-- ----------------------------------------------------------day-5-----------------------------------------------------------------------
-- group by : used to group and will contain multiple rows 
-- display unique value but contain no. of multiple rows
-- cant not directly apply on any column without aggregation function
-- where use on orignal data 
 
select customer_id, sum(amount) from payment group by customer_id;
select staff_id , sum(amount) from payment group by staff_id;

select staff_id , count(customer_id) from payment group by staff_id;

select * from payment;
select payment_id , sum(amount) from payment group by payment_id;

-- ques how many time each amt is visile 
select amount, count(amount) from payment group by amount;
-- try to get the total amt , max amt and the total trnc done by each cust
select customer_id, max(amount) , sum(amount) from payment group by customer_id ;
-- find out the total amt spend by each staff along with the no of cust they serve done only after the payent id 9

select staff_id, sum(amount) , count(customer_id) from payment where payment_id > 9 group by staff_id;

-- find the total amt spend the avg amt and total tranc done in each month
select extract(month from payment_date) , sum(amount) , avg(amount) , count(customer_id) from payment group by  extract(month from payment_date);

-- get me total avg max done for the first week of each month for may june and july
select extract(month from payment_date), sum(amount) , avg(amount) , max(amount) from payment 
where extract(month from payment_date) in (5,6,7) and day(payment_date) between 7 and 14 
group by extract(month from payment_date);

select sum(amount) , avg(amount) , max(amount) from payment 
where extract(month from payment_date) in (5,6,7) ;


-- ------------------------------------------------------------------day-7--------------------------------------------------------------------
use world;
show tables;

select * from country;

select sum(population) from country;

select sum(population) from country where continent ='Asia';

select continent , sum(population) from country group by continent;

select region,continent , sum(population) from country group by Region,Continent;

select continent , count(name) from country group by Continent;

select indepyear , count(name) from country group by IndepYear;
-- count skip null values
-- where is used before group by
-- where only filter on column which exist in table 
-- where generally are not use on aggregate function
-- having claues used  to filter the row based on aggregate function
-- having cant be used wthout group by 
-- having use after group by  

-- ques
-- ***find  how many  how many contry got ind in each year each cont***
select continent, indepyear,count(name) from country group by Continent,IndepYear;

-- *** ques
select continent , count(name) as count from country group by Continent having count > 30;

-- ques 
select Continent , avg(population) as count from country group by Continent having count> 500000;

-- ques get the avg pop , no. of country for each govt form  , for the country who got 
select GovernmentForm , avg(population) , count(name) from country
 where indepyear > 1890 
group by GovernmentForm 
having count(name) >= 4;

-- primary key 
-- foregign key 
-- what is normanlisaion  1nf 2nf 

-- ------------------------------------------------------------joins--------------------------------------------------------------
 use testdb;
 
 -- join -> give the common value from both the table
 -- a table may contain primary key
 
 select o.orderid , o.pname,price from orders as o;
 select c.city , c.name from customers as c;
 drop table orders;
select c.name,c.city,
o.pname , o.price 
from orders as o join customers as c 
where c.customerid  = o.customerid;

use world;

-- get the cityid city name , and county code for the city
-- counrty code, count id , country name , conti ,
-- city id city name and country name for each city
select co.name,co.Continent ,
 c.name 
 from country as co join city as c 
 where co.code = c.CountryCode;
 
 select co.name,co.Continent ,
 c.name 
 from country as co join city as c 
 where co.code = c.CountryCode and co.name = 'Argentina';
 
-- find the country name , and all the language spoken in that counrty

select co.name,c.Language
from countrylanguage as c join country as co 
where  co.code = c.CountryCode ;
 
 select co.name,c.Language
 from countrylanguage as c inner join country as co 
 on co.code = c.CountryCode where c.Language = 'English';
 
 select * from country;
 
 
 
 -- types of joins 
 -- inner join 
 -- left join
-- right join
-- full outer join
-- self join
-- ------------------------------------------ joins -----------------------------------------------------------------------------------

create database rmd;
use rmd;

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


INSERT INTO customers VALUES
(1, 'John', 'New York'),
(2, 'Alice', 'Los Angeles'),
(3, 'Bob', 'Chicago'),
(4, 'Emma', 'Houston'),
(5, 'Michael', 'Phoenix'),
(6, 'Sophia', 'Dallas'),
(7, 'David', 'Seattle'),
(8, 'Olivia', 'Boston'),
(9, 'James', 'Denver'),
(10, 'Isabella', 'Miami');


INSERT INTO orders VALUES
(101, 1, 250.00),
(102, 2, 300.00),
(103, 1, 150.00),
(104, 3, 400.00),
(105, 5, 500.00),
(106, 7, 700.00),
(107, 7, 200.00),
(108, 9, 350.00),
(109, 11, 600.00), 
(110, 12, 800.00);  

select * from customers;
select * from orders;
-- inner join
select c.customer_id , c.name , o.order_id from customers as c inner join orders as o on c.customer_id = o.customer_id ;
-- left join -- inner join + any aditional records in the left table 
select c.customer_id , c.name , o.order_id ,o.order_amount from customers as c left join orders as o on c.customer_id = o.customer_id ;
-- right join -- inner join + any additional records from the right table 
select c.customer_id , c.name , o.order_id ,o.order_amount from customers as c right join orders as o on c.customer_id = o.customer_id ;

select c.customer_id , c.name , o.order_id ,o.order_amount 
from customers as c left join orders as o
 on c.customer_id = o.customer_id 
 where o.order_id is null ;


-- total amt spend placed by a each customer
select  sum(o.order_amount) , c.name
from customers as c inner join orders as o
 on c.customer_id = o.customer_id  group by c.name;
 
 -- total no of order which are not placed by the customer 
 select  count(o.order_id) 
from customers as c right join orders as o
 on c.customer_id = o.customer_id  where c.customer_id is null  ;
 
 -- total amt spend and the avg amt spend for the order by each cust cust id 3 and more 
 select  c.name,c.customer_id,sum(o.order_amount) , avg(o.order_amount) 
from customers as c inner join orders as o
 on c.customer_id =o.customer_id where c.customer_id>=3 group by c.customer_id , c.name;
 
 SELECT 
    c.name,c.customer_id,
    SUM(o.order_amount) AS total_spent,
    AVG(o.order_amount) AS avg_spent,
    COUNT(o.order_id) AS total_orders
FROM customers AS c
JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
 
-- ------------------- self join ---------------------------------------------------------------------------
CREATE TABLE employees (
    eid INT PRIMARY KEY,
    ename VARCHAR(100),
    salary DECIMAL(10,2),
    manager_id INT
);
INSERT INTO employees VALUES
(1, 'John', 90000, NULL),   -- Top-level manager (CEO)
(2, 'Alice', 75000, 1),
(3, 'Bob', 70000, 1),
(4, 'Emma', 65000, 2),
(5, 'Michael', 60000, 2),
(6, 'Sophia', 62000, 2),
(7, 'David', 58000, 3),
(8, 'Olivia', 55000, 3),
(9, 'James', 50000, 4),
(10, 'Isabella', 52000, 4);
select * from employees;
select e.eid , e.ename , e.manager_id ,m.ename from employees as e  join employees as m  where e.manager_id=m.eid;

-- --------------------------------------------------------------cross join( carteisian product)-------------------------------------------------------------
-- combining every row from the first table with every row of from the second table.
-- --------------------------------------------------------------natural join------------------------------------------------------------
 -- act as a inner join if have same columne and data type 
 -- and act as cross join if dont have same columne
 select * from customers natural join orders;
 
 -- ----------------------------------------------------------join  with group by----------------------------------------------------
 
 use world;
 
 select * from city;
 select * from country;
 

 
select cnty.name ,c.district ,sum(c.population) from city as c inner join country as cnty on cnty.code = c.countrycode
 group by cnty.name,c.district;
 
 select cnty.region ,cnty.name,c.district ,sum(c.population) from city as c inner join country as cnty on cnty.code = c.countrycode
 group by cnty.region,cnty.name,c.district;
 
 select * from countrylanguage;
 
 -- ques find tototal popul for each lang spoken
 select cl.language,sum(cnty.population) from country as cnty inner join countrylanguage as cl on cnty.code = cl.countrycode
 group by cl.language;
 
 
 
 -- find the total popul for each language spoken either a language is offical and unofficial 
  select cl.language,cl.Isofficial,sum(cnty.population) from country as cnty 
  inner join countrylanguage as cl on cnty.code = cl.countrycode
 group by cl.language,cl.isofficial;
 select * from country;
 select * from countrylanguage;
 
 
 
 
 use sakila;
 select * from actor;
 select * from film_actor;
 select * from film;
 
 -- ques find the actor name and the total no. of movies the actor made 
 select a.actor_id,a.first_name,count(film_id) from actor as a inner join film_actor as f 
 on a.actor_id =f.actor_id
 group by a.actor_id,a.first_name;
 
 -- ques get the name of the actor and the rating of the film along with avg length of the movie
  select a.actor_id,a.first_name ,fl.rating,avg(fl.length) from actor as a inner join film_actor as f 
 on a.actor_id =f.actor_id 
 inner join film as fl on f.film_id = fl.film_id
 group by a.actor_id,a.first_name ,fl.rating;
 
 
 -- ------------------------------------------------------ subquery -------------------------------------------------------------------
 -- subquery --> query within a query or nested/inner query 
 -- Have two parts outer query or inner query 
 -- > outer query depends on inner query 
 -- > always solve inner query first
 select * from city;
 
 -- ques give those cities jinka country code = Silang wale counrty code ke equal ho
 
 select name ,countrycode 
 from city 
 where 
 countrycode = (select countrycode from city where name = 'silang');
 
  
 -- ques give those cities jinka country code = oran wale counrty code ke equal ho
  select name ,countrycode 
 from city 
 where 
 countrycode = (select countrycode from city where name = 'oran');
 
 -- ques city which have population greater then the population of oran
 
 select name , population
 from city 
 where 
 population > (select population from city where name = 'oran');
 
 --  ques get me the city info whose district is same as of tafuna city
 select name 
 from city 
 where 
 district = (select district from city where name = 'tafuna');
 
 -- ques get the district and its population for all the city where the country code is same as of city namibe
 select district , population 
 from city 
 where 
 countrycode = (select countrycode from city where name ='namibe');
 
-- ques get me the city name and district where the district is same as of americana
 
select name,district  
 from city 
 where 
 district = (select district from city where name ='Americana');
 
 -- get me all the city info where the population of city is less then the popuation og barueri
 
 select *  
 from city 
 where 
 population < (select population from city where name ='barueri');
 
 select * from country;
 
 -- ques get me the countrycode and the country name where the continent is same as of country albania
  select code,name  
 from country 
 where 
 continent = (select continent from country where name ='albania');
 -- get me those country info where the independence should be after afg
   select * 
 from country 
 where 
 indepyear > (select IndepYear from country where name ='Afghanistan');
 -- get the name , cont , region and population for all the country where the region is same as of belgium and have the ind year after 1800
 select name ,continent,region,population 
 from country 
 where 
 region = (select region from country where name ='belgium') and indepyear > '1800';
 
 
 select * from payment;
 
-- columne with lowest payment_id
select * from payment where payment_id = (select min(payment_id) from payment);
select payment_id  from payment where amount =( select min(amount) from payment );
-- get all the payment info with the high rental id
select * from payment 
where 
rental_id =( select max(rental_id) from payment );
-- grt me all the payemnt info for the earliest payment date
select * from payment 
where 
payment_date =( select min(payment_date) from payment );

-- select all the payment info where the amount is same as of payment id 5
select * from payment 
where 
amount =( select amount from payment where payment_id=5 );

-- select all the payment info where the amount is greater then the avg amount payment table 
select * from payment 
where 
amount >( select avg(amount) from payment );
-- get all the payment info where the amount is greater then the maximum amt of cust id 1
select * from payment 
where 
amount >( select max(amount) from payment where customer_id=1 );

-- find the payment id , staff id , amt only for the payment where the month = the month of payment id 4
select payment_id ,staff_id,amount from payment 
where 
month(payment_date) =( select month(payment_date) from payment where payment_id=4 );

-- high payment_id from table where the amount is same of paymnet id =11 and cust_id 1
select max(payment_id) from payment 
where 
amount =( select amount from payment where customer_id=1 and payment_id=11 );
-- --------------------------------------------------------------------------------------------------------------------------------------
-- multiple subquery 
-- multirow subquery  --> can't use comparision operator ( in operator and =any operator is used )
-- and with  (any operator we can use comperison operator)
-- cant use =all in a multirow subquery but use compersion with it 
-- multirow multi col subquery
 -- co-related query

select * from payment 
where 
amount  in ( select amount from payment where payment_id=3 or payment_id=4 );

-- get all the payment info where the customer id is same as the custmore id of payment id 3 or 250
select * from payment 
where 
customer_id  in ( select customer_id from payment where payment_id=3 or payment_id=250 );

select * from payment 
where 
customer_id  =any ( select customer_id from payment where payment_id=3 or payment_id=6 );
select * from payment 
where 
amount  >any ( select amount from payment where payment_id=3 or payment_id=6 );
select * from payment 
where 
amount  >all ( select amount from payment where payment_id=3 or payment_id=6 );

-- ques get all the payment info where the amount is greater then any amount of payment 1 and 3 

select * from payment 
where 
amount  >any ( select amount from payment where payment_id=1 );
-- ques get all the pay info where amount is greater among all the payment of customer id 1
select * from payment 
where 
amount  >all ( select amount from payment where customer_id=1 );


-- ------------------------------------------------- co-related subquery------------------------------------------------------------
-- type of subquery which is executed again and again for each row outer query. 
-- inner query refers to a table/column in the outer query.
-- Execution: It runs repeatedly—once for every row returned by the outer query.

create database regex2;
use regex2;
CREATE TABLE employee (
    eid INT PRIMARY KEY,
    name VARCHAR(50),
    dept VARCHAR(50),
    salary DECIMAL(10,2)
);


INSERT INTO employee (eid, name, dept, salary) VALUES
(101, 'Amit', 'HR', 40000),
(102, 'Neha', 'HR', 45000),
(103, 'Raj', 'IT', 60000),
(104, 'Priya', 'IT', 75000),
(105, 'Suresh', 'IT', 50000),
(106, 'Anita', 'Finance', 55000),
(107, 'Vikram', 'Finance', 65000),
(108, 'Kavita', 'Finance', 48000),
(109, 'Rohit', 'Marketing', 52000),
(110, 'Sneha', 'Marketing', 58000);

select eid , name, salary from employee as e1 where salary > 
(select avg(salary ) from employee where dept =e1.dept);

-- highest paid employee in each dept
select eid , name, salary from employee as e1 where salary = 
(select max(salary) from employee where dept = e1.dept);

-- employee earn more al least more then one in their department
select eid , name, salary from employee as e1 where salary > 
(select min(salary) from employee where dept = e1.dept);
select eid , name, salary from employee as e1 where salary >any 
(select salary from employee where dept = e1.dept);

-- more then all employee in their dept except themselev
select eid , name, salary from employee as e1 where salary >any 
(select max(salary) from employee where dept = e1.dept and e1.eid <>eid);

-- -----------------------------------------------------------------leetcode practice --------------------------------------------------
-- ques 180

-- diff between in and exists keyword
-- corelated with group by 

-- -------------------------------------------------------------------------------------------------------------------------------------

select * from city;
select * from country;

-- show cities whose population is higher 
-- then the averge city population of their own country

select name , population from city c1 where 
population >(select avg(population) from city where countrycode =c1.countrycode);
-- find cities that have the maximum population within their country
select name , population ,countrycode from city c1 where 
population =(select max(population) from city where countrycode =c1.countrycode);

select c1.name , country.name ,country.code from city c1 
join country 
on country.code = c1.countrycode 
where c1.population >(select avg(c2.population) from city c2 where c2.countrycode =c1.countrycode);

-- get me the continent name who have the total no of country greater then the no . of country in south america 
 select continent ,count(name) from country group by continent having count(name) >
       (select count(*) from country where continent = 'south america');