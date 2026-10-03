

USE DataWarehouse

SELECT * FROM bronze.crm_cust_info

-- check uniqueness of primary key
-- expectation : No results
-- output : results , there is a duplicates
select cst_id ,
count(*)
from silver.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null


--
-- check for unwanted spaces
-- expectation : No results
-- output : results exists
select cst_firstname from silver.crm_cust_info
where cst_firstname != trim(cst_firstname)

select cst_lastname from silver.crm_cust_info
where cst_lastname != trim(cst_lastname)

-- good quailty 
select cst_gndr from silver.crm_cust_info
where cst_gndr != trim(cst_gndr)

----- Data Standardization & Consistency

select distinct cst_gndr from silver.crm_cust_info

select distinct cst_marital_status from silver.crm_cust_info

select * from silver.crm_cust_info
where cst_id is null

select * from silver.crm_cust_info


-----------------------
-- crm_prd_info
select prd_nm from bronze.crm_prd_info
where prd_nm != trim (prd_nm)

select prd_cost from bronze.crm_prd_info
where prd_cost <0 or prd_cost is null


select distinct prd_line from bronze.crm_prd_info


select * from bronze.crm_prd_info
where prd_end_dt < prd_start_dt



select prd_id,	
prd_key,
prd_nm	,
prd_cost,
prd_line,
prd_start_dt,	
prd_end_dt,

lead(prd_start_dt) over (partition by prd_key order by prd_start_dt )-1 as prd_end_dt_test
from bronze.crm_prd_info
where prd_key in ('AC-HE-HL-U509-R' , 'AC-HE-HL-U509')








------------

--crm_sales_details
select 
nullif(sls_order_dt ,0) sls_order_dt
from bronze.crm_sales_details
where 
sls_order_dt <=0 
OR len(sls_order_dt) !=8 
OR sls_order_dt >20500001 
OR sls_order_dt <19000001




select * from bronze.crm_sales_details
where sls_order_dt >sls_ship_dt or sls_order_dt > sls_due_dt


select 
sls_sales as old_sls_sales,
sls_quantity,
sls_price as old_sls_price,
	case when sls_sales is null or sls_sales <=0 or sls_sales !=sls_quantity * abs(sls_price)
	then sls_quantity * abs(sls_price)
	else sls_sales
	end as sls_sales
	,
	case when sls_price  is null or sls_price <=0
		then sls_sales /nullif(sls_quantity,0)
		else sls_price
	end as sls_price
from bronze.crm_sales_details
where sls_sales !=  sls_quantity * sls_price
or sls_sales is null or sls_quantity is null or sls_price is null
or sls_sales <=0 or sls_quantity <=0 or sls_price <=0
order by sls_sales ,sls_quantity ,sls_price

-------------


-- erp_loc_a101


select 
	replace(cid , '-', '') as cid, 
	cntry
from bronze.erp_loc_a101
where replace(cid , '-', '') not in (select cst_key from silver.crm_cust_info)




select distinct cntry from bronze.erp_loc_a101
order by cntry
------

-- erp_px_cat_g1v2

select * from bronze.erp_px_cat_g1v2 
where cat !=trim(cat)


select * from bronze.erp_px_cat_g1v2 
where cat !=trim(cat) or subcat !=trim (subcat)


select distinct cat from bronze.erp_px_cat_g1v2
select distinct subcat from bronze.erp_px_cat_g1v2