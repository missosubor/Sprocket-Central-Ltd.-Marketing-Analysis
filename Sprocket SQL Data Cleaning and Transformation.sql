--Data Cleaning and Transformation
--I viewed the transactions table
  Select *
 From Transactions

 

 -- Clean State Column in Customer Address Dataset
 UPDATE Customer_Address
SET State = REPLACE(State, 'Victoria', 'Vic')
WHERE State = 'Victoria';

UPDATE Customer_Address
SET State = REPLACE(State, 'New South Wales', 'NSW')
WHERE State = 'New South Wales';


 -- Cleaned Gender Column in Customer Demographics
UPDATE Customer_Demographics
SET Gender = REPLACE(Gender, 'femal', 'Female')
WHERE Gender= 'femal'

UPDATE Customer_Demographics
SET Gender = REPLACE(Gender, 'M', 'Male')
WHERE Gender= 'M'

UPDATE Customer_Demographics
SET DOB = CAST(DOB AS DATE)



 Select 
 t.transaction_id AS Transaction_id,
 t.product_id AS Product_id,
 t.customer_id AS Customer_id,
 t.transaction_date AS Transaction_date,
 t.online_order AS online_order,
 t.brand AS Brand,
 t.product_line AS Product_line,
 t.product_class AS Product_class,
 t.product_size AS Product_size,
 Round(t.list_price,2) AS List_price,
 t.standard_cost AS Standard_cost,
 Round((List_price-Standard_cost),2) AS Profit,
 t.product_first_sold_date AS Product_first_sold_date,
  cd.gender AS [Gender],
  CONCAT(cd.first_name,' ',cd.last_name) AS [Full_Name],
  2018 - CAST(LEFT(cd.DOB, 4) AS INT) AS [Age],
  --I converted the Year from the DOB to an integer and subtracted it from 2018 to get the age
  cd.DOB AS DOB,
  cd.job_title AS [Job_title],
  cd.job_industry_category AS [Job_industry_category],
  cd.wealth_segment AS [Wealth_segment],
  cd.owns_car AS [Owns_car],
  cd.tenure AS [Tenure],
  ca.state AS [State] 
 From Transactions AS t
 Join Customer_Demographics AS cd on t.customer_id = cd.customer_id 
 Join Customer_Address AS ca ON t.customer_id = ca.customer_id 
--Joined both tables to the Transactions table)


--To check for Information on the datasets- ensuring the data types are right

 sp_help Transactions
 sp_help Customer_Demographics
 sp_help Customer_Address


-- To know the total number of entries and customers in the data set

 Select Count (customer_id)
 From Transactions

 Select Count (DISTINCT(customer_id))
 From Transactions