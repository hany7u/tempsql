create or replace view yw_v_checkbill_01 as
/*用于大豆采购入库单打印质检结果取数*/
select h.cgeneralhid,h.vbillcode,b.nnum,qc_checkbill_b.pk_checkitem,qc_checkitem.vcheckitemcode, qc_checkitem.vcheckitemname,qc_checkbill_b.vchkvalue,qc_checkbill_b.vstdvalue1
from ic_purchasein_b b --采购入库单表体
left join ic_purchasein_h h on b.cgeneralhid = h.cgeneralhid
left join po_arriveorder_b po_arriveorder_b on b.csourcebillbid = po_arriveorder_b.pk_arriveorder_b --到货单表体
left join qc_applybill_s qc_applybill_s on po_arriveorder_b.pk_arriveorder_b = qc_applybill_s.csourcebid --报检单明细
left join qc_reportbill_b rpb on qc_applybill_s.pk_applybill_s = rpb.csourcebid--质检报告表体
left join qc_reportbill rp on rpb.pk_reportbill = rp.pk_reportbill---质检报告
left join qc_checkbill qc_checkbill on rp.pk_reportbill = qc_checkbill.csourceid 
left join qc_checkbill_b qc_checkbill_b on qc_checkbill.pk_checkbill = qc_checkbill_b.pk_checkbill
left join qc_checkitem qc_checkitem on qc_checkbill_b.pk_checkitem = qc_checkitem.pk_checkitem
where b.dr = 0 and h.dr = 0 and po_arriveorder_b.dr = 0 and qc_applybill_s.dr = 0
      and rpb.dr = 0 and rp.dr = 0 and qc_checkbill.dr = 0 and qc_checkbill_b.dr = 0


