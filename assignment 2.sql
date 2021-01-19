-- e5.1 Exercises from chapter 5
--
-- Before you begin:
-- re-create the tables and data using the script 
--   zagimore_schema.sql

-- 1  Display the RegionID, RegionName and number of stores in each region.
SELECT region.regionid, region.regionname, COUNT(*)
FROM region
INNER JOIN store
ON region.regionid = store.regionid
GROUP BY region.regionid;

-- 2 Display CategoryID and average price of products in that category.
SELECT category.categoryid, AVG(productprice)
FROM category
INNER JOIN product
ON category.categoryid = product.categoryid
GROUP BY category.categoryid;

-- 3 Display CategoryID and number of items purchased in that category.
SELECT category.categoryid, COUNT(*)
FROM category
JOIN product 
ON category.categoryid = product.categoryid
JOIN store
JOIN salestransaction
ON store.storeid = salestransaction.storeid
JOIN includes
ON product.productid = includes.productid
AND salestransaction.tid = includes.tid
GROUP BY category.categoryid;

-- 4 Display RegionID, RegionName and total amount of sales as AmountSpent
SELECT region.regionid, region.regionname, product.productprice * SUM(includes.quantity) AS AmountSpent
FROM region
JOIN store
ON region.regionid = store.regionid
JOIN product
JOIN salestransaction
ON store.storeid = salestransaction.storeid
JOIN includes 
ON product.productid = includes.productid
AND salestransaction.tid = includes.tid
GROUP BY region.regionid;
-- NEEDS REVIEW


-- 5 Display the TID and total number of items in the sale
--    for all sales where the total number of items is greater than 3
SELECT salestransaction.tid, SUM(includes.quantity) AS NumItems
FROM salestransaction
INNER JOIN includes 
ON salestransaction.tid = includes.tid
WHERE includes.quantity > 3
GROUP BY salestransaction.tid;
-- NEEDS REVIEW

-- 6 For vendor whose product sales exceeds $700, display the
--    VendorID, VendorName and total amount of sales as "TotalSales"


-- 7 Display the ProductID, Productname and ProductPrice
--    of the cheapest product.
SELECT productid, productname, MIN(productprice)
FROM product;

-- 8 Display the ProductID, Productname and VendorName
--    for products whose price is below average price of all products
--    sorted by productid.
SELECT productid, productname, productprice, vendorname
FROM vendor
RIGHT JOIN product 
ON vendor.vendorid = product.productid
WHERE productprice < (SELECT AVG(productprice) FROM product)
GROUP BY productid;

-- 9 Display the ProductID and Productname from products that
--    have sold more than 2 (total quantity).  Sort by ProductID
SELECT product.productid, productname
FROM product
JOIN salestransaction
JOIN includes
ON product.productid = includes.productid
AND salestransaction.tid = includes.tid
GROUP BY productid
HAVING SUM(quantity) > 2;


-- 10 Display the ProductID for the product that has been 
--    sold the most (highest total quantity across all
--    transactions). 


-- 11 Rewrite query 30 in chapter 5 using a join.
-- For each product that has more than three items sold within all sales
-- transactions, retrieve the product id, product name, and product price
-- SELECT productid, productname, productprice
-- FROM product
-- WHERE productid IN 
	-- (SELECT productid
	-- FROM includes
    -- GROUP BY productid
    -- HAVING SUM(quantity) > 3);   
SELECT product.productid, productname, productprice
FROM product
JOIN includes
ON product.productid = includes.productid
GROUP BY productid
HAVING SUM(quantity) > 3;

-- 12 Rewrite query 31 using a join.
-- For each product whose items were sold in more than one sales transaction,
-- retrieve the product id, product name, and product price
-- SELECT productid, productname, productprice
-- FROM product
-- WHERE productid IN 
	-- (SELECT productid
	-- FROM includes
	-- GROUP BY productid
    -- HAVING COUNT(tid) > 1);
SELECT product.productid, productname, productprice
FROM product
JOIN includes
ON product.productid = includes.productid
GROUP BY productid
HAVING COUNT(tid) > 1;

-- 13 create a view over the product, salestransaction, includes, customer, store, region tables
--     with columns: tdate, productid, productname, productprice, quantity, customerid, customername, 
--                   storeid, storezip, regionname
CREATE VIEW new_view AS
SELECT salestransaction.tdate, product.productid, product.productname, product.productprice, 
	includes.quantity, customer.customerid, customer.customername, store.storeid, store.storezip, region.regionname
FROM product 
JOIN region
JOIN store
ON region.regionid = store.regionid
JOIN customer
JOIN salestransaction
ON customer.customerid = salestransaction.customerid
AND store.storeid = salestransaction.storeid
JOIN includes
ON product.productid = includes.productid
AND salestransaction.tid = includes.tid;

-- 14 Using the view created in question 13
--   Display ProductID, ProductName, ProductPrice  
--   for products sold in zip code "60600" sorted by ProductID
SELECT productid, productname, productprice
FROM new_view
WHERE storezip = "60600"
GROUP BY productid;

-- 15 Using the view from question 13 
--    display CustomerName and TDate for any customer buying a product "Easy Boot"
SELECT customername, tdate
FROM new_view
WHERE productname = "Easy Boot";

-- 16 Using the view from question 13
--    display RegionName and total amount of sales in each region as "AmountSpent"
SELECT regionname, productprice * SUM(quantity)  AS AmountSpent
FROM new_view
GROUP BY regionname;
