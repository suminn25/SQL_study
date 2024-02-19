# DML : DATA : C(insert into)R(select from)U(update set)D(delete from)
#	- where : operator(산술,비교,논리) : between, in, not in, like
#	- order by : asc, desc
#	- limit : num1(limit) : num1(skip), num2(limit)
# DDL : DATABASE, TABLE : C(create)R(show,desc)U(alter)D(drop)
#	- create table : column name, datatype, constraint
#		- datatype
#			- numeric(int,float)
#			- string(char,varchar,text)
#			- date(datetime,timestamp)
#		- constraint
#			- not null, unique, default, primary key, auto_increment
#			- foreign key : on update, on delete
#				- cascade, set null, no action, set default, restrict
# Functions
#	- round(), concat(), count(), distinct(), date_format()
#	- if(condition, true, false), ifnull(column, data), case when then end
# GROUP BY
#	- 특정컬럼(중복결합) 다른컬럼(결합함수)
#	- 결합함수 : min, max, count, avg, sum ...

use world;

# 국가코드별 총 도시의 인구를 출력
select CountryCode, sum(Population) as sum_pop
from city
group by countrycode;

use sakila;
select *
from payment;
# 스태프(staff_id)별 총 매출(amount)을 출력
select staff_id
		, sum(amount) as sum_amount
        , avg(amount) as avg_amount
        , count(amount) as count_amount
from payment
group by staff_id
order by sum_amount desc;

# 연월별 총 매출액, 매출횟수 출력
# date_format(payment_date, '%Y-%m')
select date_format(payment_date, '%Y-%m') as monthly
				, sum(amount) as total_amount
                , count(amount) as count_amount
                , avg(amount) as avg_amount
from payment
group by monthly; 

# group by, date_format() : KPI 지표에서 많이 사용됨

use wolrd;

# 대륙별 총인구 출력 : 대륙의 인구수가 5억 이상인 대륙만 출력
# where : 쿼리 실행 전에 데이터 필터링
# having : 쿼리 실행 후에 데이터 필터링
select *
from country;
select continent, sum(population) as population
from country
group by continent
having population >= 50000 * 10000;

# 2개 이상의 컬럼을 그룹핑
# 대륙과 지역별 총 인구수 출력
select continent
		, ifnull(region, 'total') as region
		, sum(population) as total_population
from country
group by continent, region # 2개 이상의 컬럼을 그룹핑
with rollup; # 그룹핑한 전체 집계 결과를 나타냄(그룹핑 시 사용 가능)

use sakila;
# 고객, 스태프별 총 매출 출력
# 고객별 총 매출을 추가해서 출력
select customer_id
		, ifnull(staff_id, 'total')
        , sum(amount) as sum_amount 
from payment
group by customer_id, staff_id
with rollup;

# 연월별 총매출 출력
select date_format(payment_date, '%Y-%m') as monthly
		, ifnull(staff_id, 'total')
		, sum(amount)
from payment
group by monthly, staff_id
with rollup;

# 변수 선언
set @data = 1;
select @data;

# 변수 선언을 이용한 Ranking 출력
use world;
set @RANK = 0;
select @RANK := @RANK + 1 as ranking
		, code, name, population
from country
order by population desc
limit 5;

# 함수를 이용한 ranking 출력
select rank() over (order by gnp desc) as ranking, code, name, population
from country
order by population desc
limit 5;
# rank() : 공동순위가 있으면 건너뜀 : 1 2 2 4 5
# dense_rank() : 공동순위가 있어도 건너뛰지 않음 : 1 2 2 3 4
# row_number() : 공동순위를 무시 : 1 2 3 4 5

# 데이터타입의 형변환 : float > int -> cast(컬럼 as signed int)
select countrycode
		, cast(avg(population) as signed int) as avg_population
from city
group by countrycode; 

# 날짜 계산 -> datediff()
use sakila;
select payment_date, last_update
		, datediff(last_update, payment_date)
from payment;

# timestampdiff -> 월, 주, 일, 시, 분, 초로 계산 가능
select payment_date, last_update
		, timestampdiff(month, payment_date, last_update)
from payment;

# UTC > KST
select payment_date + interval 9 hour as KST
from payment;
