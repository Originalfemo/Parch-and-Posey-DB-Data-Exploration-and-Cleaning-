-- PARCH AND POSEY DATABASE. ALL QUESTIONS FROM UDACITY COURSE ANSWERED


-- Try writing your own query to select only the id, account_id, and occurred_at columns for all 
--orders in the orders table.
SELECT id, account_id, occurred_at
FROM orders;

--LIMIT
--Try using LIMIT yourself below by writing a query that displays all the data in the occurred_at, 
--account_id, and channel columns of the web_events table, and limits the output to only the first 15
--rows.
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15;

--ORDER BY

--Write a query to return the 10 earliest orders in the orders table. 
--Include the id, occurred_at, and total_amt_usd.
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at ASC
LIMIT 10

--Write a query to return the top 5 orders in terms of largest total_amt_usd. 
--Include the id, account_id, and total_amt_usd.
SELECT id, account_id, total_amt_usd
FROM ORDERS
ORDER BY total_amt_usd DESC
LIMIT 5;

-- Write a query to return the lowest 20 orders in terms of smallest total_amt_usd. 
--Include the id, account_id, and total_amt_usd.
-- The first query returns accounts with $0 purchase but we want accounts that actually had purchases
--Thus, this can be fixed with the second query
SELECT id, account_id, total_amt_usd
FROM ORDERS
ORDER BY total_amt_usd
LIMIT 20;

SELECT id, account_id, total_amt_usd
FROM orders
WHERE total_amt_usd > 0
ORDER BY total_amt_usd
LIMIT 20;


--Write a query that displays the order ID, account ID, and total dollar amount for all the orders,
--sorted first by the account ID (in ascending order), and then by the total dollar amount 
--(in descending order).
SELECT
id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC

--Now write a query that again displays order ID, account ID, and total dollar amount for each order,
--but this time sorted first by total dollar amount (in descending order), 
--and then by account ID (in ascending order).
SELECT
id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id

--Compare the results of these two queries above. How are the results different when you switch the column you sort on first?

--The difference here is, the ORDER BY function sorts based on the first/primary sort column. 
--The secondary sort comes into play when the primary sort has two of the exact same values, then 
--sorting would switch from primary sort to secondary sort e.g., if we have 440 for two different values
--then order by would switch to the account_id sorting (secondary sort) and arrange them in ASC order.

--WHERE FUNCTION

--Pull the first 5 rows and all columns from the orders table that have a dollar amount of 
--gloss_amt_usd greater than or equal to 1000.

SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

--Pulls the first 10 rows and all columns from the orders table that have a total_amt_usd less than 500.

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

--WHERE WITH NON-NUMERIC VALUES

--Filter the accounts table to include the company name, website, and the primary point of contact 
--(primary_poc) just for the Exxon Mobil company in the accounts table.

SELECT website, name, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil'


--ARITHMETIC OPERATIONS

-- Create a column that divides the standard_amt_usd by the standard_qty to find the unit price 
--for standard paper for each order. Limit the results to the first 10 orders, and include the 
--id and account_id fields.
SELECT id, account_id, standard_amt_usd/standard_qty AS unit_price, standard_amt_usd, standard_qty
FROM orders
LIMIT 10;

-- Write a query that finds the percentage of revenue that comes from poster paper for each order.
--You will need to use only the columns that end with _usd. (Try to do this without using the total
--column.) Display the id and account_id fields also
SELECT id, account_id, 
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS post_per
FROM orders
LIMIT 10;

--We use the LIMIT 10 becauseat least one of the values in the data(the sum total) creates a division by zero in your formula
--This can be solved by the following
SELECT id, account_id, 
   poster_amt_usd/(standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_percent
FROM orders
WHERE (standard_amt_usd + gloss_amt_usd + poster_amt_usd) > 0


-- LIKE OPERATOR
-- Use the accounts table to find

-- All the companies whose names start with 'C'.
SELECT * 
FROM accounts
WHERE name LIKE 'C%'
-- All companies whose names contain the string 'one' somewhere in the name.
SELECT * 
FROM accounts
WHERE name LIKE '%one%'
-- All companies whose names end with 's'.
SELECT * 
FROM accounts
WHERE name LIKE '%s'


-- IN Operator
-- Use the accounts table to find the account name, primary_poc, and sales_rep_id for Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom')

-- Use the web_events table to find all information regarding individuals who were contacted via 
--the channel of organic or adwords.
SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords')

-- NOT Operator
-- Use the accounts table to find the account name, primary poc, and sales rep id for all stores except Walmart, Target, and Nordstrom.
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom')

-- Use the web_events table to find all information regarding individuals who were contacted via any method except using organic or adwords methods.
SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords')

-- Use the accounts table to find:
-- All the companies whose names do not start with 'C'.
SELECT * 
FROM accounts
WHERE name NOT LIKE 'c%'
-- All companies whose names do not contain the string 'one' somewhere in the name.
SELECT * 
FROM accounts
WHERE name NOT LIKE '%one%'
-- All companies whose names do not end with 's'.
SELECT * 
FROM accounts
WHERE name NOT LIKE '%s'


--AND & BETWEEN OPERATOR

--Write a query that returns all the orders where the standard_qty is over 1000, the poster_qty is 0
-- and the gloss_qty is 0.
SELECT *
FROM orders
WHERE standard_qty > 1000 AND standard_qty  = 0 AND gloss_qty = 0

--Using the accounts table, find all the companies whose names do not start with 'C' and end with 's'.

SELECT a."name"
FROM accounts a
WHERE a."name" NOT LIKE 'C%' AND LIKE '%s'

--When you use the BETWEEN operator in SQL, do the results include the values of your endpoints, 
--or not? Figure out the answer to this important question by writing a query that displays the 
--order date and gloss_qty data for all orders where gloss_qty is between 24 and 29. 
--Then look at your output to see if the BETWEEN operator included the begin and end values or not.

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29

--Use the web_events table to find all information regarding individuals who were contacted via the
--organic or adwords channels, and started their account at any point in 2016, sorted from newest 
--to oldest.

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2016-12-31'
ORDER BY 2 DESC

--OR FUNCTION

--Find list of orders ids where either gloss_qty or poster_qty is greater than 4000. 
--Only include the id field in the resulting table.

SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000

-- Write a query that returns a list of orders where the standard_qty is zero and either the 
--gloss_qty or poster_qty is over 1000.
SELECT *
FROM orders
WHERE standard_qty = 0 AND gloss_qty > 1000 OR poster_qty > 1000

--Find all the company names that start with a 'C' or 'W', and the primary contact contains 
--'ana' or 'Ana', but it doesn't contain 'eana'.

SELECT name, primary_poc
FROM  accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%') AND (primary_poc LIKE '%ana%' OR primary_poc LIKE 'Ana%')
AND primary_poc NOT LIKE '%eana%'





--SQL JOINS
-- Try pulling all the data from the accounts table, and all the data from the orders table.
SELECT *
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

-- Try pulling standard_qty, gloss_qty, and poster_qty from the orders table, and the website and 
--the primary_poc from the accounts table
SELECT orders.standard_qty, orders.poster_qty, accounts.website, accounts.primary_poc
FROM orders
JOIN accounts
ON orders.account_id = accounts.id

-- Provide a table for all web_events associated with account name of Walmart.
--There should be three columns. Be sure to include the primary_poc, time of the
-- event, and the channel for each event. 
--Additionally, you might choose to add a fourth column to assure only Walmart events were chosen.
SELECT a.primary_poc, w.occurred_at, w.channel, a.name
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE a.name IN ('Walmart')
-- Provide a table that provides the region for each sales_rep along with their
--associated accounts. Your final table should include three columns: the region
--name, the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT region.name AS region_name, 
sales_reps.name AS sales_rep, 
accounts.name AS account
FROM region
JOIN sales_reps
ON region.id = sales_reps.region_id
JOIN accounts
ON sales_reps.id = accounts.sales_rep_id
ORDER BY accounts.name ASC;

--Provide the name for each region for every order, as well as the account name
--and the unit price they paid (total_amt_usd/total) for the order. 
--Your final table should have 3 columns: region name, account name, and unit price.
--A few accounts have 0 for total, so I divided by (total + 0.01) to assure not dividing by zero.
SELECT region.name AS region,
accounts.name AS account_name,
orders.total_amt_usd/(orders.total+0.01) AS unit_price
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id

-- LEFT AND RIGHT JOINS

--Provide a table that provides the region for each sales_rep along with their
--associated accounts. This time only for the Midwest region. 
--Your final table should include three columns: the region name, 
--the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT region."name" AS region_name, sales_reps."name" AS sales_rep_name,
accounts."name" AS account_name
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region_id
WHERE region."name" IN ('Midwest')
ORDER BY accounts."name" ASC

--Provide a table that provides the region for each sales_rep along with their
--associated accounts.
--This time only for accounts where the sales rep has a first name starting with S
--and in the Midwest region.
--Your final table should include three columns: the region name, 
--the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT region."name" AS region_name, sales_reps."name" AS sales_rep_name,
accounts."name" AS account_name
FROM accounts
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region_id
WHERE region."name" IN ('Midwest') AND sales_reps."name" LIKE ('S%')
ORDER BY accounts."name" ASC

--Provide a table that provides the region for each sales_rep along with their
--associated accounts.
--This time only for accounts where the sales rep has a last name starting with K
--and in the Midwest region.
--Your final table should include three columns: the region name, 
--the sales rep name, and the account name. 
--Sort the accounts alphabetically (A-Z) according to account name.
SELECT r.name region, s.name rep, a.name account
FROM sales_reps s
JOIN region r
ON s.region_id = r.id
JOIN accounts a
ON a.sales_rep_id = s.id
WHERE r.name = 'Midwest' AND s.name LIKE '% K%'
ORDER BY a.name;

--Provide the name for each region for every order, 
--as well as the account name and the unit price they paid (total_amt_usd/total)
--for the order. However, you should only provide the results if the standard 
--order quantity exceeds 100. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
SELECT region.name AS region,
accounts.name AS account_name,
orders.total_amt_usd/(orders.total+0.01) AS unit_price,
orders.standard_qty AS quantity
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
WHERE orders.standard_qty > 100

--Provide the name for each region for every order, 
--as well as the account name and the unit price they paid (total_amt_usd/total)
--for the order. However, you should only provide the results if the standard 
--order quantity exceeds 100. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
-- Sort by the smallest unit price first
SELECT region.name AS region,
accounts.name AS account_name,
orders.total_amt_usd/(orders.total+0.01) AS unit_price
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
WHERE orders.standard_qty > 100 AND orders.poster_qty > 50
ORDER BY unit_price ASC;

--Provide the name for each region for every order, 
--as well as the account name and the unit price they paid (total_amt_usd/total)
--for the order. However, you should only provide the results if the standard 
--order quantity exceeds 100. 
--Your final table should have 3 columns: region name, account name, and unit price. 
--In order to avoid a division by zero error, adding .01 to the denominator here is helpful total_amt_usd/(total+0.01).
-- Sort by the largest unit price first
SELECT region.name AS region,
accounts.name AS account_name,
orders.total_amt_usd/(orders.total+0.01) AS unit_price
FROM orders
JOIN accounts
ON orders.account_id = accounts.id
JOIN sales_reps
ON accounts.sales_rep_id = sales_reps.id
JOIN region
ON sales_reps.region_id = region.id
WHERE orders.standard_qty > 100 AND orders.poster_qty > 50
ORDER BY unit_price DESC;

--What are the different channels used by account id 1001? 
--Your final table should have only 2 columns: 
--account name and the different channels. 
--You can try SELECT DISTINCT to narrow down the results to only the unique values.
SELECT DISTINCT a.name, w.channel
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
WHERE w.account_id = 1001

--Find all the orders that occurred in 2015. 
--Your final table should have 4 columns: occurred_at, account name, 
--order total, and order total_amt_usd.
SELECT occurred_at, accounts.name AS account_name, total AS order_total, total_amt_usd
FROM orders
JOIN accounts ON accounts.id = orders.account_id
WHERE occurred_at BETWEEN '2015-01-01' AND '2016-01-01'
ORDER BY occurred_at DESC;

-- SQL AGGREGATIONS
--SUM FUNCTION

-- Find the total amount of poster_qty paper ordered in the orders table.
SELECT SUM(poster_qty) AS poster
FROM orders

--Find the total amount of standard_qty paper ordered in the orders table.
SELECT SUM(standard_qty) AS standard
FROM orders

-- Find the total dollar amount of sales using the total_amt_usd in the orders table.
SELECT SUM(total_amt_usd) AS total_dollar_sales
FROM orders
-- Find the total amount spent on standard_amt_usd and gloss_amt_usd paper for each order in the orders table. This should give a dollar amount for each order in the table.
SELECT standard_amt_usd + gloss_amt_usd AS total_spent
FROM orders

-- Find the standard_amt_usd per unit of standard_qty paper. Your solution should use both an aggregation and a mathematical operator.
SELECT SUM(standard_amt_usd)/SUM(standard_qty) AS standard_amt_sales
FROM orders

-- MIN, MAX, & AVG
-- When was the earliest order ever placed? You only need to return the date.
SELECT MIN(occurred_at)
FROM orders

-- Try performing the same query as in question 1 without using an aggregation function.
SELECT occurred_at
FROM orders
ORDER BY occurred_at ASC
LIMIT 1;

-- When did the most recent (latest) web_event occur?
SELECT MAX(occurred_at)
FROM web_events

-- Try to perform the result of the previous query without using an aggregation function.
SELECT occurred_at
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

-- Find the mean (AVERAGE) amount spent per order on each paper type, 
--as well as the mean amount of each paper type purchased per order. 
--Your final answer should have 6 values - 
--one for each paper type for the average number of sales, 
--as well as the average amount.
SELECT AVG(standard_qty) AS avg_standard_qty,
AVG(gloss_qty) AS avg_gloss_qty,
AVG(poster_qty) AS avg_poster_qty,
AVG(standard_amt_usd) AS avg_standard_usd,
AVG(gloss_amt_usd) AS avg_gloss_usd,
AVG(poster_amt_usd) AS avg_poter_usd
FROM orders

-- Via the video, you might be interested in how to calculate the MEDIAN. 
-- Though this is more advanced than what we have covered so far try finding -
--what is the MEDIAN total_usd spent on all orders?
SELECT PERCENTILE_CONT(0.5) 
WITHIN GROUP(ORDER BY total_amt_usd)
FROM orders

-- GROUP BY

SELECT account_id, 
SUM(standard_qty), 
SUM(gloss_qty)
FROM orders
-- For the above to work, it has to be written as the below. The ORDER BY isnt a must
SELECT account_id, 
SUM(standard_qty), 
SUM(gloss_qty)
FROM orders
GROUP BY account_id
ORDER BY account_id



-- Which account (by name) placed the earliest order? 
--Your solution should have the account name and the date of the order.
SELECT acct.name, MIN(o.occurred_at)
FROM orders o
JOIN accounts acct
ON acct.id = o.account_id
GROUP BY acct.name
ORDER BY MIN(o.occurred_at)
LIMIT 1

-- Find the total sales in usd for each account. You should include two columns 
-- the total sales for each company's orders in usd and the company name.
SELECT acct.name, SUM(o.total_amt_usd)
FROM orders o
JOIN accounts acct
ON acct.id = o.account_id
GROUP BY acct.name
ORDER BY SUM(o.total_amt_usd)

--Via what channel did the most recent (latest) web_event occur, 
--which account was associated with this web_event? 
--Your query should return only three values - the date, channel, and account name.
SELECT MAX(w.occurred_at), acct.name, w.channel 
FROM accounts acct
JOIN web_events w
ON acct.id = w.account_id
GROUP BY acct.name, w.channel
ORDER BY MAX(w.occurred_at) DESC
LIMIT 1

-- Find the total number of times each type of channel from the web_events was
--used. Your final table should have two columns - the channel and the number 
--of times the channel was used.
SELECT channel, COUNT(channel)
FROM web_events
GROUP BY channel

-- Who was the primary contact associated with the earliest web_event?
SELECT a.primary_poc
FROM web_events w
JOIN accounts a
ON a.id = w.account_id
ORDER BY w.occurred_at
LIMIT 1;

--What was the smallest order placed by each account in terms of total usd. 
--Provide only two columns - the account name and the total usd. 
--Order from smallest dollar amounts to largest.
SELECT acct.name, MIN(o.total_amt_usd)
FROM accounts acct
JOIN orders o
ON acct.id = o.account_id
GROUP BY acct.name
ORDER BY MIN(o.total_amt_usd);

-- Find the number of sales reps in each region. Your final table should have
--two columns - the region and the number of sales_reps. Order from fewest reps
--to most reps.
SELECT r.name, COUNT(r.name)
FROM region r
JOIN sales_reps s
ON r.id = s.region_id
GROUP BY r.name
ORDER BY COUNT(r.name)

-- GROUP BY II
--For each account, determine the average amount of each type of paper they 
--purchased across their orders. Your result should have four columns 
-- one for the account name and one for the average quantity purchased 
--for each of the paper types for each account.
SELECT a.name, AVG(o.gloss_qty) AS gloss_qty_avg, 
AVG(standard_qty) AS standard_qty_avg, 
AVG(o.poster_qty) AS poster_qty_avg
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name

--For each account, determine the average amount spent per order on each paper
--type. Your result should have four columns - one for the account name and one
--for the average amount spent on each paper type.
SELECT a.name, AVG(o.gloss_amt_usd) AS gloss_amt_avg, 
AVG(standard_amt_usd) AS standard_amt_avg, 
AVG(o.poster_amt_usd) AS poster_amt_avg
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a.name

--Determine the number of times a particular channel was used in the web_events
--table for each sales rep. Your final table should have three columns 
-- the name of the sales rep, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first.
SELECT s.name, w.channel, COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name, w.channel
ORDER BY COUNT(w.channel) DESC;

--Determine the number of times a particular channel was used in the web_events
--table for each region. Your final table should have three columns 
-- the region name, the channel, and the number of occurrences. 
--Order your table with the highest number of occurrences first.
SELECT r.name, w.channel, COUNT(w.channel)
FROM web_events w
JOIN accounts a
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
GROUP BY r.name, w.channel
ORDER BY COUNT(w.channel) DESC;

-- DISTINCT
--Use DISTINCT to test if there are any accounts associated with more than 
--one region.
SELECT DISTINCT a.id, r.id, a.name, r.name
FROM accounts a
JOIN web_events w
ON w.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id

-- Have any sales reps worked on more than one account?
SELECT DISTINCT s."name", COUNT(a.name) 
FROM accounts a
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s."name"
ORDER BY COUNT(a.name)

-- HAVING
-- How many of the sales reps have more than 5 accounts that they manage?
SELECT s."name" AS sales_reps, COUNT(a."name") AS no_of_accounts
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
GROUP BY s."name"
HAVING COUNT(a."name") > 5

-- How many accounts have more than 20 orders?
SELECT a."name" AS account_name, COUNT(o.account_id) AS no_of_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
HAVING COUNT(o.account_id) > 20

-- Which account has the most orders?
SELECT a."name" AS account_name, COUNT(o.account_id) AS no_of_orders
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
ORDER BY COUNT(o.account_id) DESC
LIMIT 1;

--Which accounts spent more than 30,000 usd total across all orders?
SELECT a."name" account_name, SUM(o.total_amt_usd) order_total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
HAVING SUM(o.total_amt_usd) > 30000

--Which accounts spent less than 1,000 usd total across all orders?
SELECT a."name" account_name, SUM(o.total_amt_usd) order_total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
HAVING SUM(o.total_amt_usd) < 1000

--Which account has spent the most with us?
SELECT a."name" account_name, SUM(o.total_amt_usd) order_total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
ORDER BY SUM(o.total_amt_usd) DESC
LIMIT 1;

--Which account has spent the least with us?
SELECT a."name" account_name, SUM(o.total_amt_usd) order_total_usd
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY a."name"
ORDER BY SUM(o.total_amt_usd)
LIMIT 1;

--Which accounts used facebook as a channel to contact customers more than 6 times?
SELECT a."name" account_name, w.channel channel, COUNT(w.channel) channel_count
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a."name", w.channel
HAVING w.channel IN ('facebook') AND COUNT(w.channel) > 6

-- Which account used facebook most as a channel?
SELECT a."name" account_name, w.channel channel, COUNT(w.channel) channel_count
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a."name", w.channel
HAVING w.channel IN ('facebook') AND COUNT(w.channel) > 6
ORDER BY COUNT(w.channel) DESC
LIMIT 1;

--Which channel was most frequently used by most accounts?
SELECT a."name" account_name, w.channel channel, COUNT(w.channel) channel_count
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY a."name", w.channel
ORDER BY COUNT(w.channel) DESC

SELECT w.channel channel, COUNT(a."name") account_name, COUNT(w.channel) channel_count
FROM accounts a
JOIN web_events w
ON a.id = w.account_id
GROUP BY w.channel
ORDER BY COUNT(w.channel) DESC

-- DATE FUNCTION
--Find the sales in terms of total dollars for all orders in each year, 
--ordered from greatest to least. Do you notice any trends in the yearly 
--sales totals? To get the trends, investigate further on years with low sales
SELECT DATE_PART('year', occurred_at) AS date, SUM(total_amt_usd) AS sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

--Which month did Parch & Posey have the greatest sales in terms of total dollars? Are all months evenly represented by the dataset?
--In order for this to be 'fair', we should remove the sales from 2013 and 2017.
-- Because 2013 and 2017 only have one month of sales in the dataset
SELECT DATE_PART('month', occurred_at) AS date, SUM(total_amt_usd) AS sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1; -- without removing 2013 and 2017

SELECT DATE_PART('month', occurred_at) ord_month, SUM(total_amt_usd) total_spent
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;-- when we remove 2013 and 2017. We still get december as the answer for both

--Which year did Parch & Posey have the greatest sales in terms of total 
--number of orders? Are all years evenly represented by the dataset?
SELECT DATE_PART('year', occurred_at) AS date, 
SUM(total_amt_usd) AS sales, COUNT(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

--Which month did Parch & Posey have the greatest sales in terms of total 
--number of orders? Are all months evenly represented by the dataset?
SELECT DATE_PART('month', occurred_at) AS date, 
SUM(total_amt_usd) AS sales, COUNT(*) AS total_orders
FROM orders
GROUP BY 1
ORDER BY 3 DESC;

--In which month of which year did Walmart spend the most on gloss paper in 
--terms of dollars?
SELECT DATE_PART('month', o.occurred_at) AS date,
DATE_PART('year', o.occurred_at) AS date_year,
a."name" AS account_name,
SUM(o.gloss_qty) AS gloss_quantity,
SUM(o.gloss_amt_usd) AS amt_spent
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1, 2, 3
HAVING a."name" = 'Walmart'
ORDER BY 5 DESC;

--CASE STATEMENT
-- Write a query to display for each order, the account ID, total amount of the
--order, and the level of the order - ‘Large’ or ’Small’ - depending on if the
--order is $3000 or more, or smaller than $3000.
SELECT id, account_id, total_amt_usd,
CASE WHEN total_amt_usd >= 3000 THEN 'large'
ELSE 'small' END
FROM orders

--Write a query to display the number of orders in each of three categories, 
--based on the total number of items in each order. 
--The three categories are: 'At Least 2000', 'Between 1000 and 2000' 
--and 'Less than 1000'.
SELECT COUNT(*),
CASE WHEN total >= 2000 THEN 'At least 2000'
WHEN total BETWEEN 1000 AND 2000 THEN 'Between 1000 and 2000'
ELSE 'Less than 1000' END AS total_bins
FROM orders
GROUP BY 2

--We would like to understand 3 different levels of customers based on the 
--amount associated with their purchases. The top level includes anyone with 
--a Lifetime Value (total sales of all orders) greater than 200,000 usd. 
--The second level is between 200,000 and 100,000 usd. 
--The lowest level is anyone under 100,000 usd. 
--Provide a table that includes the level associated with each account. 
--You should provide the account name, the total sales of all orders for 
--the customer, and the level. Order with the top spending customers listed first.

SELECT a."name" AS name, SUM(o.total_amt_usd) AS sales_to_account,
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'Lifetime value'
WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Second level'
ELSE 'lowest level' END AS orders_tier
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;

--We would now like to perform a similar calculation to the first, but we want 
--to obtain the total amount spent by customers only in 2016 and 2017. 
--Keep the same levels as in the previous question. 
--Order with the top spending customers listed first.

SELECT a."name" AS name, SUM(o.total_amt_usd) AS sales_to_account,
CASE WHEN SUM(o.total_amt_usd) > 200000 THEN 'Lifetime value'
WHEN SUM(o.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'Second level'
ELSE 'lowest level' END AS orders_tier
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE o.occurred_at > '2015-12-31'
GROUP BY a.name, o.occurred_at
ORDER BY 2 DESC;

-- We would like to identify top performing sales reps, which are sales reps 
--associated with more than 200 orders. Create a table with the sales rep name,
--the total number of orders, and a column with top or not depending on if 
--they have more than 200 orders. Place the top sales people first in your 
--final table.

SELECT s."name" AS sales_rep, COUNT(o.id),
CASE WHEN COUNT(o.id) > 200 THEN 'top sales rep'
ELSE 'Not in top sales reps' END
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 2 DESC;

-- The previous didn't account for the middle, nor the dollar amount associated 
--with the sales. Management decides they want to see these characteristics 
--represented as well. We would like to identify top performing sales reps, 
--which are sales reps associated with more than 200 orders or more than 750000 
--in total sales. The middle group has any rep with more than 150 orders or 
--500000 in sales. Create a table with the sales rep name, the total number of 
--orders, total sales across all orders, and a column with top, middle, or low 
--depending on this criteria. Place the top sales people based on dollar amount 
--of sales first in your final table. You might see a few upset sales people by 
--this criteria!

SELECT s."name" AS sales_rep, 
COUNT(o.id) AS orders_count, 
SUM(o.total_amt_usd) AS sales_to_reps, 
CASE WHEN COUNT(o.id) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'top sales rep'
WHEN COUNT(o.id) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'mid sales rep'
ELSE 'low sales reps' END
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 3 DESC;


-- SUBQUERIES AND TEMPORARY TABLES

-- find the number of events that occurr for each day for each channel
SELECT DATE_TRUNC('day', occurred_at), 
channel,
COUNT(channel) AS count_of_events
FROM web_events
GROUP BY 1, 2
ORDER BY 1

-- write a subquery that provides all of the data from your first query
SELECT *
FROM
(SELECT DATE_TRUNC('day', occurred_at), 
channel,
COUNT(channel) AS count_of_events
FROM web_events
GROUP BY 1, 2
ORDER BY 1
) sub

-- Find the average number of events for each channel
SELECT channel,
AVG(count_of_events)
FROM
(SELECT DATE_TRUNC('day', occurred_at) AS day, 
channel AS channel,
COUNT(channel) AS count_of_events
FROM web_events
GROUP BY 1, 2
ORDER BY 1
) sub
GROUP BY 1

-- SUB-QUERIES II
SELECT *
FROM orders
WHERE DATE_TRUNC('month', occurred_at) = 
(SELECT DATE_TRUNC('month', MIN(occurred_at)) AS min
		FROM orders
 )
ORDER BY occurred_at 

-- Using DATE_TRUNC, pull month level info about the 1st order ever placed
SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders

-- From the previous query, find the orders that took place in the same month 
--of the same year as the first order, then pull the average for each type of 
--paper quantity in this month
SELECT DATE_TRUNC('month', occurred_at) AS month,
	   AVG(standard_qty) AS standard_avg,
       AVG(gloss_qty) AS gloss_avg,
       AVG(poster_qty) AS poster_avg,
       SUM(total_amt_usd) AS sum
FROM orders
WHERE DATE_TRUNC('month', occurred_at) =
(SELECT DATE_TRUNC('month', MIN(occurred_at))
FROM orders
)
GROUP BY month 

-- Provide the name of the sales_rep in each region with the largest amount 
--of total_amt_usd sales.
SELECT t3.rep_name, t3.region_name, t3.total_amt
FROM(SELECT region_name, MAX(total_amt) total_amt
     FROM(SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
             FROM sales_reps s
             JOIN accounts a
             ON a.sales_rep_id = s.id
             JOIN orders o
             ON o.account_id = a.id
             JOIN region r
             ON r.id = s.region_id
             GROUP BY 1, 2) t1
     GROUP BY 1) t2
JOIN (SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
     FROM sales_reps s
     JOIN accounts a
     ON a.sales_rep_id = s.id
     JOIN orders o
     ON o.account_id = a.id
     JOIN region r
     ON r.id = s.region_id
     GROUP BY 1,2
     ORDER BY 3 DESC) t3
ON t3.region_name = t2.region_name AND t3.total_amt = t2.total_amt;

--For the region with the largest (sum) of sales total_amt_usd, 
--how many total (count) orders were placed?
SELECT region_name, MAX(total_amt) AS total, MAX(order_count) AS ordercnt
FROM
(SELECT r."name" AS region_name, SUM(o.total_amt_usd) AS total_amt, COUNT(*) AS order_count
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
)t1
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- OR
SELECT r.name, SUM(total_amt_usd), COUNT(*) AS order_count
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
HAVING SUM(total_amt_usd) = 
(SELECT MAX(total_amt)
FROM
(SELECT r."name" AS region_name, SUM(o.total_amt_usd) AS total_amt
FROM sales_reps s
JOIN accounts a
ON a.sales_rep_id = s.id
JOIN orders o
ON o.account_id = a.id
JOIN region r
ON r.id = s.region_id
GROUP BY 1
)t1
) 

--What is the lifetime average amount spent in terms of total_amt_usd 
--for the top 10 total spending accounts
SELECT AVG(avg_amt)
FROM (SELECT a."name" AS accounts, SUM(o.total_amt_usd) AS avg_amt
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10) t1

-- For the customer that spent the most (in total over their lifetime as a 
--customer) total_amt_usd, how many web_events did they have for each channel?
SELECT t3.customer, t3.amt_spent, t3.events
FROM
(SELECT MAX(amt_spent) AS t2_amt, MAX(events) AS t2_event
FROM
(SELECT a."name" AS customer, SUM(o.total_amt_usd) AS amt_spent, COUNT(w.channel) AS events
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1
ORDER BY 2 DESC
) t1
) t2
JOIN (SELECT a."name" AS customer, SUM(o.total_amt_usd) AS amt_spent, COUNT(w.channel) AS events
FROM accounts a
JOIN orders o
ON a.id = o.account_id
JOIN web_events w
ON a.id = w.account_id
GROUP BY 1
)t3
ON t3.amt_spent = t2.t2_amt

--How many accounts had more total purchases than the account name which has 
--bought the most standard_qty paper throughout their lifetime as a customer?
SELECT COUNT(*)
FROM (SELECT a.name
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total) >
(SELECT total
FROM (SELECT a."name" AS customer, SUM(o.standard_qty) AS standard, SUM(o.total) AS total
FROM accounts a
JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
) t1
)
)tt

--What is the lifetime average amount spent in terms of total_amt_usd, 
--including only the companies that spent more per order, on average, 
--than the average of all orders.

SELECT AVG(total_avg)
FROM (SELECT a."name" AS client, AVG(o.total_amt_usd) AS total_avg
FROM orders o
JOIN accounts a
ON o.account_id = a.id
GROUP BY 1
HAVING AVG(o.total_amt_usd) > (SELECT AVG(o.total_amt_usd) AS total
					  FROM orders o
							  )) table2


-- DATA CLEANING
QUESTIONS
--In the accounts table, there is a column holding the website for each 
--company. The last three digits specify what type of web address they 
--are using. A list of extensions (and pricing) is provided here. 
--Pull these extensions and provide how many of each website type exist 
--in the accounts table.
SELECT RIGHT(website,3) AS extensions, COUNT(website) AS extension_count
FROM accounts
GROUP BY 1

--There is much debate about how much the name (or even the first letter 
--of a company name) matters. Use the accounts table to pull the first 
--letter of each company name to see the distribution of company names 
--that begin with each letter (or number).

SELECT LEFT(a."name", 1) AS account_name, COUNT(a."name") AS name_distribution
FROM accounts a
GROUP BY 1
ORDER BY 1

--Use the accounts table and a CASE statement to create two groups: one 
--group of company names that start with a number and a second group of 
--those company names that start with a letter. What proportion of 
--company names start with a letter?
SELECT t1.bin AS bins, COUNT(bin) AS bin_count 
FROM (SELECT LEFT(a."name", 1) AS name_start,
CASE WHEN a.name SIMILAR TO '(A|B|C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z|e)%' THEN 'vowels'
ELSE 'other_characters' END AS bin
FROM accounts a) t1
GROUP BY 1

--OR
SELECT SUM(num) nums, SUM(letter) letters
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 1 ELSE 0 END AS num, 
         CASE WHEN LEFT(UPPER(name), 1) IN ('0','1','2','3','4','5','6','7','8','9') 
                       THEN 0 ELSE 1 END AS letter
      FROM accounts) t1;


--Consider vowels as a, e, i, o, and u. What proportion of company names
--start with a vowel, and what percent start with anything else?
SELECT t1.bin AS bins, COUNT(bin) AS bin_count 
FROM (SELECT LEFT(a."name", 1) AS name_start,
CASE WHEN UPPER(a.name) SIMILAR TO '(A|E|I|O|U)%' THEN 'vowels'
ELSE 'other_characters' END AS bin
FROM accounts a) t1
GROUP BY 1

--OR
SELECT SUM(vowels) vowels, SUM(other) other
FROM (SELECT name, CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                        THEN 1 ELSE 0 END AS vowels, 
          CASE WHEN LEFT(UPPER(name), 1) IN ('A','E','I','O','U') 
                       THEN 0 ELSE 1 END AS other
         FROM accounts) t1;

-- POSITION, STRPOS, LOWER, UPPER

-- QUIZ

--Use the accounts table to create first and last name columns that hold 
--the first and last names for the primary_poc.

SELECT a.primary_poc AS poc, LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1),
RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' '))
FROM accounts a

--Now see if you can do the same thing for every rep name in the 
--sales_reps table. Again provide first and last name columns.
SELECT s."name" AS s_name, LEFT(s."name", POSITION(' ' IN s."name")-1),
RIGHT(s."name", LENGTH(s."name") - STRPOS(s."name", ' '))
FROM sales_reps s


--Now see if you can do the same thing for every rep name in the 
--accounts table. Again provide first and last name columns.
SELECT t2.namez, t2.firsts_name,
CASE WHEN t2.integer_pos = 0 THEN ''
WHEN t2.integer_pos > 0 THEN RIGHT(t2.namez, LENGTH(t2.namez) - STRPOS(t2.namez, ' ')) END AS last_namez
FROM (SELECT *,
CASE WHEN t1.integer_pos = 0 THEN t1.namez
WHEN t1.integer_pos > 0 THEN t1.first_name END AS firsts_name
FROM (SELECT a."name" AS namez, LEFT(a."name", POSITION(' ' IN a."name")-1) AS first_name,
	  POSITION(' ' IN a."name") AS integer_pos
FROM accounts a) t1) t2

--CONCATENATION (CONCAT)

--Each company in the accounts table wants to create an email address for
--each primary_poc. The email address should be the first name of the 
--primary_poc . last name primary_poc @ company name .com.
SELECT t1.first_name, t1.last_name,
CONCAT(t1.first_name, '', t1.last_name, '@', t1.company_name, '.com') AS email
FROM (SELECT a."name" AS company_name, a.primary_poc AS customer,
LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1) AS first_name,
RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' ')) AS last_name
FROM accounts a) t1

-- OR


SELECT a."name" AS company_name, a.primary_poc AS customer,
CONCAT(LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1), '', 
	   RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' '))
	  , '@', a."name", '.com') AS email
FROM accounts a

--You may have noticed that in the previous solution some of the company
--names include spaces, which will certainly not work in an email address.
--See if you can create an email address that will work by removing all 
--of the spaces in the account name, but otherwise your solution should 
--be just as in question 1. Some helpful documentation is here.

SELECT t1.first_name, t1.last_name, t1.company_name,
CONCAT(t1.first_name, '', t1.last_name, '@', t1.company_name, '.com') AS email
FROM (SELECT REPLACE(a."name", ' ', '') AS company_name, a.primary_poc AS customer,
LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1) AS first_name,
RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' ')) AS last_name
FROM accounts a) t1

--We would also like to create an initial password, which they will 
--change after their first log in. The first password will be the first 
--letter of the primary_poc's first name (lowercase), then the last 
--letter of their first name (lowercase), the first letter of their 
--last name (lowercase), the last letter of their last name (lowercase),
--the number of letters in their first name, the number of letters in 
--their last name, and then the name of the company they are working with,
--all capitalized with no spaces.
SELECT a.primary_poc AS "name", 
CONCAT(LEFT(LOWER(a.primary_poc), 1), 
	   RIGHT(LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1), 1),
	  LEFT(LOWER(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' '))), 1),
	  RIGHT(LOWER(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' '))), 1),
	  LENGTH(LEFT(a.primary_poc, POSITION(' ' IN a.primary_poc)-1)),
	  LENGTH(RIGHT(a.primary_poc, LENGTH(a.primary_poc) - STRPOS(a.primary_poc, ' '))),
	  UPPER(REPLACE(a."name", ' ', ''))
	  ) AS passcode
FROM accounts a


-- CAST

--EXERCISE
--Convert the date column to the appropirate sql date format.
SELECT s.date,
CONCAT(SUBSTR(s.date,7,4), '-',
SUBSTR(s.date,1,2), '-', 
SUBSTR(s.date,4,2)) AS new_date
FROM sf_crime_data s

--OR

SELECT CAST(sf_crime_data.date AS date)
FROM sf_crime_data

--OR

SELECT (t1.new_year || '-' || t1.new_month || '-' || t1.new_day)
FROM(SELECT s.date,
SUBSTR(s.date,7,4) AS new_year,
SUBSTR(s.date,1,2) AS new_month, 
SUBSTR(s.date,4,2) AS new_day
FROM sf_crime_data s)t1

-- COALESCE

--QUIZ
--Run the query below
SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
--USE COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table above
SELECT COALESCE(o.id, a.id) filled_id, a.*, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
--Use COALESCE to fill in the orders.account_id column with the account.id for the NULL value in table 1

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, 
a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, o.standard_qty, 
o.gloss_qty, o.poster_qty, o.total, o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, 
o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

--Use COALESCE to fill in each of the qty and usd columns with 0 for the table in question 1

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, 
a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, 
COALESCE(o.standard_qty, 0) standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, 
COALESCE(o.poster_qty,0) poster_qty, COALESCE(o.total,0) total, 
COALESCE(o.standard_amt_usd,0) standard_amt_usd, COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
COALESCE(o.poster_amt_usd,0) poster_amt_usd, COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;
-- Run the query in question 1 with the WHERE removed and COUNT the number of ids
SELECT COUNT(*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;
--Run the query in question 5 but with COALESCE used in question 2 through 4
SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, 
a.sales_rep_id, COALESCE(o.account_id, a.id) account_id, o.occurred_at, COALESCE(o.standard_qty, 0)
standard_qty, COALESCE(o.gloss_qty,0) gloss_qty, COALESCE(o.poster_qty,0) poster_qty, 
COALESCE(o.total,0) total, COALESCE(o.standard_amt_usd,0) standard_amt_usd, 
COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;




































