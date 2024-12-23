-- Question Set = Easy

/* Q1: Who is the senior most employee based on job title? */

select title, first_name, last_name
from employee
order by levels
desc limit 1;

-- Q2: which countries have most invoices?

select count(*) as c, billing_country from invoice
group by billing_country 
order by c desc;

-- Q3: What are top 3 values of total invoice?

select total from invoice
order by total
desc limit 3;

-- Q.4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
-- Write a query that returns one city that has the highest sum of invoice totals. 
-- Return both the city name & sum of all invoice totals */

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order by invoice_total desc;


 -- Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
-- Write a query that returns the person who has spent the most money.*/

select customer.customer_id, first_name, last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id, first_name, last_name
order by total desc
limit 1;

-- Question Set = Intermiddiate

-- Q1: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
-- Return your list ordered alphabetically by email starting with A.

select distinct email, first_name, last_name 
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in (
select track_id from track
join genre on track.genre_id = genre.genre_id
where genre.name like "Rock"
)

order by email;


-- Q.2 Let's invite the artists who have written the most rock music in our dataset. 
-- Write a query that returns the Artist name and total track count of the top 10 rock bands

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track

join album2 on album2.album_id = track.album_id
join artist on artist.artist_id = album2.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name = "Rock"
group by artist.artist_id, artist.name
order by number_of_songs desc
limit 10;

-- Q.3: Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

select name, milliseconds 
from track
where milliseconds > (
 select avg(milliseconds) as avg_track_length
from track)
order by milliseconds desc;