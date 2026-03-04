-- -------------------------------------------window function --------------------------------------------------------------------------

-- window function: A window function performs a calculation across a set of rows without collapsing rows and
--                  return single value for each row .
-- advantages: Do not collapse rows (keep original data intact)
--             Allow ranking, running totals, moving averages
--             Perform calculations across partitions (groups) easily
-- disadvantages: May reduce performance on very large datasets
--                 Cannot be used in WHERE clause directly

-- group by: reduce the rows but window function keep all the rows
-- group by used for aggregation but window function used for Analytical calculation
-- in group by row details are lost but in window function rows are preserved 
-- In group by we get 1 row per group but In window function All rows with extra column

create database windowdb;
use windowdb;

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    sale_date DATE,
    amount DECIMAL(10,2)
);

select * from sales;

select * , (select avg(amount) from sales) from sales; 

-- over() -> used to get output for every row 
--          defines the window of rows on which a window function operates without collapsing the result set.
--         A function becomes a window function only when it uses OVER()

-- Partition by --> PARTITION BY splits rows into groups, but unlike GROUP BY, it does NOT reduce rows
--               -> only the calculation is done per group.
 
select *,avg(amount) over() as avgAmt from sales; 

-- with partition by 
select *,avg(amount) over(partition by customer_name) as avgAmt from sales; 

select *,min(amount) over(partition by customer_name,month(sale_date)) as minAmt from sales; 

-- Running Sum : A running sum is a total that keeps adding values row by row as you move through the result set.
select *,sum(amount) over(order by sale_id) as running_sum from sales; 
select *,sum(amount) over(order by amount) as running_sum from sales; 

-- rank(): IT is a window function used to assign a position (rank) to each row based on a specified order
--        Rows with the same value get the same rank.
--        The next rank number is skipped if there is a tie.
select *, rank() over(order by amount) as rnk from sales;

-- When you use PARTITION BY with RANK(), SQL assigns ranks separately inside each group.
select *, rank() over(partition by customer_name order by amount) as rnk from sales;

-- dense_rank() : It assigns a rank (position) to rows based on an order without leaving gaps in ranking numbers.
--              :Equal values get the same rank.
--              :The next rank number is NOT skipped.

select *, dense_rank() over(order by amount) as rnk from sales;

-- ques bob ka avg total se kitna kamm h ?
select *,sum(amount) over(partition by customer_name),
avg(amount) over(partition by customer_name),
sum(amount) over(partition by customer_name) -avg(amount) over(partition by customer_name)  
from sales;

select *,sum(amount) over(partition by customer_name), 
amount- sum(amount) over(partition by customer_name order by sale_date) 
from sales;
use regex2;
 