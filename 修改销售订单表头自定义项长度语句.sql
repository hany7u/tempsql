
select A.COLUMN_NAME, A.DATA_TYPE
  from user_tab_columns A
 where TABLE_NAME = 'SO_SALEORDER';
 
 alter table SO_SALEORDER modify VDEF2 varchar2(1000) ;
 COMMIT;
  alter table SO_SALEORDER modify VDEF3 varchar2(1000) ;
 COMMIT;

 alter table SO_SALEORDER modify VDEF4 varchar2(1000) ;
 COMMIT;

 alter table SO_SALEORDER modify VDEF6 varchar2(1000) ;
 COMMIT;

