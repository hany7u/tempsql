﻿select '付款单' 单据名称, h.billno 付款单号,h.billdate 付款日期,orgs.name 采购组织,dept.name 采购部门,psn.name 业务员,s.code 供方编码,s.name 供方名称,mclazz.name 物料分类,m.name 物料名称, meas.name 计量单位,b.local_money_bal  未核销金额,t.name 结算方式,'' 票据到期日,fiorg.name 财务组织,clazz.name 供应商基本分类
from ap_payitem b
left join ap_paybill h on b.pk_paybill = h.pk_paybill
left join org_dept dept on b.pu_deptid = dept.pk_dept
left join org_orgs orgs on dept.pk_org = orgs.pk_org
left join bd_psndoc psn on b.pk_psndoc = psn.pk_psndoc
left join bd_supplier s on b.supplier = s.pk_supplier
left join bd_supplierclass clazz on s.pk_supplierclass = clazz.pk_supplierclass
left join bd_balatype t on b.pk_balatype = t.pk_balatype
left join org_orgs fiorg on h.pk_org = fiorg.pk_org
left join bd_material m on b.material = m.pk_material
left join bd_marbasclass mclazz on m.pk_marbasclass = mclazz.pk_marbasclass
left join bd_measdoc meas on b.postunit = meas.pk_measdoc
where b.dr = 0 and b.local_money_bal <> 0 and h.billstatus = 1 and s.supprop = 0
