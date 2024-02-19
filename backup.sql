delimiter |
create trigger cbackup
before delete on chat
for each row begin
	insert into chat_backup(chat_id, msg)
    values (old.chat_id, old.msg);
end |

show triggers;

select * from chat where msg like "h%";



select * from chat_backup;

delete from chat 
where msg 
like 'h%' limit 5;

select * from chat;
select * from chat_backup;

insert into chat
select chat_id, msg
from chat_backup;

select * from chat;

# Backup
# 데이터베이스 상태 : hot(데이터베이스 on), cold(데이터베이스 off)
# 백업 방식
# logical(sql query)
#  - 백업 속도 느림 : 쿼리 변환 시간과 자원 필요
#  - 용량 적게 사용
#  - 문제발생파악 쉬움 : 쿼리 실행해서 복원 > 에러 메시지 발생
#  - OS 호환이 잘됨
#physical(bin)
#  - 백업 속도 빠름
# 백업 사용 : 데이터양이 많으면 physical 사용, 데이터양이 적으면 logical




