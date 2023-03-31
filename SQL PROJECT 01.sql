/*---SQL PROJECT 01 ---*/
/* Written by:- Pratik Deore
batch:- Neowise
roll no.:- (fn-neo-64JFL)
email:- deorepratik2020@gmail.com */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Insight Takem :-
  1. Category wise total sales
  2. Category wise highest sales 
  3. Region wise Total sales 
  4. Region wise maximum sales 
  5. Region wise minimum sales 
  6. Region wise total profit
  7. Region wise highest profit 
  8. Region wise lowest profit 
  9. Which Region has highest sales ?
  10.Which Region has lowest sales ?
  11.Which Region has highest profit ?
  12.Which Region has lowest profit ?
  13.Product has maximum sales 
  14.Product has minimum sales
  15.Which Categories and sub categories has highest number of returns ?
  16.Which Categories and sub categories has lowest number of returns ?
  17.Which shipping mode is the most preferable ?
  18.Sub categories wise total sales 
  19.Sub categories wise highest sales
  20.Category wise profit
  21.Sub Category wise profit 
  22.City wise total sales
  23.City wise total profit 
  24.Which city has maximum sales ?
  25.Which city has minimum sales ?
  26.Overall sales
  27.Overall Profit 
  28.Product has maximum profit 
  29.Product has minimum profit
  30.Which sub categories has highest number of returns ?
  31.Which sub categories has lowest number of returns ?
  32. How many registered customer during 2014-2016?
  33.Calculating Frequency of each order id by each customer Name in descending order
  34.Calculate Totals Sales of each customer name?
  35.Display No of Customers in each region in descending order?
  36.Find a region having maximum number of customers?
  37.Display the records for customers who live in state California and postal code 90032?
38.Which is the most loss making category in the East region?
39. Give me the top 3 product ids by most returns?
40.In which city the most number of returns are being recorded?
41.Find the relationship between days between order date , ship date and profit?
42. Find the region wise profits for all the regions and give the output of the most profitable region
43.Which month observe the highest number of orders placed and return placed for each year?
44.Calculate percentage change in sales for the entire dataset?
	X axis should be year_month
	Y axis percent change
45.Find out if any sales pattern exists for all the region?
46.Top and bottom selling product for each region
47. Why are returns initiated? Are there any specific characteristics for all the returns?
	Hint: Find return across all categories to observe any pattern
48. Create a table having two columns ( date and sales), Date should start with the min date of data and 
end at max date - in between we need all the dates If date is available show sales for that date else show date and NA as sale
*/
use sample;

select * from superstore;

/* 1. Category wise total sales */
select Category, round(Sum(Sales),2) from superstore group by Category;

/* 2. Category wise highest sales */
select Category , round(Max(Sales),2) from superstore group by Category;

/* 3. Region wise Total sales */
select Region , round(Sum(Sales),2) from superstore group by Region order by Region;

/* 4. Region wise maximum sales */
select Region , round(Max(Sales),2) from superstore group by Category;

/* 5. Region wise minimum sales */
SELECT Region, ROUND(MIN(Sales), 2) FROM superstore GROUP BY Category;

/*   6. Region wise total profit */
select Region, Round(SUM(Profit),2) from superstore group by Region;

/*7. Region wise highest profit */
select Region , max(Profit) from superstore group by Region;

/*  8. Region wise lowest profit */
select Region,round(min(Profit),2) from superstore  group by Region;

/*  9. Which Region has highest sales */
select Region, Max(Sales) from superstore group by Region;

/*  10.Which Region has lowest sales */
select Region ,min(Sales) from superstore group by Region;

/*  11.Which Region has highest profit */
select Region,max(Profit) from superstore group by Region limit 2;

/*  12.Which Region has lowest profit */
select Region , min(Profit) from superstore group by Region limit 1;
  
/* 15.which Product  has maximum sales */
select  Product_Name , max(Sales) from superstore ;

/*  16.Product has minimum sales */
select Product_Name , min(Sales) from superstore group by Product_Name;

/*  17.Which Categories and sub categories has highest number of returns */
with cte as (select s.Category, count(r.Returned)  as no_of_return from superstore as s
join returns as r on s.Order_ID = r.Order_ID  group by  s.Category)
select Category ,no_of_return from cte limit 1;

/*  18.Which Categories and sub categories has lowest number of returns */
with cte as (select s.Category, count(r.Returned)  as no_of_return from superstore as s
join returns as r on s.Order_ID = r.Order_ID  group by  s.Category)
select Category ,no_of_return from cte order by Category Desc limit 1;

/* 19.Which shipping mode is the most preferable */
select Ship_Mode ,count(Ship_Mode) as l from superstore group by Ship_Mode order by l desc limit 1 ;

/*   20.Sub categories wise total sales */
select Sub_Category,round(sum(Sales),2) from superstore group by Sub_Category ;

/*  21.Sub categories wise highest sales*/
select Sub_Category,round(max(Sales),2)as h from superstore group by Sub_Category order by h desc limit 1;

/*  22.Category wise profit*/
select Category ,round(sum(Profit),2)as p from superstore group by Category order by p desc limit 1;
  
/*  23.Sub Category wise profit */
select Sub_Category ,round(sum(Profit),2)as p from superstore group by Sub_Category order by p desc limit 1;

/*  24.City wise total sales*/
select l.City , sum(s.Sales) as t from superstore as s 
join location as l 
on s.Postal_Code = l.Postal_Code ;

/*  25.City wise total profit */
select l.City , sum(s.Profit) as t from superstore as s 
join location as l 
on s.Postal_Code = l.Postal_Code ;

/*  26.Which city has maximum sales */
select l.City , max(s.Profit) as t from superstore as s 
join location as l 
on s.Postal_Code = l.Postal_Code 
group by l.City order by s.Profit desc limit 1 ;

/*  27.Which city has minimum sales */
select l.City , min(s.Profit) as t from superstore as s 
join location as l 
on s.Postal_Code = l.Postal_Code 
group by l.City order by s.Profit desc limit 1 ;

 /* 28.Overall sales */
 select sum(Sales) from superstore ; 

  /* 29.Overall Profit */
  select sum(Profit) from superstore where Profit >0;

/*  30.Product has maximum profit */
select max(Profit) FROM superstore where profit >0 ;

 /* 31.Product has minimum profit */
select min(Profit) FROM superstore where profit <0 ;
 
 /* 32.Which sub categories has highest number of returns */
 select s.Sub_Category , count(r.Returned) from superstore s 
 join returns as r 
 on s.Order_ID = r.Order_ID
 group by 1 
 order by 2 desc limit 1;
 
 /*33.Which sub categories has lowest number of returns */
select s.Sub_Category , count(r.Returned) from superstore s 
 join returns as r 
 on s.Order_ID = r.Order_ID
 group by 1 
 order by 2 ASC limit 1;
 
/* 32. How many registered customer during 2014-2016 */
select distinct(Customer_Name),count(Customer_ID),year(Order_Date) as reg from superstore 
WHERE year(Order_Date) in ( 2014,2015,2016) group by Customer_Name order by reg desc;

 /* 33.Calculating Frequency of each order id by each customer Name in descending order  */
 Select Customer_Name , Order_ID , COUNT(Order_ID) as freq from superstore
 group by 2 order by 3 desc;

/*  34.Calculate Totals Sales of each customer name*/
select Customer_Name , (Sales * Quantity ) as total from superstore
group by 1;

/*  35.Display No of Customers in each region in descending order */
select Region , count(*) as t from superstore group by 1 order by 2 desc;

 /* 36.Find a region having maximum number of customers */
 select Region , count(Customer_ID) as m from superstore group by 1 order by 2 desc limit 1 ;

/*  37.Display the records for customers who live in state California and postal code 90032*/
select distinct(s.Customer_Name), l.State , l.Postal_Code from superstore  s 
join location as l on s.Postal_Code = l.Postal_Code 
where l.State= 'California' AND l.Postal_Code = 90032;

/* 38.Which is the most loss making category in the East region */
select Region , Category ,Profit from superstore
where profit < 0 and Region= 'East' order by 3 asc limit 3;

/* 39. Give me the top 3 product ids by most returns */
select s.Product_ID ,COUNT(r.Returned) as re from superstore as s  
join returns as r on s.Order_ID = r.Order_ID  group by  1 order by re desc  limit 3; 


/* 40.In which city the most number of returns are being recorded */
select l.City ,COUNT(r.Returned) as re from location as l
join superstore as s on s.Postal_Code = l.Postal_Code  
join returns as r on s.Order_ID = r.Order_ID 
group by  1 order by re desc  limit 3; 


/*41.Find the relationship between days between order date , ship date and profit */
select (Ship_Date - Order_Date) as diff , Profit from superstore
group by diff order by diff;

/*42. Find the region wise profits for all the regions and give the output of the most profitable region */
select Region , round(Sum(Profit),2) as p FROM superstore 
group by 1 order by 2 desc limit 1; 

/* 43.Which month observe the highest number of orders placed and return placed for each year */
with recursive cte as(
select month(s.Order_Date) as monthl , count(s.Order_ID) as no_of_placed,
 Year(s.Order_Date) as yearl , count(r.Order_ID) as no_of_returned ,count(*) as orders from superstore as s
join returns as r on s.Order_ID = r.Order_ID
where r.Returned = 'Yes' group by 1,3)

select monthl, max(no_of_placed) as a , yearl, max(no_of_returned) as b ,orders from cte 
group by yearl  ;

/* 44.Calculate percentage change in sales for the entire dataset?
	X axis should be year_month
	Y axis percent change */
WITH recursive cte AS (
  SELECT Order_Date, Sales,Region,
         LAG(Sales) OVER (ORDER BY Order_Date) AS prev_sales
  FROM superstore
)
SELECT Order_Date, Region,
      round( (Sales - prev_sales) / prev_sales * 100 )AS percent_change
FROM cte ;
    
/* 45.Find out if any sales pattern exists for all the region? */
select Region , Sum(Sales) as sales from superstore group by 1;

/*46.Top and bottom selling product for each region */
WITH recursive RegionSales AS (
    SELECT 
        Region, 
        Product_Name, 
        SUM(Sales) AS TotalSales
    FROM 
        superstore
    GROUP BY 
        Region, Product_Name
)
SELECT 
    Region,
    Product_Name, 
    TotalSales,
    ROW_NUMBER() OVER (PARTITION BY Region ORDER BY TotalSales DESC) AS RankDesc
    /*ROW_NUMBER() OVER (PARTITION BY Region ORDER BY TotalSales ASC) AS RankAsc */
FROM 
    RegionSales;

/* 47. Why are returns initiated? Are there any specific characteristics for all the returns?
	Hint: Find return across all categories to observe any pattern */
    select s.Category , count(r.Returned) from superstore as s 
    join returns as r on s.Order_ID = r.Order_ID
    group by 1;
    
/*48. Create a table having two columns ( date and sales), Date should start with the min date of data and 
end at max date - in between we need all the dates If date is available show sales for that date else show date and NA as sale */
