CREATE OR REPLACE TRIGGER pu_order_1  before insert   on po_order_b   for each row
declare/*合格供方管控使用的触发器。用于替代系统在交易类型上做的校验，减少采购订单的交易类型数量*/
  is_materInVRM   NUMBER(2,0);
  is_VRM          NUMBER(2,0);
  price_Model     varchar2(20);
  is_jzjg          NUMBER(9,0);
  is_jmb          NUMBER(9,0);
  jzjg_price   NUMBER(16,9);
  jmb_price   NUMBER(16,9);
  djlx        varchar2(20);
begin
  SELECT COUNT(*) into is_materInVRM    FROM VRM_VENDORMATER T WHERE T.PK_MATERIAL = :new.pk_material and t.dr = 0 and t.pk_org = :new.pk_org;
  select count(*) into is_VRM           from vrm_vendormater t where t.pk_material = :new.pk_material and t.dr = 0 and t.pk_supplier = :new.pk_supplier and t.pk_org = :new.pk_org;
  select decode(m.def1,'~','1001NC10000000002MMF',m.def1)   into price_Model from bd_material m where m.pk_material = :new.pk_material;
  select distinct h.ctrantypeid into djlx from  po_order h  where h.pk_order = :new.pk_order and h.dr = 0 ;
  if djlx <> '1001NC1000000000229X' then
    IF is_materInVRM = 0                 THEN :NEW.vbdef2 := 1; END IF;--物料不控制合格供方
    IF is_VRM >= 0                       THEN :NEW.vbdef2 := 2; END IF;--合格供方检查通过
    IF is_materInVRM > 0 AND is_VRM < 1  
      THEN :NEW.vbdef2 := 3; 
           raise_application_error(-20001,'不符合合格供方管理，请联系质量部添加合格供方信息'); 
    
    END IF;--合格供方检查不通过
  end if;
  if price_Model = '1001NC10000000002MMG' then --基准价格
     select count(*) into is_jzjg  from po_preprice_b b
     left join po_preprice h on b.pk_preprice = h.pk_preprice
     where b.pk_org = :new.pk_org and b.pk_gcode = :new.pk_material and substr(h.effectivedate,1,10) <= substr(:new.dbilldate,1,10) 
           and substr(h.expirydate,1,10) >= substr(:new.dbilldate,1,10) and b.dr = 0
     order by h.creatortime desc;--按创建日期倒序排列
     if is_jzjg >0 then --存在有效基准价格
       select nvl(iprice,0) into jzjg_price from     
          ( select b.iprice iprice from po_preprice_b b
            left join po_preprice h on b.pk_preprice = h.pk_preprice
            where b.pk_org = :new.pk_org and b.pk_gcode = :new.pk_material and substr(h.effectivedate,1,10) <= substr(:new.dbilldate,1,10) 
                  and substr(h.expirydate,1,10) >= substr(:new.dbilldate,1,10) and b.dr = 0
            order by h.creatortime desc)
        where rownum = 1;
        :new.vbdef4 := jzjg_price;

     elsif is_jzjg <= 0 then 
       :new.vbdef4 := 0.00;
       jzjg_price := 0.00; 
     end if;
     if  :new.nprice > jzjg_price then --采购价格高于基准价格 ，则去价格审批单记录中查找是否存在有效记录          
            select count(*) into is_jmb from purp_priceaudit_b b
            left join purp_priceaudit h on b.pk_priceaudit = h.pk_priceaudit
            where b.pk_org = :new.pk_org and b.pk_srcmaterial = :new.pk_material and substr(b.dqtvaliddate,1,10) <= substr(:new.dbilldate,1,10) 
            and substr(nvl(b.dqtinvaliddate,(select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual)),1,10) >= substr(:new.dbilldate,1,10) and h.fbillstatus = 3 
            and b.border = 'Y' and b.pk_supplier = :new.pk_supplier and b.dr = 0
            order by h.creationtime desc;
            if is_jmb > 0 then --存在有效价格审批记录
                select nvl(nordprice,0) into jmb_price from
                (select b.nordprice nordprice from purp_priceaudit_b b
                left join purp_priceaudit h on b.pk_priceaudit = h.pk_priceaudit
                where b.pk_org = :new.pk_org and b.pk_srcmaterial = :new.pk_material and substr(b.dqtvaliddate,1,10) <= substr(:new.dbilldate,1,10) 
                and substr(nvl(b.dqtinvaliddate,(select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual)),1,10) >= substr(:new.dbilldate,1,10) and h.fbillstatus = 3 
                and b.border = 'Y' and b.pk_supplier = :new.pk_supplier and b.dr = 0
                order by h.creationtime desc)
                where rownum = 1;
                :new.vbdef4 := jmb_price;
                if :new.nprice > jmb_price then 
                   raise_application_error(-20021,'采购价格既高于基准价格也高于价目表价格，请确认'); 
                end if; 
            elsif is_jmb <= 0 then --不存在有效价格审批记录
                :new.vbdef4 := jmb_price;
                raise_application_error(-20022,'采购价格高于基准价且价目表中不存在有效价格记录，请确认'); 
            end if;
      end if; 
  elsif price_Model = '1001NC10000000002MMF' then --价目表
       select count(*) into is_jmb from purp_priceaudit_b b
       left join purp_priceaudit h on b.pk_priceaudit = h.pk_priceaudit
       where b.pk_org = :new.pk_org and b.pk_srcmaterial = :new.pk_material and substr(b.dqtvaliddate,1,10) <= substr(:new.dbilldate,1,10) 
            and substr(nvl(b.dqtinvaliddate,(select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual)),1,10) >= substr(:new.dbilldate,1,10) and h.fbillstatus = 3 
            and b.border = 'Y' and b.pk_supplier = :new.pk_supplier
       order by b.dqtinvaliddate desc;
       if is_jmb > 0 then --存在有效价格审批记录
          select nvl(nordprice,0) into jmb_price from
             (select b.nordprice nordprice from purp_priceaudit_b b
              left join purp_priceaudit h on b.pk_priceaudit = h.pk_priceaudit
              where b.pk_org = :new.pk_org and b.pk_srcmaterial = :new.pk_material and substr(b.dqtvaliddate,1,10) <= substr(:new.dbilldate,1,10) 
                    and substr(nvl(b.dqtinvaliddate,(select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual)),1,10) >= substr(:new.dbilldate,1,10) and h.fbillstatus = 3 
                    and b.border = 'Y' and b.pk_supplier = :new.pk_supplier
              order by h.creationtime desc)
           where rownum = 1;
           :new.vbdef4 := jmb_price;
                if :new.nprice > jmb_price then 
                   raise_application_error(-20023,'采购价格高于价目表价格，请确认'); 
                end if; 
       elsif is_jmb <= 0 then 
                :new.vbdef4 := 0;
                raise_application_error(-20024,'价目表中不存在有效价格记录，请确认'); 
       end if;
  end if; 
end pu_order_1;
/
