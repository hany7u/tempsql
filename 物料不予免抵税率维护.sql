select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,2) = '10'


union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and  substr(clazz.code,1,2) = '11'

union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and  substr(clazz.code,1,2) = '12'

union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,2) = '21' 

union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,2) = '89' 

union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,2) = '90'

union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,5) = '01001'


union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,5) = '01006'
union 
select M.PK_MATERIAL 物料主键, clazz.code 物料基本分类编码, clazz.name 物料基本分类, m.code 物料编码, m.name 物料名称, m.def7 不予免抵税率
from   bd_material m
left   join bd_marbasclass clazz
on     m.pk_marbasclass = clazz.pk_marbasclass
where m.dr = 0 and substr(clazz.code,1,5) = '01002'
 

