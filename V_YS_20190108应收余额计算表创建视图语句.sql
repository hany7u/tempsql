create or replace view V_YS_20190108 AS
select ar_recitem.pk_recitem 应收单行主键,ar_recbill.billno 应收单号,d2.billno 对方单据号,d2.billclass 对方单据类型,
       substr(h.busidate,1,10) 处理时间,
       h.busiflag 处理标识,       
       substr(ar_recitem.billdate,1,10) 单据日期,
       substr(ar_recitem.busidate,1,10) 起算日期,
       substr(d2.billdate,1,10) 对方单据日期,
       ar_recitem.local_money_de 组织本币价税合计,
       nvl(b.local_money_de,0)+nvl(b.local_money_cr,0)  处理本币金额,
       m.code 物料编码,m.name 物料名称,
       cust.code 客户编码,cust.name 客户名称,
       orgs.name 发货库存组织,
       fiorgs.name 财务组织
from ar_recitem ar_recitem --客户应收单行
left join ar_recbill ar_recbill --客户应收单
     on ar_recitem.pk_recbill  = ar_recbill.pk_recbill
left join arap_verifydetail b--核销明细
     on ar_recitem.pk_recitem = b.pk_item
left join arap_verify h --核销主表
     on b.pk_verify = h.pk_verify
left join arap_busidata d2 on b.pk_busidata2 = d2.pk_busidata  --对方业务数据
left join ar_gatherbill ar_gatherbill on b.pk_bill2 = ar_gatherbill.pk_gatherbill
left join bd_material m on ar_recitem.material = m.pk_material
left join bd_customer cust on ar_recitem.customer = cust.pk_customer
left join so_squareinv_d invd on csalesquaredid = ar_recitem.top_itemid
left join so_saleinvoice_b invb on invd.csquarebillbid   = invb.csaleinvoicebid
left join org_orgs orgs on invb.csendstockorgid = orgs.pk_org
left join org_orgs fiorgs on ar_recbill.pk_org = fiorgs.pk_org
where 1=1 
      --and ar_recbill.src_syscode = '3' --应收单来源于销售系统      
      --and d2.billclass = 'yf'
      --and ar_recbill.billno in ( '2014071662')
      --and m.code in( '100210006','100210011','100210003')
      --and cust.code = '402030290' 
      and ar_recitem.dr = 0 and ar_recbill.dr = 0
      and fiorgs.name= '保龄宝生物股份有限公司本部'
      --and (substr(d2.billdate,1,10)<='2018-12-31' or d2.billdate is null) and substr(ar_recitem.billdate,1,10)<='2018-12-31'  
union all
select ar_recitem.pk_recitem 应收单行主键,ar_recbill.billno 应收单号,ar_recbill.billno 对方单据号,'hd' 对方单据类型,
       substr(h.busidate,1,10) 处理时间,
       h.dealflag  处理标识,       
       substr(ar_recitem.billdate,1,10) 单据日期,
       substr(ar_recitem.busidate,1,10) 起算日期,
       substr(h.busidate,1,10) 对方单据日期,
       ar_recitem.local_money_de 组织本币价税合计,
       b.local_money_de+b.local_money_cr  处理本币金额,
       m.code 物料编码,m.name 物料名称,
       cust.code 客户编码,cust.name 客户名称,
       orgs.name 发货库存组织,
       fiorgs.name 财务组织
from ar_recitem ar_recitem --客户应收单行
left join ar_recbill ar_recbill --客户应收单
     on ar_recitem.pk_recbill  = ar_recbill.pk_recbill
inner join arap_agiotage_d b--损益明细
     on b.pk_item = ar_recitem.pk_recitem
left join arap_agiotage h --损益主表
     on b.pk_agiotage = h.pk_agiotage
left join bd_material m on ar_recitem.material = m.pk_material
left join bd_customer cust on ar_recitem.customer = cust.pk_customer
left join so_squareinv_d invd on csalesquaredid = ar_recitem.top_itemid
left join so_saleinvoice_b invb on invd.csquarebillbid   = invb.csaleinvoicebid
left join org_orgs orgs on invb.csendstockorgid = orgs.pk_org
left join org_orgs fiorgs on ar_recbill.pk_org = fiorgs.pk_org
where 1=1 
      --and ar_recbill.src_syscode = '3' --应收单来源于销售系统      
      --and d2.billclass = 'yf'
      --and ar_recbill.billno in ( '2014071662')
      --and m.code in( '100210006','100210011','100210003')
      --and cust.code = '402030290' 
      and ar_recitem.dr = 0 and ar_recbill.dr = 0
      and fiorgs.name= '保龄宝生物股份有限公司本部'
      --and substr(h.busidate,1,10)<='2018-12-31' and substr(ar_recitem.billdate,1,10)<='2018-12-31'
      
union all
select ar_recitem.pk_recitem 应收单行主键,ar_recbill.billno 应收单号,d2.billno 对方单据号,d2.billclass 对方单据类型,
       substr(h.busidate,1,10) 处理时间,
       h.busiflag  处理标识,       
       substr(ar_recitem.billdate,1,10) 单据日期,
       substr(ar_recitem.busidate,1,10) 起算日期,
       substr(d2.billdate,1,10) 对方单据日期,
       ar_recitem.local_money_de 组织本币价税合计,
       b.local_money   处理本币金额,
       m.code 物料编码,m.name 物料名称,
       cust.code 客户编码,cust.name 客户名称,
       orgs.name 发货库存组织,
       fiorgs.name 财务组织
from ar_recitem ar_recitem --客户应收单行
left join ar_recbill ar_recbill --客户应收单
     on ar_recitem.pk_recbill  = ar_recbill.pk_recbill
inner join arap_debtstransfer b--并账明细
     on b.pk_item = ar_recitem.pk_recitem
left join arap_transfer_h h --并账主表
     on b.pk_transfer_h = h.pk_transfer_h
left join arap_busidata d2 on b.pk_hisdata2  = d2.pk_busidata  --对方业务数据
--left join ar_gatherbill ar_gatherbill on b.pk_bill2 = ar_gatherbill.pk_gatherbill
left join bd_material m on ar_recitem.material = m.pk_material
left join bd_customer cust on ar_recitem.customer = cust.pk_customer
left join so_squareinv_d invd on csalesquaredid = ar_recitem.top_itemid
left join so_saleinvoice_b invb on invd.csquarebillbid   = invb.csaleinvoicebid
left join org_orgs orgs on invb.csendstockorgid = orgs.pk_org
left join org_orgs fiorgs on ar_recbill.pk_org = fiorgs.pk_org
where 1=1
      --and ar_recbill.billno in ( '2014071662')
      --and m.code in( '100210006','100210011','100210003')
      --and cust.code = '402030290' 
      and ar_recitem.dr = 0 and ar_recbill.dr = 0
      and fiorgs.name= '保龄宝生物股份有限公司本部'
