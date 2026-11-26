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

INSERT INTO CUSTOMERS (customer_id, customer_unique_id, city, state_)
SELECT MIN(customer_id), customer_unique_id, customer_city, customer_state
FROM olist_customers_dataset
GROUP BY customer_unique_id;

--ORDER dataset

INSERT INTO PRODUCT(product_id, product_category_name)
SELECT product_id, product_category_name
FROM olist_products_dataset;
