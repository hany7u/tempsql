insert into T_YS_YUETAB(应收单行主键,应收单号,对方单据号,对方单据类型,
  处理时间,
  处理标识,
  单据日期,
  起算日期,对方单据日期,
  
  组织本币价税合计,
  处理本币金额,
  物料编码,
  物料名称,
  客户编码,
  客户名称,
  发货库存组织) 
select ar_recitem.pk_recitem 应收单行主键,ar_recbill.billno 应收单号,d2.billno 对方单据号,d2.billclass 对方单据类型,
       substr(h.busidate,1,10) 处理时间,
       h.busiflag 处理标识,       
       substr(ar_recitem.billdate,1,10) 单据日期,
       substr(ar_recitem.busidate,1,10) 起算日期,
       substr(d2.billdate,1,10) 对方单据日期,
       ar_recitem.local_money_de 组织本币价税合计,
       b.local_money_de+b.local_money_cr  处理本币金额,
       m.code 物料编码,m.name 物料名称,
       cust.code 客户编码,cust.name 客户名称,
       orgs.name 发货库存组织
from arap_verifydetail b --核销明细
left join arap_verify h --核销主表
     on b.pk_verify = h.pk_verify
left join arap_busidata d on b.pk_busidata = d.pk_busidata and d.billclass = 'ys' --业务数据
left join arap_busidata d2 on b.pk_busidata2 = d2.pk_busidata  --对方业务数据
left JOIN ar_recitem ar_recitem --客户应收单行
    ON b.pk_item = ar_recitem.pk_recitem
left join ar_recbill ar_recbill --客户应收单
     on b.pk_bill  = ar_recbill.pk_recbill
left join ar_gatherbill ar_gatherbill on b.pk_bill2 = ar_gatherbill.pk_gatherbill
left join bd_material m on ar_recitem.material = m.pk_material
left join bd_customer cust on b.customer = cust.pk_customer
left join so_squareinv_d invd on csalesquaredid = ar_recitem.top_itemid
left join so_saleinvoice_b invb on invd.csquarebillbid   = invb.csaleinvoicebid
left join org_orgs orgs on invb.csendstockorgid = orgs.pk_org

where 1=1 and b.billclass = 'ys'
      and ar_recbill.src_syscode = '3' --销售系统
/*      and d2.billclass = 'yf'
      --and ar_recbill.billno in( '06551705','01338403','01338403')
--order by ar_gatherbill.billdate
*/