-- Create table
create table T_YS_YUETAB
(
  应收单行主键 NVARCHAR2(40) not null,
  应收单号     NVARCHAR2(40) not null,
  对方单据号     NVARCHAR2(40),
  对方单据类型     NVARCHAR2(4),
  处理时间     NVARCHAR2(10),
  处理标识     NVARCHAR2(1),
  单据日期     NVARCHAR2(10),
  起算日期     NVARCHAR2(10),
  对方单据日期 NVARCHAR2(10),
  组织本币价税合计 NUMBER(26,2),
  处理本币金额 NUMBER(26,2),
  物料编码     NVARCHAR2(30),
  物料名称     NVARCHAR2(60),
  客户编码     NVARCHAR2(30),
  客户名称     NVARCHAR2(60),
  发货库存组织   NVARCHAR2(40)
)
tablespace NNC_DATA01
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 256K
    next 256K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
