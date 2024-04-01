use sakila ;


#Write the SQL queries to answer the following questions:

#Select the first name, last name, and email address of all the customers who have rented a movie.

select distinct c.first_name, c.last_name, c.email
from customer c 
join rental r on r.customer_id = c.customer_id;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select concat(c.first_name, " ", c.last_name) as name, c.customer_id, avg(amount) as avg_amount
from customer c 
join payment p on c.customer_id = p.customer_id
group by c.customer_id ;

#Select the name and email address of all the customers who have rented the "Action" movies.
#  - Write the query using multiple join statements
select c.first_name, c.last_name, c.email, ca.name 
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id 
join film_category fc on f.film_id = fc.film_id 
join category ca on ca.category_id = fc.category_id
where ca.name = "Action";

#  - Write the query using sub queries with multiple WHERE clause and IN condition
select category_id from category where name = "Action";

select film_id from film_category where category_id = (select category_id from category where name = "Action") ;

select c.first_name, c.last_name, c.email from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id 
where i.film_id in (select film_id from film_category where category_id = (select category_id from category where name = "Action")) ;


select c.first_name, c.last_name, c.email
from customer c
join rental r on r.customer_id = c.customer_id
join inventory i on i.inventory_id = r.inventory_id
join film f on f.film_id = i.film_id 
join film_category fc on f.film_id = fc.film_id 
where fc.category_id = (select category_id from category where name = "Action");


#Verify if the above two queries produce the same results or not


#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

#If the amount is between 0 and 2 = low
# if the amount is between 2 and 4,=  medium,
#  and if it is more than 4 = high

select * from payment;

select *, 
	case
		when 0 < amount < 2 then "low"
		when 2 < amount < 4 then "medium"
		when amount > 4 then "high"
	end as transactions 
from payment;
