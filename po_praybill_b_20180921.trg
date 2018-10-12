CREATE OR REPLACE TRIGGER po_praybill_b_1
  before insert or update
  on po_praybill_b 
  for each row
declare
/*根据物料自定义项1的值生成请购单表体上的订单类型*/
  price_Model     varchar2(20);
  class_pk        varchar2(20);
  class_code      varchar2(4);
  valuemgt      varchar2(4);
begin
  select decode(m.def1,'~','1001NC10000000002MMF',m.def1)   into price_Model      from bd_material m where m.pk_material = :new.pk_material;
  select m.pk_marbasclass  into class_pk from bd_material m where m.pk_material = :new.pk_material;
  select mfi.materialvaluemgt into valuemgt  from bd_materialfi mfi where mfi.pk_material = :new.pk_material and rownum = 1;
  select substr(c.code,1,4) into class_code from bd_marbasclass c where c.pk_marbasclass = class_pk;
  if class_code = '9902'or valuemgt = '2'  then :new.cordertrantypecode := '1001NC1000000000229N';  
      elsif  price_Model = '1001NC10000000002MME' then :new.cordertrantypecode := '1001NC1000000000228T'; --采购合同
      elsif  price_Model = '1001NC10000000002MMF' then :new.cordertrantypecode := '1001NC10000000002293'; --价目表
      elsif  price_Model = '1001NC10000000002MMG' then :new.cordertrantypecode := '1001NC1000000000229D'; --基准价格
  end if;  
end po_praybill_b_1;
/
