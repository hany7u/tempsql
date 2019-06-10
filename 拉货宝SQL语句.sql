SELECT h.vbillcode 运输单号,
       substr(h.dbilldate, 1, 10) 运输时间,
       (b.vbdef17 * 1) 价格,b.csendaddrid,b.creceiveaddrid,
       b.vbdef15 计费里程,p.name 发货省,c.name 发货市,t.name 发货区县,
       --r.*
       pr.name 收货省,cr.name 收货市,tr.name 收货区县
FROM dm_delivbill_b b
LEFT JOIN dm_delivbill h    ON b.cdelivbill_hid = h.cdelivbill_hid
left join bd_address a     on b.csendaddrid = a.pk_address
left join bd_region p on a.province = p.pk_region
left join bd_region c on a.city = c.pk_region
left join bd_region t on a.vsection = t.pk_region
left join bd_address r     on b.creceiveaddrid  = r.pk_address
left join bd_region pr on r.province = pr.pk_region
left join bd_region cr on r.city = cr.pk_region
left join bd_region tr on r.vsection = tr.pk_region

WHERE b.dr = 0
   AND h.dr = 0 and substr(h.dbilldate,1,7) = '2018-07' and h.vbillcode = '2018070097'
   ;

--select * from bd_region r where r.pk_region in ('1001Z01000000000SFXR','1001Z01000000000SFXQ','1001Z01000000000SFXZ');
