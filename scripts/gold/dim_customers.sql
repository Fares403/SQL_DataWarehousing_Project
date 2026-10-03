
/*
-- Customer Information
select cst_id , count(*) from (
SELECT 
	ci.cst_id , 
	ci.cst_key,
	ci.cst_firstname , 
	ci.cst_lastname,
	ci.cst_marital_status,
	ci.cst_gndr,
	ci.cst_create_date,
	ca.bdate,
	ca.gen,
	la.cntry

FROM SILVER.crm_cust_info ci left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
)t group by cst_id 
having count(*) > 1
*/
-- CUSTOMER DIMENSION

create view gold.dim_customers AS
SELECT 
	ROW_NUMBER() over (order by cst_id) as customer_key, -- surgate key
	ci.cst_id  AS customer_id, 
	ci.cst_key as customer_number,
	ci.cst_firstname AS first_name, 
	ci.cst_lastname AS last_name,
	la.cntry as country ,
	ci.cst_marital_status AS marital_status,
		CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr -- CRM IS THE MASTER
		ELSE coalesce (ca.gen , 'n/a')
	end as gender,
	ca.bdate as birthdate,
	ci.cst_create_date as create_date


FROM SILVER.crm_cust_info ci left join silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid





/*
SELECT distinct
	ci.cst_gndr,
	ca.gen,

FROM SILVER.crm_cust_info ci 
LEFT join silver.erp_cust_az12 ca
on		ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON		ci.cst_key = la.cid
order by 2,1
*/


SELECT * FROM GOLD.dim_customers