SELECT l.session_id      sid,
       s.serial#,
       'ALTER SYSTEM KILL SESSION ''' || S.SID || ', ' || S.SERIAL# || ''';' 解锁SQL,
       l.locked_mode     锁模式,
       l.oracle_username 登录用户,
       l.os_user_name    登录机器用户名,
       s.machine         机器名,
       s.terminal        终端用户名,
       o.object_name     被锁对象名,
       s.logon_time      登录数据库时间
  FROM v$locked_object l, all_objects o, v$session s
 WHERE l.object_id = o.object_id
   AND l.session_id = s.sid
   and o.OBJECT_NAME in ('PO_ORDER','PO_ORDER_B')
 ORDER BY sid, s.serial#;

SELECT '1' 实例, 
       S.LAST_CALL_ET 耗时,
       NVL(S.CLIENT_IDENTIFIER, S.CLIENT_INFO) NMC标识,
       CASE WHEN LENGTH(S.CLIENT_IDENTIFIER) > 0 THEN '0' ELSE '1 'END NMC,
       S.SQL_ID,
       SUBSTR(Q.SQL_TEXT, 0, 100) 执行的SQL,
       S.EVENT,
       'ALTER SYSTEM KILL SESSION ''' || S.SID || ', ' || S.SERIAL# || ''';' 解锁SQL,
       S.USERNAME 用户名,
       S.STATUS 状态,
       'kill -9 ' || P.SPID KILL_SPID
FROM V$SESSION S
JOIN V$SQL Q ON S.SQL_ADDRESS = Q.ADDRESS AND S.SQL_HASH_VALUE = Q.HASH_VALUE
JOIN V$PROCESS P ON S.PADDR = P.ADDR
WHERE 1 = 1
AND S.STATUS <> 'INACTIVE'
 ;
 
select spid, osuser, s.program 
from v$session s,v$process p
where s.paddr=p.addr and s.sid=578 
