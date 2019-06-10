select ial.pk_org,ialb.vsrctype ,sb.bbarsettleflag,
       ial.pk_group,
       ial.cbillid,
       ialb.cbill_bid,
       se.csaleinvoiceid,
       seb.csaleinvoicebid,
       substr(ial.dbilldate,1,10) iadbilldate, --销售成本结转单单据日期
       substr(se.dbilldate,1,10) sedbilldate, --开票日期
       (seb.nmny - ialb.nmny) margin,
       case when seb.norigmny = 0 then 0 else (seb.nmny - ialb.nmny)/seb.nmny end marginRatio  ,se.vbillcode,ial.dr,ial.vbillcode
from ia_i5bill_b ialb ---销售成本结转单表体
left join  ia_i5bill ial  on  ialb.cbillid=ial.cbillid  --销售成本结转单
/*left join ic_saleout_b ib1 on ialb.cicitemid = ib1.cgeneralbid--销售出库单表体
left join ic_saleout_h ih on ih.cgeneralhid = ib1.cgeneralhid--销售出库单表头
left join so_saleinvoice_b seb on ib1.cgeneralbid = seb.csrcbid  --销售发票子表
left join so_saleinvoice se on seb.csaleinvoiceid = se.csaleinvoiceid --销售发票*/
left join so_saleinvoice_b seb on ialb.csrcbid= seb.csaleinvoicebid  --销售发票子表
left join so_saleinvoice se on seb.csaleinvoiceid = se.csaleinvoiceid --销售发票
left join so_saleorder_b sb on sb.csaleorderbid=ialb.cfirstbid
where ialb.dr=0 and ial.dr=0 and nvl(seb.dr,0)=0 and nvl(se.dr,0)=0 and nvl(sb.dr,0)=0
