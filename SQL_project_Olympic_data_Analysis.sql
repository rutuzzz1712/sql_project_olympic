create database sqlprjt;
 use sqlprjt;
 
 create table olympics
 (
ID int,
Name varchar(500),
Sex varchar(10),
Age int,
Height int,
Weight int,
Team varchar(350),
NOC varchar(100),
Games varchar(500),
Year int,
Season varchar(400),
City varchar(300),
Sport varchar(500),
Event varchar(400),
Medal varchar(200));

select * from olympics;

show variables like "secure_file_priv";

load data infile "C:/ProgramData/MySQL/MySQL Server 9.0/Uploads/Athletes_Transformed.csv"
into table olympics3
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from olympics;


-- Show how many medal counts present for entire data
select count(medal) as medalcount from olympics
where medal is not null
limit 5;

-- 2. Show count of unique sports present in Olympics
select count( distinct sport)as uniquesportscount
 from olympics;

-- 3. Show how many different medals won by team India
select count(distinct medal)as dfferent_medals_count
from olympics
where team='india';


-- 4. Show event wise medals won by India show from highest to lowest medals won in order

select  event,medal,count(*) as medalcount 
from olympics
where team='india'
group by event,medal 
order by medalcount desc;

-- 5. Show event wise medals won by India in order of year
select year,event,medal from olympics
where team='india'and medal in ('gold','silver','bronze');


-- 6. show country who won maximum medals.
select team,count(medal)as total_medals
from olympics
where medal is not null
group by team
order by total_medals desc;

-- 7.show top 10 countries whowon gold
select team,count(medal) as gold_medals
from olympics
where medal='gold'
group by team
order by gold_medals desc
limit 10;


--  8. show in which year did United states won most gold medal
select year,count(medal) as gold_medals
from olympics
where team='united states' and medal='gold'
group by year
order by gold_medals desc
limit 1;


-- 9. In which sports United States has most medals.
select sport, COUNT(medal) AS TOTAL_MEDAL from
olympics
WHERE team ='united states' 
GROUP BY sport
ORDER BY TOTAL_MEDAL desc
limit 1;



-- 10. Find top three players who won most medals along with their sports and country
select  name,sport,TEAM ,COUNT(medal) AS TOTAL_MEDALS from olympics
where medal  is  not null
group by name,sport,team
order by TOTAL_MEDALS desc
limit 3;


-- 11. Find player with most gold medals in cycling along with his country.
select name,team,count(medal) as GOLD_MEDAL
from olympics
where sport='cycling'and medal='gold'
group by name,team
order by GOLD_MEDAL desc
limit 1;

-- 12.Find player with most medals (Gold+Silver+Bronze) in Basketball also show his country.
select name,team,count(medal) as TOTAL_MEDALS
from olympics
where sport='basketball'and medal in ('gold','silver','bronze')
group by name,team
order by TOTAL_MEDALS desc
limit 1;

-- 13. Find out the count of different medals of the top basketball player Teresa Edwards
select name,medal,count(medal) as MEDAL_COUNT from olympics
where name='teresa edwards'and 
sport='basketball'
group by name,medal;



-- 14. Find out medals won by male,female each year , Export this data and plot graph in excel

select year,medal, COUNT(medal) AS MEDAL_TOTAL
from olympics
where sex in ('male','female')and medal is not null
group by year,sex,medal
order by year;