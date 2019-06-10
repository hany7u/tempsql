select  b.cdelivbill_bid bid,o.cdeptid deptid , o.cdeptvid  deptvid 
from dm_delivbill_b b
left join so_saleorder o on b.cfirstid = o.csaleorderid
left join org_dept dept on o.cdeptid = dept.pk_dept
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid
where h.vbillcode = '测试，请勿处理';

select  b.cdelivbill_bid bid,b.cfirstbid, o.cindeptid, o.cindeptvid,b.vbdef20,b.dr
from dm_delivbill_b b
left join to_bill_b o on b.cfirstbid = o.cbill_bid
left join org_dept dept on o.cindeptid = dept.pk_dept
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid
where h.vbillcode = '测试20190513'/*'测试，请勿处理'*/;


update dm_delivbill_b b set b.vbdef20 = '1001B310000000001O3K' where b.cdelivbill_bid = '1001B3100000000YVB9E';
commit;

select * from org_dept_v t where t.pk_vid = '0001B310000000002GB2';

select  b.cdelivbill_bid bid,b.cfirstbid, b.vbdef20,b.dr
from dm_delivbill_b b
where b.cdelivbill_bid = '1001B3100000000YVB9E'
--for update ;


select * from org_dept_v t where t.pk_vid = '0001B310000000002GB2';

select  b.cdelivbill_bid bid,b.cfirstbid, b.vbdef20,b.dr
from dm_delivbill_b b
where b.cdelivbill_bid = '1001B310000000001O3K'
for update ;
