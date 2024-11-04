OBTAINING NET_INVOICE _SALES FOR FISCAL YEAR 2021 USING COMMON TABLE EXPRESSION (CTE)

SELECT * FROM gdb0041.fact_sales_monthly;

with cte1 as (
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
     JOIN fact_gross_price g
    	    ON g.fiscal_year = s.fiscal_year
    	    AND g.product_code=s.product_code
	JOIN fact_pre_invoice_deductions as pre
            ON pre.customer_code = s.customer_code AND
            pre.fiscal_year = s.fiscal_year
	WHERE 
		  s.fiscal_year = 2021)    
	select
    *,
    (gross_price_total - gross_price_total * pre_invoice_discount_pct) as net_invoice_sales
    from cte1;
    
