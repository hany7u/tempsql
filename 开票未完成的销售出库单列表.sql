select b.cgeneralbid,h.cgeneralhid,H.VBILLCODE,h.csaleorgoid,h.pk_org,h.pk_group,substr(h.dbilldate,1,10) dbilldate,substr(b.dbizdate,1,10) dbizdate,ob.bbinvoicendflag, 
case when b.cunitid = '0001Z0100000000000XI' or b.cunitid = '1001B3100000000D26QT' then b.nnum/1000 when b.cunitid = '0001Z0100000000000XK' then b.nnum else 0 end  outnum,
  e.nsignnum ,e.nrushnum 
from ic_saleout_b b
left join ic_saleout_h h on b.cgeneralhid = h.cgeneralhid
left join ic_saleout_e e on b.cgeneralbid = e.cgeneralbid
left join so_saleorder o on b.cfirstbillhid = o.csaleorderid
left join so_saleorder_b ob on b.cfirstbillbid = ob.csaleorderbid
where ob.bbinvoicendflag <> 'Y'
