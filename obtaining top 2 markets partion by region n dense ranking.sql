OBTAINING TOP 2 MARKETS IN TERMS OF GROSS_SALES (MLN) AND THE REGIONS THOSE MARKETS FALL USING PARTITION BY AND DENSE RANKING

SELECT * FROM gdb0041.dim_customer;

with cte1 as (
select 
c.market,
c.region,
round(sum(gross_price_total)/1000000,2) as gross_sales_mln
from gross_sales s 
join dim_customer c
on c.customer_code = s.customer_code
where fiscal_year = 2021
group by market,region
order by gross_sales_mln desc),
cte2 as (
select * ,
dense_rank () over (partition by region order by gross_sales_mln desc) as drnk from cte1)
select * from cte2 
where drnk <= 2;
