# VIEW
# 가상의 테이블 : 실제 데이터 저장 X 
# 추가, 수정, 삭제 불가능
# 쿼리를 더 단순화 시켜줌 > 가독성을 좋게
# 도시의 인구가 900만 이상인 도시의 국가코드, 국가이름, 도시이름, 도시인구수 출력
use world;
select country.code, country.name, city.name, city.population
from country
join(
	select countrycode, name, population
	from city
	where population >= 900 * 10000
) as city
on country.code = city.countrycode;

create view city_900 as
select countrycode, name, population
from city
where population >= 900 * 10000;

select * from city_900;

select country.code, country.name, city.name, city.population
from country
join city_900 as city
on country.code = city.countrycode;

# 데이터 베이스 백업
# csv 파일 백업
select *
from country
where population >= 10000 * 10000;
# pdf 5

# trigger
# 특정 테이블을 감시하고 있다가 설정 조건이 감지되면
# 지정한 쿼리가 자동으로 실행
# 1일치 update, delete가 실행된 쿼리 백업
use mgs;
create table chat(
		chat_id int primary key auto_increment
        , msg varchar(200) not null
);
drop table chat;
insert into chat(msg)
values("hello"), ("hi"), ("mysql"), ("python");
select * from chat;

create table chat_backup(
	chat_backup int primary key auto_increment
    , chat_id int 
    , msg varchar(200)
    , bdate timestamp default current_timestamp
);


select * from chat_backup;

