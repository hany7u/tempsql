select *
from (select owner || '.' || tablespace_name name, sum(b) g
from (select owner,
t.segment_name,
t.partition_name,
round(bytes / 1024 / 1024 / 1024, 2) b,
tablespace_name
from dba_segments t)
where owner not in
('SYS', 'OUTLN', 'SYSTEM', 'TSMSYS', 'DBSNMP', 'WMSYS')
group by owner || '.' || tablespace_name)
order by name 
