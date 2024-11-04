        A> TO IDENTIFY IF CROMA CUSTOMER OPERATES IN INDIA

SELECT * FROM gdb0041.dim_customer
where customer like "%croma%" and market like "%India%";

        B> TO OBTAIN MONTHLY SALES REPORT FOR A PARTICULAR CUSTOMER WITHA CODE FOR A GIVEN FISCLA YEAR
select * from fact_sales_monthly
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

      C> TO OBTAIN MONTHLY GROSS SALES REPORT  for this get product info from dim_product
select s.date,
       s.product_code,
       s.sold_quantity,
       p.product,
       p.variant from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

       D> TO OBTAIN GROSS PRICE FOR EACH PRODUCT
select s.date,
s.product_code,
s.sold_quantity,
p.product,
p.variant,
g.gross_price from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(date)
and g.product_code=s.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

         E> TO OBTAIN GROSS PRICE FOR THE TOTAL QUANTITY SOLD 
select s.date,
s.product_code,
s.sold_quantity,
p.product,
p.variant,
g.gross_price,round(s.sold_quantity*g.gross_price,2) as gross_price_total from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(date)
and g.product_code=s.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;
 
 
           F> TO GET YEARLY REPORT FOR CROMA WITH TWO COLUMNS FISCAL YEAR & TOTAL GROSS SALES AMOUNT 
select
get_fiscal_year(date) as fiscal_year,
sum(round(sold_quantity*g.gross_price,2)) as yearly_sales
from fact_sales_monthly s
Join fact_gross_price g
on 
g.fiscal_year=get_fiscal_year(s.date) and
g.product_code=s.product_code
where
customer_code=90002002
group by get_fiscal_year(date)
order by fiscal_year;
		

 



