SELECT * FROM gdb0041.dim_customer
where customer like "%croma%" and market like "%India%";

select * from fact_sales_monthly
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

gross sales report monthly for this get product info from dim_product

select s.date,s.product_code,s.sold_quantity,p.product,p.variant from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

to get gross sales report monthly transaction

select s.date,s.product_code,s.sold_quantity,p.product,p.variant,g.gross_price from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(date)
and g.product_code=s.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;

for obtaining gross price total

select s.date,s.product_code,s.sold_quantity,p.product,p.variant,g.gross_price,round(s.sold_quantity*g.gross_price,2) as gross_price_total from fact_sales_monthly s
join dim_product p
on s.product_code=p.product_code
join fact_gross_price g
on g.fiscal_year=get_fiscal_year(date)
and g.product_code=s.product_code
where customer_code = 90002002 and
get_fiscal_year(date)=2021
order by date asc
limit 100000;
 
 
 to get croma Yearly report with 2 columns fiscal year n tot gross sales amount
 
 select
get_fiscal_year(date) as fiscal_year,
sum(round(sold_quantity*g.gross_price,2)) as yearly_sales
	from fact_sales_monthly s
	join fact_gross_price g
	on 
g.fiscal_year=get_fiscal_year(s.date) and
g.product_code=s.product_code
	where
	    customer_code=90002002
	group by get_fiscal_year(date)
	order by fiscal_year;
		

 



