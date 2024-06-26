create database if not exists WALMART sales

create table if not exists sales(
	invoice_id varchar(30) not null primary key,
    branch varchar(10) not null,
    city varchar(30) not null,
    customer_type varchar(30) not null,
    gender varchar (10) not null,
    product_line varchar(100) not null,
    unit_price decimal(10, 2) not null,
    quantity int not null,
    VAT float (6, 4) not  null,
    total decimal(12,4) not null,
    date Datetime not null,
    time Time not null,
    payment_method varchar(15) not null,
    cogs Decimal(10,2) not null,
    gross_margin_percentage Float (11,9),
    gross_income Decimal(12,4) not null,
    rating float(2,1)
)

select * from sales


select time,
	(CASE
		when `time` BETWEEN "00:00:00" and "12:00:00" then "Morning"
		when `time` BETWEEN "12:01:00" and "16:00:00" then "Afternoon"
		else "Evening"
    END
    )as time_of_date 
from sales;

alter table sales add column time_of_day varchar(20)

Update sales 
set time_of_day = (
	CASE
			when `time` BETWEEN "00:00:00" and "12:00:00" then "Morning"
			when `time` BETWEEN "12:01:00" and "16:00:00" then "Afternoon"
			else "Evening"
	END
)

--day_name

select date,
dayname(date) as day_name
from sales

Alter table sales add column day_name varchar(10)

update sales
set day_name = dayname(date)

select date,
monthname(date)
from sales;

alter table sales add column month_name varchar(10);

update sales 
set month_name = monthname(date);

-- How many unique cities does the data have
select distinct city
from sales

-- In which city is the each branch?

select distinct branch
from sales

select distinct city,
branch from sales 

-- Product -----

-- How many unique product lines does the data have
select 
distinct product_line
from sales 

select 
count(distinct product_line)
from sales 

-- ---what is the most common payment method?
select payment_method
from sales;

select 
payment_method,
count(payment_method) as cnt
from sales
group by payment_method
order by cnt desc;

-- -- what is the most selling product line
select * from sales;

select product_line,
count(product_line) as cnt
from sales 
group by product_line 
order by cnt desc;

-- what is the total revenue by month

select month_name as mnth,
sum(total) as total_revenue
from sales
group by month_name
order by total_revenue desc

-- what month had the largest COGS

select month_name as month,
sum(cogs) as cogs 
from sales 
group by month_name
order by cogs desc;


-- what product line has the lagest revenue?

select product_line,
sum(total) as total_revenue
from sales 
group by product_line
order by total_revenue;

-- What city has the largest revenue?

select branch,
city,
sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue desc;

-- what product line has largest VAT?

select product_line, 
avg(VAT) as avg_tax 
from sales
group by product_line
order by avg_tax desc;


-- which branch sold more products than average product sold?
select branch, 
sum(quantity) as qty
from sales 
group by branch
having sum(quantity) > (select avg(quantity) from sales);

-- what is the most common product line by gender?
select 
gender,
product_line,
count(gender) as total_cnt
from sales 
group by gender, product_line
order by total_cnt desc;

-- what is the average rating of each product line?
select 
avg(rating) as avg_rating,
product_line
from sales 
group by product_line
order by avg_rating desc

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Sales
-- --------Number of sales made in each time of the day per week

select time_of_day,
count(*) as total_sales
from sales
where day_name = "Monday"
group by time_of_day
order by total_sales desc;
  
-- Which of the customer types bring more revenue?

select
customer_type,
sum(total) as total_rev
from sales 
group by customer_type
order by total_rev desc;

-- Which city has largest VAT 

select 
city,
avg(vat) as vat
from sales
group by city
order by vat desc;

-- which customer type pays the most in vat?

select 
customer_type,
avg(vat) as vat
from sales
group by customer_type
order by vat desc;

-------------- Customers -----------------------------------
-- how many unique customer types does the data have 

select distinct customer_type
from sales;

-- how many unique payments method we have

select distinct payment_method
from sales;

-- what is the most common customer type

select distinct customer_type
from sales;

-- which customer types buys the most?

select  customer_type,
count(*) as cust_cnt
from sales
group by customer_type;

-- what is the gender of most customers
select gender,
count(*) as gender_count
from sales
group by gender


-- what is the gender distribution for each branch
select gender,
count(*) as gender_count
from sales
where branch = "C"
group by gender
order by gender_count

select gender,
count(*) as gender_count
from sales
where branch = "B"
group by gender
order by gender_count

select gender,
count(*) as gender_count
from sales
where branch = "A"
group by gender
order by gender_count

-- which time of the day customer give most rating?

Select time_of_day,
avg(rating) as avg_rating
from sales
group by time_of_day
order by avg_rating


-- which time of day do customer gives most ratings per branch
Select time_of_day,
avg(rating) as avg_rating
from sales
where branch = 'C'
group by time_of_day
order by avg_rating desc

Select time_of_day,
avg(rating) as avg_rating
from sales
where branch = 'A'
group by time_of_day
order by avg_rating

-- which day of the week has the best avg ratings?

select day_name,
avg(rating) as avg_rating
from sales
group by day_name
order by avg_rating

-- which day of the week has the best avg ratings per branch?  
select day_name,
avg(rating) as avg_rating
from sales
where branch ='A'
group by day_name
order by avg_rating
