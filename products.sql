CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    quantity INTEGER NOT NULL DEFAULT 0
);

CREATE TABLE operations_log (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    operation VARCHAR CHECK (operation IN ('ADD', 'REMOVE')),
    quantity INTEGER NOT NULL
);


CREATE OR REPLACE PROCEDURE update_stock(product_id INT, operation VARCHAR, q INT)
LANGUAGE plpgsql AS $$
BEGIN
    IF operation = 'ADD' THEN
        UPDATE products
        SET quantity = quantity + q
        WHERE id = product_id;
        INSERT INTO operations_log (product_id, operation, quantity)
        VALUES (product_id, operation, q);
    
    ELSIF operation = 'REMOVE' THEN
        IF (SELECT quantity FROM products WHERE id = product_id) >= q THEN
            UPDATE products
            SET quantity = quantity - q
            WHERE id = product_id;
            INSERT INTO operations_log (product_id, operation, quantity)
            VALUES (product_id, operation, q);
        ELSE
            RAISE EXCEPTION 'Недостаточно товара для удаления';
        END IF;
    
    ELSE
        RAISE EXCEPTION 'Неверная операция. Используйте ADD или REMOVE.';
    END IF;
END;
$$;


INSERT INTO products(name, quantity)
VALUES('pizza', 15),
('coke', 33);

CALL update_stock(1, 'REMOVE', 10);
CALL update_stock(2, 'ADD', 10);
