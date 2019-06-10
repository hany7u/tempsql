select b.pk_voucher        凭证主键,
       b.yearv             会计年度,
       b.periodv           会计期间,
       b.prepareddatev     制单日期,
       b.accountcode,
       b.localcreditamount 组织本币贷方发生额,
       b.localdebitamount  组织本币借方发生额,
       b.pk_systemv 制单系统,
       orgs.pk_org

  from gl_detail b
left join org_orgs orgs on b.pk_org = orgs.pk_org
 where b.accountcode in( '1402','1401','1405','1406','1408','141101','1403') and orgs.name = '保龄宝生物股份有限公司本部' 
       and b.yearv = '2018' 
