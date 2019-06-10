
SELECT /*采购入库*/
       h.cbillid hid,b.cbill_bid bid,h.pk_group g, h.pk_org orgs,b.vsrccode,
       m.code,m.name,clazz.name,
       h.caccountperiod 会计期间,
       b.vsrcrowno,
       b.vsrctrantype,b.nnum,b.nmny,
       bt.billtypename 来源单据类型,
       b.ccalcid,
       h.bestimateflag 暂估标志,h.bsystemflag,ORGS.NAME,H.VBILLCODE
  FROM ia_i2bill_b b
LEFT JOIN ia_i2bill h    ON b.cbillid = h.cbillid 
left join bd_billtype bt on b.vsrctype  = bt.pk_billtypeid
LEFT JOIN ORG_ORGS ORGS ON B.PK_ORG = ORGS.PK_ORG
left join bd_material m on b.cinventoryid = m.pk_material
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass
where h.dr = 0  and b.dr = 0 and h.bestimateflag = 'N' AND ORGS.NAME = '保龄宝生物股份有限公司本部'
      and h.caccountperiod = '2018-12'
      --and h.vbillcode in ( 'I22018113000088384'  ,'I22018123100090360','I22018122600089579','I22018113000088463','I22019010700090362','I22019010700090363') 
      --and b.vsrccode = 'JS2018121300009533'
      --and m.name = '有机玉米'
union all
select /*调拨入库*/
       h.cbillid hid,b.cbill_bid bid,h.pk_group g, h.pk_org orgs,b.vsrccode,
       m.code,m.name,clazz.name,
       h.caccountperiod 会计期间,
       b.vsrcrowno,
       b.vsrctrantype,b.nnum,b.nmny,
       bt.billtypename 来源单据类型,
       b.ccalcid,
       h.bestimateflag 暂估标志,h.bsystemflag,ORGS.NAME,H.VBILLCODE
from ia_iibill_b b
left join ia_iibill h   ON b.cbillid = h.cbillid
left join bd_billtype bt on b.vsrctype  = bt.pk_billtypeid
LEFT JOIN ORG_ORGS ORGS ON B.PK_ORG = ORGS.PK_ORG
left join bd_material m on b.cinventoryid = m.pk_material
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass
where h.dr = 0  and b.dr = 0 and (h.bestimateflag = 'Y' /*OR bt.billtypename <> '库存调拨入库单' AND h.bestimateflag = 'N'*/)
      --and h.caccountperiod = '2018-12'
      --and h.vbillcode in ( 'II2018123100030892')
      --AND b.vsrccode IN( '5F2018063000000001','5F2018062500000001')
      AND ORGS.NAME = '保龄宝生物股份有限公司本部'
union all
select /*入库调整*/
       h.cbillid hid,b.cbill_bid bid,h.pk_group g, h.pk_org orgs,b.vsrccode,
       m.code,m.name,clazz.name,
       h.caccountperiod 会计期间,
       b.vsrcrowno,
       b.vsrctrantype,b.nadjustnum ,b.nmny,
       bt.billtypename 来源单据类型,
       b.ccalcid,
       h.bestimateflag 暂估标志,h.bsystemflag,ORGS.NAME,H.VBILLCODE
from ia_i9bill_b b
LEFT JOIN ia_i9bill h    ON b.cbillid = h.cbillid
left join bd_billtype bt on b.vsrctype  = bt.pk_billtypeid
LEFT JOIN ORG_ORGS ORGS ON B.PK_ORG = ORGS.PK_ORG
left join bd_material m on b.cinventoryid = m.pk_material
left join bd_marbasclass clazz on m.pk_marbasclass = clazz.pk_marbasclass
where h.dr = 0  and b.dr = 0 AND ORGS.NAME = '保龄宝生物股份有限公司本部'
      --and h.caccountperiod = '2018-12'
