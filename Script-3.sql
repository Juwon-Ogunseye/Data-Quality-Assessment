SELECT * FROM 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\Intenship\transactions.csv'
CREATE TABLE Transactions(
	transaction_id int,
	product_id int,
	customer_id int ,
	transaction_date date,
	online_order varchar,
	order_status varchar,
	brand varchar,
	product_line varchar,
	product_class varchar,
	product_size varchar,
	list_price int,
	standard_cost int,
	product_first_sold_date date 
)
COPY transactions FROM 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\Intenship\transactions.csv'(DELIMITER ',', HEADER,  '%y/%m/%d')

SELECT CAST
	( product_first_sold_date AS numeric(18,3)) 
FROM transactions;

ALTER TABLE transactions ALTER product_first_sold_date TYPE numeric(18,3); 

SELECT DATE '1900-01-01' + INTERVAL (product_first_sold_date::INT) DAYS FROM transactions;

select count(*) from transactions where transaction_id is null;
/**no null value**/
select count(*) from transactions where product_id is null;
/**no null value**/
select count(*) from transactions where customer_id is null;
/**no null value**/
select count(*) from transactions where transaction_date is null;
select count(*) from transactions where online_order is null;
/**there are 360 null value**/
select count(*) from transactions where order_status is null;
/**there are no null value**/
select count(*) from transactions where brand is null;
/**there are 197 null value**/
select count(*) from transactions where product_line is null;
/**there are 197 null value**/
select count(*) from transactions where product_class is null;
/**there are 197 null value**/
select count(*) from transactions where product_size is null;
/**there are 197 null value**/
select count(*) from transactions where list_price is null;
/**there are no null value**/
select count(*) from transactions where standard_cost is null;
/**there are 197 null value**/
select count(*) from transactions where product_first_sold_date is null;
/**there are 197 null value**/

SELECT 
	transaction_id,
	product_id,
	customer_id,
	transaction_date,
	online_order,
	order_status,
	brand,
	product_line,
	product_class,
	product_size,
	list_price,
	standard_cost,
	list_price-standard_cost AS profit,
	DATE '1900-01-01' + INTERVAL (product_first_sold_date::INT) DAYS-2
	FROM transactions;

SELECT * FROM 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\Intenship\CustomerDemographic.csv';
CREATE TABLE NewCustomerlist (
	first_name VARCHAR, 
	last_name VARCHAR,
	gender VARCHAR,
	past_3_years_bike_related_purchases INT,
	DOB DATE,
	job_title VARCHAR,
	job_industry_category VARCHAR,
	wealth_segment VARCHAR, 
	deceased_indicator VARCHAR,
	owns_car VARCHAR,
	tenure INT,
	address VARCHAR,
	postcode INT,
	state VARCHAR,
	country VARCHAR, 
	property_valuation INT,
	column16 
)
SELECT 
	customer_id,
	first_name,
	last_name,
	gender,
	past_3_years_bike_related_purchases,
	DOB,
	job_title,
	job_industry_category,
	wealth_segment,
	deceased_indicator,
	owns_car,
	tenure 
FROM 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\Intenship\CustomerDemographic.csv';

CREATE TABLE CustomerDemographic(
	customer_id INT,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	past_3_years_bike_related_purchases INT,
	DOB DATE,
	job_titleB VARCHAR,
	job_industry_category VARCHAR,
	wealth_segment VARCHAR,
	deceased_indicator VARCHAR,
	owns_car VARCHAR,
	tenure INT 
)

CREATE TEMP TABLE my_temp_table 
(
	customer_id varchar,
	first_name VARCHAR,
	last_name VARCHAR,
	gender VARCHAR,
	past_3_years_bike_related_purchases varchar,
	DOB DATE,
	job_titleB VARCHAR,
	job_industry_category VARCHAR,
	wealth_segment VARCHAR,
	deceased_indicator VARCHAR,
	owns_car VARCHAR,
	tenure varchar

);
drop table my_temp_table 

/**created a temporary table and inserted all data into the table without formating**/
CREATE TEMP TABLE my_temp_table as select * from 'C:\Users\HP\Desktop\EverSed\DataLeum\First Project Portfolio\second project\Intenship\CustomerDemographic.csv';

select count(*) from my_temp_table where dob is null;
/**no null values in dob**/

SELECT CAST(dob AS DATE) FROM my_temp_table;

SELECT dob
FROM my_temp_table
WHERE dob  LIKE '____-__-__';

select customer_id,
	first_name,
	last_name,
	gender,
	past_3_years_bike_related_purchases,
	DOB,
	2022-year(DOB) as Age,
	job_title,
	job_industry_category,
	wealth_segment,
	deceased_indicator,
	owns_car,
	tenure 
	from my_temp_table
	order by dob asc

/** DOb have an unclean date format with a age of 179 which is obviouly a wrong date **/
	
	select dob from my_temp_table where 2022-year(dob)>100 
	/**check the age that is greatter than the avearge age for a person**/

delete
FROM my_temp_table
WHERE dob  LIKE '____-__-__';
/**to check and delete any date format that doesnt come with a year**/

INSERT INTO CustomerDemographic SELECT * FROM my_temp_table
/**moved data into permanent table after formating dates and checking for null values on the dates columns**/ 

select count(*) from CustomerDemographic where dob is null;
/**87 null values in dob**/

SELECT CAST(dob AS DATE) FROM CustomerDemographic;

SELECT dob
FROM CustomerDemographic
WHERE dob  LIKE '____-__-__';

select customer_id,
	first_name,
	last_name,
	gender,
	past_3_years_bike_related_purchases,
	DOB,
	2022-year(DOB) as Age,
	job_titleB,
	job_industry_category,
	wealth_segment,
	deceased_indicator,
	owns_car,
	tenure 
	from CustomerDemographic
	order by dob asc

/** DOb have an unclean date format with a age of 179 which is obviouly a wrong date **/
	select dob from CustomerDemographic where 2022-year(dob)>100 
	/**check the age that is greatter than the avearge age for a person**/

select distinct gender from CustomerDemographic;
Update CustomerDemographic
SET gender = replace(Gender, 'Femaleemaleeemaleeemale', 'Female');

Update CustomerDemographic
SET gender = replace(Gender, 'Femaleemaleeemalee', 'Female');

Update CustomerDemographic
SET gender = replace(Gender, 'Femaleemal', 'Female');

Update CustomerDemographic
SET gender = replace(Gender, 'Malealeale', 'Male');

Update CustomerDemographic
SET gender = replace(Gender, 'Maleale', 'Male');

/**cleaned up the gender values so that they remain consistent with male, female. we have an unknown gender called u**/


select count(*) from CustomerDemographic where first_name is null;

select count(*) from CustomerDemographic where last_name is null;
/**127 null values **/

select count(*) from CustomerDemographic where gender is null;
/**no null values **/

select count(*) from mCustomerDemographic where past_3_years_bike_related_purchases is null;
/**127 null values **/

select count(*) from CustomerDemographic where job_titleB  is null;
/**no null values**/

select count(*) from CustomerDemographic where job_industry_category is null;
/**no null values **/

select count(*) from CustomerDemographic where dob is null;
/**no null values in dob**/

select count(*) from CustomerDemographic where wealth_segment is null;
/**no null values in **/

select count(*) from CustomerDemographic where deceased_indicator is null;
/**no null values in **/

select count(*) from CustomerDemographic where owns_car is null;
/**no null values**/

select count(*) from CustomerDemographic where tenure is null;
/**87 null values **/

select * from CustomerDemographic
select distinct job_titleB from CustomerDemographic;
/** there are 193 Job tiltles**/
select distinct job_industry_category from CustomerDemographic;

select distinct deceased_indicator from CustomerDemographic










