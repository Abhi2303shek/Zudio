create database zudio_sales;
use zudio_sales;

select * from zudio limit 10;

-- / -- 🏬 1. Revenue & Profitability Insights -- /
## 1. Which states generate the highest revenue?
select state, sum(price*quantity) as revenue from zudio group by state order by revenue desc limit 1;

## 2. Which states generate the highest profit?
select state, sum(profit) as net_profit from zudio group by state order by net_profit desc limit 1;

## 3. Are high-revenue states also high-profit states?
select state, sum(price*quantity) as revenue, sum(profit) as net_profit from zudio group by state order by revenue desc;

## 4. Which cities are underperforming in profit despite good sales?
select state, sum(price*quantity) as revenue, sum(profit) as net_profit from zudio group by state order by net_profit asc;

## 5. What is the overall profit margin (%)?
select round((sum(profit)/sum(quantity*price))*100,2) as profit_pct from zudio;

## 6. What is the profit margin by state?
select state, round((sum(profit)/sum(quantity*price))*100,2) as profit_pct from zudio group by state;

## 7. What is the profit margin by category (Men, Women, Kids)?
select category, round((sum(profit)/sum(quantity*price))*100,2) as profit_pct from zudio group by category;

## 8. Which clothing type has the highest profit per unit?
select cloth_type, round(sum(profit)/sum(quantity)*100,2) as profit_pct from zudio group by cloth_type order by profit_pct desc;

## 9. Which clothing type sells the most but earns low profit?
select cloth_type, sum(quantity) as qty, sum(profit) as net_profit from zudio group by cloth_type order by qty desc;

## 10. What are the top 10 most profitable stores?
select store_no, sum(profit) as net_profit from zudio group by store_no order by net_profit desc limit 10;


-- / -- 🏪 2. Store Performance Analysis --/
## 11. Do owned stores perform better than rented stores?
select store_type, sum(quantity*price) as revenue, sum(profit) as net_profit from zudio group by store_type;

## 12. What is the average revenue per store type?
select store_type, round(avg(quantity*price),2) as avg_revenue from zudio group by store_type;

## 13. What is the average profit per store type?
select store_type, round(avg(profit),2) as avg_profit from zudio group by store_type;

## 14. Which store has the highest revenue per sq ft?
select store_no, round(sum(quantity*price)/max(selling_area),2) as revenue_per_sqft from zudio group by store_no order by revenue_per_sqft limit 1;

## 15. Does larger selling area mean higher revenue?
select selling_area, sum(quantity*price) as revenue from zudio group by selling_area;

## 16. Does staff count impact sales?
select staff, sum(quantity*price) as revenue from zudio group by staff;

## 17. Does parking availability increase store sales?
select parking, sum(quantity*price) as revenue from zudio group by parking;

## 18. Do stores with CCTV + Alarm perform better?
select security, sum(quantity*price) as revenue from zudio group by security;

## 19. Which store managers handle the most profitable stores?
select manager, sum(profit) as net_profit from zudio group by manager order by net_profit;

## 20. Which stores are loss-making (if any)?
select store_no, sum(profit) as net_profit from zudio group by store_no having net_profit<0;


-- / --  📦 3. Product & Category Insights -- /
## 21. Which category is best-selling by revenue?
select category, sum(quantity*price) as revenue from zudio group by category order by revenue desc limit 1;

## 22. Which category is best-selling by quantity?
select category, sum(quantity) as qty from zudio group by category order by qty desc limit 1;

## 23. Which clothing type is most profitable?
select category, sum(profit) as net_profit from zudio group by category order by net_profit desc limit 1;

## 24. What are the top 10 most sold products?
select prod_id, sum(quantity) as most_sold from zudio group by prod_id order by most_sold desc limit 1;

## 25. Which clothing types have low sales but high profit margin?
select cloth_type, sum(quantity*price) as sales, sum(profit) as net_profit from zudio group by cloth_type order by sales asc;

## 26. What is the category contribution to total revenue (%)?
select category, (sum(price*quantity)/(select sum(price*quantity) from zudio))*100 as rev_share from zudio group by category;

## 27. Which category shows seasonal spikes?
select month, category, sum(price*quantity) as revenue from zudio group by month, category order by month;

## 28. Which clothing types should be expanded based on profitability?
select category, sum(profit) as net_profit from zudio group by category order by net_profit desc;

## 29. What is the average order value by category?
select category, sum(price*quantity)/ count(distinct order_id) as aov from zudio group by category;

## 30. Which products have the highest average quantity per order?
select prod_id, avg(quantity) as aqpv from zudio group by prod_id order by aqpv desc limit 1;



-- / -- 👥 4. Customer Insights --/
## 31. Who are the top 10 highest spending customers?
select cust_id, cust_name, sum(price*quantity) as spend from zudio group by cust_id, cust_name order by spend; 

## 32. How many repeat customers are there?
select count(*) as repeaters from (select cust_id from zudio group by cust_id having count(order_id)>1) as repeat_table;

## 33. What is the average revenue per customer?
select avg(cust_total) as avg_revenue from (select cust_id, sum(price*quantity) as cust_total from zudio group by cust_id) as total_custs;

## 34. What is the customer purchase frequency?
select cust_id, count(distinct order_id) as freq from zudio group by cust_id order by freq desc;

## 35. Which month sees the most unique customers?
select month, count(distinct order_id) as unique_cust from zudio group by month order by unique_cust desc;

## 36. What is the estimated customer lifetime value?
select cust_id, cust_name, sum(price*quantity) as ltv from zudio group by cust_id, cust_name order by ltv desc; 

## 37. Do high-value customers prefer specific categories?
select cust_id, category, sum(price*quantity) as spend from zudio group by cust_id, category order by spend; 

## 38. What is the distribution of order sizes (single item vs bulk buyers)?
select quantity, count(*) as orders from zudio group by quantity order by quantity;

## 39. What percentage of customers generate 80% of revenue? (Pareto Analysis)
with store_revenue as (select store_no, sum(price*quantity) as store_revenue from zudio group by store_no),
ranked_stores as (select *, ntile(5) over(order by store_revenue desc) as revenue_bucket from store_revenue)
select(sum(case when revenue_bucket=1 then store_revenue end) / (select sum(price*quantity) from zudio))*100 as top20_revenue_pct from ranked_stores;

## 40. Which states have the highest customer spending per order?
select state, sum(price*quantity) / count(distinct order_id) as avg_spend_value from zudio group by state order by avg_spend_value desc;



-- / -- 📅 5. Time-Based Insights --/
## 41. What is the monthly revenue trend?
select month, sum(quantity*price) as monthly_revenue from zudio group by month order by month;

## 42. What is the monthly profit trend?
select month, sum(profit) as monthly_profit from zudio group by month order by month;

## 43. Which month has the highest sales?
select month, sum(quantity*price) as monthly_revenue from zudio group by month order by monthly_revenue desc limit 1;

## 44. Which month has the lowest profit?
select month, sum(profit) as monthly_profit from zudio group by month order by monthly_profit asc limit 1;

## 45. What is the month-over-month sales growth rate?
select month, sum(price*quantity) as revenue, lag(sum(price*quantity)) over(order by month) as prev_month_revenue, 
((sum(price*quantity) - lag(sum(price*quantity)) over (order by month)) / lag(sum(price*quantity)) over(order by month)) * 100 as growth_pct from zudio group by month;

## 46. What are the seasonal trends by category?
select month, category, sum(price*quantity) as revenue from zudio group by month, category order by month;

## 47. Does festive season impact Women/Kids category more?
select month, category, sum(price*quantity) as revenue from zudio where category in ('kids', 'Women') group by month, category order by month;

## 48. How do stores perform before and after their opening year?
select year(store_open) as opening_yr, sum(price*quantity) as revenue from zudio group by opening_yr order by opening_yr;

## 49. Which stores ramped up fastest after opening?
select store_no, year(order_date) - year(store_open) as yrs_since_open, sum(price*quantity) as revenue from zudio group by store_no, yrs_since_open order by revenue desc;

## 50. How does revenue vary by store age (new vs old stores)?
select case when year(curdate()) - year(store_open) <= 2 then 'New' else 'Old' end as store_age, sum(price*quantity) as revenue from zudio group by store_age order by revenue;



 -- / -- 📊 6. Operational Efficiency Insights -- /
## 51. What is the revenue per staff member?
select store_no, sum(price*quantity) / max(staff) as revenue_per_staff from zudio group by store_no order by revenue_per_staff desc;

## 52. What is the profit per sq ft?
select store_no, sum(profit) / max(selling_area) as profit_per_sqft from zudio group by store_no order by profit_per_sqft desc;

## 53. What is the revenue per order?
select sum(price*quantity) / count(distinct order_id) as rev_per_order from zudio;

## 54. What is the profit per order?
select sum(profit) / count(distinct order_id) as profit_per_order from zudio;

## 55. Which stores have the highest operational efficiency ratio?
select store_no, sum(profit) / max(operating_hours) as OER from zudio group by store_no order by OER desc limit 1;

## 56. Which state has the highest revenue density (revenue per store)?
select state, sum(price*quantity) / count(distinct store_no) as Revenue_density from zudio group by state order by Revenue_density desc limit 1;

## 57. Does store size correlate with staff count?
select selling_area, avg(staff) from zudio group by selling_area order by selling_area;

## 58. Does store size correlate with profitability?
select selling_area, avg(profit) from zudio group by selling_area order by selling_area;

## 59. Which large stores are underperforming?
select store_no, max(selling_area) as size, sum(profit) as pro from zudio group by store_no having size>1100 and pro<200000;

## 60. Which small stores are highly profitable?
select store_no, max(selling_area) as size, sum(profit) as profits from zudio group by store_no having size<1000 order by profits desc;




-- / -- 🧠 7. Strategic / Executive-Level Questions -- /
## 61. If we close the bottom 10% of stores, what is the profit impact?
with store_profit as (select store_no, sum(profit) as profits from zudio group by store_no),
ranked_stores as (select *, ntile(10) over(order by profits asc) as profit_bucket from store_profit)
select sum(profits) as bottom10_pct_profit from ranked_stores where profit_bucket=1;

## 62. Which 3 states should we expand into more?
select state, sum(profit) as profits from zudio group by state order by profits desc limit 3;

## 63. If we double Women category inventory, what could be the revenue impact?
select (sum(case when category='Women' then price*quantity else 0 end) / sum(price*quantity)) as women_pct from zudio;

## 64. Which category should receive more marketing budget?
select category, sum(price*quantity) as revenue, (sum(profit) / sum(price*quantity))*100 as margin from zudio group by category order by margin desc;

## 65. Where are we losing margin?
select category, sum(price*quantity) as revenue, (sum(profit) / sum(price*quantity))*100 as margin from zudio group by category order by margin asc;

## 66. Which stores are high revenue but low margin (pricing issue)?
select store_no, sum(price*quantity) as revenue, (sum(profit) / sum(price*quantity))*100 as margin from zudio group by store_no order by margin desc;

## 67. Which product types need price optimization?
select cloth_type, avg(price) as avg_price, sum(profit) as profits from zudio group by cloth_type order by profits asc;

## 68. What percentage of revenue comes from the top 20% stores?
with store_revenue as (select store_no, sum(price*quantity) as store_revenue from zudio group by store_no),
ranked_stores as (select *, ntile(5) over(order by store_revenue desc) as revenue_bucket from store_revenue)
select(sum(case when revenue_bucket=1 then store_revenue end) / (select sum(price*quantity) from zudio))*100 as top20_revenue_pct from ranked_stores;

## 69. Which combination (State + Category) is most profitable?
select state, category, sum(profit) as profits from zudio group by state, category order by profits desc;

## 70. Is the business more dependent on location or category?
select state, category, sum(price*quantity) as revenue from zudio group by state, category order by revenue desc;
