# Data-Management-Final-Project-KEDGEBS
## Project team

Batuhan Uzunlar, Anbuchelvan MANIVANNAN, Ali Esmaeil Zadeh, and Likit Poojari SUNDARA.


# Exploring Olist Orders and Marketplace Geography with SQL

We developed this project for the Data Management course at KEDGE Business School. Using SQLite and the Brazilian E-Commerce Public Dataset by Olist, we built a relational database and explored where customers and sellers are located across Brazil.


### Database design and data loading

We created new tables that include necessary columns.

- **Primary keys.** Each order is identified by `order_id`. In `ORDER_ITEMS`, we used `(order_id, item_no)` as a composite primary key because one order can contain several items.
- **Foreign keys.** `ORDERS.customer_id` links each order to a customer. In `ORDER_ITEMS`, `order_id` and `seller_id` identify the order and seller associated with each item.
- **Required fields.** We used `NOT NULL` for fields such as `price` and `freight_value` so that each order item has both amounts recorded.
- **Data loading.** We used `INSERT INTO ... SELECT` to copy selected columns from the imported Olist tables. For `CUSTOMERS` and `REVIEWS`, we used `INSERT OR IGNORE` so that a repeated primary key would be skipped and the remaining rows could still be loaded.


## Analysis


| Query | Business question | SQL approach |
| --- | --- | --- |
| 1 | Which orders purchased in January 2018 have the status `shipped`? | Filter by status and purchase timestamp, then sort the orders chronologically. |
| 2 | Which states have at least one customer but no sellers in the dataset? | Use `EXCEPT` to subtract seller states from customer states after excluding missing state codes. |
| 3 | Which city–state pairs appear among customers or sellers? | Use `UNION` to combine both lists, remove duplicate pairs, and sort by state and city. |

The first query uses the purchase date to define the January cohort. An order purchased in January and shipped in February can therefore appear in the results if its recorded status is `shipped`.

## Database structure

| Table | What it stores |
| --- | --- |
| `CUSTOMERS` | Customer IDs, unique customer identifiers, cities, and states |
| `ORDERS` | Order IDs, customer references, order status, and purchase timestamps |
| `ORDER_ITEMS` | Items within each order, their sellers, shipping deadlines, prices, and freight charges |
| `SELLERS` | Seller IDs, cities, and states |
| `PAYMENT` | Payment methods, installment counts, and payment amounts by order |
| `REVIEWS` | Review scores and comments linked to orders |
| `PRODUCT` | Product IDs and category names |

`ORDER_ITEMS` uses `(order_id, item_no)` as its primary key, so each order can contain multiple numbered items. The current schema stores the product catalog separately. Linking an item to its product category would require adding `product_id` to `ORDER_ITEMS`.



