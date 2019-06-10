select 
'' dailyvolume,--日加工量/产出(吨/万粒)
sum(icon.nonhandnum) countnumb,--结算数量
sum(icon.nonhandnum) countday, --"库存加工天数"
'' purprice, --"售/购价（元/吨、元/粒）"
sum(pri.nabprice*icon.nonhandnum) invreport--"结存金额"

from nc65.ic_onhandnum icon--现存量
left join nc65.ic_onhanddim icod on icon.pk_onhanddim = icod.pk_onhanddim--现存量唯独表
left join nc65.bd_material bdm on icod.cmaterialoid = bdm.pk_material--物料多版本
left join nc65.bd_stordoc  bds on icod.cwarehouseid = bds.pk_stordoc--仓库
left join nc65.bd_measdoc  bdme on icod.castunitid  = bdme.pk_measdoc--计量单位
left join nc65.bd_marbasclass bdma on bdm.pk_marbasclass  = bdma.pk_marbasclass --物料分类
left join (select t1.cinventoryid,t1.nabprice from
          (select ROW_NUMBER() OVER(PARTITION BY t.cinventoryid ORDER BY t.caccountperiod DESC) rn,t.cinventoryid,t.nabprice from
                  nc65.ia_monthnab t where t.dr=0) t1
                      where t1.rn = 1) pri on bdm.pk_material = pri.cinventoryid
where   1 = 1
  and COALESCE(icon.nonhandnum, 0) <> 0  and icon.dr=0  and icod.dr=0  and bdm.dr=0  and bds.dr=0  and bdme.dr=0  and bdma.dr=0
  --现存量：胶囊成品库+外采胶囊成品库中明胶软胶囊：纯鱼油和鱼油+其他的现存量合计
  and bds.name in ('胶囊成品库','外采胶囊成品库') and substr(bdma.code,1,6) in ('020401','020402','020403')  
