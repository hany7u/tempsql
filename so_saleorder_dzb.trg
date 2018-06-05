create or replace trigger so_saleorder_dzb--地址簿检查
  before insert
  on so_saleorder_b
  for each row
declare
  province        nvarchar2(40);
  city            nvarchar2(40);
  vsection        nvarchar2(40);
begin
  select  nvl(d.province,'A')  into province from bd_address d where d.pk_address = :new.creceiveaddrid;
  select  nvl(d.city,'B')   into city from bd_address d where d.pk_address = :new.creceiveaddrid;
  select  nvl(d.vsection,'C')  into vsection from bd_address d where d.pk_address = :new.creceiveaddrid;
  
  if length(province) < 6 then raise_application_error(-20001,'请维护客户地址簿中省份信息！');     end if;
  if length(city) < 6 then raise_application_error(-20001,'请维护客户地址簿中城市信息！');     end if;
  if length(vsection) < 6 then raise_application_error(-20001,'请维护客户地址簿中区县信息！');     end if;
end so_saleorder_dzb;
/
