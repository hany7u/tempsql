create or replace view def_saleoeder_001 as
select distinct t2.cdeliveryid,/*发货单关联销售订单的自定义项，用于把销售订单上的几个发货用的自定义项显示到发货单上；*/
                t3.vdef1,
                t3.vdef2,
                t3.vdef3,
                t3.vdef4,
                t3.vdef5,
                t3.vdef6,
                t3.vdef7,
                t3.vdef8,
                t3.vdef9,
                t3.vdef10,
                t3.vdef11,
                t3.vdef12,
                t3.vdef13,
                t3.vdef14,
                t3.vdef15,
                t3.vdef16,
                t3.vdef17,
                t3.vdef18,
                t3.vdef19,
                t3.vdef20
  from so_delivery_b t1
  left join so_delivery t2    on t1.cdeliveryid = t2.cdeliveryid
  left join so_saleorder t3    on t1.csrcid = t3.csaleorderid
 where t1.dr = 0   and t2.dr = 0   and t3.dr = 0;
