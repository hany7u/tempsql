select b.cgeneralbid ,ab.vbdef1,mclazz.code,fiorg.pk_org,fiorg.name
from ic_saleout_b b
left join so_delivery_b ab on b.csourcebillbid = ab.cdeliverybid
left join bd_material m on b.cmaterialoid = m.pk_material 
left join bd_marbasclass mclazz on m.pk_marbasclass = mclazz.pk_marbasclass
left join org_orgs fiorg on ab.pk_org = fiorg.pk_org;

select t.icbid,t.vbillcode,t.dbilldate from (
       select icb.cgeneralbid icbid,h.vbillcode vbillcode,substr(b.dbilldate,1,10) dbilldate,
              ROW_NUMBER() OVER(PARTITION BY icb.cgeneralbid ORDER BY b.dbilldate desc) rn
        from so_saleinvoice_b b
        left join so_saleinvoice h on b.csaleinvoiceid = h.csaleinvoiceid
        left join ic_saleout_b icb on b.csrcbid = icb.cgeneralbid
        where b.dr = 0 and icb.dr = 0 and h.dr = 0
        group by icb.cgeneralbid,h.vbillcode ,b.dbilldate) t
where t.rn <=1
