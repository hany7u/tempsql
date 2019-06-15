create or replace view fr_v_zjyf as
select t.zj 主键, t.dbizdate 出库日期, sum(t.ftyfje) 直接运费
  from (select b.cgeneralbid zj,
               substr(b.dbizdate, 1, 10) dbizdate,
               b.nnum cksl,
               dm_b.nnum yssl,
               to_number(case
                           when dm_b.pk_org = '0001B3100000004AG5D0' then
                            dm_b.vbdef10
                           else
                            dm_b.vbdef18
                         end) yfje,
               case
                 when b.nnum < dm_b.nnum then
                  to_number(case
                              when dm_b.pk_org = '0001B3100000004AG5D0' then
                               dm_b.vbdef10
                              else
                               dm_b.vbdef18
                            end) * b.nnum / dm_b.nnum
                 else
                  to_number(case
                              when dm_b.pk_org = '0001B3100000004AG5D0' then
                               dm_b.vbdef10
                              else
                               dm_b.vbdef18
                            end) * 1.00
               end ftyfje
          from ic_saleout_b b
          left join ic_saleout_h h
            on b.cgeneralhid = h.cgeneralhid
          left join so_delivery_b so_d_b
            on b.csourcebillbid = so_d_b.cdeliverybid
          left join dm_delivbill_b dm_b
            on so_d_b.cdeliverybid = dm_b.csrcbid
         where b.dr = 0
           and h.dr = 0
           and so_d_b.dr = 0
           and dm_b.dr = 0
           and b.nnum > 0
           and substr(b.dbizdate, 1, 10) >= '2017-01-01'
        union all
        select b.cgeneralbid zj,
               substr(b.dbizdate, 1, 10) dbizdate,
               b.nnum cksl,
               dm_b.nnum yssl,
               to_number(case
                           when dm_b.pk_org = '0001B3100000004AG5D0' then
                            dm_b.vbdef10
                           else
                            dm_b.vbdef18
                         end) yfje,
               case
                 when b.nnum < dm_b.nnum then
                  to_number(case
                              when dm_b.pk_org = '0001B3100000004AG5D0' then
                               dm_b.vbdef10
                              else
                               dm_b.vbdef18
                            end) * b.nnum / dm_b.nnum
                 else
                  to_number(case
                              when dm_b.pk_org = '0001B3100000004AG5D0' then
                               dm_b.vbdef10
                              else
                               dm_b.vbdef18
                            end) * 1.00
               end ftyfje
          from ic_saleout_b b
          left join ic_saleout_h h
            on b.cgeneralhid = h.cgeneralhid
          left join dm_delivbill_b dm_b
            on b.cgeneralbid = dm_b.csrcbid
         where b.dr = 0
           and h.dr = 0
           and dm_b.dr = 0
           and b.nnum > 0
           and substr(b.dbizdate, 1, 10) >= '2017-01-01') t
 group by t.zj, t.dbizdate;
