CREATE TABLE CUSTOMERS (
             customer_id TEXT PRIMARY KEY,
	         customer_unique_id TEXT NOT NULL;
			 city TEXT,
			 state_ TEXT
			 			 
);

CREATE TABLE CATEGORIES (
             category_id INTEGER PRIMARY KEY,
			 name_pt TEXT,
			 name_en TEXT
);

CREATE TABLE ORDER_ITEMS (
             order_id TEXT NOT NULL,
			 item_no INTEGER NOT NULL,
			 seller_id TEXT NOT NULL,
			 shipping_limit_ts TEXT,
			 price REAL NOT NULL,
			 freight_value REAL NOT NULL,
			 PRIMARY KEY(order_id, item_no),
			 FOREIGN KEY(order_id) REFERENCES olist_order_items_dataset(order_id),
			 FOREIGN KEY(seller_id) REFERENCES olist_sellers_dataset(seller_id)
);



