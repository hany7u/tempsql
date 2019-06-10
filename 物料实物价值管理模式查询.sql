select m.code,m.name,decode(mfi.materialvaluemgt,1,'存货核算',2,'固定资产','费用'),mfi.dr
from bd_material m
left join bd_materialfi mfi on m.pk_material = mfi.pk_material and mfi.pk_org = '0001B3100000000028GW'--(select distinct t.pk_org from org_orgs t where t.name = '保龄宝生物股份有限公司本部')
where m.dr = 0 and mfi.dr = 0
