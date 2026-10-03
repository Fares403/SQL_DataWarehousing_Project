

insert into silver.erp_cust_az12 (
	cid , bdate, gen
)
select 
	case
		when cid like 'NAS%' THEN substring (cid ,4 , len (cid))
		ELSE cid
	end as cid,

	case when bdate > getdate() then null 
	else bdate
	end as bdate
,
	case when upper(trim(gen)) in ('F' ,'FEMALE') THEN 'Female'
		when upper (trim(gen)) in ('M' ,'MALE') THEN 'Male'
		else 'n/a'
end as gen

from bronze.erp_cust_az12

where 
	case
		when cid like 'NAS%' THEN substring (cid ,4 , len (cid))
		ELSE cid
	end as cid
	not in (select crm_cust_info.cst_key from silver.crm_cust_info)


select * from silver.crm_cust_info


select distinct bdate 
from bronze.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()


select distinct gen from bronze.erp_cust_az12