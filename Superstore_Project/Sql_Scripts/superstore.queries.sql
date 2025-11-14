-- i edited and the table names, re-arranged the columns, and i also included the cost column
--  because the original file didn't come with column. before all the above i create a copy of the
-- original table so i won't alter the original.
-- i did some anakysis here to better understand why there are some negative values,
-- i concluded that its as a result of the discounts, probably because they where trying to attract more customers
-- i will give more details of my report in power bi

CREATE TABLE `superstore` (
  `Row_ID` int DEFAULT NULL,
  `Order_ID` text,
  `Order_Date` text,
  `Ship_Date` text,
  `Ship_Mode` text,
  `Customer_ID` text,
  `Customer_Name` text,
  `Segment` text,
  `Country` text,
  `City` text,
  `State` text,
  `Postal_code` int DEFAULT NULL,
  `Region` text,
  `Product_ID` text,
  `Category` text,
  `Sub_Category` text,
  `Product_Name` text,
  `Sales` double DEFAULT NULL,
  `Quantity` int DEFAULT NULL,
  `Discount` double DEFAULT NULL,
  `Profit` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
 FROM `sample - superstore`;
 
 
 
 
 Alter table `sample - superstore`
 change column `Order ID` Order_ID text,
 change column `Order Date` Order_Date text,
 change column `Ship Date` Ship_Date text,
 change column `Ship Mode` Ship_Mode text,
 change column `Customer ID` Customer_ID text,
 change column `Customer Name` Customer_Name text,
 change column `Postal Code` Postal_code int DEFAULT NULL,
 change column `Product ID` Product_ID text,
 change column `Sub-Category` Sub_Category text,
 change column `Product Name` Product_Name text;

 Alter table `sample - superstore`
 modify column  Order_Date date,
 modify column  Ship_Date date;
 
 
select * from  superstore;
 
 insert into superstore
SELECT *
 FROM `sample - superstore`;
 
 ;
 
 alter table superstore
 modify column Order_Date date,
 modify column Ship_Date date;
 
update superstore
set Ship_date = str_to_date(Ship_date, '%m/%d/%Y') ;

alter table superstore
modify cost text after sales;

alter table superstore
drop column Row_ID;

select count(distinct Product_ID) totalOrderPerCustomer
from superstore
;

select * from  superstore;

select Segment, count(Customer_ID) total_numberBySegment
from superstore

group by segment;


select  state, Category,  round(sum(profit),2) profit
from superstore
where Category = 'furniture'
group by state;


select Customer_Name,state,city,segment,Region, product_name,Quantity,sales,Discount, profit
from superstore
where Product_Name like 'Chromcraft Bull-Nose Wood Oval Conference Tables & Bases' or 
'Riverside Palais Royal Lawyers Bookcase, Royale Cherry Finish';

with profit_loss as (select  state,city,Category,Quantity,Discount,
round(sum(case when profit < 0 then profit else 0 end),2) loss,
round(sum(case when profit >0 then profit else 0 end),2) profit
from superstore 
group by state,Category,city,Discount,Quantity)
select state,city,Profit,loss, Quantity,discount,round((profit + loss),2) `profit&loss`
,Dense_rank() over(order by round((profit + loss),2)) ranking
	from profit_loss 
group by state,city,Profit,loss, Quantity,discount
having loss < 0;

select distinct city,Category,sub_Category,product_name,round(sum(Profit)) profit
	from superstore
    group by city,Category,sub_Category,product_name
having profit < 0;


select 
* from  superstore
where Product_Name like 'Holmes%';
;
        
alter table superstore
Add column `Cost` decimal (10,1);

select *
from superstore
where Product_Name = 'Holmes Replacement Filter for HEPA Air Cleaner, Very Large Room, HEPA Filter';
-- roup by Customer_Name,state,Product_Name, round((sales - profit),2);

select state, year(order_date)`year_month`,discount,ROUND(SUM(sales),2) total_sales,quantity,
ROUND(SUM(Profit),2) profit,Category
from superstore
where profit <= 0
group by state,year(order_date),discount,Category,quantity,sales;

update superstore
set sales = round(sales,2)
;

select *
from superstore;
