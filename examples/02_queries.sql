INSERT INTO customers (name, country) VALUES ('Ada Lovelace', 'GB');
INSERT INTO customers (name, country) VALUES ('Grace Hopper', 'US');
INSERT INTO customers (name, country) VALUES ('Edsger Dijkstra', 'NL');

INSERT INTO orders (customer_id, total) VALUES (1, 120.50);
INSERT INTO orders (customer_id, total) VALUES (1, 80.00);
INSERT INTO orders (customer_id, total) VALUES (2, 240.00);

SELECT * FROM order_summary ORDER BY revenue DESC;

WITH ranked AS (
    SELECT c.name, o.total,
           ROW_NUMBER() OVER (PARTITION BY c.id ORDER BY o.total DESC) AS rn
    FROM customers c
    JOIN orders o ON o.customer_id = c.id
)
SELECT name, total FROM ranked WHERE rn = 1 ORDER BY total DESC
FETCH FIRST 10 ROWS ONLY;
