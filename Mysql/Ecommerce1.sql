create database ecommerce;
use ecommerce;


-- Users Table
CREATE TABLE Users (
    user_id INT PRIMARY KEY ,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY ,
    name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY ,
    user_id INT,
    order_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY ,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
insert into Users values(1,"saranya","saranya@gmail.com"),
(2,"bhagi","bhagi@gmail.com"),
(3,"chandu","chandu@gmail.com");
select*from Users;
insert into products values(001,"laptop",50000,10),
(002,"shoes",2000,50),
(014,"watch",2300,30),
(055,"mobile",100000,4),
(064,"headphones",7000,10);
select*from products;
insert into orders values(111,1,"2025-08-10"),
(112,2,"2025-08-11"),
(113,3,"2025-08-12");
select*from orders;
insert into order_items values(1,1,1,1),
(2,1,3,2),
(3,2,4,1),
(4,3,2,1),
(5,3,5,1);
select*from order_items;
-- UPDATE: Change email of a user
UPDATE Users
SET email = 'new_saranya@gmail.com'
WHERE user_id = 1;
-- DELETE: Remove a product from catalog
DELETE FROM Products
WHERE product_id = 64;

-- WHERE: Select users with Gmail accounts
SELECT * FROM Users
WHERE email LIKE '%@gmail.com';

-- Aggregate Functions: Total stock and average price
SELECT 
    COUNT(*) AS total_products,
    SUM(stock) AS total_stock,
    AVG(price) AS avg_price
FROM Products;

-- GROUP BY: Total quantity ordered for each product
SELECT 
    P.name AS product,
    SUM(OI.quantity) AS total_ordered
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id
GROUP BY P.name;

-- HAVING: Only show products ordered more than 1 time
SELECT 
    P.name AS product,
    SUM(OI.quantity) AS total_ordered
FROM Order_Items OI
JOIN Products P ON OI.product_id = P.product_id
GROUP BY P.name
HAVING SUM(OI.quantity) > 1;

-- LIKE: Find all products with names containing 'o'
SELECT * FROM Products
WHERE name LIKE '%o%';

-- Subquery: Find users who have placed at least one order
SELECT * FROM Users
WHERE user_id IN (SELECT DISTINCT user_id FROM Orders);

-- Find products with price greater than the average price
SELECT * FROM Products
WHERE price > (SELECT AVG(price) FROM Products);

--reduce stock automatically
DELIMITER //
CREATE TRIGGER reduce_stock
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
   UPDATE Products
   SET stock = stock - NEW.quantity
   WHERE product_id = NEW.product_id;
END;
//
DELIMITER ;


-- Check updated stock
SELECT * FROM Products;

-- Check orders
SELECT * FROM Orders;

-- Check order items
SELECT P.product_id, P.name AS product, OI.quantity
FROM Products P
LEFT JOIN Order_Items OI ON P.product_id = OI.product_id;
SELECT O.order_id, U.name AS customer, O.order_date
FROM Orders O
INNER JOIN Users U ON O.user_id = U.user_id;
SELECT O.order_id, U.name AS customer, O.order_date
FROM Orders O
INNER JOIN Users U ON O.user_id = U.user_id;



