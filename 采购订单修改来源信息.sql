select h.vbillcode,b.pk_order_b,b.csourcebid,
                   b.csourceid,
                   b.csourcetypecode,b.cpriceaudit_bb1id,
                                     b.cpriceaudit_bid,
                                     b.cpriceauditid
from po_order_b b
left join po_order h on b.pk_order = h.pk_order
where substr(h.dbilldate,1,10) = '2019-03-07';

update po_order_b b set b.csourcebid = '1001NC100000000C0JPF',
                   b.csourceid = '1001NC100000000C0JPE',
                   b.csourcetypecode = '20'
       where /*1=2 and*/ b.pk_order_b = '1001NC100000000C0JQF';
commit;
