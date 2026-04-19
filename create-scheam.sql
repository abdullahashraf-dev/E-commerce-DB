
CREATE TABLE categories (
    category_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    category_name CHAR(255)
);

CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(255),
    last_name CHAR(255),
    email CHAR(255),
    phone CHAR(255),
    password VARCHAR(255)
);

CREATE TABLE products (
    product_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    category_id INTEGER,
    name CHAR(255),
    description VARCHAR(255),
    price DECIMAL(5, 2),
    stock_quantity INTEGER,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    customer_id INTEGER,
    order_date DATETIME,
    total_amount DECIMAL(5, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_detail_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    order_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    unit_price DECIMAL(5, 2),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
