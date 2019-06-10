create or replace trigger OTMS_BPM_002 
before  update
on SO_DELIVERY
for each row
begin
  IF :new.ctransporttypeid <> :old.ctransporttypeid THEN
    :new.vdef16 := '~' ;
  END IF;
END;
