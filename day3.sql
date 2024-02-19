# SQL 종류
# - DML : DATA : C(insert into)R(select from)U(update set)D(delete from)
# - DDL : DATABASE, TABLE : C(create)R(show,desc)U(alter)D(drop)
# - DCL : SYSTEM

# DML : READ : select from where order by limit
# select <columns> from <table name>
# as : 컬럼이름 대체 
# where : 특정 조건에 해당하는 데이터 출력
#	- 연산자
#		- 산술(데이터+데이터=데이터) : +, -, *, /, %
#		- 비교(데이터+데이터=논리값) : =, !=, >, <, >=, <= : 조건 1가지
#		- 논리(논리값+논리값=논리값) : not, and(T), or(F) : 조건 2가지 이상
#		- 우선순위 : 산술 > 비교 > 논리 
#	- between and : 범위로 데이터를 필터링해서 출력
#	- in, not in : 특정 데이터가 포함(되지않은)된 필터링해서 출력
#	- like : 특정 문자열이 포함된 데이터 출력 : %(아무문자 0개이상)
# order by : 데이터 정렬 : asc(생략가능), desc : 여러개의 컬럼을 기준으로 정렬
# limit : num1(limit) : num1(skip), num2(limit)

# DDL : CREATE : create
desc world.city;
# table 생성 조건 : field, datatype, constraint

use mgs;
create table num1(data tinyint);
show tables; # 현재 데이터 베이스의 테이블 목록 출력
desc num1;
select * from num1;
insert into num1 value (128);
insert into num1 value (-128);

create table num2( data tinyint unsigned );
desc num2;
insert into num2 value (128);
select * from num2;

create table num3( data float );
desc num3;
insert into num3 value (12.3456789);
select * from num3;

create table num4( data double );
desc num4;
insert into num4 value (12.34567890123456789);
select * from num4;

create table num5( data double(5, 2) );
desc num5;
insert into num5 value (123.456);
select * from num5;

# 데이터타입
# - 숫자 : 정수형(int), 실수형(float)
# - 문자열 : 고정(char), 가변(varchar), 긴길이(text)
# - 날짜시간 : datetime, timestamp

# 제약조건
# not null : null 저장 x
# unique : 중복 데이터 저장 x
# primary key : not null + unique
# default : 데이터 저장시 해당 컬럼에 데이터가 없으면 default 값으로 저장
# auto_increment : 자동으로 1씩 숫자를 증가시켜 데이터 저장

# create database
create database tmp;

# DDL : READ : show
show databases;
show tables;

use tmp;

# create : table : field, datatype, constrant
create table user(
	user_id int primary key auto_increment
    , name varchar(20) not null
    , email varchar(30) not null unique
    , age int default 30
    , rdate timestamp
);

desc user;

show tables;

# DDL : UPDATE : alter
# change database encoding
show variables like 'character_set_database';

# 테이블 생성시 인코딩 방식은 데이터베이스의 인코딩 방식을 따름
alter database tmp character set = utf8;
show variables like 'character_set_database';

# change table
# add : 컬럼 추가
# modify : 컬럼 수정
# drop : 컬럼 삭제

desc user;

alter table user add content text;
alter table user modify column content varchar(100) not null;
alter table user drop content;

# change table encoding
show full columns from user;
alter table user convert to character set utf8mb3;

# DDL 
# delete table
drop table user;
show tables;

# delete database
drop database tmp;
show databases;

# mgs 데이터 베이스 삭제
drop database mgs;
# mgs 데이터 베이스 생성
create database mgs;
# 데이터 베이스 목록 확인
show databases;
# mgs 데이터 베이스 선택
use mgs;
# 선택된 데이터 베이스 확인
select database();
# user 테이블 생성
create table user(
	user_id int primary key auto_increment
    , name varchar(20) not null
    , email varchar(30) not null unique
    , age int default 30
    , rdate timestamp default current_timestamp
);
# user 테이블 목록 확인
show tables;
# user 테이블 구조 확인
desc user;

# DDL : DATABASE, TABLE : CRUD
# C(create) R(show, desc) U(alter: add, modify, drop) D(drop)

# DML : CREATE : insert into
insert into user(name, email, age)
value('andy', 'andy@gamil.com', 27);
select * from user;

insert into user(name, email, age)
values('alice', 'alice@naver.com', 32)
, ('peter', 'peter@gamil.com', 25)
, ('jhon', 'jhon@mysql.com', 38);
select * from user;

insert into user(name, email)
value('andy2', 'andy2@gamil.com');
desc user; # 데이터 구조 확인
select * from user; # unique

# select 실행 후 나온 결과를 insert
# 30세 미만의 user 출력 : user_id, name, age
select user_id, name, age
from user
where age < 30;

create table user_20(
	user_id int
    , name varchar(20)
    , age int
    );

insert into user_20
select user_id, name, age
from user
where age < 30;

select * from user_20;
# show, desc, select 차이!!!!!

# DML : UPDATE : update set
select * from user;
# user_id = 6 데이터의 name = anchel, age =34 으로 변경
update user
set name = 'anchel', age =34
where user_id=6
limit 5;
select * from user;

# 현재 프로세스에서 실행되는 쿼리 리스트 출력
show processlist;

# 프로세스 아이디로 쿼리 실행 강제 중단
kill 130;

select * from user;
# 30세 이상의 user의 나이를 30으로 변경
update user
set age = 30
where age >=30
limit 100; # 데이터 개수 제한 명령

select * from user
where age >= 30;

select * from user;

# DML : DELETE : delete from
select * from user;

# 2022-12-07 02:35 이후의 데이터 삭제
select * from user
where rdate > '2022-12-07 02:35';

delete from user
where rdate > '2022-12-07 02:35'
limit 2;

select * from user;

# truncate : 테이블 초기화 : 스키마 구조만 남기고 데이터 모두 삭제
truncate user;
select * from user;

# 외래키 : Foreign Key
# 데이터의 무결성을 지켜줌
use mgs;
show tables;
drop table user;
drop table user_20;

# 테이블 만들기
create table user(
	ui int primary key auto_increment
    , un varchar(10)
);
desc user;
create table income(
	ui int
	, am int
);
desc income;
# 데이터 추가
insert into user(un)
values('A'), ('B'), ('C');
select * from user;

insert into income(ui, am)
values (1, 100), (2, 200), (4, 300);
select * from income;

delete from income
where ui = 4
limit 1;
select * from income;

# FK 추가 ( 테이블 생성 후)
desc income;
alter table income
add constraint fk_user
foreign key (ui) references user (ui);
desc income;

# FK 제약조건에 의해 에러 발생
insert into income(ui, am)
value (4, 300);

# 무결성 조약 지켜줌
insert into income(ui, am)
value (3, 300);
select * from income;

update user
set ui = 4
where ui = 2
limit 1;

# on delete, on update 설정 가능
# - cascade : 동기화
# - set null : null 변경
# - no action : 변경 x
# - set default : default 변경
# - restrict : 수정, 삭제 불가 -> FK키 디폴트

drop table income;

# FK 추가 (테이블 생성 시)
# update 동기화(cascade), delete null(set null)
create table income(
	ui int
    , am int
    ,foreign key (ui) references user(ui)
    on update cascade on delete set null
);

insert into income(ui, am)
values (1, 100), (1, 200), (2, 300), (2, 400), (3, 500);
select * from income;

update user
set ui=4
where ui=2
limit 1;
select * from income;

delete from user
where ui = 1
limit 1;
select * from income;

# mysql 함수들
# 함수 : 특별한 기능을 하는 sql 코드
select database();

# round() : 반올림
use world;
select * from country;
select round(12.345, 2);
use wolrd;
select countrycode, language, round(percentage)
from countrylanguage;

# concat() : 컬럼들을 합쳐서 새로운 컬럼을 만들때
# 국가이름(국가코드)
select code, name, concat(name, '(', code, ')')
from country;

# distinct() : 중복데이터를 제거해서 출력
# 전세계의 대륙 리스트를 출력
select distinct(continent)
from country;

# count() : row 데이터의 갯수를 출력
# 한국 도시의 갯수를 출력
select count(name) # 어떤 컬럼을 써도 갯수 동일(*)
from city
where countrycode = 'KOR';

# date_format() : 날짜 데이터의 포멧을 변경 : y-m-d h:m:s -> y-m
use sakila;

# 매출이 발생한 년월을 출력
select distinct(date_format(payment_date,'%Y-%m %p')) # 레퍼런스 확인
from payment;

# round, concat, distinct, count, date_format

# condition function : if, ifnull, case when then
# 도시의 인구가 100만이 넘으면 big, 아니면 small을 출력하는 컬럼 추가
use world;
select countrycode, name, population
		, if(population >= 100 * 10000, 'big', 'small') as scale
from city
order by population desc;

# 도시의 인구가 500만이 넘으면 big, 100만이 넘으면 medium, 나머지는 small
select countrycode, name, population
		, case 
				when population >= 500 * 10000 then 'big'
				when population >= 100 * 10000 then 'medium'
                else 'small'
			end as scale
from city
order by population desc;

# ifnull : null 데이터를 특정 데이터로 출력
select code, name, indepyear, ifnull(indepyear, 0)
from country;

# group by
# 특정 컬럼(중복결합) - 다른 컬럼(결합함수)
# sum, count, min, max, avg . . .
# 국가별 도시의 개수 출력
# 도시가 많은 상위 5개 국가 출력
select countrycode, count(name) as count # 결합함수 
from city
group by countrycode # 중복결합
order by count desc
limit 5;

# country 테이블에서 대륙별 총 인구수를 출력, 인구가 많은 상위 세 개의 대륙 출력
select continent, sum(population) as total_population
from country
group by continent
order by total_population desc
limit 3;



