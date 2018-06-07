select h.vbillcode || ';' || h.cdeliveryid ERPNumber,        --erp单号
       psn.name branch,        --地区，值为业务员姓名
       b.creceiveaddrid, 
      1 autoProcessMode, 
      1 allowUpdate, 
      1 xttSupport, 
       substr(b.dsenddate, 1, 10) pickupDate,        --提货日期，发货单上的发货日期
       '08:00:00' pickupTimeFrom, 
       '18:00:00' pickupTimeTo, 
       substr(b.dreceivedate, 1, 10) deliveryDate,        --送货日期，发货单上的到货日期
       'LTL' transportType, store_org.pk_org shipFromExternalId,        --发货方外部代码，库存组织主键
       cust.name companyName,        --客户名称
       province.name province,        --省
       town.name town,        --市
       couny.name country,        --区县
       bd_address.DETAILINFO address,        --详细地址
       h.vdef3 name,
       '13012345678' mobile, 
       '' phoneAreaCode, 
       decode(psn.mobile,'','18553405225',psn.mobile) mobile2,--业务员手机号 ，也可以加多个手机号
       decode(psn.email,'', '18553405225@163.com',psn.email) email,--业务员email
       cust.name || ';' || cust.pk_customer customText1,        --客户名称
       m.code customText2,        --产品编码
       m.name customText3,        --产品名称
       m.materialspec || m.materialtype customText4,        --规格型号
       bd_measdoc.name customText5,        --计量单位
       sm_user.user_name customText6,        --制单人
       h.vdef4 customText7,        --联系电话
       bd_billtype.billtypename customText8,        --订单类型
       store_org.name customText9,        --库存组织名称
       bd_custclass.name customText10,        --客户基本分类名称
       sale_org.name customText11,        --销售组织名称
       h.vnote customText12,        --发货单备注
       fi_org.name || ';' || fi_org.pk_org customText13,        --财务组织
       '公路运输' customText14,        --运输类型
       fhfs.name customText15,        --发货方式，自定义项14
       h.cdeliveryid customText16,        --表头ID
       b.vsrccode customText17,        --订单号，来源单据号
       h.vbillcode customText18,        --发货单号
       dept.name || ';' || dept.pk_dept customText19,        --销售部门
       psn.name customText20, b.nastnum customNum1,        --计划数量，取表体第一行数量
       b.nnum  customNum2,        --计划重量，取表体第一行重量
       case when fhfs.name ='吨箱' and(bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then 1.05*b.nnum/1000 
            when fhfs.name ='吨箱' and bd_measdoc.name = '吨' then b.nnum*1.05  
            when fhfs.name <>'吨箱' and(bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then b.nnum/1000 
            when fhfs.name <>'吨箱' and bd_measdoc.name = '吨' then b.nnum else b.nnum 
       end customNum3,        --计划体积
       
       '' customEnum1,        --子账号的人员，默认值：‘其他’?来源是发货单上的值吗？承运商不在发货单上填写
       '其它' cargoCategory,        --产品分类
       m.code productCode,        --产品编码
       m.name productCode,        --产品名称
       b.nastnum customNum1,        --计划数量
       b.nnum customNum2,        --计划重量
       case when fhfs.name ='吨箱' and(bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then 1.05*b.nnum/1000 
            when fhfs.name ='吨箱' and bd_measdoc.name = '吨' then b.nnum*1.05 
            when fhfs.name <>'吨箱' and(bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then b.nnum/1000 
            when fhfs.name <>'吨箱' and bd_measdoc.name = '吨' then b.nnum else b.nnum 
       end  customNum3,        --计划体积
       ceil(b.nastnum) quantity,        --发运数量
       b.nnum weight,        --发运重量
       case when fhfs.name = '吨箱' and(bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then 1.05*b.nnum/1000 
            when fhfs.name = '吨箱' and bd_measdoc.name = '吨' then b.nnum*1.05 
            when fhfs.name <> '吨箱' and (bd_measdoc.name = '千克' or bd_measdoc.name = 'kg' or bd_measdoc.name = 'KG') then b.nnum/1000 
            when fhfs.name <> '吨箱' and bd_measdoc.name = '吨' then b.nnum else b.nnum 
       end  volume,        --发运体积 
       m.materialspec || m.materialtype customText21,        --规格型号
       bd_measdoc.name customText22, --计量单位
     h.creationtime,h.modifiedtime
from   so_delivery h
left join so_delivery_b b on h.Cdeliveryid=b.Cdeliveryid
left join bd_psndoc psn on  b.Cemployeeid=psn.pk_psndoc
left join bd_stordoc bd_stordoc on b.csendstordocid=bd_stordoc.pk_stordoc
left join bd_customer cust on b.cordercustid=cust.pk_customer 
left join bd_custclass bd_custclass on cust.pk_custclass = bd_custclass.pk_custclass
left join bd_address bd_address ON  b.creceiveaddrid = bd_address.PK_ADDRESS
left join bd_region province on bd_address.province = province.pk_region
left join bd_region town on bd_address.city = town.pk_region
left join bd_region couny on bd_address.vsection = couny.pk_region
left join bd_material m on b.cmaterialid = m.pk_material
left join bd_measdoc bd_measdoc on b.cunitid = bd_measdoc.pk_measdoc
left join sm_user sm_user on h.billmaker = sm_user.cuserid
left join bd_custaddress bd_custaddress on bd_custaddress.pk_address = b.creceiveaddrid 
left join bd_linkman bd_linkman on bd_custaddress.pk_linkman =  bd_linkman.pk_linkman
left join org_orgs store_org on b.csendstockorgid = store_org.pk_org
left join org_orgs sale_org on b.csaleorgid = sale_org.pk_org
left join org_orgs fi_org on b.carorgid = fi_org.pk_org
left join org_dept dept on b.cdeptid = dept.pk_dept
left join so_saleorder so_saleorder on b.csrcid = so_saleorder.csaleorderid
left join bd_billtype bd_billtype on so_saleorder.ctrantypeid  = bd_billtype.pk_billtypeid
left join bd_transporttype bd_transporttype on so_saleorder.ctransporttypeid = bd_transporttype.pk_transporttype
left join bd_defdoc fhfs on h.vdef14 = fhfs.pk_defdoc
where  (substr(b.dsenddate, 1, 10) >= '2018-06-11'  and fhfs.name = '槽罐车'  or substr(b.dsenddate, 1, 10) >= '2018-06-11' and fhfs.name = '槽罐车整车' )
       and bd_transporttype.name <>'自提' and  bd_transporttype.name <>'手续单据'  and  bd_transporttype.name <>'OEM无运输'  and fhfs.name <> '手续' and fhfs.name <> '自提'  and h.modifiedtime is null
and h.creationtime>'{0}'