create or replace view v_pray_price_010
as /*此视图用于构建请购单表体关联的最新价格审批单的单据状态；20190418*/
select t.praybill_b praybill_b,t.djzt djzt
from 
  (select b.pk_praybill_b praybill_b,decode(purp.fbillstatus,3,'审批通过',0,'自由',1,'提交',2,'正在审批',4,'审批通过',purp.fbillstatus) djzt,
         RANK() OVER(PARTITION BY b.pk_praybill_b ORDER BY b.pk_praybill_b,purp.creationtime desc) RANK
  from po_praybill_b b
  left join purp_priceaudit_b purp_b on b.pk_praybill_b = purp_b.csrcbid
  left join purp_priceaudit purp on purp_b.pk_priceaudit = purp.pk_priceaudit
  where b.dr = 0 and nvl(purp_b.dr,0) = 0 
  order by b.pk_praybill_b,purp.creationtime desc) t
where t.RANK = 1