
--a.	Find out the avg_inventory as per the store and product.

select 
  p.Product_ID, 
  product_name, 
  st.store_id, 
  store_name, 
  avg(stock_on_hand) as Average_inventory 
from 
  inventory i 
  join stores st on i.store_id = st.store_id 
  join products p on i.product_id = p.Product_ID 
group by 
  p.Product_ID, 
  st.store_id, 
  product_name, 
  store_name 
order by 
  store_id, 
  Product_ID;
