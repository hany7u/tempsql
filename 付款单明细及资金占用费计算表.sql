select h.billno ,b.top_billid 上层单据主键,b.top_billtype 上层单据类型,b.top_itemid 上层单据行主键,b.top_termch ,b.top_tradetype 上层交易类型 ,b.prepay 付款性质 
from ap_payitem b
left join ap_paybill h on b.pk_paybill = h.pk_paybill
left join ap_payableitem t1 on b.top_itemid = t1.pk_payableitem 
left join po_invoice_b t2 on t1.top_itemid = t2.pk_invoice_b
left join ic_purchasein_b t3 on t2.csourcebid = t3.cgeneralbid
left join ic_purchasein_h t4 on t3.cgeneralhid = t4.cgeneralhid
where b.top_billid is not null and h.dr=0 and b.dr=0 and b.top_billtype = 'F1'--参照应付单生成的付款单【这部分留着做数据校验吧，下面的语句已经包含了这部分数据了


select h.billno ,b.top_billid 上层单据主键,b.top_billtype 上层单据类型,b.top_itemid 上层单据行主键,b.top_termch ,b.top_tradetype 上层交易类型 ,b.prepay 付款性质,t.dr,t1.dr,t2.dr,t3.dr,t4.dr
from ap_payitem b
left join ap_paybill h on b.pk_paybill = h.pk_paybill
left join arap_verifydetail t on b.pk_payitem = t.pk_item
left join ap_payableitem t1 on t.pk_item2 = t1.pk_payableitem
left join po_invoice_b t2 on t1.top_itemid = t2.pk_invoice_b
left join ic_purchasein_b t3 on t2.csourcebid = t3.cgeneralbid
left join ic_purchasein_h t4 on t3.cgeneralhid = t4.cgeneralhid
where h.dr=0 and b.dr=0 --and b.top_billtype <> 'F1'--不是参照应付单生成的付款单
