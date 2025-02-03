/**
  @author
 */
-- version2.sql
ALTER TABLE users ALTER COLUMN age TYPE SMALLINT;
ALTER TABLE users ADD COLUMN last_login TIMESTAMP DEFAULT NOW();
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (email);
ALTER TABLE orders ALTER COLUMN order_date SET NOT NULL;
ALTER TABLE products ADD COLUMN category VARCHAR(100);
ALTER TABLE payments ADD COLUMN status VARCHAR(50) DEFAULT 'pending';
ALTER TABLE shipments ADD COLUMN delivery_date TIMESTAMP;
--  (rollback)
ALTER TABLE users ALTER COLUMN age TYPE INTEGER;
ALTER TABLE users DROP COLUMN last_login;
ALTER TABLE users DROP CONSTRAINT unique_email;
ALTER TABLE orders ALTER COLUMN order_date DROP NOT NULL;
ALTER TABLE products DROP COLUMN category;
ALTER TABLE payments DROP COLUMN status;
ALTER TABLE shipments DROP COLUMN delivery_date;
