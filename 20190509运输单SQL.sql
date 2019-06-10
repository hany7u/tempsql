select substr(h.dbilldate, 1, 10) dbilldate,
       b.cdelivbill_bid bid,
       b.cdelivbill_hid hid,
       h.pk_group org_group,
       h.pk_org org_dm,
       fhprovince.name fprovince,
       fhcity.name fcity,
       fhvsection.name fvsection,
       fhdz.detailinfo fhdz,
       shprovince.name sprovince,
       shcity.name scity,
       shvsection.name svsection,
       shdz.detailinfo shdz,
       b.vpuplancode car_number,
       bd_transporttype.name ysfs,
       cust.name cust_name,
       b.vbdef4||'['||m.materialspec||']' cpmc,
       decode(b.vsrcrowno, '10', '', '~', '', b.vsrcrowno) punit,
       case when meas.name = '千克' or meas.name = 'KG' then b.nnum/1000 when meas.name = '吨' then b.nnum else b.nnum end  nnum,
       b.vbdef15 jflc,
       b.vbdef18 fpnmny,
       '' ptno,
       b.vsrccode vsrccode
from dm_delivbill_b b
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid
left join bd_address fhdz on b.csendaddrid = fhdz.pk_address
left join bd_region fhprovince  on fhdz.province  = fhprovince.pk_region
left join bd_region fhcity on fhdz.city = fhcity.pk_region
left join bd_region fhvsection on fhdz.vsection = fhvsection.pk_region
left join bd_address shdz on b.creceiveaddrid  = fhdz.pk_address
left join bd_region shprovince  on shdz.province  = shprovince.pk_region
left join bd_region shcity on shdz.city = shcity.pk_region
left join bd_region shvsection on shdz.vsection = shvsection.pk_region
left join bd_transporttype bd_transporttype on h.csendtypeid =  bd_transporttype.pk_transporttype
left join bd_customer cust on b.casscustid = cust.pk_customer
left join bd_material m on b.cinventoryid = m.pk_material
left join bd_measdoc meas on b.cunitid = meas.pk_measdoc
where b.dr = 0 and h.dr = 0 and substr(h.dbilldate, 1, 10)> '2019-03-31'
