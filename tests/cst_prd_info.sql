use DataWarehouse

insert into silver.crm_prd_info (
prd_id	,
cat_id	,
prd_key,
prd_nm,
prd_cost,
prd_line	,
prd_start_dt,
prd_end_dt	
)

select 
prd_id	,
replace(substring (prd_key, 1,5) , '-' , '_') as cat_id,
SUBSTRING(prd_key , 7,LEN(prd_key)) as prd_key,
prd_nm,
isnull(prd_cost,0)as prd_cost ,
	case upper(trim(prd_line))
		when  'M' THEN 'Mountain'
		when  'R' THEN 'Road'
		when 'S' THEN 'Other Sales'
		when 'T' THEN 'Touring'
		else 'n/a'
	end prd_line
	,
cast (prd_start_dt as date) as prd_start_dt,
cast (lead(prd_start_dt) over (partition by prd_key order by prd_start_dt )-1 as date) as prd_end_dt
from bronze.crm_prd_info

select * from bronze.crm_prd_info
select * from silver.crm_prd_info
select * from bronze.erp_px_cat_g1v2
select * from bronze.crm_sales_details





select prd_nm from silver.crm_prd_info
where prd_nm != trim (prd_nm)

select prd_cost from silver.crm_prd_info
where prd_cost <0 or prd_cost is null


select distinct prd_line from silver.crm_prd_info


select * from silver.crm_prd_info
where prd_end_dt < prd_start_dt

