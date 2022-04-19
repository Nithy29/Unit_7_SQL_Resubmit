-- Drop Views
DROP VIEW IF EXISTS transactions_per_cardholder;
DROP VIEW IF EXISTS small_transactions_per_cardholder;
DROP VIEW IF EXISTS top_100transaction_between_7_9_by_amount;
DROP VIEW IF EXISTS small_transactions_between_7_9_by_amount;
DROP VIEW IF EXISTS small_transactions_between_7_9;
DROP VIEW IF EXISTS avg_small_transactions_between_7_9;
DROP VIEW IF EXISTS small_transactions_outside_7_9;
DROP VIEW IF EXISTS avg_small_transactions_outside_7_9;
DROP VIEW IF EXISTS top_5_hacked_merchants;


-- Drop table if exists
DROP TABLE IF EXISTS card_holder;
DROP TABLE IF EXISTS credit_card;
DROP TABLE IF EXISTS merchant_category;
DROP TABLE IF EXISTS merchant;
DROP TABLE IF EXISTS transactions;


--- Create tables and constraints as per database schema ready for data import
CREATE TABLE "card_holder" (
    "id"   INT            NOT NULL,
    "name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_card_holder" 
	PRIMARY KEY ("id")
);


CREATE TABLE "credit_card" (
    "card"          VARCHAR(20)   NOT NULL,
    "cardholder_id" INT           NOT NULL,
    CONSTRAINT "pk_credit_card" 
	PRIMARY KEY ("card")
);

CREATE TABLE "merchant_category" (
    "id"   INT           NOT NULL,
    "name" VARCHAR(50)   NOT NULL,
    CONSTRAINT "pk_merchant_category" 
	PRIMARY KEY ("id")
);

CREATE TABLE "merchant" (
    "id"                   INT           NOT NULL,
    "name"                 VARCHAR(50)   NOT NULL,
    "id_merchant_category" INT   NOT NULL,
    CONSTRAINT "pk_merchant" 
	PRIMARY KEY ("id")
);


CREATE TABLE "transaction" (
    "id"          INT         NOT NULL,
    "date"        TIMESTAMP   NOT NULL,
    "amount"      FLOAT       NOT NULL,
    "card"        VARCHAR(20) NOT NULL,
    "id_merchant" INT         NOT NULL,
    CONSTRAINT "pk_transaction" 
	PRIMARY KEY ("id")
);

--- Alter table to add constraints
ALTER TABLE "credit_card" ADD CONSTRAINT "fk_credit_card_cardholder_id" FOREIGN KEY("cardholder_id")
REFERENCES "card_holder" ("id");

ALTER TABLE "merchant" ADD CONSTRAINT "fk_merchant_id_merchant_category" FOREIGN KEY("id_merchant_category")
REFERENCES "merchant_category" ("id");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_card" FOREIGN KEY("card")
REFERENCES "credit_card" ("card");

ALTER TABLE "transaction" ADD CONSTRAINT "fk_transaction_id_merchant" FOREIGN KEY("id_merchant")
REFERENCES "merchant" ("id");



