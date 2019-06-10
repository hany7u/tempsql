SELECT mm_wr.pk_group,
       mm_wr.pk_org,
       --生产报告
       mm_wr.vbillcode wrvbillcode, --生产(完工)报告单号
       mm_wr.dmakedate,   --制单日期
       mm_wr_product.cbdeptvid,   --生产部门
       mm_wr_product.cbmaterialvid,--产品编码  
       bd_material.name, --产品名称  
       bd_material.materialspec,--产品规格  
       mm_wr_product.vbbatchcode,--生产批次号  
       mm_wr_product.vbinbatchcode, --入库批次号
       mm_wr_product.nbwrastnum,--完工数量  
       mm_wr_quality.ngastnum,--处理数量  
       mm_wr_quality.nginastnum,--实际入库数量
       --报检单
       qc_applybill.vbillcode qcvbillcode, --报检单号
       qc_applybill.dapplydate,--报检日期
       decode(qc_applybill.fbillstatus,0,'自由',1,'提交',2,'正在审批',3,'审批通过',4,'审批未通过',5,'拒收'),--单据状态
       --质检报告
       qc_reportbill.vbillcode revbillcode, --质检报告号
       qc_reportbill.dreportdate,--报告日期
       qc_reportbill.taudittime ,--审批日期
       qc_reportbill_b.pk_suggprocess,--建议处理方式
       qc_reportbill_b.fprocessjudge,--处理方式判定
       --库存产成品入库单
       ic_finprodin_b.dbizdate,  --入库日期
       --报检到入库的时间差
       qc_applybill.dapplydate,
       ((substr(ic_finprodin_b.dbizdate, 1, 4)- substr(qc_applybill.dapplydate, 1, 4))*12 
        +substr(ic_finprodin_b.dbizdate, 6, 2)-substr(qc_applybill.dapplydate, 6, 2))*30
       +substr(ic_finprodin_b.dbizdate, 9, 2)-substr(qc_applybill.dapplydate, 9, 2) datecha
       
FROM nc65.mm_wr_product  mm_wr_product --完工报告子表
left join nc65.mm_wr mm_wr on mm_wr_product.pk_wr = mm_wr.pk_wr --完工报告主表
left join nc65.mm_wr_quality mm_wr_quality on mm_wr_product.Pk_wr_Product = mm_wr_quality.pk_wr_product --完工报告质量信息
left join nc65.bd_material bd_material on mm_wr_product.cbmaterialid = bd_material.pk_material--物料
left join nc65.qc_applybill qc_applybill on mm_wr.vbillcode =  qc_applybill.vprodrptcode  and  mm_wr_product.cbmaterialid = qc_applybill.pk_material --报检单
left join nc65.qc_reportbill_b qc_reportbill_b on qc_applybill.pk_applybill = qc_reportbill_b.csourceid --质检报告明细
left join nc65.qc_reportbill qc_reportbill on qc_reportbill_b.pk_reportbill = qc_reportbill.pk_reportbill  --质量报告
left join nc65.ic_finprodin_b ic_finprodin_b on mm_wr_product.pk_wr_product = ic_finprodin_b.csourcebillbid--产成品入库单表体
left join nc65.ic_finprodin_h ic_finprodin_h on ic_finprodin_b.cgeneralhid = ic_finprodin_h.cgeneralhid--产成品入库单表头
WHERE 1 = 1
      and nvl(bd_material.dr,0) = 0
      AND nvl(mm_wr.dr,0) = 0
      AND nvl(mm_wr_product.dr,0) = 0
      AND nvl(ic_finprodin_h.dr,0) = 0 
      AND nvl(qc_applybill.dr,0) = 0
      AND nvl(qc_reportbill.dr,0)=0
