CREATE TABLE appleStore_description_combined AS
SELECT * FROM appleStore_description1
UNION ALL 
SELECT * FROM appleStore_description2
UNION ALL
SELECT * FROM appleStore_description3
UNION ALL 
SELECT * FROM appleStore_description4

** Exploratory Data Analysis 
--Check thr number of unique apps in both tablesAppleStore
SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM AppleStore
SELECT COUNT(DISTINCT id) AS UniqueAppIDs
FROM appleStore_description_combined

--Check for any missing values
SELECT COUNT (*) AS MissingValues
FROM AppleStore
WHERE track_name IS null OR user_rating IS null or prime_genre IS null

SELECT COUNT (*) AS MissingValues
FROM appleStore_description_combined
WHERE app_desc IS null 

--FIND out the number of apps per genre
SELECT prime_genre, COUNT (*) AS NumberApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumberApps DESC

-- Get an overview of the apps' ratings
SELECT min(user_rating) AS MinRating,
 max(user_rating) AS MaxRating,
 avg(user_rating) AS AvgRating
FROM AppleStore


--GET priceAppleStore
SELECT (price/2)*2 AS PriceBInStart,
((price/2)*2) +2 AS PriceBInEnd,
COUNT(*) AS NumberApps
FROM AppleStore

GROUP BY PriceBInStart
Order BY PriceBInEnd

** Data Analysis
--Determine whether paid apps have higher ratings than free apps
SELECT CASE 
WHEN price > 0 THEN 'Paid'
ELSE 'Free'
END AS App_Type,
avg(user_rating)AS Avg_Rating 
FROM AppleStore
GROUP BY App_Type

--Check  if apps with more supported languages have higher ratings
SELECT CASE 
WHEN lang_num <10 THEN '<10 languages'
WHEN lang_num BETWEEN 10 AND 30 THEN '10- 30 langauges'
ELSE '>30 langauges'
END AS languages_bucket,
avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY languages_bucket
ORDER BY Avg_Rating DESC

--Check genre with low ratings
SELECT prime_genre,
avg(user_rating) AS Avg_Rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_Rating ASC
Limit 15



