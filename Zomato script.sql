use zomato;
select * from mytable;

/* Which cuisines have the highest average ratings across different cities and countries? Are there particular cuisines that are universally popular?*/

With cte as(
select m.cuisines,m.country_code,m.rating_text,c.country,m.city,m.aggregate_rating from mytable m left join country_code c on m.country_code=c.country_code)
select cuisines,city,country,AVG(aggregate_rating) AS avg_rating from cte GROUP BY 
    cuisines, city, country
ORDER BY 
    avg_rating DESC;


/* Question: Does a higher price range correlate with better ratings, or do affordable restaurants have comparable or even better ratings?*/

SELECT 
    price_range,
    COUNT(*) AS num_restaurants,
    AVG(aggregate_rating) AS avg_rating,
    SUM(votes) AS total_votes
FROM 
    mytable
GROUP BY 
    price_range
ORDER BY 
    price_range;
    
    
/*Online Delivery Impact on Ratings and Popularity */

select has_online_delivery,count(*) as no_of_restauarnts,avg(aggregate_rating) as avg_rating, sum(votes) as total_votes from mytable group by has_online_delivery order by total_votes DESC;

/* Table Booking Preference by City */
select city,has_table_booking,count(*) as no_of_restuarants,avg(aggregate_rating) as average_rating from mytable group by city,has_table_booking order by average_rating desc;

/* Customer Voting Patterns for Different Cuisines */

select cuisines, sum(votes) as total_votes from mytable group by cuisines order by total_votes desc; 

/* Analysis of Rating Distribution by City and Locality */
select locality,city,count(*) as no_of_restuarants,avg(aggregate_rating) as average_rating from mytable group by city,locality;

/* Currency and Price Range Analysis */
with cte as(
select m.price_range,m.city,m.country_code,c.country,m.Currency from mytable m left join country_code c on m.country_code=c.country_code)
select avg(price_range) as average_price_range,city,country,Currency from cte group by country,city,currency;

/* Rating Color Distribution Analysis */
with cte as(
select m.rating_color,m.city,m.country_code,c.country from mytable m left join country_code c on m.country_code=c.country_code)
select count(*) as no_of_restuarants, city,country, rating_color from cte group by rating_color,city,country;
	
with cte as(
select m.city,m.country_code,m.rating_color,c.country from mytable m left join country_code c on m.country_code=c.country_code),
 cte1 as(select city,country,count(*) as total_hotels from cte group by city,country)select cte.city,cte.country,cte.rating_color,(count(*)*100)/cte1.total_hotels as percentage from cte left join cte1 on cte.city=cte1.city and cte.country=cte1.country group by cte.city,cte.country,cte.rating_color;

/*Common Cuisines Offered in High-Density Restaurant Areas */
with cte as(
select m.cuisines,m.city,m.country_code,c.country ,m.aggregate_rating from mytable m left join country_code c on m.country_code=c.country_code)
select cuisines,city,country,avg(aggregate_rating) as average_rating ,count(*) as no_of_restuarnts from cte group by cuisines,city,country;

