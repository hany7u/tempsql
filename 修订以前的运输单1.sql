select b.cdelivbill_bid, b.cdelivbill_hid, orgs.name   物流组织,
       h.vbillcode 运输单号,
       b.dbilldate 运输单日期,
       b.vbdef10   应收运费,
       b.vbdef17   本币运费,
       b.vbdef18   "原币运费/应付平台运费",
       b.vbdef12   应付司机运费,
       b.vbdef15   里程数,b.vbdef11,
       
       b.vbdef19   汇率
  from dm_delivbill_b b
left join dm_delivbill h on b.cdelivbill_hid = h.cdelivbill_hid
left join org_orgs orgs on h.pk_org = orgs.pk_org
where  b.vbdef19 = '~' and b.dr = 0 and b.vbdef19 <> '1.00000'
order by b.vbdef19 desc;

/*update dm_delivbill_b b set b.vbdef18 = b.vbdef17 where   b.vbdef19 = '~' and b.dr = 0 and b.vbdef19 <> '1.00000';
commit;
*/
/*update dm_delivbill_b b set b.vbdef17 = b.vbdef18 where   b.vbdef19 <> '~' and b.dr = 0 and b.vbdef19 > '1.00000';
commit;*/
/*update dm_delivbill_b b set b.vbdef18 = b.vbdef17 where  b.cdelivbill_bid = '1001B31000000001CBEB';
commit;*/
