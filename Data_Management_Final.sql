CREATE TABLE CUSTOMERS (
             customer_id TEXT PRIMARY KEY,
	         customer_unique_id TEXT NOT NULL,
			 city TEXT,
			 state_ TEXT
			 			 
);

CREATE TABLE ORDERS (
		order_id TEXT PRIMARY KEY,
		customer_id TEXT,
		order_status char(20),
		order_purchase_timestamp datetime
		order_delivered_customer_date  datetime,
		FOREIGN key (customer_id) REFERENCES CUSTOMERS(customer_id)
);

CREATE TABLE PRODUCT (
		product_id TEXT PRIMARY KEY,
		product_category_name TEXT
);

CREATE TABLE SELLERS (
		seller_id TEXT PRIMARY KEY,
		seller_city TEXT,
		seller_state TEXT
);


CREATE TABLE ORDER_ITEMS (
             order_id TEXT NOT NULL,
			 item_no INTEGER NOT NULL,
			 seller_id TEXT NOT NULL,
			 shipping_limit_ts TEXT,
			 price REAL NOT NULL,
			 freight_value REAL NOT NULL,
			 PRIMARY KEY(order_id, item_no),
			 FOREIGN KEY(order_id) REFERENCES ORDERS(order_id),
			 FOREIGN KEY(seller_id) REFERENCES SELLERS(seller_id)
);

CREATE TABLE PAYMENT(
             order_id TEXT,
			 paymet_type TEXT,
			 payment_installments char(2),
			 payment_value NUMERIC(3,2),
			 FOREIGN KEY(order_id) REFERENCES ORDERS(order_id)
			 
);

CREATE TABLE REVIEWS (
		review_id TEXT PRIMARY KEY,
		order_id TEXT,
		review_score INTEGER,
		review_comment_message TEXT,
		FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);

INSERT OR IGNORE INTO CUSTOMERS
SELECT customer_id, customer_unique_id,
       customer_city, customer_state
FROM olist_customers_dataset;

INSERT INTO ORDERS
SELECT order_id, customer_id, order_status,
       order_purchase_timestamp
FROM olist_orders_dataset;

INSERT INTO PAYMENT
SELECT order_id, payment_type,
       payment_installments, payment_value
FROM olist_order_payments_dataset;

INSERT INTO PRODUCT
SELECT product_id, product_category_name
FROM olist_products_dataset;

INSERT OR IGNORE INTO REVIEWS
SELECT review_id, order_id,
       review_score, review_comment_message
FROM olist_order_reviews_dataset;

INSERT INTO SELLERS
SELECT seller_id, seller_city, seller_state
FROM olist_sellers_dataset;

INSERT INTO ORDER_ITEMS
SELECT order_id, order_item_id, seller_id, shipping_limit_date, price, freight_value
FROM olist_order_items_dataset;

DROP TABLE olist_customers_dataset;
DROP TABLE olist_order_items_dataset;
DROP TABLE olist_order_payments_dataset;
DROP TABLE olist_order_reviews_dataset;
DROP TABLE olist_orders_dataset;
DROP TABLE olist_products_dataset;
DROP TABLE olist_sellers_dataset;
