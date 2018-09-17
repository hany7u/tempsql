select t.code,
       t.layertype,
       t.name,
       t.pk_costregion,
       t.pk_org from org_costregion t

for update;
