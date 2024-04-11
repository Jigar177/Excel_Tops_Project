use[Pizza DB];

select * from pizza_sales;

-- 1) Total Revenue : The sum of the total price of all pizza orders.

select SUM(total_price) AS Totao_Revenue from pizza_sales;

-- 2) Average Order Value : The average amount spent per order,calculated by dividing the total revenue by the total number of orders.

select  sum(total_price) / count(distinct order_id) as Avg_Order_Value from pizza_sales;

-- 3) Total Pizzas Sold: the sum of the quantities of all pizzas sold.

select sum(quantity) Tota_Pizza_Sold from pizza_sales;

--4) Total orders : The total number of orders placed.

select count(distinct order_id ) as Total_Orders from pizza_sales;

--5) Average Pizzas Per order : The average number of pizzas sold per order.calculated by didviding the total number 
-- of pizzas sold by the total number of orders.

select  sum(quantity) / count(distinct order_id)  from pizza_sales;
-- in decimal number if you want .
select  cast(cast(sum(quantity) as decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2)) as decimal (10,2)) from pizza_sales;

-- 6) Daily trends for for total orders. creat a bar chart displays the daily trnd of total orders over a specific time peried.this chart will 
-- help us identity any patterns or fluctuatuions in order volumes on a daily basis.


select DATENAME(WEEKDAY,order_date) as order_day , count(distinct order_id) as total_orders from pizza_sales GROUP BY DATENAME(DW,order_date);


-- 7) Hourly Trend for total orders: create a line chart that illustrates the hourly trend or total orders throughout the day. this chart will 
-- allow us to identity peopel hour or periouds of high order activity.

select DATEPART(hour,order_time) as order_hours , count(distinct order_id) as total_orders from pizza_sales 
group by DATEPART(hour,order_time) order by DATEPART(hour,order_time);



-- 8) Percentage  of sales by pizza category : create a pie chart that show the distribution of sales across different pizza categories.this chart 
-- will provide insights into the popularirty of various pizza categories and their contributions to overall sales.

select pizza_category , sum(total_price) as Total_sales, 
sum(total_price) * 100 / (select sum(total_price) from pizza_sales where MONTH(order_date) = 1) as Total_Sales 
from pizza_sales where MONTH(order_date) = 1 group by pizza_category;

-- 9) Percentage of sales by pizza size: Generate a pie chart that represents the percentage of sales attributed to different sazes.
-- this chart will help us understand customer preferences for pizza sizes and their impract on sales.

select pizza_size , sum(total_price) as Total_sales , sum (total_price) * 100 /(select sum(total_price) from pizza_sales) as PCT
from pizza_sales group by pizza_size;

select pizza_size , cast(sum(total_price) as decimal(10,2)) as Total_sales ,
cast(sum (total_price) * 100 /(select sum(total_price) from pizza_sales) as decimal(10,2))as PCT
from pizza_sales group by pizza_size order by PCT Desc;

select pizza_size , cast(sum(total_price) as decimal(10,2)) as Total_sales ,
cast(sum (total_price) * 100 /(select sum(total_price) from pizza_sales where DATEPART(Quarter,order_date) = 1 ) as decimal(10,2))as PCT
from pizza_sales where DATEPART(Quarter,order_date) = 1 group by pizza_size order by PCT Desc;

select pizza_size , sum(total_price) as Total_sales , sum (total_price) * 100 /(select sum(total_price) from pizza_sales where pizza_size = 'L') as PCT
from pizza_sales where pizza_size = 'L' group by pizza_size;

-- 10) Total pizzas sold by pizza category: create a funnel chart that presents the total number of pizzas sold for each pizza category.
-- this chart will allow us to compare the sales performance of different pizza categories.

select pizza_category , sum(quantity) Total_Pizzas_sold from pizza_sales group by pizza_category;

--11) Top 5 Best sellers by total pizza sales : create a bar chart highlighting the top 5 best-selling pizzas based on the total number of pizza
-- sold. this chart will help us identity the most popular pizza options.

select  Top 5 pizza_name , sum(quantity) as Total_pizzas_sold from pizza_sales group by pizza_name order by sum(quantity)  desc; 

-- 12) Bottom 5 worst sellers by total pizzas sold: create a bar chart showcasing the bottom 5 worst-selling pizzas based on the total number
-- of pizzas sold.this chart will enable us to identity underperforming or less popular pizza options.

select  top 5 pizza_name , sum(quantity) as Total_pizzas_sold from pizza_sales group by pizza_name order by sum(quantity)  asc; 

select  top 5 pizza_name , sum(quantity) as Total_pizzas_sold from pizza_sales where MONTH(order_date) = 1 group by pizza_name 
order by sum(quantity)  asc; 


