-- Databricks notebook source exported at Tue, 28 Jun 2016 17:08:40 UTC
SHOW DATABASES;

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

SELECT * from moviestable LIMIT 5;

-- COMMAND ----------

SELECT * from ratingstable LIMIT 5;

-- COMMAND ----------

SELECT * from userstable LIMIT 5;

-- COMMAND ----------

-- MAGIC %md Describe the movies table:

-- COMMAND ----------

DESC moviestable;

-- COMMAND ----------

-- MAGIC %md How was the movies table created?

-- COMMAND ----------

SHOW CREATE TABLE MoviesTable;

-- COMMAND ----------

-- MAGIC %md From the moviestable, show the following cols in order and limit it to 7 rows: MovieID, Title, Year, Genres

-- COMMAND ----------

SELECT movieID, title, year, genres FROM moviestable LIMIT 7

-- COMMAND ----------

-- MAGIC %md Use a WHERE clause to see only movies from 1999:

-- COMMAND ----------

SELECT * FROM moviestable WHERE year = '1999'

-- COMMAND ----------

-- MAGIC %md #### .. or find movies from the 1970s:

-- COMMAND ----------

SELECT movieID, title, year, genres FROM moviestable WHERE year >= '1970' AND year <= '1979' LIMIT 500;

-- COMMAND ----------

SELECT MovieID, Title, Year, Genres FROM MoviesTable WHERE Year BETWEEN 1970 AND 1979 limit 10;

-- COMMAND ----------

-- MAGIC %md ### Fine the year a specific movie was released: Grease

-- COMMAND ----------

SELECT year, title FROM moviestable WHERE title = 'Grease'

-- COMMAND ----------

-- MAGIC %md ### .. or to find all movie titles beginning with only 'A' or 'B':

-- COMMAND ----------

SELECT title FROM moviestable WHERE title >= 'A' and title < 'C' LIMIT 10

-- COMMAND ----------

-- MAGIC %md How many movie rows are there in the movies table?

-- COMMAND ----------

SELECT COUNT (*) FROM moviestable 

-- COMMAND ----------

-- MAGIC %md ### The keyword LIKE can be used to find all movies with the word "American" somewhere in the title:

-- COMMAND ----------

SELECT title, year FROM moviestable WHERE title LIKE '%American%'

-- COMMAND ----------

-- MAGIC %md ### What about finding romantic comedies from 1990, 1991 or 1992?

-- COMMAND ----------

-- MAGIC %md Hint: You'll have to do a WHERE on genres and year..

-- COMMAND ----------

SELECT title, year FROM moviestable WHERE year = '1990' OR year = '1991' OR year = '1992'

-- COMMAND ----------

SELECT MovieID, Title, Year, Genres FROM MoviesTable WHERE YEAR IN (1990, 1991, 1992) 

-- COMMAND ----------

SELECT MovieID, Title, Year, Genres FROM MoviesTable WHERE YEAR IN (1990, 1991, 1992) AND genres = 'Comedy'

-- COMMAND ----------

SELECT MovieID, Title, Year, Genres FROM MoviesTable WHERE YEAR IN (1990, 1991, 1992) AND genres LIKE '%Comedy%' AND genreS LIKE '%Romance%' 

-- COMMAND ----------

-- MAGIC %md ### Perhaps you're in the mood for a movie that is recent (newer than 1995) and not a Thriller or Horror?

-- COMMAND ----------

SELECT * FROM moviestable WHERE year >= '1996'

-- COMMAND ----------

SELECT movieID, title, year, genres FROM moviestable WHERE year >= '1996'

-- COMMAND ----------

SELECT movieID, title, year, genres FROM moviestable WHERE year >= '1996' AND NOT Genres LIKE '%Thriller%'

-- COMMAND ----------

SELECT movieID, title, year, genres FROM moviestable WHERE year >= '1996' AND NOT Genres LIKE '%Thriller%' AND NOT Genres LIKE '%Horror%'

-- COMMAND ----------

-- MAGIC %md #### Use the AVG() function to get the average year a movie was released  (in this dataset of around 3,000 movies):

-- COMMAND ----------

SELECT AVG(year) FROM moviestable

-- COMMAND ----------

-- MAGIC %md #### Use the MIN() and MAX() functions to figure out what the newest and oldest movie years are in the dataset:

-- COMMAND ----------

SELECT min(year) FROM moviestable

-- COMMAND ----------

SELECT max(year) FROM moviestable

-- COMMAND ----------

-- MAGIC %md What is the average rating of all movies?

-- COMMAND ----------

SELECT AVG(rating) FROM ratingstable

-- COMMAND ----------

-- MAGIC %md #### Use the COUNT() function to count how many total ratings we have:

-- COMMAND ----------

SELECT COUNT(rating) FROM ratingstable 

-- COMMAND ----------

-- MAGIC %md #### Use ORDER BY to display movies according to the release year (hint: ORDER BY comes after the FROM clause): (so like from 1919 to 2000)

-- COMMAND ----------

SELECT title, year FROM moviestable ORDER BY year ASC

-- COMMAND ----------

-- MAGIC %md ### Use ORDER BY for two different columns to order by Year as above, and then sub-order by Title (so show all 1919 movies first):

-- COMMAND ----------

SELECT title, year FROM moviestable ORDER BY year, title ASC

-- COMMAND ----------

-- MAGIC %md #### Get a count of ALL the different ratings for Toy Story (so how many people rated it 1, 2, 3, 4, 5):

-- COMMAND ----------

SELECT rating, COUNT(rating) FROM ratingstable WHERE movieID = '1' GROUP BY rating

-- COMMAND ----------

-- MAGIC %md #### Recall that our RatingsTable only contained the MovieID, not the Movie's title:

-- COMMAND ----------

SELECT * FROM RatingsTable;

-- COMMAND ----------

SELECT * FROM MoviesTable;

-- COMMAND ----------

-- MAGIC %md #### Display a table with 3 columns: UserID, Rating & Title  (we will need to join the RatingsTable to the MoviesTable):

-- COMMAND ----------

SELECT ratingstable.userID, ratingstable.rating, moviestable.title
FROM ratingstable 
JOIN moviestable ON ratingstable.movieID = moviestable.movieID

-- COMMAND ----------

SELECT ratingstable.userID, ratingstable.rating, moviestable.title
FROM ratingstable 
JOIN moviestable ON ratingstable.movieID = moviestable.movieID
ORDER BY userID ASC

-- COMMAND ----------

-- MAGIC %md #### Use JOIN on more than two tables. For example, get a list of all movie ratings with movie title and the rater?s gender (we will have to JOIN the ratings, movies and users tables):

-- COMMAND ----------

DESC userstable

-- COMMAND ----------

SELECT ratingstable.userID, ratingstable.rating, moviestable.title, userstable.gender
FROM ratingstable 
JOIN moviestable ON ratingstable.movieID = moviestable.movieID
JOIN userstable ON ratingstable.userID = userstable.userID
ORDER BY userID ASC

-- COMMAND ----------

-- MAGIC %md #### Notice that there are 6 or 7 age groups in the Users table. Show the average rating for each of the groups? I'm wondering if young people rate movies on average higher than old people.

-- COMMAND ----------

-- MAGIC %md Age is chosen from the following ranges:
-- MAGIC 
-- MAGIC 	*  1:  "Under 18"
-- MAGIC 	* 18:  "18-24"
-- MAGIC 	* 25:  "25-34"
-- MAGIC 	* 35:  "35-44"
-- MAGIC 	* 45:  "45-49"
-- MAGIC 	* 50:  "50-55"
-- MAGIC 	* 56:  "56+"

-- COMMAND ----------

SELECT * FROM userstable

-- COMMAND ----------

SELECT userstable.age, ratingstable.rating
FROM ratingstable 
JOIN userstable ON ratingstable.userID = userstable.userID
ORDER BY age ASC

-- COMMAND ----------

SELECT userstable.age, AVG(ratingstable.rating)
FROM ratingstable 
JOIN userstable ON (ratingstable.userID = userstable.userID)
GROUP BY userstable.age 
ORDER BY userstable.age ASC

-- COMMAND ----------

-- MAGIC %md Get a list of all users who have rated more than 15 movies as the very best rating of 5. Get back a table with 2 cols: user_id and rating_count (which is the # of movies the user gave a 5 to, ignore ratings < 5)

-- COMMAND ----------

-- MAGIC %md Hint: Use a subquery (do 2 SELECTS): http://www.tutorialspoint.com/sql/sql-sub-queries.htm

-- COMMAND ----------

SELECT ratingstable.userID, COUNT(ratingstable.rating) AS Numberof5
FROM ratingstable 
WHERE ratingstable.rating = '5'
GROUP BY userID

-- COMMAND ----------

SELECT userID, Numberof5
FROM (SELECT ratingstable.userID, COUNT(ratingstable.rating) AS Numberof5
      FROM ratingstable 
      WHERE ratingstable.rating = '5'
      GROUP BY userID) top_raters
WHERE Numberof5 > 15
ORDER BY Numberof5 DESC


-- COMMAND ----------


