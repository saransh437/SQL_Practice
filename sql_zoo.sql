-- select basic
-- 1
SELECT population FROM world
  WHERE name = 'Germany';
-- 2
SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark');

-- 3
SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000;

-- select names
-- 1
SELECT name FROM world
  WHERE name LIKE 'Y%';
-- 2
SELECT name FROM world
  WHERE name LIKE '%Y';
-- 3
SELECT name FROM world
  WHERE name LIKE '%X%';
-- 4
SELECT name FROM world
  WHERE name LIKE '%LAND';
-- 5
SELECT name FROM world
  WHERE name LIKE 'C%IA';
-- 6 
SELECT name FROM world
  WHERE name LIKE '%OO%';
-- 7
SELECT name FROM world
  WHERE name LIKE '%A%A%A%A%_';
-- 8
SELECT name FROM world
 WHERE name LIKE '_T%'
ORDER BY name;
-- 9 
SELECT name FROM world
 WHERE name LIKE '%O__O%';
-- 10
SELECT name FROM world
 WHERE name LIKE '____';
-- 11 
SELECT name
  FROM world
 WHERE name = capital;
-- 12 
SELECT name
  FROM world
 WHERE capital = concat_ws(' ',name, 'City');
-- 13 
select capital, name from world where capital like concat('%',name,'%');
-- 14
select capital, name from world where capital like concat(name,'_','%');
-- 15
select name, replace(capital,name,'') from world where capital like concat(name,'_','%');

-- select from nobal 
-- 1
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950;
-- 2 
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature';
-- 3
select yr , subject from nobel where winner = 'Albert Einstein';
-- 4
select winner from nobel where subject ='peace' and yr >=2000;
-- 5 
select yr , subject , winner from nobel where subject='literature' and yr between 1980 and 1989; 
-- 6 
select * from nobel where winner IN ('Theodore Roosevelt',
'Thomas Woodrow Wilson',
'Jimmy Carter',
'Barack Obama');
-- 7
select winner from nobel where winner like 'john%';
-- 8
select yr , subject , winner from nobel where subject = 'physics' and yr = 1980 or subject = 'chemistry' and yr = 1984;
-- 9
select yr , subject , winner from nobel where subject not in ('chemistry' , 'medicine') and yr = 1980;
-- 10
select yr , subject , winner from nobel where subject =  'medicine' and yr <1910 or subject = 'literature' and yr >=2004;
-- 11 
select * from nobel where winner  = 'PETER GRUNBERG';
-- 12 
select * from nobel where winner  = 'EUGENE O''NEILL';
-- 13 
SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC;
-- 14
SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('physics','chemistry');

-- select within select 

-- 1 
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia');

-- 2
select name from world where continent = 'europe' and gdp/population > (select gdp/population from world where name ='United Kingdom' );
-- 3
select name ,continent from world where continent in
(select continent from world where name ='Argentina' 
or name='Australia') order by name ;
-- 4
SELECT name, population
FROM world
WHERE population >( SELECT population FROM world WHERE name = 'United Kingdom'
)
AND population < (SELECT population FROM world WHERE name = 'Germany');
-- 5
SELECT 
    name,
    CONCAT(ROUND((population / (SELECT population FROM world WHERE name = 'Germany')) * 100),'%') as percentage
FROM world
WHERE continent = 'Europe';
-- 6
select name from world where gdp >all (select ifnull(gdp,0) from world where continent = 'Europe');
 
-- sum and count 
-- 1
SELECT SUM(population)
FROM world;
-- 2
select distinct continent from world ;
-- 3
select sum(gdp) from world where continent = 'Africa';
-- 4 
select count(name)  from world where area >= 1000000;
-- 5
select sum(population) from world where name in ('Estonia', 'Latvia', 'Lithuania');
-- 6
select continent , count(continent) from world group by continent;
-- 7 
select continent,count(name)  from world where population >=10000000 group by continent;
-- 8  
select continent from world group by continent having sum(population) > 100000000;

























