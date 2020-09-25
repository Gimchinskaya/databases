-- Task 1

SELECT * FROM users;

SELECT * FROM orders;

SELECT u.id, u.name
  FROM users u 
    JOIN orders o
      ON u.id = o.user_id;

-- Task 2

SELECT * FROM products;

SELECT * FROM catalogs;

SELECT p.id, p.name, c.name as product_type
  FROM products p 
    LEFT JOIN catalogs c
      ON p.catalog_id = c.id
  ORDER BY id;