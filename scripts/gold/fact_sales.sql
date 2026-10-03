


use DataWarehouse

create view gold.fact_sales as
select 
	sd.sls_ord_num AS order_number,
	pr.product_key,
	cu.customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt	as due_date,
	sd.sls_sales	as sales_amount,
	sd.sls_quantity as quantity,
	sd.sls_price

from silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr
on sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu
on sd.sls_cust_id = cu.customer_id



select * from gold.fact_sales f
left join gold.dim_customers c 
on c.customer_key = f.customer_key 
where c.customer_key is null


select * from gold.fact_sales f
left join gold.dim_product p
on p.product_key = f.product_key 
where p.product_key is null

