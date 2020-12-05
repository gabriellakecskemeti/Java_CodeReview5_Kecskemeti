
USE cr5_famazon_Gabriella;

/* Quiry1: how many products were bought from a specific company, in this case supplier2 */

select 
OI.fk_orders_order_nr as 'order nr.' ,
OI.fk_products_prod_id as 'product ID', 
PP.prod_name as 'Name', 
sum(OI.quantity), 
OI.price, SS.name as 'Supplier' 
from order_items as OI 
inner join products as PP on OI.fk_products_prod_id= PP.prod_id
inner join supplier as SS on PP.fk_supplier_sup_id=SS.sup_id

where PP.fk_supplier_sup_id=2 group by PP.fk_supplier_sup_id;



/* Quiry2: who purchased products on 2020.12.01 */

select 
ORD.order_nr as 'order nr.' ,
CC.first_name as 'first name', 
CC.last_name as 'last name',
ORD.orderdate as 'Date' 
 
from orders as ORD 
inner join customers as CC on ORD.fk_customers_customer_id= CC.customer_id

where ORD.orderdate='2020.12.01' group by CC.customer_id;
 

/* Quiry3: what  products were sent between '2020.12.01' and '2020.12.05' */

select  shipments.shipment_id,
orders.order_nr,
products.prod_name,
 shipments.start,
 shipments.end,
shipments.status
from shipments 
inner join orders on shipments.fk_orders_order_nr=orders.order_nr
inner join order_items on orders.order_nr=order_items.fk_orders_order_nr
inner join products on order_items.fk_products_prod_id= products.prod_id
where shipments.start between '2020.12.01' and '2020.12.05' order by shipments.start;


/* Quiry4: how many products were sent to a specific city,Wien */

select  
sum(order_items.quantity),
orders.city as 'city to deliver'
from shipments 
inner join orders on shipments.fk_orders_order_nr=orders.order_nr
inner join order_items on orders.order_nr=order_items.fk_orders_order_nr
inner join products on order_items.fk_products_prod_id= products.prod_id
where orders.city="Wien" ;



/* Quiry5: all orders between '2020.12.01' and '2020.12.05' */

select  
orders.order_nr as 'order',
orders.fk_customers_customer_id as 'customer id',
customers.first_name as 'first name', 
customers.last_name as 'last name',
orders.orderdate as 'date',
products.prod_name,
order_items.price,
order_items.quantity,
(order_items.price*order_items.quantity) as 'amount to pay'
from orders 
inner join customers on orders.fk_customers_customer_id=customers.customer_id
inner join order_items on orders.order_nr=order_items.fk_orders_order_nr
inner join products on order_items.fk_products_prod_id= products.prod_id
where orders.orderdate between '2020.12.01' and '2020.12.05' order by orders.order_nr ;



/* Quiry6: all orders between '2020.12.01' and '2020.12.05' including calculation of quantity*price */

select  
orders.order_nr as 'order',
orders.fk_customers_customer_id as 'customer id',
customers.first_name as 'first name', 
customers.last_name as 'last name',
orders.orderdate as 'date',

sum(order_items.price*order_items.quantity) as 'amount to pay'
from orders 
inner join customers on orders.fk_customers_customer_id=customers.customer_id
inner join order_items on orders.order_nr=order_items.fk_orders_order_nr
inner join products on order_items.fk_products_prod_id= products.prod_id
where orders.orderdate between '2020.12.01' and '2020.12.05' group by orders.order_nr;




/* Quiry7: what our clients wish */

select wishlist.fk_customers_customer_id,
customers.first_name as 'first name', 
customers.last_name as 'last name',
products.prod_name as 'wished product'
from wishlist
inner join customers on wishlist.fk_customers_customer_id=customers.customer_id
inner join products on wishlist.fk_products_prod_id=products.prod_id
order by wishlist.fk_customers_customer_id,wishlist.fk_products_prod_id;



/* Quiry8: Stock under minimum*/

select 
products.prod_id,
products.prod_name as 'name',
products.min_stock,
products.stock,
supplier.name,
supplier.phone
from products
inner join supplier on products.fk_supplier_sup_id=supplier.sup_id
where products.stock < products.min_stock;










