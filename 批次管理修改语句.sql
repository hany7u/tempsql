select ms.pk_materialstock 物料库存信息主键,
       m.pk_material       物料主键,
       m.code              物料编码,
       m.name              物料名称,
       m.materialspec      规格,
       m.materialtype      型号,
       orgs.name 库存组织,
       ms.wholemanaflag    批次管理,
       ms.chkfreeflag      免检,
       ms.stockbycheck     根据检验结果入库,
       ms.negallowed       允许负库存
  from bd_materialstock ms
Left join bd_material m on ms.pk_material = m.pk_material
left join org_orgs orgs on ms.pk_org = orgs.pk_org
where ms.wholemanaflag = 'Y' and m.code not like '990%' and m.dr = 0 and ms.dr = 0 and m.name = '结晶果糖' AND orgs.name = '山东保龄宝倍健食品有限公司' ;
/*
update bd_materialstock ms set ms.wholemanaflag = 'Y' where ms.pk_materialstock = '1001B3100000000SE3U7';
commit;

update bd_materialstock ms set ms.wholemanaflag = 'N' where ms.pk_materialstock = '1001B3100000000RR22Q';
commit;*/

