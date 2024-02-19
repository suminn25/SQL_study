# DML : DATA : C(insert into)R(select from)U(update set)D(delete from)
# 	- where : 데이터 필터링 출력
#		- operator
#			- 산술(데이터+데이터=데이터)
#			- 비교(데이터+데이터=논리값) : 조건 1개
#			- 논리(논리값+논리값=논리값) : 조건 2개 이상 : not, and(T), or(F)
#		- between, in, not in, like
#	- order by : 데이터 정렬 : asc, desc
#	- limit : num1(limit) : num1(skip) num2(limit)

# DDL : DATABASE, TABLE : C(create)R(show,desc)U(alter)D(drop)
# 	- create table
#		- datatype
#			- numeric(int,float)
#			- string(char,varchar,text)
#			- datetime(datetime,timestamp)
#		- constraint
#			- not null : null 값 저장 X
#			- unique : 중복 데이터 저장 X
#			- primary key : not null, unique 제약조건 설정
#			- auto_increment : 자동으로 숫자를 1씩 증가하면서 데이터 저장 
#			- default : 데이터가 넘어오지 않는경우 default 값을 저장
#			- foreign key : 데이터의 무결성
#				- on update, on delete
#					- cascade, set null, no action, set default, restrict

# functions
#	- round(), concat(), distinct(), count(), date_format()
#	- if(), ifnull(), case when then end

# group by
# 특정컬럼(중복결합), 다른컬럼(결합함수)
# 결합함수 : min, max, avg, sum, count
# 여러개의 컬럼을 그룹핑
# having : 쿼리 실행 후 데이터 필터링

# join
# 두개이상의 테이블을 결합해서 데이터 출력
# inner, left, right, outer(union)

# sub query
# 쿼리 안에 쿼리 작성
# select, from, where

# index
# read에 해당하는 쿼리의 속도 향상
# create, update, delete 속도가 느려짐
# 테이블의 컬럼 단위로 설정 가능
# 자주 사용되는 select 구문의 where에서 사용되는 컬럼