select t.pk_verifydetail    核销子表主键,
       substr(t.busidate,1,10)           处理日期,
       substr(po_invoice.dbilldate,1,10) 采购发票日期,
       ic_purchasein_h.vbillcode 采购入库单号,
       substr(ic_purchasein_b.dbizdate,1,10) 采购入库日期,
       ap_payableitem.busidate 起算日期,
       dept.name 采购部门,
       psn.name 业务员,
       s.code 供应商编码,
       s.name 供应商名称,
       m.code 物料编码,
       m.name 物料名称,
       m.materialspec||m.materialtype 规格型号,
       ic_purchasein_b.nnum 入库数量,
       ap_payableitem.local_money_cr  含税金额,
       TO_NUMBER(TO_DATE(substr(t.busidate,1,10),'yyyy-mm-dd hh24:mi:ss')- TO_DATE(substr(ic_purchasein_b.dbizdate,1,10),'yyyy-mm-dd hh24:mi:ss')) 付款时长_天,
       1 账期,
       1 账期天数,
       ap_payableitem.local_money_cr*TO_NUMBER(TO_DATE(substr(t.busidate,1,10),'yyyy-mm-dd hh24:mi:ss')- TO_DATE(substr(ic_purchasein_b.dbizdate,1,10),'yyyy-mm-dd hh24:mi:ss'))*0.72*0.077/360 账期利润
  from arap_verifydetail t
left join ap_payableitem ap_payableitem on t.pk_item = ap_payableitem.pk_payableitem
left join ap_payablebill ap_payablebill on t.pk_bill = ap_payablebill.pk_payablebill
left join org_dept dept on ap_payableitem.pk_deptid = dept.pk_dept
left join bd_psndoc psn on ap_payableitem.pk_psndoc = psn.pk_psndoc
left join po_invoice_b po_invoice_b     on ap_payableitem.top_itemid = po_invoice_b.pk_invoice_b--采购发票子表
left join po_invoice po_invoice on po_invoice_b.pk_invoice = po_invoice.pk_invoice
left join bd_supplier s on po_invoice.pk_supplier = s.pk_supplier
left join ic_purchasein_b ic_purchasein_b on po_invoice_b.csourcebid = ic_purchasein_b.cgeneralbid--采购入库单子表
left join ic_purchasein_h ic_purchasein_h on ic_purchasein_b.cgeneralhid = ic_purchasein_h.cgeneralhid
left join bd_material m on ic_purchasein_b.cmaterialoid = m.pk_material
where t.billclass = 'yf' and substr(t.busidate,1,4) = '2018'



