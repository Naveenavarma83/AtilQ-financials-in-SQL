SELECT * FROM gdb0041.dim_date;

creating dim_date table n adding in gross_sales total 

SELECT 
    	   s.date, 
           s.product_code, 
           p.product, 
	   p.variant, 
           s.sold_quantity, 
           g.gross_price as gross_price_per_item,
           ROUND(s.sold_quantity*g.gross_price,2) as gross_price_total,
           pre.pre_invoice_discount_pct
	FROM fact_sales_monthly s
	JOIN dim_product p
            ON s.product_code=p.product_code
     JOIN dim_date dt
     ON dt.calender_date = s.date
	JOIN fact_gross_price g
    	    ON g.fiscal_year = dt.fiscal_year
    	    AND g.product_code=s.product_code
	JOIN fact_pre_invoice_deductions as pre
            ON pre.customer_code = s.customer_code AND
            pre.fiscal_year = dt.fiscal_year
	WHERE 
		  dt.fiscal_year = 2021     
	LIMIT 1000000;

