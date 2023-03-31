/*---SQL PROJECT 01 ---*/
/* Written by:- Pratik Deore
batch:- Neowise
roll no.:- (fn-neo-64JFL)
email:- deorepratik2020@gmail.com */
/*--------------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
/* Insight Takem :-  */
use sample;
/* 1.Which is the most loss making category in the East region */
select Region , Category ,Profit from superstore
where profit < 0 and Region= 'East' order by 3 asc;

/* 2. Give me the top 3 product ids by most returns */
select s.Product_ID ,COUNT(r.Returned) as re from superstore as s  
join returns as r on s.Order_ID = r.Order_ID  group by  1 order by re desc  limit 3; 


/* 3.In which city the most number of returns are being recorded */
select l.City ,COUNT(r.Returned) as re from location as l
join superstore as s on s.Postal_Code = l.Postal_Code  
join returns as r on s.Order_ID = r.Order_ID 
group by  1 order by re desc  limit 5; 


/*4.Find the relationship between days between order date , ship date and profit */
select Ship_Date, Order_Date, (Ship_Date - Order_Date) as diff , Profit from superstore
group by diff order by diff asc limit 3;

/*5. Find the region wise profits for all the regions and give the output of the most profitable region */
select Region , round(Sum(Profit),2) as p FROM superstore 
group  by 1 order by 2 desc limit 1; 

/* 6.Which month observe the highest number of orders placed and return placed for each year */
with recursive cte as(
select month(s.Order_Date) as order_month , Year(s.Order_Date) as order_year, count(*)as orders , 
count(r.Returned) as Return_items from superstore as s join returns as r on s.Order_ID = r.Order_ID
 group by 1,2)

select order_year, max(order_month) as high_month,orders, Return_items  from cte 
group by 1 order by 1 ;

/* 7.Calculate percentage change in sales for the entire dataset?
	X axis should be year_month
	Y axis percent change */
WITH recursive cte AS (
  SELECT Order_Date, Sales,Region,
         LAG(Sales) OVER (ORDER BY Order_Date) AS prev_sales
  FROM superstore
)
SELECT Order_Date, Region,
      round( (Sales - prev_sales) / prev_sales * 100 )AS percent_change
FROM cte
group by 1 ;
    
/* 8.Find out if any sales pattern exists for all the region? */
select Region , Sum(Sales) as sales from superstore group by 1;

/*9.Top and bottom selling product for each region */
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

/* 10. Why are returns initiated? Are there any specific characteristics for all the returns?
	Hint: Find return across all categories to observe any pattern */
    select s.Category , count(r.Returned) from superstore as s 
    join returns as r on s.Order_ID = r.Order_ID
    group by 1;
    
/*11. Create a table having two columns ( date and sales), Date should start with the min date of data and 
end at max date - in between we need all the dates If date is available show sales for that date else show date and NA as sale */
/* 1 st step */
CREATE TEMPORARY TABLE calendar (
  id INT PRIMARY KEY,
  date DATE
);
-- Set the start date and end date for the calendar
SET @start_date = '2014-02-01';
SET @end_date = '2020-02-28';

-- 3 rd step
-- Loop through each day of the month and insert data into the temporary table
SET @date = @start_date;
while @date <= @end_date DO
  INSERT INTO calendar (id, date)
  VALUES (NULL, @date);
  SET @date = DATE_ADD(@date, INTERVAL 1 DAY);
END WHILE;