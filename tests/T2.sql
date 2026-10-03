

USE DataWarehouse

SELECT * FROM bronze.crm_cust_info

-- check uniqueness of primary key
-- expectation : No results
-- output : results , there is a duplicates
select cst_id ,
count(*)
from bronze.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null


--
-- check for unwanted spaces
-- expectation : No results
-- output : results exists
select cst_firstname from bronze.crm_cust_info
where cst_firstname != trim(cst_firstname)

select cst_lastname from bronze.crm_cust_info
where cst_lastname != trim(cst_lastname)

-- good quailty 
select cst_gndr from bronze.crm_cust_info
where cst_gndr != trim(cst_gndr)

----- Data Standardization & Consistency

select distinct cst_gndr from bronze.crm_cust_info

select distinct cst_marital_status from bronze.crm_cust_info

select * from silver.crm_cust_info
--------------









