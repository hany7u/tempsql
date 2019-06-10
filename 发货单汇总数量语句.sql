SELECT so_delivery.pk_group,
       so_delivery.pk_org,
       so_delivery.vbillcode,
       so_delivery.cdeliveryid,
       so_delivery_b.csrcid csrcid,
       t1.pk_printnumber,
       substr(so_delivery.dbilldate,1,10) as dbilldate,
       substr(so_delivery_b.dsenddate,1,10) as dsenddate,
       so_delivery_b.cemployeeid,
       so_delivery_b.csendstockorgid,
       so_delivery_b.csendstordocid,
       so_delivery_b.cordercustid,
       so_delivery_b.cmaterialid,max(so_delivery_b.cdeliverybid) cdeliverybid,
       sum(so_delivery_b.nnum)as nnum,
       sum(so_delivery_b.norigtaxmny) as norigtaxmny
  FROM nc65.so_delivery so_delivery
 INNER JOIN nc65.so_delivery_b so_delivery_b    ON so_delivery.cdeliveryid = so_delivery_b.cdeliveryid
  LEFT JOIN nc65.pub_printnumber t1  on t1.pk_billtype = '4331' AND t1.dr = 0 and so_delivery.cdeliveryid = t1.billid
 WHERE so_delivery.dr = 0
   AND so_delivery_b.dr = 0
   AND so_delivery.pk_group = '0001NC100000000018TH'
   AND so_delivery_b.pk_group = '0001NC100000000018TH'
group by so_delivery.pk_group,
       so_delivery.pk_org,
       so_delivery.vbillcode,
       so_delivery.cdeliveryid,
       so_delivery_b.csrcid,
       t1.pk_printnumber,
       substr(so_delivery.dbilldate,1,10),
       substr(so_delivery_b.dsenddate,1,10),
       so_delivery_b.cemployeeid,
       so_delivery_b.csendstockorgid,
       so_delivery_b.csendstordocid,
       so_delivery_b.cordercustid,
       so_delivery_b.cmaterialid
