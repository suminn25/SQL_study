# JOIN
use mgs;
drop table income;
drop table user;

# 테이블 생성
create table user(
	ui int primary key auto_increment
    , un varchar(20)
);
create table addr(
	ui int
    , an varchar(20)
);

# 데이터 추가
insert into user(un)
values ('A'), ('B'), ('C');
select * from user;
insert into addr(ui, an)
values (1, 'S'), (2, 'P'), (4, 'D'), (5, 'S');
select *from addr;

# inner
select user.ui, user.un, addr.an
from user
join addr # INNER는 생략 가능
on user.ui = addr.ui;

# left
select user.ui, user.un, addr.an
from user # user를 기준으로 left
left join addr
on user.ui = addr.ui;

# right
select addr.ui, user.un, addr.an # right join에서는 다른쪽 id를 선언
from user
right join addr
on user.ui = addr.ui;

# full outer
# union : 2개의 select 결과를 합쳐서 출력(중복 데이터 제거)
# union all : 중복 데이터 제거 X
select un from user
union
select an from addr;

# union을 이용한 outer join (left union right)
select user.ui, user.un, addr.an
from user # user를 기준으로 left
left join addr
on user.ui = addr.ui
union
select addr.ui, user.un, addr.an # right join에서는 다른쪽 id를 선언
from user
right join addr
on user.ui = addr.ui;

use world;
# 국가코드, 국가이름, 도시이름, 국가인구수, 도시인구수 출력
# 도시의 인구수가 500만명 이상이 되는 데이터를 출력
# 도시화율(도시인구/국가인구) 컬럼 추가
# 도시화율이 높은 도시순으로 5개의 도시를 출력
select country.code
	   , country.name as country_name
       , city.name as city_name
       , country.population as country_population
       , city.population as city_population
       , round(city.population / country.population * 100, 2) as ratio # round : 소수점 자릿수
from country
join city
on country.code = city.countrycode
having city_population >= 500*10000 # 쿼리 실행 후 조건 추가
order by ratio desc
limit 5;

# 국가코드, 국가이름, 국가 인구수, 사용언어, 사용언어비율, 언어사용인구수
select country.code, country.name, country.population
		, countrylanguage.language, countrylanguage.percentage
        , round(country.population * countrylanguage.percentage / 100)
from country
join countrylanguage
on country.code = countrylanguage.countrycode;

# 스태프 아이디, 전체이름(concat()), 매출금액, 매출날짜를 출력
use sakila;
select staff_id, amount, payment_date from payment;
select staff_id, first_name, last_name from staff;

select payment.staff_id
		, concat(staff.first_name, ' ', staff.last_name) as full_name
        , payment.amount, payment.payment_date
from payment
join staff
on payment.staff_id = staff.staff_id;

use wolrd;
# 국가코드, 국가이름, 도시이름, 사용언어, 언어사용률
select country.code, country.name as country_name, city.name as city_name
	   , countrylanguage.language, countrylanguage.percentage
from country
join city
on country.code = city.countrycode
join countrylanguage
on country.code = countrylanguage.countrycode;

# INNER JOIN 축소
select country.code, country.name as country_name, city.name as city_name
	   , countrylanguage.language, countrylanguage.percentage
from country, city, countrylanguage
where (country.code = city.countrycode) 
	  and (country.code = countrylanguage.countrycode);

# SubQuery : 쿼리 안에 쿼리 작성하는 방법 !!!!!!!!!!!!!!

# select
# 전체국가수, 전체도시수, 전체언어수를 1개의 row로 출력
select (select count(*) from country) as country_count
	   , (select count(*) from city) as city_count
       , (select count(distinct(language)) from countrylanguage) 
	   as language_count;
       # distinct -> 중복 데이터 제거

# from
# 800만 이상이되는 도시의 국가코드, 국가이름, 도시이름, 도시인구수를 출력
# 실행계획 : join(4079*239) > having(filtering)
select country.code, country.name as country_name
	   , city.name as city_name, city.population
from country
join city
on country.code = city.countrycode
having city.population >= 800 * 10000;

# 실행계획 : where(filtering) > join(10*239)
select country.code, country.name as country_name
	   , city.name as city_name, city.population
from (select * from city where population >= 800 * 10000) as city #10개
join country #239개
on country.code = city.countrycode;
# 리소스를 더 작게 사용하는 쿼리

# where
# 한국(KOR)의 인구수(46844000)보다 많은 국가의 국가코드, 국가이름, 국가인구수 출력
select code, name, Population
from country
where code = 'kor';

select code, name, Population
from country
where population > 46844000;

select code, name, Population
from country
where population > (
	select Population
	from country
	where code = 'kor'
); # 데이터가 업데이트되더라도 수정 필요 x

# 대륙별 사용되는 언어의 갯수를 출력 (from절 서브쿼리)
# join, group by, sub query
select sub.continent, count(sub.language) as count
from(
		select distinct country.Continent, countrylanguage.language # 명령어로 distinct 사용
		from country
		join countrylanguage
		on country.code = countrylanguage.countrycode
) as sub
group by sub.continent # distinct와 group by가 같이 있을 수 없음 (countrylanguage.language때문)
order by count desc;

# INDEX
# 테이블의 데이터 검색을 빠르게 해주는 기능
# 장점 : 검색(READ)속도증가
# 단점 : CREATE,UPDATE,DELETE가 느려짐
# B-Tree 알고리즘 사용

use employees;
show tables;
select * from salaries limit 5;
select count(*) from salaries;

# 인덱스 확인
show index from salaries;

# 쿼리 실행 속도 확인 : 0.789 sec
select * 
from salaries
where to_date < '1986-01-01';

# 인덱스 생성
create index tdate on salaries (to_date);

# 인덱스 확인
show index from salaries;

# 쿼리 실행 속도 확인 : 0.789 sec > 0.034 sec
select * 
from salaries
where to_date < '1986-01-01';

# 인덱스를 효율적으로 사용하는 방법
# 자주 사용하는 select 쿼리 실행시 where 에서 사용하는 컬럼을 설정

# 인덱스 삭제
drop index tdate on salaries;

# 인덱스 확인
show index from salaries;

# explain : 실행계획
# 쿼리를 실행하기 전에 쿼리가 어떻게 실행될지에 대해서 알려줌
# 쿼리 실행전에 실행되는 쿼리가 오래 걸릴지 확인
explain
select * 
from salaries
where to_date < '1986-01-01';

# 인덱스 생성
create index tdate on salaries (to_date);

explain
select * 
from salaries
where to_date < '1986-01-01';

# group by
# 특정컬럼(중복결합) 다른컬럼(결합함수)
# with rollup : 특정 컬럼이 2개 이상일때, 전체 총합계
# having : 쿼리 실행 후 필터링
# join : 두 개 이상의 테이블을 결합해서 결과를 출력
# inner, left, right, outer(union)
# SubQuery : select, from, where
# Index : read의 속도를 빠르게 해주는 문법(insert, update, delete가 느려짐)






