select '采购入库单' 单据名称, h.vbillcode 单据编号, h.dbilldate 单据日期, orgs.name 采购组织, dept.name 采购部门, psn.name 业务员, s.code 供方编码,
       s.name 供方名称, m.code 物料编码, m.name 物料名称, b.nnum 入库数量, b.nprice 无税单价, b.ntaxprice 含税单价, b.nmny 无税金额, b.ntaxmny 价税合计,  b.ntaxprice*(b.nnum - nvl(e.nsignnum,0)) 未处理金额,clazz.name 供应商基本分类
from   ic_purchasein_b b
left join ic_purchasein_h h on b.cgeneralhid = h.cgeneralhid
left join ic_purchasein_e e on b.cgeneralbid = e.cgeneralbid
left join org_orgs orgs on h.cpurorgoid = orgs.pk_org
left join org_dept dept on h.cdptid = dept.pk_dept
left join bd_psndoc psn on h.cbizid = psn.pk_psndoc
left join bd_supplier s on h.cvendorid = s.pk_supplier
left join bd_supplierclass clazz on s.pk_supplierclass = clazz.pk_supplierclass
left join bd_material m on b.cmaterialvid = m.pk_material
where b.dr = 0 and b.nnum - nvl(e.nsignnum,0) <> 0 and h.fbillflag = 3 and s.supprop = 0
union all
select '采购发票' 单据名称, h.vbillcode 单据编号,substr( h.dbilldate,1,10) 单据日期, orgs.name 采购组织,dept.name 采购部门, psn.name 业务员, s.code 供方编码,
       s.name 供方名称, m.code 物料编码, m.name 物料名称, b.nnum  入库数量, b.nprice 无税单价, b.ntaxprice 含税单价, b.nmny 无税金额, b.ntaxmny 价税合计, t.local_money_bal  未处理金额,clazz.name 供应商基本分类
from po_invoice_b b
left join po_invoice h on b.pk_invoice = h.pk_invoice
/*left join po_invoice_b invoice_b on b.top_itemid = invoice_b.pk_invoice_b
left join po_invoice invoice on invoice_b.pk_invoice = invoice.pk_invoice*/
left join org_orgs orgs on b.pk_org = orgs.pk_org
left join org_dept dept on h.pk_dept = dept.pk_dept
left join bd_psndoc psn on h.pk_bizpsn = psn.pk_psndoc
left join bd_supplier s on b.pk_supplier = s.pk_supplier
left join bd_supplierclass clazz on s.pk_supplierclass = clazz.pk_supplierclass
left join bd_material m on b.pk_material = m.pk_material
left join ap_payableitem t on b.pk_invoice_b = t.top_itemid

 where t.local_money_bal <> 0 and b.dr = 0 and nvl(t.dr,0) = 0 and s.supprop = 0


