

-- dim product
create view gold.dim_product as 
select 
	row_number() over (order by prd_start_dt ) as product_key,
	pn.prd_id as product_id , 
	pn.prd_key as product_number,
	pn.prd_nm as product_name,
	pn.cat_id as category_id,
	pc.cat as category,
	pc.subcat as subcategory,
	pc.maintenance,
	pn.prd_cost as cost,
	pn.prd_line as product_line,	
	pn.prd_start_dt as start_date
	
from silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
on pn.cat_id = pc.id
where pn.prd_end_dt is null -- filter out all historcal data




select * from silver.crm_prd_info
select * from silver.erp_px_cat_g1v2

select * from gold.dim_product