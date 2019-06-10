SELECT ap_payablebill.isreded isreded,
       ap_payablebill.pk_tradetype pk_tradetype,
       ap_payablebill.isinit isinit,
       ap_payablebill.billno billno,
       substr(ap_payablebill.billdate, 1, 10) billdate,
       ap_payablebill.syscode syscode,
       ap_payablebill.src_syscode src_syscode,
       ap_payablebill.money money,
       dept.name def20,
       ap_payableitem.top_billtype top_billtype,
       ap_payableitem.top_tradetype top_tradetype,
       ap_payableitem.src_tradetype src_tradetype,
       ap_payableitem.src_billtype src_billtype,
       ap_payableitem.purchaseorder purchaseorder,
       ap_payableitem.invoiceno invoiceno,
       ap_payableitem.outstoreno outstoreno,
       ap_payableitem.project project,
       (CASE
         WHEN ap_payableitem.money_bal = 0 THEN
          '是'
         ELSE
          '否'
       END) sfhxwb,
       bd_customer.name cust_name,
       bd_material.name material_name,
       pz.period period,
       pz.num num,
       bd_materialfi.materialvaluemgt materialvaluemgt,
       ap_payableitem.local_money_cr local_money_cr,
       ap_payableitem.local_money_bal local_money_bal,
       ap_payableitem.local_tax_cr local_tax_cr,
       ap_payableitem.local_notax_cr local_notax_cr
  FROM ap_payableitem ap_payableitem
  LEFT JOIN ap_payablebill ap_payablebill
    ON (ap_payableitem.pk_payablebill = ap_payablebill.pk_payablebill)
  LEFT JOIN bd_customer bd_customer
    ON (ap_payableitem.def4 = bd_customer.pk_customer)
  LEFT JOIN bd_material bd_material
    ON (ap_payableitem.material = bd_material.pk_material)
  LEFT JOIN fip_relation fip_relation
    ON (ap_payableitem.pk_payablebill = fip_relation.src_relationid)
  LEFT JOIN (SELECT gl_voucher.period period,
                    gl_voucher.num num,
                    substr(gl_voucher.prepareddate, 1, 10) prepareddate,
                    substr(gl_voucher.checkeddate, 1, 10) checkeddate,
                    gl_voucher.pk_prepared pk_prepared,
                    gl_voucher.pk_system pk_system,
                    gl_voucher.pk_voucher pk_voucher
               FROM gl_voucher gl_voucher
              WHERE gl_voucher.dr = 0) pz
    ON (fip_relation.des_relationid = pz.pk_voucher)
  LEFT JOIN bd_materialfi bd_materialfi
    ON (ap_payablebill.pk_org = bd_materialfi.pk_org AND
       bd_material.pk_material = bd_materialfi.pk_material)
  LEFT JOIN org_dept dept
    ON ap_payablebill.def20 = dept.pk_dept
 WHERE ap_payablebill.dr = 0
   AND ap_payableitem.dr = 0
   and substr(ap_payablebill.billdate, 1, 7) = '2018-08'
   and pz.num in ('2561','2599')
 ORDER BY ap_payablebill.billdate
