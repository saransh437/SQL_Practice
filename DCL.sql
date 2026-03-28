 -- DCL: stands for data control language that used for access rights and permission to user

-- grant: gives privalege to a user 
-- revoke: takes away permission from the user 
create database DCL;
use DCL;

create table Test as select actor_id , first_name from sakila.actor
where actor_id between 1 and 4;

select * from test;
select current_user();
-- query to see the permission
show grants for current_user();
-- user is created by CREATE command.
create user saransh identified by 'saranshp';
show grants for saransh;

-- grant PRIVIELEGE on db.object_name to user

grant select on dcl.Test to saransh; 
show grants for saransh;
-- grant select on dcl.* to saransh; -- used to give permission to all the table in the database 
--  grant select(column_name) on dcl.Test to saransh; -- giving privalege to more the one column;
-- grant ALL PRIVILEGES on dcl.* to saransh -- grant privileges on the entier database
-- Flush PRIVILEGES

-- REVOKE select on dcl.Test from saransh; -- used for taking the privilages 
-- REVOKE ALL_PRIVILEGES on dcl.Test from saransh; -- used for taking the all the privilages
-- WITH GRANT OPTION -->  a user can give his permission to any other user when i am using WITH GRANT OPTION  

-- create a role in mysql
-- create two user naman and adarsh 
-- check the permission for naman and adarsh
-- assign the role to the user.
-- check the grants for addarsh
-- then assign a select privalege to the role
-- verify this select statement
-- login to addarsh user
-- verify permission
-- go to root user assign role to naman the it will also have those privilages

create role salerole;
grant delete on ctedb.test101 to salerole;
grant salerole to tanish1;

show grants for tanish1;
show grants for salerole;