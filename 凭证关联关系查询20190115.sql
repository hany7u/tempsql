select t.busimessage1,
       t.busimessage2,
       t.busimessage3,t.des_busidate 目标业务日期,
       t.des_freedef1 目标辅助信息1,
       t.des_freedef2 目标辅助信息2,
       t.des_freedef3 目标辅助信息3,
       U.USER_NAME    凭证制单人,
       t.des_system  目标系统,
       t.src_billtype 来源单据类型,
       t.src_busidate 来源业务日期,
       t.src_defdoc1  来源分组档案1,
       t.src_defdoc2  来源分组档案2,
       t.src_defdoc3  来源分组档案3,
       t.src_freedef1 来源辅助信息1,
       t.src_freedef2 来源辅助信息2,
       t.src_freedef3 来源辅助信息3,
       t.src_freedef4 来源辅助信息4,
       t.src_freedef5 来源辅助信息5,
       Us.USER_NAME   来源单据制单人,
       t.src_system   来源系统,
       t.sumflag      来源单据是否汇总
from fip_relation t
--    ON (ap_payableitem.pk_payablebill = fip_relation.src_relationid)
left JOIN SM_USER U ON t.des_operator = U.CUSERID
left JOIN SM_USER Us ON t.src_operator = Us.CUSERID
LEFT JOIN (SELECT gl_voucher.period period,
                    gl_voucher.num num,
                    substr(gl_voucher.prepareddate, 1, 10) prepareddate,
                    substr(gl_voucher.checkeddate, 1, 10) checkeddate,
                    gl_voucher.pk_prepared pk_prepared,
                    gl_voucher.pk_system pk_system,
                    gl_voucher.pk_voucher pk_voucher
               FROM gl_voucher gl_voucher
              WHERE gl_voucher.dr = 0 
           ) pz
ON (pz.pk_voucher = t.des_relationid) 
where pz.num is not null and substr(t.des_busidate,1,7) = '2018-12'
