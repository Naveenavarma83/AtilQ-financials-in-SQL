A> To arrive at monthly sales given fiscal year for all the products

SELECT * FROM gdb0041.fact_sales_monthly;

select
s.date,
sum(round(s.sold_quantity*g.gross_price,2)) as monthly_sales
from fact_sales_monthly s
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(date)
and g.product_code=s.product_code
where customer_code=90002002
group by date;

B>  To arrive at pre_invoice discount for all the products in a given fiscal year 
     The resultent table will have the columns 
      DATE   PRODUCT_CODE   SOLD_QUANTITY   PRODUCT   VARIANT   GROSS_PRICE_PER_ITEM

select 
s.date,
s.product_code,
s.sold_quantity,
p.product,
p.variant,
g.gross_price as gross_price_per_item,
ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
pre.pre_invoice_discount_pct
From fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(s.date)
and g.product_code=s.product_code
join fact_pre_invoice_deductions as pre
on pre.customer_code=s.customer_code
and pre.fiscal_year=get_fiscal_year(s.date)
where 
 get_fiscal_year(s.date)=2021
limit 1000000;
