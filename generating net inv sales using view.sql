generating net_invsales using sales_preinv_discount-view

select *,
(gross_price_total -
pre_invoice_discount_pct * gross_price_total) as net_invoice_sales
from gdb0041.sales_preinv_discount;