                 with cte1 as (select
                     p.division,
                     p.product,
                     sum(sold_quantity) as total_qty
                from fact_sales_monthly s
                join dim_product p
                      on p.product_code=s.product_code
                where fiscal_year=2021
                group by p.division,
                p.product),
                 cte2 as (
                select *,
                dense_rank() over(partition by division order by total_qty desc) as drnk
                from cte1)
                select * from cte2 where drnk <= 3;