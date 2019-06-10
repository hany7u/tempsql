--物资需求申请单记录
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.po_storereq_b b
left join nc65.po_storereq h on b.pk_storereq = h.pk_storereq
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--采购请购单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.po_praybill_b b
left join nc65.po_praybill h on b.pk_praybill = h.pk_praybill
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--采购订单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.po_order_b b
left join nc65.po_order h on b.pk_order = h.pk_order
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--到货单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.po_arriveorder_b b
left join nc65.po_arriveorder h on b.pk_arriveorder = h.pk_arriveorder
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--销售订单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.so_saleorder_b b
left join nc65.so_saleorder h on b.csaleorderid = h.csaleorderid
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and orgs.name <> '山东天然之宝进出口有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--发货单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,count(*) 记录数
from nc65.so_delivery_b b
left join nc65.so_delivery h on b.cdeliveryid = h.cdeliveryid
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and orgs.name <> '山东天然之宝进出口有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name
order by substr(h.creationtime,1,10);

--报检单
select substr(h.creationtime,1,10) 创建日期,orgs.name,u.user_name,t.billtypename,count(*) 记录数
from nc65.qc_applybill_s b
left join nc65.qc_applybill h on b.pk_applybill = h.pk_applybill
left join nc65.bd_billtype t on h.ctrantypeid = t.pk_billtypeid
left join nc65.org_orgs orgs on h.pk_org = orgs.pk_org
left join nc65.sm_user u on h.billmaker = u.cuserid
where orgs.name <> '山东禹王制药有限公司' and orgs.name <> '山东天然之宝进出口有限公司' and b.dr = 0
group by substr(h.creationtime,1,10),orgs.name,u.user_name,t.billtypename
order by substr(h.creationtime,1,10);
