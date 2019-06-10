/*存货采购入库单 ia_i2bill、ia_i2bill_b
库存采购入库单 ic_purchasein、ic_purchasein_b

*/

select ih.bestimateflag,st.name,h.cgeneralhid,b.cgeneralbid,ih.cbillid,ib.cbill_bid,h.vbillcode,h.dbilldate,ih.vbillcode,ih.dbilldate,m.code,m.name,b.nnum,ib.nnum
from ic_purchasein_b b 
left join ic_purchasein_h h on b.cgeneralhid = h.cgeneralhid
left join ia_i2bill_b ib on b.cgeneralbid = ib.csrcbid 
left join ia_i2bill ih on ib.cbillid = ih.cbillid
left join bd_material m on b.cmaterialoid = m.pk_material
left join bd_materialfi mfi on m.pk_material = mfi.pk_material and b.cfanaceorgoid = mfi.pk_org
left join bd_stordoc st on h.cwarehouseid = st.pk_stordoc
where h.dr = 0 and b.dr = 0 and nvl(ih.dr,0) = 0 and nvl(ib.dr,0) = 0  and mfi.materialvaluemgt = 1 and ih.bestimateflag = 'Y' AND B.NNUM <> IB.NNUM 

order by h.vbillcode


UNION ALL

select ih.bestimateflag,st.name,h.cgeneralhid,b.cgeneralbid,ih.cbillid,ib.cbill_bid,h.vbillcode,h.dbilldate,ih.vbillcode,ih.dbilldate,m.code,m.name,b.nnum
from ic_purchasein_b b 
left join ic_purchasein_h h on b.cgeneralhid = h.cgeneralhid
left join ia_i2bill_b ib on b.cgeneralbid = ib.csrcbid 
left join ia_i2bill ih on ib.cbillid = ih.cbillid
left join bd_material m on b.cmaterialoid = m.pk_material
left join bd_materialfi mfi on m.pk_material = mfi.pk_material and b.cfanaceorgoid = mfi.pk_org
left join bd_stordoc st on h.cwarehouseid = st.pk_stordoc
where h.dr = 0 and b.dr = 0 and nvl(ih.dr,0) = 0 and nvl(ib.dr,0) = 0  and mfi.materialvaluemgt = 1 and ih.bestimateflag = 'N' AND B.NNUM <> IB.NNUM


