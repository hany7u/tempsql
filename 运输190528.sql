--运输单子表 (dm_delivbill_b) 
--运输单主表 (dm_delivbill) 
select dm_delivbill_b.bapflag 应付运费发票标志, dm_delivbill_b.barflag 应收运费发票标志
from dm_delivbill_b dm_delivbill_b
left join dm_delivbill dm_delivbill on dm_delivbill_b.cdelivbill_hid = dm_delivbill.cdelivbill_hid
left join 
where dm_delivbill.vbillcode in ('2019050292','2019050293','2019051146')
;

select dm_arinvoice_b.cdelivbill_hid,
       dm_arinvoice_b.cfeeinid,
       dm_arinvoice_b.cfeeinvid,
       dm_arinvoice_b.cinexitemid,
       dm_arinvoice_b.cinvoice_bid,
       dm_arinvoice_b.cinvoice_hid,
       dm_arinvoice_b.crowno,
       dm_arinvoice_b.csettlebill_bid,
       dm_arinvoice_b.ctaxcodeid
from dm_arinvoice_b dm_arinvoice_b 
left join dm_arinvoice dm_arinvoice on dm_arinvoice_b.cinvoice_hid = dm_arinvoice.cinvoice_hid
where dm_arinvoice.vbillcode = '07723945-07723950'
;

select dm_apinvoice_b.cinexitemid,
       dm_apinvoice_b.dbilldate,
       dm_apinvoice_b.nverifymny
from dm_apinvoice_b dm_apinvoice_b 
left join dm_apinvoice dm_apinvoice on dm_apinvoice_b.cinvoice_hid = dm_apinvoice.cinvoice_hid
where dm_apinvoice.vbillcode = '9249017'
