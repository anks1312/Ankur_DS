USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

-- director_mapping
select count(*)
from director_mapping;

-- > 3867 rows in director_mapping table

-- Genre
select count(*)
from genre;

-- > 14662 rows in genre table

-- movie
select count(*)
from movie;

-- > 7997 rows in movie table

-- names
select count(*)
from names;

-- > 25735 rows in names table

-- ratings
select count(*)
from ratings;

-- > 7997 rows in ratings table

-- role_mapping
select count(*)
from role_mapping;

-- > 15615 rows in role_mapping table

-- Q2. Which columns in the movie table have null values?
-- Type your code below:

-- To check the ID Column for null values
SELECT * 
FROM movie
where id is null;
-- > No null values

-- To check the title Column for null values
SELECT * 
FROM movie
where title is null;
-- > No null values

-- To check the year Column for null values
SELECT * 
FROM movie
where year is null;
-- > No null values

-- To check the date_published Column for null values
SELECT * 
FROM movie
where date_published is null;
-- > No null values

-- To check the duration Column for null values
SELECT * 
FROM movie
where duration is null;
-- > No null values

-- To check the Country Column for null values
SELECT * 
FROM movie
where country is null;
-- > has null values

-- To check the worlwide_gross_income Column for null values
SELECT * 
FROM movie
where worlwide_gross_income is null;
-- > has null values

-- To check the Languages Column for null values
SELECT * 
FROM movie
where languages is null;
-- > has null values

-- To check the production_company Column for null values
SELECT * 
FROM movie
where production_company is null;
-- > has null values

select 
    sum(case when id is null then 1 else 0 end) as id, 
    sum(case when title is null then 1 else 0 end) as title, 
    sum(case when year is null then 1 else 0 end) as year,
    sum(case when date_published is null then 1 else 0 end) as date_published, 
    sum(case when duration is null then 1 else 0 end) as duration, 
    sum(case when country is null then 1 else 0 end) as country, 
    sum(case when worlwide_gross_income is null then 1 else 0 end) as worlwide_gross_income, 
    sum(case when languages is null then 1 else 0 end) as languages, 
    sum(case when production_company is null then 1 else 0 end) as production_company
from movie ;

-- country(20 Null Values), worlwide_gross_income(3724 Null Values), 
-- languages(194 Null Values), production_company(528 Null Values)

-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select year, count(title) as number_of_movies
from movie
group by year
order by year; 

/* Output 
+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	3052			|
|	2018		|	2944			|
|	2019		|	2001			|
+---------------+-------------------+

*/

SELECT MONTH(date_published) as month_num, count(title) as number_of_movies
FROM movie
GROUP BY month_num
ORDER BY month_num;

/*

month_num	number_of_movies
1				804
2				640
3				824
4				680
5				625
6				580
7				493
8				678
9				809
10				801
11				625
12				438

*/


/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

select country, count(title) as number_of_movies
from movie
where country = "USA" OR country = "India"
group by country;

/*
Country	number_of_movies
India			1007
USA				2260
*/



/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

select genre
from genre
group by genre;

/*
'Action'
'Adventure'
'Comedy'
'Crime'
'Drama'
'Family'
'Fantasy'
'Horror'
'Mystery'
'Others'
'Romance'
'Sci-Fi'
'Thriller'
*/


/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

select genre, count(genre) as movie_count
from genre
group by genre
order by movie_count Desc
limit 1;

/*
Genre		movie_count
'Drama'		  '4285'
*/


/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:


select movie_id, count(movie_id) as Movie_Count
from genre
group by movie_id
having Movie_Count = '1';


/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select distinct genre, avg(duration)
from genre g
inner join movie m
on g.movie_id = m.id
group by genre;

/*
Drama	106.7746
Fantasy	105.1404
Thriller	101.5761
Comedy	102.6227
Horror	92.7243
Family	100.9669
Romance	109.5342
Adventure	101.8714
Action	112.8829
Sci-Fi	97.9413
Crime	107.0517
Mystery	101.8
Others	100.16
*/


/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:


select genre, count(movie_id) as movie_count, dense_rank() over (order by count(movie_id) desc) as genre_rank
from genre
group by genre;

/*
'Drama','4285','1'
'Comedy','2412','2'
'Thriller','1484','3'
'Action','1289','4'
'Horror','1208','5'
'Romance','906','6'
'Crime','813','7'
'Adventure','591','8'
'Mystery','555','9'
'Sci-Fi','375','10'
'Fantasy','342','11'
'Family','302','12'
'Others','100','13'
*/




/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

select min(avg_rating) as min_avg_rating, max(avg_rating) as max_avg_rating,
	   min(total_votes) as min_total_votes, max(total_votes) as max_total_votes,
       min(median_rating) as min_median_rating, max(median_rating) as max_median_rating
from ratings;
/*
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|max_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		1		|			10		|	       100		  |	   725138	    	 |		1	       |	10			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+ 
*/


    

/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

select title, avg_rating, dense_rank() over (order by avg_rating desc) as movie_rank
from movie m 
inner join ratings r
on m.id = r.movie_id
limit 10;

/*
'Kirket','10.0','1'
'Love in Kilnerry','10.0','1'
'Gini Helida Kathe','9.8','2'
'Runam','9.7','3'
'Fan','9.6','4'
'Android Kunjappan Version 5.25','9.6','4'
'Yeh Suhaagraat Impossible','9.5','5'
'Safe','9.5','5'
'The Brighton Miracle','9.5','5'
'Shibu','9.4','6'
*/


/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have


select median_rating, count(*) as movie_count
from genre g
inner join ratings r
on g.movie_id = r.movie_id
group by median_rating
order by median_rating;

/*
'1','156'
'2','235'
'3','536'
'4','912'
'5','1909'
'6','3714'
'7','3973'
'8','1874'
'9','771'
'10','582'
*/



/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

select production_company, count(*) as movie_count, dense_rank() over (order by count(*) desc) as prod_company_rank
from movie m
inner join ratings r
on m.id = r.movie_id
where avg_rating > 8
group by production_company
order by movie_count desc;






-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select genre, count(*) as movie_count
from genre g
inner join movie m
on m.id = g.movie_id
inner join ratings r
on m.id = r.movie_id
where country = "USA" and date_published >= '2017-3-01' and date_published <= '2017-3-31' and total_votes > 1000
group by genre
order by movie_count desc;

/*
'Drama','16'
'Comedy','8'
'Crime','5'
'Horror','5'
'Action','4'
'Sci-Fi','4'
'Thriller','4'
'Romance','3'
'Fantasy','2'
'Mystery','2'
'Family','1'
*/


-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

select title, avg_rating, genre
from genre g
inner join movie m
on m.id = g.movie_id
inner join ratings r
on m.id = r.movie_id
where title like 'the%' and avg_rating > 8
order by avg_rating desc;





-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:


select median_rating, title, date_published
from movie m
inner join ratings r
on m.id = r.movie_id
where date_published > '2018-04-01' and date_published < '2019-04-01' and median_rating = 8;

-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

select country, count(total_votes)
from movie m
inner join ratings r
on m.id = r.movie_id
where country = 'Germany' or country = 'Italy'
group by country;

/*
'Germany','146'
'Italy','123'
*/

-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

select sum(case when name IS NULL then 1 else 0 end) as name_nulls, 
	   sum(case when height IS NULL then 1 else 0 end) as height_nulls,
       sum(case when date_of_birth IS NULL then 1 else 0 end) as date_of_birth_nulls,
       sum(case when known_for_movies IS NULL then 1 else 0 end) as known_for_movies_nulls
from names;

/* '0','17335','13431','15226' */

/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:


select name as director_name , genre, count(id) as movie_count 
from names as n 
inner join 
director_mapping as dm 
on n.id = dm.name_id 
inner join 
genre as g 
on g.movie_id = dm.movie_id 
inner join 
ratings as r 
on g.movie_id = r.movie_id 
where avg_rating > 8 
group by director_name ,genre
order by movie_count desc 
limit 3;




/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

select name as actor_name, count(*) as movie_count
from names n
inner join role_mapping rm
on rm.name_id = n.id
inner join ratings r
on rm.movie_id = r.movie_id
where median_rating >= 8
group by actor_name
order by movie_count desc
limit 2;

/*
'Mammootty','8'
'Mohanlal','5'
*/




/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

select production_company, sum(total_votes) as vote_count, dense_rank() over (order by sum(total_votes) desc) as prod_comp_rank
from movie m
inner join ratings r
on m.id = r.movie_id
group by production_company
order by prod_comp_rank
limit 3;

/*
'Marvel Studios','2656967','1'
'Twentieth Century Fox','2411163','2'
'Warner Bros.','2396057','3'
*/





/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT 	t1.*, RANK() OVER (ORDER BY t1.actor_avg_rating DESC, t1.total_votes DESC) AS actor_rank
FROM 	(SELECT n.id AS actor_id, n.name AS actor_name, 
				SUM(total_votes) AS total_votes,
				COUNT(DISTINCT m.id) AS movie_count, 
				ROUND(SUM(avg_rating*total_votes)/SUM(total_votes), 2) AS actor_avg_rating 
		 FROM  names AS n
		 INNER JOIN role_mapping AS rm ON n.id = rm.name_id
		 INNER JOIN movie AS m ON m.id = rm.movie_id
		 INNER JOIN ratings AS r ON m.id = r.movie_id
		 WHERE LOWER(m.country) like '%india%' 
         AND rm.category = 'actor'
		 GROUP BY n.id, n.name
		 HAVING movie_count >= 5) AS t1 ;

-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

select name as actress_name, sum(total_votes) as total_votes, count(title) as movie_count, avg(avg_rating) as actress_avg_rating, 
dense_rank() over (order by (avg(avg_rating)*avg(total_votes)) desc) as actress_rank
from names n
inner join role_mapping rm
on n.id = rm.name_id
inner join ratings r
on rm.movie_id = r.movie_id
inner join movie m
on r.movie_id = m.id
where country = 'India' and category = 'actress'
group by actress_name
having movie_count >= 5
order by actress_rank;







/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

with genre1 as
(
select genre , avg_rating as rating 
from genre as g 
inner join 
ratings as r 
on g.movie_id = r.movie_id 
where genre = "thriller"
) 
select * ,
	case 
         when rating > 8 then "superhit movies"
         when rating >7 and rating<8 then "hit movies"
         when rating >5 and rating <7 then "one_time_watch movies"
         else "flop movies"
     
	end as movie_category 
from genre1
order by rating desc ;

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT genre, avg(duration) as avg_duration,
round(SUM(duration) OVER (ORDER BY genre)) AS running_total_duration,
round(AVG(duration) OVER (ORDER BY genre)) AS moving_avg_duration
FROM movie m
inner join genre g
on m.id = g.movie_id
group by genre;

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies
select genre, count(*) as movie_count
from genre g
group by genre
order by movie_count desc
limit 3;

/*
'Drama','4285'
'Comedy','2412'
'Thriller','1484'
*/


select genre, max(year), max(title) as movie_name, worlwide_gross_income, 
dense_rank() over (order by worlwide_gross_income desc) as movie_rank
from movie m
inner join genre g
on m.id = g.movie_id
where genre = 'Drama' or genre = 'Comedy' or genre = 'Thriller'
group by genre;



-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:


select production_company, count(*) as movie_count,
dense_rank() over (order by count(*) desc) as movie_rank
from movie m
inner join ratings r
on r.movie_id = m.id
where languages LIKE '%,%' and median_rating > 8
group by production_company ;




-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

select name as actress_name, sum(total_votes) as total_votes, count(title) as movie_count, avg(avg_rating) as actress_avg_rating, 
dense_rank() over (order by count(title) desc) as actress_rank
from names n
inner join role_mapping rm
on n.id = rm.name_id
inner join ratings r
on rm.movie_id = r.movie_id
inner join movie m
on r.movie_id = m.id
inner join genre g
on m.id = g.movie_id
where avg_rating > 8 and genre = 'Drama' and category = 'actress'
group by actress_name
order by actress_rank
limit 3;

/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

select  name_id as director_id,
name as director_name, count(title) as number_of_movies, 
LEAD(date_published,1) OVER(ORDER BY date_published) as avg_inter_movie_days,
round(avg(avg_rating)) as avg_rating, sum(total_votes) as total_votes, min(avg_rating) as min_rating, 
max(avg_rating) as max_rating, sum(duration) as total_duration
from names n
inner join director_mapping d
on n.id = d.name_id
inner join movie m
on d.movie_id = m.id
inner join ratings r
on m.id = r.movie_id
group by director_name
order by number_of_movies desc
limit 9;