DROP DATABASE IF EXISTS shop;
-- Create the database if it doesn't already exist
CREATE DATABASE IF NOT EXISTS shop;
USE shop;

-- Create the customers table
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Create the categories table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
) ENGINE=InnoDB;

-- Create the suppliers table
CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    phone VARCHAR(15),
    address TEXT
) ENGINE=InnoDB;

-- Create the products table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    stock INT DEFAULT 0,
    category_id INT,
    supplier_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(category_id) ON DELETE SET NULL,
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- Create the orders table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status varchar(40) DEFAULT 'pending',
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Create the order_lines table
CREATE TABLE order_lines (
    order_line_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT
) ENGINE=InnoDB;


-- Insert categories
INSERT INTO categories (name, description) VALUES
    ('Electronics', 'Devices and gadgets'),
    ('Books', 'Fiction, non-fiction, and academic books'),
    ('Clothing', 'Men and women clothing'),
    ('Home & Kitchen', 'Home and kitchen appliances'),
    ('Toys & Games', 'Toys and games for children and adults');

-- Insert customers
INSERT INTO customers (name, email, phone, address) VALUES
    ('Alice Johnson', 'alice@example.com', '1234567890', '123 Main St'),
    ('Bob Smith', 'bob@example.com', '0987654321', '456 Oak St'),
    ('Charlie Brown', 'charlie@example.com', '1231231234', '789 Pine St'),
    ('Diana Prince', 'diana@example.com', '2342342345', '321 Maple St'),
    ('Evan Davis', 'evan@example.com', '3453453456', '654 Elm St'),
    ('Fiona Apple', 'fiona@example.com', '4564564567', '987 Birch St'),
    ('George Clark', 'george@example.com', '5675675678', '111 Cedar St'),
    ('Hannah Scott', 'hannah@example.com', '6786786789', '222 Spruce St'),
    ('Ian Wright', 'ian@example.com', '7897897890', '333 Willow St'),
    ('Julia Roberts', 'julia@example.com', '8908908901', '444 Chestnut St');

-- Insert suppliers (for simplicity, adding 2 suppliers)
INSERT INTO suppliers (name, contact_name, phone, address) VALUES
    ('Tech Supplier Co.', 'John Doe', '1234560000', '555 Tech Blvd'),
    ('Home Goods Ltd.', 'Jane Doe', '1234561111', '666 Home St');

-- Insert products
INSERT INTO products (name, description, price, stock, category_id, supplier_id) VALUES
    ('Smartphone', 'Latest model smartphone', 599.99, 50, 1, 1),
    ('Laptop', '15 inch high performance laptop', 1099.99, 30, 1, 1),
    ('Headphones', 'Noise-cancelling headphones', 199.99, 100, 1, 1),
    ('Fiction Book', 'Bestselling fiction book', 14.99, 200, 2, NULL),
    ('Non-Fiction Book', 'Top rated non-fiction book', 19.99, 150, 2, NULL),
    ('Jeans', 'Comfortable blue jeans', 39.99, 100, 3, NULL),
    ('T-Shirt', 'Basic white t-shirt', 9.99, 500, 3, NULL),
    ('Jacket', 'Warm winter jacket', 89.99, 75, 3, NULL),
    ('Blender', 'High power kitchen blender', 49.99, 60, 4, 2),
    ('Microwave', '800W microwave oven', 79.99, 40, 4, 2),
    ('Board Game', 'Fun family board game', 29.99, 120, 5, NULL),
    ('Puzzle', '1000 piece puzzle', 19.99, 150, 5, NULL),
    ('Toy Car', 'Remote controlled toy car', 24.99, 80, 5, NULL),
    ('Doll', 'Doll with accessories', 14.99, 200, 5, NULL),
    ('Smartwatch', 'Wearable fitness tracker', 149.99, 100, 1, 1),
    ('Cookware Set', '10-piece cookware set', 89.99, 70, 4, 2),
    ('Novel', 'Classic literature novel', 9.99, 250, 2, NULL),
    ('Dress', 'Elegant evening dress', 59.99, 80, 3, NULL),
    ('Gaming Console', 'Popular gaming console', 299.99, 40, 1, 1),
    ('Coffee Maker', 'Automatic coffee maker', 79.99, 50, 4, 2);

-- Insert orders
INSERT INTO orders (customer_id, status, total_amount) VALUES
    (1, 'pending', NULL),
    (2, 'shipped', NULL),
    (3, 'delivered', NULL),
    (4, 'cancelled', NULL),
    (5, 'pending', NULL),
    (6, 'shipped', NULL),
    (7, 'delivered', NULL),
    (8, 'pending', NULL),
    (9, 'shipped', NULL),
    (10, 'delivered', NULL),
    (1, 'pending', NULL),
    (2, 'shipped', NULL),
    (3, 'delivered', NULL),
    (4, 'pending', NULL),
    (5, 'shipped', NULL),
    (6, 'delivered', NULL),
    (7, 'cancelled', NULL),
    (8, 'pending', NULL),
    (9, 'shipped', NULL),
    (10, 'delivered', NULL),
    (10,'new_order',Null);

-- Insert order lines
INSERT INTO order_lines (order_id, product_id, quantity, price) VALUES
    (1, 1, 1, 599.99),
    (1, 5, 2, 14.99),
    (2, 2, 1, 1099.99),
    (2, 7, 3, 9.99),
    (3, 4, 1, 14.99),
    (3, 3, 2, 199.99),
    (4, 8, 1, 89.99),
    (4, 9, 2, 49.99),
    (5, 10, 1, 79.99),
    (5, 13, 3, 24.99),
    (6, 12, 1, 19.99),
    (6, 6, 2, 39.99),
    (7, 14, 2, 14.99),
    (7, 11, 1, 29.99),
    (8, 15, 1, 149.99),
    (8, 16, 1, 89.99),
    (9, 3, 1, 199.99),
    (9, 17, 2, 9.99),
    (10, 18, 1, 59.99),
    (10, 19, 1, 299.99),
    (11, 7, 3, 9.99),
    (11, 20, 1, 79.99),
    (12, 1, 1, 599.99),
    (12, 5, 2, 14.99),
    (13, 2, 1, 1099.99),
    (13, 7, 3, 9.99),
    (14, 4, 1, 14.99),
    (14, 3, 2, 199.99),
    (15, 8, 1, 89.99),
    (15, 9, 2, 49.99),
    (16, 10, 1, 79.99),
    (16, 13, 3, 24.99),
    (17, 12, 1, 19.99),
    (17, 6, 2, 39.99),
    (18, 14, 2, 14.99),
    (18, 11, 1, 29.99),
    (19, 15, 1, 149.99),
    (19, 16, 1, 89.99),
    (20, 3, 1, 199.99),
    (20, 17, 2, 9.99);

select * from orders where order_id not in (select order_id from order_lines);