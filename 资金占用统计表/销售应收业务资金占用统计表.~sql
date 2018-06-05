select '销售出库单' 单据名称, h.vbillcode 单据号, substr(h.dbilldate,1,10) 单据日期, orgs.name 销售组织, dept.name 销售部门, psn.name 业务员, cust.code 客户编码,
       cust.name 客户名称, m.code 产品编码, m.name 产品名称, b.nnum 数量, b.nprice 无税单价, b.ntaxmny  产品金额,b.ntaxprice *( b.nnum-nvl(e.nsignnum,0)-nvl(e.naccumwastnum,0) - nvl(e.nrushnum,0)- nvl(e.naccumoutbacknum,0)) 未处理金额,clazz.name 客户基本分类
from   ic_saleout_b b
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
left join ic_saleout_e e on b.cgeneralbid = e.cgeneralbid
left join org_orgs orgs on h.csaleorgoid = orgs.pk_org
left join org_dept dept on h.cdptid = dept.pk_dept
left join bd_psndoc psn on h.cbizid = psn.pk_psndoc
left join bd_customer cust on h.ccustomerid = cust.pk_customer
left join bd_custclass clazz on cust.pk_custclass = clazz.pk_custclass
left join bd_material m on b.cmaterialoid = m.pk_material
/*left join so_delivery_b d on b.csourcebillhid = d.cdeliverybid
left join so_saleorder_b o on d.csrcbid = o.csaleorderbid*/
where b.nnum-nvl(e.nsignnum,0) <> 0 and b.dr = 0 and b.nnum-nvl(e.nsignnum,0)-nvl(e.naccumwastnum,0) <> 0 AND  b.nnum-nvl(e.nsignnum,0)-nvl(e.naccumwastnum,0) - nvl(e.naccumoutbacknum,0) <> 0
AND  b.nnum-nvl(e.nsignnum,0)-nvl(e.naccumwastnum,0) - nvl(e.nrushnum,0) <> 0 and h.fbillflag = 3 and cust.custprop = 0

union all
select '销售发票' 单据名称, h.vbillcode 单据号, substr(h.dbilldate,1,10) 单据日期, orgs.name 销售组织,dept.name 销售部门,psn.name 业务员,cust.code 客户编码,
       cust.name 客户名称,m.code 产品编码, m.name 产品名称, b.nnum 数量,b.nprice 无税单价,b.ntaxmny  产品金额,nvl(ar.local_money_bal,b.nmny) 未处理金额,clazz.name 客户基本分类
from   so_saleinvoice_b b
left join so_saleinvoice h on b.csaleinvoiceid = h.csaleinvoiceid
left join org_orgs orgs on b.csaleorgid = orgs.pk_org
left join org_dept dept on b.cdeptid = dept.pk_dept
left join bd_psndoc psn on b.cemployeeid = psn.pk_psndoc
left join bd_customer cust on h.cinvoicecustid = cust.pk_customer
left join bd_custclass clazz on cust.pk_custclass = clazz.pk_custclass
left join bd_material m on b.cmaterialid = m.pk_material
left join so_squareinv_b so_squareinv_b on b.csaleinvoicebid = so_squareinv_b.csquarebillbid 
left join so_squareinv_d d on so_squareinv_b.csalesquarebid = d.csalesquarebid 
left join ar_recitem ar on d.csalesquaredid    = ar.top_itemid
where b.dr = 0 and nvl(so_squareinv_b.dr,0) = 0 and nvl(d.dr,0) = 0 and nvl(d.fsquaretype,1) = 1 and nvl(ar.local_money_bal,b.nmny) <> 0 and cust.custprop = 0

