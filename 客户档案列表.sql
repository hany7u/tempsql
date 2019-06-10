select nvl(maincust.code,cust.code) 上级客户编码,nvl(maincust.name,cust.name) 上级客户名称, cust.code 客户编码,cust.name 客户名称
from bd_customer cust 
left join bd_customer maincust on cust.pk_customer_main = maincust.pk_customer
where cust.dr = 0
order by nvl(maincust.code,cust.code)
