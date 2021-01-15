-- e5.1 Exercises from chapter 5
--
-- Before you begin:
-- re-create the tables and data using the script 
--   zagimore_schema.sql

-- 1  Display the RegionID, RegionName and number of stores in each region.
select 1;

-- 2 Display CategoryID and average price of products in that category.
select 2;

-- 3 Display CategoryID and number of items purchased in that category.
select 3;

-- 4 Display RegionID, RegionName and total amount of sales as AmountSpent
select 4;

-- 5 Display the TID and total number of items in the sale
--    for all sales where the total number of items is greater than 3
select 5;

-- 6 For vendor whose product sales exceeds $700, display the
--    VendorID, VendorName and total amount of sales as "TotalSales"
select 6;

-- 7 Display the ProductID, Productname and ProductPrice
--    of the cheapest product.
select 7;

-- 8 Display the ProductID, Productname and VendorName
--    for products whose price is below average price of all products
--    sorted by productid.
select 8;

-- 9 Display the ProductID and Productname from products that
--    have sold more than 2 (total quantity).  Sort by ProductID
select 9;

-- 10 Display the ProductID for the product that has been 
--    sold the most (highest total quantity across all
--    transactions). 
select 10;


-- 11 Rewrite query 30 in chapter 5 using a join.

-- 12 Rewrite query 31 using a join.

-- 13 create a view over the product, salestransaction, includes, customer, store, region tables
--     with columns: tdate, productid, productname, productprice, quantity, customerid, customername, 
--                   storeid, storezip, regionname
create view 13;

-- 14 Using the view created in question 13
--   Display ProductID, ProductName, ProductPrice  
--   for products sold in zip code "60600" sorted by ProductID
select 14;

-- 15 Using the view from question 13 
--    display CustomerName and TDate for any customer buying a product "Easy Boot"
select 15;

-- 16 Using the view from question 13
--    display RegionName and total amount of sales in each region as "AmountSpent"
select 16;
