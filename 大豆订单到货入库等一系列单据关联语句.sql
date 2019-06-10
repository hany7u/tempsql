select 1
from nc65.po_order_b po_order_b
left join nc65.po_order po_order on po_order_b.pk_order = po_order.pk_order
left join nc65.po_arriveorder_b po_arriveorder_b on po_arriveorder_b.csourcebid = po_order_b.pk_order_b
left join nc65.po_arriveorder po_arriveorder on po_arriveorder_b.pk_arriveorder = po_arriveorder.pk_arriveorder
