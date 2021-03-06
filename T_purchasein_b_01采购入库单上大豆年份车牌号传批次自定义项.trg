﻿create or replace trigger T_purchasein_b_01
after insert
on ic_purchasein_b
for each row
  begin
    update scm_batchcode a set a.vdef7 = (select b.vbdef7 from po_arriveorder_b b where b.pk_arriveorder_b = :new.csourcebillbid)  ,
           a.vdef8 = (select b.vbdef8 from po_arriveorder_b b where b.pk_arriveorder_b = :new.csourcebillbid) where a.pk_batchcode = :new.pk_batchcode ;
  end;
