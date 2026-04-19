INSERT INTO categories (category_name) VALUES 
('Electronics'), 
('Clothing'), 
('Home & Kitchen');

INSERT INTO customers (first_name, last_name, email, phone, password) VALUES 
('Ahmed', 'Ali', 'ahmed@email.com', '123456789', 'hashed_pass_1'),
('Sara', 'Mohamed', 'sara@email.com', '987654321', 'hashed_pass_2'),
('John', 'Doe', 'john.d@email.com', '555000111', 'hashed_pass_3');


INSERT INTO products (category_id, name, description, price, stock_quantity) VALUES 
(1, 'Smartphone', 'High-end mobile device', 899.99, 50),
(1, 'Wireless Buds', 'Noise-cancelling earphones', 149.50, 100),
(2, 'Cotton T-Shirt', 'Premium organic cotton', 25.00, 200),
(3, 'Coffee Maker', 'Programmable drip coffee machine', 75.25, 30);


INSERT INTO orders (customer_id, order_date, total_amount) VALUES 
(1, '2024-07-19 10:00:00', 924.99), 
(3, '2026-04-10 14:30:00', 149.50),
(2, '2026-04-18 09:15:00', 100.25), 
(1, '2026-04-18 16:45:00', 1799.98); 

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES 
(1, 1, 1, 899.99), 
(1, 3, 1, 25.00),
(2, 2, 1, 149.50),
(3, 3, 1, 25.00),
(3, 4, 1, 75.25),
(4, 1, 2, 899.99); 