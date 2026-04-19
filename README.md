# E-commerce-DB

E-commerce database project containing schema, seed data, and reporting queries.

## Tables

The database has 5 tables:

1. categories
2. customers
3. products
4. orders
5. order_details

## Relations

1. categories (1) -> (N) products

- One category can have many products.

2. customers (1) -> (N) orders

- One customer can place many orders.

3. orders (1) -> (N) order_details

- One order can have many order detail rows.

4. products (1) -> (N) order_details

- One product can appear in many order detail rows.

In short, order_details is a bridge table between orders and products.

## ERD

![ERD Diagram](e_commerce_db.png)

## Create Schema

1. [create-scheam.sql](create-scheam.sql) - Creates all tables and foreign key relations

## Data

1. [data.sql](data.sql) - Inserts sample data into all tables

## Queries

1. [queries.sql](queries.sql) - Contains reporting and analytics queries

## Denormalization

For denormalization mechanism on customer and order entities we can add customer columns into the order entity which would make reading data faster as there is no need to join another table however this would duplicate customer data and if the customer need to update its data then it would required to update all rows containing that customer which would take time, also if the we want to delete the order then the data of customer no longer exist
