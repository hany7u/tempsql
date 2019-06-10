select b.cgeneralbid,
       b.cgeneralhid,
       so_delivery_b.cdeliverybid,
       so_delivery_b.cdeliveryid,
       so_saleorder_b.csaleorderbid,
       so_saleorder_b.csaleorderid,
       so_saleorder_exe.csaleorderbid,
       po_order_b.pk_order,
       po_order_b.pk_order_b,
       po_order_b.cfirstbid,
       so_saleorder_b.csaleorderbid,
       h.vbillcode,
       po_invoice_b.cfirstbid,
       po_invoice_b.cfirstid,
       po_invoice_b.cfirsttypecode,
       po_order_b.cfirstid,
       po_order_b.cfirsttypecode,
       po_order_b.nprice,ap_payableitem.*
from so_saleorder_b so_saleorder_b --on b.cfirstbillbid =  so_saleorder_b.csaleorderbid
left join so_saleorder_exe so_saleorder_exe on so_saleorder_b.csaleorderbid = so_saleorder_exe.csaleorderbid 
left join ic_saleout_b b on so_saleorder_b.csaleorderbid = b.cfirstbillbid 
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
left join so_delivery_b so_delivery_b on b.csourcebillbid = so_delivery_b.cdeliverybid
left join po_order_b po_order_b on so_saleorder_b.csaleorderbid = po_order_b.csourcebid 
left join po_invoice_b po_invoice_b on po_order_b.pk_order_b =po_invoice_b.cfirstbid
left join ap_payableitem ap_payableitem on po_order_b.pk_order_b = ap_payableitem.src_itemid
where nvl(po_order_b.nprice,0)<>0 and b.dr = 0 and h.dr =0 and nvl(so_delivery_b.dr,0) = 0
      and nvl( so_saleorder_b.dr,0) = 0 and nvl( so_saleorder_exe.dr,0) = 0 and nvl( po_order_b.dr,0) = 0 and nvl( po_invoice_b.dr,0) = 0 
      and nvl( ap_payableitem.dr,0) = 0   and so_saleorder_b.csaleorderbid = '1001B3100000000Y9WFZ'
;

select distinct po_invoice_b.vfirstcode,po_invoice_b.cfirsttypecode from po_invoice_b po_invoice_b
;
select distinct ap_payableitem.top_billtype, ap_payableitem.top_tradetype,ap_payableitem.src_billtype, ap_payableitem.src_tradetype from ap_payableitem ap_payableitem
