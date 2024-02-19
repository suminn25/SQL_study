#  create database mgs;

# Excel : 사용이 쉬움 : 100만개 : 속도느림
# Python : 커스터마이징 : RAM 용량 : 속도빠름(엑셀보다)
# Database : SSD(HDD) 용량 : 속도빠름(파이썬보다)
# Bigdata : Spark : 여러 개의 컴퓨터

# SQL 쿼리 종류

# DML 
# - Data : C(create) R(read) U(update) D(delete)
# - CREATE : insert into
# - READ : select from
# - UPDATE : update set
# - DELETE : delete from
# DDL
# - DATABASE, TABLE : CRUD
# - CREATE : create
# - READ : show, desc
# - UPDATE : alter
# - DELETE : drop
# DCL
# - SYSTEM

# DDL : READ : SELECT FROM
# win : ctrl + enter
select *
from world.country;

# * : '모든' 의미
# sql은 대소문자 구분x
# 명령어는 대문자로 작성
select Code, Name, Population
from world.country;

# Database 선택
use world;
select * from country;

# 선택된 데이터 베이스 확인
select database();

# sakila 데이터 베이스 선택 > payment 데이터 출력
use sakila;
select database();
select * from payment;
# use wolrd;
# select * from countrylanguage;

# mysql comment(주석)
# 실행되지 않는 문자열
# 코드 설명, 코드는 남기되 실행 X
# -- : 한줄주석
# /* sql query */ : 여러 줄 주석
select
	code
/*    , name
    , population */
from country;			

# Operator : 연산자
# 산술 : +, -, *, /, % 
# 	- 데이터 + 데이터 = 데이터

# world.country 테이블에서 인구밀도(인구수/면적) 출력
select *
from world.country;
use wolrd;
select database();
select code, name, population, surfacearea
		, population / surfacearea
from country;

# country 테이블에서 1인당 GNP 출력
# columns : code, name, gnp, population
select code, name, gnp, population
		, gnp/population as gpp
from country;				

# 비교 : =, !=, >, <, >=, <= 
# 	- 데이터 + 데이터 = 논리값(TRUE(1), FALSE(0))

# country 테이블에서 국가코드, 국가이름, 대륙이름 출력
# 아시아 대륙이면 1, 아니면 0을 출력하는 컬럼 추가
select code, name, continent
		, continent = 'Asia' as is_Asia
from country;

# country 테이블에서 인구수가 1000만명 이상이면 1, 아니면 0 출력
# code, name, population, upper_1000
select code, name, population
		, population >= 1000 * 10000 as upper_1000
from country;
# 연산자 우선순위 : 산술 > 비교 > 논리

# 논리 : not, and, or
# 	- 논리값 + 논리값 = 논리값
# 	- and(T) : T and T = T
# 	- or(F) : F or F = F

# 비교연산 : 조건 1개
# (비교연산) <논리연산> (비교연산) = 논리값 : 조건 2개

# country 테이블에서 아시아국가이면서 인구수가 1000만 이상이면
# 1을 출력 아니면 0을 출력
select code, name, continent, population
		, continent = 'Asia' and
        population >= 10000000 as asia_1000
from country;
# and : 두 개의 조건 모두 만족 
# or : 둘 중의 하나의 조건 만족

# country 테이블에서 asia와 africa 대륙이면 1 출력 아니면 0 출력
# code, name, continent, is_asia_africa
select code, name, continent
		, (continent = 'Asia') or (continent = 'Africa')
        as is_asia_africa
from country;

# WHERE : 조건절
# 특정 조건으로 데이터를 필터링 할때 사용
# 산술, 비교, 논리 연산자 사용 가능
select code, name, continent
from country
where (continent = 'Asia') 
		or (continent = 'Africa');

# city 테이블에서 도시의 인구가 500만 ~ 1000만인 도시를 출력
select *
from city;
select name, CountryCode, Population
from city
where (Population >= 5000000) 
		and (Population <= 10000000);

# BETWEEN
select name, countrycode, population
from city
where population between 500 * 10000
 and 1000 * 10000;

# city 테이블에서 국가 코드가 USA, KOR 도시 출력
select name, countrycode
from city
where countrycode = 'USA'
 or countrycode = 'KOR';

# IN, NOT IN
select name, countrycode
from city
where countrycode in ('USA', 'KOR');

# LIKE : 특정 문자열이 포함된 데이터 출력
# country 테이블에서 정부형태에 republic이 들어간 국가 출력
select code, name, GovernmentForm
from country
where GovernmentForm like "%republic%";

# % 의미 : 아무 문자 0개 이상
select code
from country
where code like 'K%';

# 테이블 구조 출력
desc country;

# 정렬 : ORDER BY : ASC, DESC
# 인구수를 오름차순으로 정렬하여 국가 정보를 출력
select code, name, population
from country
order by population desc;

# 여러개 컬럼에 대한 정렬
# 국가코드를 내림차순 정렬 > 인구수를 오름차순 정렬
select countrycode, name, population
from city
order by countrycode desc, population;

# LIMIT : 조회하는 데이터의 수 제한
# 인구수가 많은 국가 5개 출력
# 인구수 내림차순 정렬 > 상위 5개로 데이터 제한
select code, name, population
from country
order by population desc
limit 5;

# 인구수가 많은 6위 ~ 8위 국가 출력
# limit num1 : num1(limit)
# limit num1, num2 : num1(skip), num2(limit)
select code, name, population
from country
order by population desc
limit 5, 3;

# 페이지당 출력 데이터 수 : block
# 몇 번째 페이지 : page
# block : 30, page 2
# limit (page - 1) * block, block

# DML : DATA(in table) : READ
# select <columns>
# from < table_name>
# where 
#	- 연산자(산술, 비교, 논리)
#	- between, in, not in, like
# order by : asc, desc
# limit : num1(limit) : num1(skip), num2(limit)

 use sakila;
 select * from film_list;
select database();

use sakila;
select * from film_list;

# category : sci-fi, drama
# length : 오름차순 정렬, 5편의 영화 목록 출력
# description : robot
# title, description, category, length, price
select title, description, category, length
from film_list
where category in ('sci-fi', 'drama')
	and description like '%robot%'
order by length
limit 5;



