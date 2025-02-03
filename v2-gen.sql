/**
  @author
 */
create table users
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(100) NOT NULL,
    email VARCHAR(100)NOT NULL UNIQUE
);



create table products
(
    id    SERIAL PRIMARY KEY,
    name  VARCHAR(100)NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);

create table orders
(
    id         SERIAL PRIMARY KEY,
    user_id    INT REFERENCES users(id),
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

create table order_items
(
    id         SERIAL PRIMARY KEY,
    order_id    INT  REFERENCES orders(id),
    product_id INT  REFERENCES products(id),
    quantity   INT NOT NULL CHECK (quantity > 0)
);





INSERT INTO users (id, name, email)
VALUES
(1,'Jessica Keilla', 'keillajessica@icloud.com'),
(2, 'Feliciano Gaspar', 'felicianogaspar68@gmail.com'),
(3, 'Sania Momed', 'sanianorgy2003@icloud.com'),
(4, 'Anaya Nayara' ,'anayamadeira@icloud.com'),
(5, 'Rehana Samussone' , 'rehanachiponde@gmail.com');

INSERT INTO products (id, name, price)
VALUES
(1, 'Laptop', 999.99),
(2, 'Smartphone', 699.99),
(3, 'Headphones', 199.99),
(4, 'Monitor', 299.99),
(5, 'Keyboard', 49.99);

INSERT INTO orders (id, user_id, order_date)
VALUES
(1, 1, '2024-12-01'),
(2, 2, '2024-12-02'),
(3, 3, '2024-12-03'),
(4, 4, '2024-12-04'),
(5, 5, '2024-12-05');

INSERT INTO order_items (id, order_id, product_id, quantity)
VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 3, 4, 1),
(5, 3, 5, 3),
(6, 4, 1, 2),
(7, 5, 2, 1),
(8, 5, 3, 1),
(9, 5, 5, 2),
(10, 2, 4, 1);

DO $$
DECLARE
    i INT;
BEGIN
    -- Добавляем пользователей
    FOR i IN 6..150 LOOP
        INSERT INTO users (id, name, email)
        VALUES (i, 'User '  i, 'user'  i  '@example.com');
    END LOOP;

    -- Добавляем товары
    FOR i IN 6..50 LOOP
        INSERT INTO products (id, name, price)
        VALUES (i, 'Product '  i, ROUND(RANDOM() * 100 + 10, 2));
    END LOOP;

    -- Добавляем заказы
    FOR i IN 6..200 LOOP
        INSERT INTO orders (id, user_id, order_date)
        VALUES (i, FLOOR(RANDOM() * 150 + 1), CURRENT_DATE - (i % 30));
    END LOOP;

    -- Добавляем товары в заказы
    FOR i IN 11..500 LOOP
        INSERT INTO order_items (id, order_id, product_id, quantity)
        VALUES (i, FLOOR(RANDOM() * 200 + 1), FLOOR(RANDOM() * 50 + 1), FLOOR(RANDOM() * 5 + 1));
    END LOOP;
END $$;
