-- general function 
-- if - else

select name, population , if(population>10000 , 'Large_p' , 'Small_p') from country; 

-- in case if the population of the counrty 20000 and with the country name with a print very large county other wise 
-- if the population >25000 then print small country;

select name, population ,
 if( name like 'a%' and population>20000, 'very_larger',if(population>25000,'small','normal') ) from country;
 
 -- CASE WHEN THEN
 -- in else by default it return null
 /*
  select column,
  case  
      when condition then expression
      when condition then expression
      else
  end from table
 */
 select name,population,
  (case  
      when population>25000 then 'Large'
      when population>1500 then 'normal'
      else null
  end ) as col
  from country;
  
  -- ques select the name continant and popu if the indp year from 1600 to 1850 print early indp
 --                                          if the indp year from 1800 to 1900 print normal indp 
--                                           if the indp year is even 
--                                                        late_early
 select name , continent , population,IndepYear,
 (case  
      when indepyear>1600 and indepyear<1850  then 'early_indep'
      when indepyear>1800 and IndepYear<1900 then 'normal'
      when IndepYear is null then null
      else 'late_early'
  end) as col,
  (case 
  when mod(indepyear,2)=0 then 'Even'
  when indepyear is null then null 
  else 'Not_even'
  end) as col
  from country;
  
  use world;
  select * from country;
  
  -- find the cont name total no. of country and print the message large conti if the total no. of country > 5
  -- print medium size conti if total no. of country > 3
  -- print small 
  
  select continent , count(name),
 (case  
      when count(name)>5  then 'large_continent'
	  when count(name)>3  then 'medium_continent'
      else 'small' 
  end) as col
  from country group by continent;
  
  
  -- CTE : stands for common table expression
	   -- This is the temp result which can be used within one sql statement;
       -- can be used multiple time in a single sql statement
       -- mainly used for code readebility
       -- make ur complex query easy 
       -- can be used n number of time in a query
       -- ctes can be used till the query execution
  use regex2;
  select * from employee;
  
with t as (
  select dept , avg(salary) as a from employee group by dept
)
select e.name,e.dept,e.salary,t.a from employee e  inner join t on e.dept = t.dept and e.salary > t.a; 

-- -----------------------------------------------------UNION and UNION ALL------------------------------------------------------------
-- set operation : used to append
-- if i will change no. of column in both table then it will give error
-- name or data type can be same 
-- join vertically 
-- union will remove the duplicate
-- union all will return all the rows
-- EXCEPT: join horizontally
-- intersect: only return common element
use world;
select code , name ,continent from country where code in ('ALB','AND')
 union all
select code , name ,continent from country where code in ('ALB','BIH');


-- -----------------------------------------------------RECURSIVE CTE-------------------------------------------------------------------
-- RECURSIVE CTE: in which we  can use cte again and again and use to find hierarchical value 

create database CTE;
use CTE;

-- -------------------------------------------------------------------------------------------------------------------------------------
-- filtering the records before join is the one of the way to make the query optimised 
select * from orders;

with completed_orders as (
    select * 
    from orders 
    where status = 'Completed'
),

cte_join as (
    select 
        co.order_id,
        co.customer_id,
        co.order_date,
        day(co.order_date) as days,
        oi.product_id,
        oi.quantity,
        oi.unit_price,
        (oi.quantity * oi.unit_price) as total
    from completed_orders as co
    join order_items as oi
        on co.order_id = oi.order_id
)

select 
    customer_id,
    sum(total)
from cte_join
where days between 1 and 15
group by customer_id;


with recursive cte as(
   select 10 as n
   union all
   select n+1 from cte where n<13
   )
select * from cte;   

-- ----------------------------------------------VIEWS-----------------------------------------------------------
-- views: stand for virtual table
-- data store ni hota query ko store krta h database me so it can be used again
-- use to make centralized logic so every user can use it who have the access of database

-- view -> run query -> on table 
-- for security purpose.
-- create view:

create view actor_view as (
select a.actor_id ,a.first_name , a.actor_id*100 from actor as a );
select * from actor_view;
-- changes with view or the orginal table affect the both

create table actor_1 as 
select actor_id , first_name  from actor where actor_id<6;
create view actor_5_v as
select first_name from actor_1;
 
 insert into actor_5_v values('yashh');
 select * from actor_5_v;
  select * from actor_1;
 -- > simple view: updatable view
 -- > complex view: non updatable view
 
 create view  temp as 
 select * from actor_1 where actor_id<8
 with check option;
 insert into temp values (5,'saransh');
 select * from temp;
