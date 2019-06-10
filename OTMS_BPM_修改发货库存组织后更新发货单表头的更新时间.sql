create or replace trigger OTMS_BPM_001 AFTER  update
on SO_DELIVERY_B
for each row
begin
  IF :new.csendstockorgid <> :old.csendstockorgid THEN
    update so_delivery h set h.modifiedtime = to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') where h.cdeliveryid = :new.cdeliveryid and h.dr = 0 ;
  END IF;
END;
