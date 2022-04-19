--- Drop any views if exists
DROP VIEW IF EXISTS transactions_per_cardholder;
DROP VIEW IF EXISTS small_transactions_per_cardholder;
DROP VIEW IF EXISTS top_100transaction_between_7_9_by_amount;
DROP VIEW IF EXISTS small_transactions_between_7_9_by_amount;
DROP VIEW IF EXISTS small_transactions_between_7_9;
DROP VIEW IF EXISTS avg_small_transactions_between_7_9;
DROP VIEW IF EXISTS small_transactions_outside_7_9;
DROP VIEW IF EXISTS avg_small_transactions_outside_7_9;
DROP VIEW IF EXISTS top_5_hacked_merchants;


--- Check card_holder table for data
Select * From card_holder;

--- Check credit_card table for data
Select * From credit_card;

--- Check merchant table for data
Select * From merchant;

--- Check merchant_category table for data
Select * From merchant_category;

--- Check transaction table for data
Select * From transaction;

--------------------------------------------------------------------------------------------
--- Section: - Part 1
--------------------------------------------------------------------------------------------
-- Question 1: How can you isolate (or group) the transactions of each cardholder?
Select 
     card_holder.name AS "Card Holder", 
	 COUNT(transaction.id) AS "Transactions Count"
	 
From transaction
INNER JOIN credit_card on credit_card.card = transaction.card
INNER JOIN card_holder on card_holder.id = credit_card.cardholder_id
Group By   "Card Holder"
Order By   "Transactions Count" DESC;


-----------------------------------------------------------------------------------
--- Question 2: Count the transactions that are less than $2.00 per cardholder
Select 
	card AS "Card Number", 
	COUNT(amount) AS "Small Transactions Count",
	amount as Amount
From transaction
Where amount < 2.00
Group By card, amount
Order By "Small Transactions Count" DESC;


-----------------------------------------------------------------------------------
--- Question 4: What are the top 100 highest transactions made between 7:00 am and 9:00 am?
Select 
	card,
	amount, 
	date :: timestamp :: date AS "Date", 
	date :: timestamp :: time AS "Time"
From transaction
Where date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
Order By amount DESC
Limit 100;


-----------------------------------------------------------------------------------
--- Question 5: Do you see any anomalous transactions that could be fraudulent?
--- Checking if small amount trans were done during 7:00 am and 9:00 am
Select 
	card, 
	amount, 
	date :: timestamp :: date AS "Date", 
	date :: timestamp :: time AS "Time"
From transaction
Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
Order By card, amount DESC;


-----------------------------------------------------------------------------------
--- Question 6: Is there a higher number of fraudulent transactions made during this time frame versus the rest of the day?
--- Query 1 - Checking fraudulent transactions between 7am and 9am
Select 
	card, amount,
	date :: timestamp :: date AS "Date", 
	date :: timestamp :: time AS "Time"
From transaction
Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
Order By card;


Select 	--- Calculate average transaction per hour
	avg(card)
From(
	Select 
		Extract(HOUR From date) AS HOUR,  
		count(card)as card
	From transaction
	Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
	Group by hour
	Order by Card) 
as me;

--- Query 2 - Checking fraudulent transactions outside of 7am and 9am
Select 
	card, amount,
	date :: timestamp :: date AS "Date", 
	date :: timestamp :: time AS "Time"
From transaction
Where amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00')
Order By card, date;


Select 	--- Calculate average transaction per hour
	avg(card)
From(
	Select 
		Extract(HOUR From date) AS HOUR,  
		count(card)as card
	From transaction
	Where amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00')
	Group by hour
	Order by Card) 
as me;


-----------------------------------------------------------------------------------
--- Question 8: What are the top 5 merchants prone to being hacked using small transactions?
Select 
	merchant.name, 
	COUNT(transaction.id_merchant) AS "Transactions Count"
From transaction
JOIN merchant ON transaction.id_merchant  = merchant.id
Where transaction.amount < 2
Group By merchant.name
Order By "Transactions Count" DESC
Limit 5;


----------------------------------------------------------------------------------------------
--- Section: - Part 1 - Creating VIEWS
--------------------------------------------------------------------------------------------
--- Question 1
Create View transactions_per_cardholder AS
	Select 
		card_holder.name AS "Card Holder", 
		COUNT(transaction.id) AS "Transactions"
	From transaction
	JOIN credit_card on credit_card.card = transaction.card
	JOIN card_holder on card_holder.id = credit_card.cardholder_id
	Group By "Card Holder"
	Order By "Transactions" DESC;


--- Question 2
Create View small_transactions_per_cardholder AS
	Select 
		card AS "Card Number", 
		COUNT(amount) AS "Transactions Count"
	From transaction
	Where amount < 2.00
	Group By card
	Order By "Transactions Count" DESC;


--- Question 4
Create View top_100transaction_between_7_9_by_amount AS
	Select 
		card, 
		amount, 
		date :: timestamp :: date AS "Date", 
		date :: timestamp :: time AS "Time"
	From transaction
	Where date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
	Order By amount DESC
	Limit 100;


--- Question 5
Create View small_transactions_between_7_9_by_amount AS
	Select 
		card, 
		amount, 
		date :: timestamp :: date AS "Date", 
		date :: timestamp :: time AS "Time"
	From transaction
	Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
	Order By amount DESC;


--- Question 6
Create View small_transactions_between_7_9  AS             ---Select record within 7-9am
	Select 
		card, amount,
		date :: timestamp :: date AS "Date", 
		date :: timestamp :: time AS "Time"
	From transaction
	Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00';

Create View avg_small_transactions_between_7_9  AS          ---Average calculation
	Select 	
		avg(card)
	From(
		Select 
			Extract(HOUR From date) AS HOUR,  
			count(card)as card
		From transaction
		Where amount < 2 AND date :: timestamp :: time > '07:00:00' AND date :: timestamp :: time < '09:00:00'
		Group by hour
		Order by Card) 
	as me;


Create View small_transactions_outside_7_9  AS             ---Select record outside 7-9am
	Select 
		card, amount,
		date :: timestamp :: date AS "Date", 
		date :: timestamp :: time AS "Time"
	From transaction
	Where amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00');
	
	
Create View avg_small_transactions_outside_7_9  AS          ---Average calculation	
	Select
		avg(card)
	From(
		Select 
			Extract(HOUR From date) AS HOUR,  
			count(card)as card
		From transaction
		Where amount < 2 AND (date :: timestamp :: time < '07:00:00' OR date :: timestamp :: time > '09:00:00')
		Group by hour
		Order by Card) 
	as me;


--- Question 8
Create View top_5_hacked_merchants  AS
	Select 
		merchant.name, 
		COUNT(transaction.id_merchant) AS "Transactions Count"
	From transaction
	JOIN merchant ON transaction.id_merchant  = merchant.id
	Where transaction.amount < 2
	Group By merchant.name
	Order By "Transactions Count" DESC
	Limit 5;
