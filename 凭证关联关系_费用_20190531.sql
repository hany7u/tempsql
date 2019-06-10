select t.src_billtype ,substr(t.src_relationid,1,20)  src_relationid,
       t.src_system   src_system,
       pz.inum inum,pz.period period
from fip_relation t
LEFT JOIN (SELECT gl_voucher.year||'-'||gl_voucher.period period,
                    gl_voucher.num inum,
                    substr(gl_voucher.prepareddate, 1, 10) prepareddate,
                    substr(gl_voucher.checkeddate, 1, 10) checkeddate,
                    gl_voucher.pk_prepared pk_prepared,
                    gl_voucher.pk_system pk_system,
                    gl_voucher.pk_voucher pk_voucher
               FROM gl_voucher gl_voucher
              WHERE gl_voucher.dr = 0 
           ) pz
ON (pz.pk_voucher = t.des_relationid) 
where pz.inum is not null and t.src_system = 'erm';

select h.pk_jkbx
from er_bxzb h
where h.djbh = '264X2019040200573'
