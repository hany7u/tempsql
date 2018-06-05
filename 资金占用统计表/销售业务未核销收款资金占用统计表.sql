select '收款单' 单据名称, h.billno 收款单号,substr(h.billdate,1,10) 收款日期,orgs.name 销售组织, dept.name 销售部门, psn.name 业务员, cust.code  客户编码,cust.name 客户名称,b.local_money_bal  未核销金额,t.name 结算方式, '' 票据到期日,fiorg.name 财务组织,clazz.name 客户基本分类
from   ar_gatheritem b
left join ar_gatherbill h on b.pk_gatherbill = h.pk_gatherbill
left join org_orgs orgs on b.so_org = orgs.pk_org
left join org_dept dept on b.so_deptid = dept.pk_dept
left join bd_psndoc psn on b.so_psndoc = psn.pk_psndoc
left join bd_customer cust on b.customer = cust.pk_customer
left join bd_custclass clazz on cust.pk_custclass = clazz.pk_custclass
left join bd_balatype t on b.pk_balatype = t.pk_balatype
left join org_orgs fiorg on h.pk_org = fiorg.pk_org

where b.dr = 0 and b.local_money_bal <> 0 and h.billstatus  = 1 and cust.custprop = 0
