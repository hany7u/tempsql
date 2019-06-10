select b.pk_payableitem 应付单表体主键,h.billno 应付单号,
       substr(h.billdate, 1, 10) 应付单日期,
       /*substr(p.billdate, 1, 10) 付款单日期,
       substr(t.busidate, 1, 10) 处理日期,*/
       h.billclass 单据类型,h.src_syscode 单据来源系统,
       h.billperiod 月份,
       h.billyear 年度,
       storg.name 库存组织,st.name 仓库,
       m.code 物料编码,
       m.name 物料名称,
       avg(b.local_money_cr) 组织本币金额,
       sum(case
         when substr(p.billdate, 1, 10) < '2018-12-31' or t.busidate is null then
          t.local_money_cr
         else
          0
       end) 贷方处理本币金额,
       avg(b.local_money_cr)-sum(case
         when substr(p.billdate, 1, 10) < '2018-12-31' or t.busidate is null then
          t.local_money_cr
         else
          0
       end) 未处理金额
      --distinct b.pk_currtype,bct.name
  from ap_payableitem b
left join ap_payablebill h on b.pk_payablebill = h.pk_payablebill
left join org_orgs fiorg on b.pk_org = fiorg.pk_org
left join bd_material m on b.material = m.pk_material
left join arap_verifydetail t on b.pk_payableitem = t.pk_item--核销明细
left join ap_payitem p on t.pk_item2 = p.pk_payitem--付款单
left join po_invoice_b invb on b.top_itemid = invb.pk_invoice_b
left join bd_stordoc st on invb.pk_stordoc = st.pk_stordoc
left join org_orgs storg on st.pk_org = storg.pk_org
left join bd_currtype bct on b.pk_currtype = bct.pk_currtype
where fiorg.name = '保龄宝生物股份有限公司本部' and b.dr = 0 and h.dr = 0
      and b.objtype = 1
      and substr(h.billdate, 1, 10)<= '2018-12-31'
      and h.src_syscode in (4,16,19)
      --and b.pk_currtype = '1002Z0100000000001K8'
group by b.pk_payableitem ,h.billno ,
       substr(h.billdate, 1, 10) ,
       /*substr(p.billdate, 1, 10) ,
       substr(t.busidate, 1, 10) ,*/
       h.billclass ,h.src_syscode ,
       h.billperiod ,
       h.billyear ,
       storg.name ,st.name ,
       m.code ,
       m.name
