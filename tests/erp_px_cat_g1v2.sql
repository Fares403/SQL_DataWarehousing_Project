

select 
id	,
cat	,
subcat,
maintenance

from bronze.erp_px_cat_g1v2



select * from bronze.erp_px_cat_g1v2 
where cat !=trim(cat)