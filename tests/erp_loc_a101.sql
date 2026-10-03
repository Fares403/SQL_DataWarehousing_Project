select *from bronze.crm_cust_info

insert into silver.erp_loc_a101(
cid , cntry
)
select 
	replace(cid , '-', '') as cid, 
	case
	 when trim(cntry) ='DE' THEN 'Germany'
	 when trim(cntry) in ('US' , 'USA') THEN 'United States'
	 when trim(cntry) ='' or cntry is null then 'n/a'
	else cntry

	end as cntry
from bronze.erp_loc_a101

select distinct cntry from silver.erp_loc_a101