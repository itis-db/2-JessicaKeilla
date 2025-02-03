/**
  @author
 */

BEGIN;
--v1-create.sql: Изменения в таблицах в первом файле create
-- =============================
ALTER TABLE Clients DROP CONSTRAINT Clients_pkey;
ALTER TABLE Clients DROP COLUMN client_id;
ALTER TABLE Clients ADD PRIMARY KEY (email);

ALTER TABLE Services DROP CONSTRAINT Services_pkey;
ALTER TABLE Services DROP COLUMN service_id;
ALTER TABLE Services ADD PRIMARY KEY (name);

ALTER TABLE Employees DROP CONSTRAINT Employees_pkey;
ALTER TABLE Employees DROP COLUMN employee_id;
ALTER TABLE Employees ADD PRIMARY KEY (name, surname);

ALTER TABLE Appointments DROP CONSTRAINT Appointments_pkey;
ALTER TABLE Appointments DROP COLUMN scheduling_id;
ALTER TABLE Appointments ADD PRIMARY KEY (client_id, service_id, employee_id, date_hour);
ALTER TABLE Appointments 
    ADD FOREIGN KEY (client_id) REFERENCES Clients(email) ON DELETE CASCADE,
    ADD FOREIGN KEY (service_id) REFERENCES Services(name) ON DELETE CASCADE,
    ADD FOREIGN KEY (employee_id) REFERENCES Employees(name, surname) ON DELETE SET NULL;

ALTER TABLE Payments DROP CONSTRAINT Payments_pkey;
ALTER TABLE Payments DROP COLUMN payment_id;
ALTER TABLE Payments ADD PRIMARY KEY (scheduling_id);
ALTER TABLE Payments ADD FOREIGN KEY (scheduling_id) REFERENCES Appointments(client_id, service_id, employee_id, date_hour) ON DELETE CASCADE;
COMMIT;

-- ==============================
-- v2-gen.sql: Изменения в таблицах генерации данных
-- ==============================
BEGIN;
ALTER TABLE Users DROP CONSTRAINT Users_pkey;
ALTER TABLE Users DROP COLUMN id;
ALTER TABLE Users ADD PRIMARY KEY (email);

ALTER TABLE Products DROP CONSTRAINT Products_pkey;
ALTER TABLE Products DROP COLUMN id;
ALTER TABLE Products ADD PRIMARY KEY (name);

ALTER TABLE Orders DROP CONSTRAINT Orders_pkey;
ALTER TABLE Orders DROP COLUMN id;
ALTER TABLE Orders ADD PRIMARY KEY (user_id, order_date);

ALTER TABLE Order_Items DROP CONSTRAINT Order_Items_pkey;
ALTER TABLE Order_Items DROP COLUMN id;
ALTER TABLE Order_Items ADD PRIMARY KEY (order_id, product_id);
ALTER TABLE Order_Items ADD FOREIGN KEY (order_id) REFERENCES Orders(user_id, order_date) ON DELETE CASCADE;
ALTER TABLE Order_Items ADD FOREIGN KEY (product_id) REFERENCES Products(name) ON DELETE CASCADE;
COMMIT;

-- ======================================================
--v3.version.sql
-- ===================================================
  BEGIN;

ALTER TABLE orders DROP COLUMN id;
ALTER TABLE payments DROP COLUMN id;
ALTER TABLE products DROP COLUMN id;
ALTER TABLE shipments DROP COLUMN id;
ALTER TABLE users DROP COLUMN id;

ALTER TABLE users ADD CONSTRAINT users_email_key UNIQUE (email);
ALTER TABLE users ADD PRIMARY KEY (email);

ALTER TABLE orders ADD CONSTRAINT orders_user_id_key UNIQUE (user_id);
ALTER TABLE payments ADD CONSTRAINT payments_user_id_key UNIQUE (user_id);
ALTER TABLE shipments ADD CONSTRAINT shipments_order_id_key UNIQUE (order_id);


ALTER TABLE orders ADD COLUMN order_id VARCHAR(255) PRIMARY KEY;
ALTER TABLE payments ADD COLUMN payment_id VARCHAR(255) PRIMARY KEY;
ALTER TABLE products ADD COLUMN product_id VARCHAR(255) PRIMARY KEY;
ALTER TABLE shipments ADD COLUMN shipment_id VARCHAR(255) PRIMARY KEY;


ALTER TABLE orders ADD CONSTRAINT fk_orders_users FOREIGN KEY (user_id) REFERENCES users(email);
ALTER TABLE payments ADD CONSTRAINT fk_payments_users FOREIGN KEY (user_id) REFERENCES users(email);
ALTER TABLE shipments ADD CONSTRAINT fk_shipments_orders FOREIGN KEY (order_id) REFERENCES orders(order_id);
COMMIT;

-- ==============================
--v4-cju.sql: Изменения в таблицах отделов и проектов
-- ==============================
BEGIN;
ALTER TABLE Departments DROP CONSTRAINT Departments_pkey;
ALTER TABLE Departments DROP COLUMN id;
ALTER TABLE Departments ADD PRIMARY KEY (department_name);

ALTER TABLE Employees DROP CONSTRAINT Employees_pkey;
ALTER TABLE Employees DROP COLUMN id;
ALTER TABLE Employees ADD PRIMARY KEY (name);
ALTER TABLE Employees ADD FOREIGN KEY (department_id) REFERENCES Departments(department_name) ON DELETE SET NULL;

ALTER TABLE Projects DROP CONSTRAINT Projects_pkey;
ALTER TABLE Projects DROP COLUMN id;
ALTER TABLE Projects ADD PRIMARY KEY (project_name);

ALTER TABLE Employee_Projects DROP CONSTRAINT Employee_Projects_pkey;
ALTER TABLE Employee_Projects ADD PRIMARY KEY (employee_id, project_id);
ALTER TABLE Employee_Projects ADD FOREIGN KEY (employee_id) REFERENCES Employees(name) ON DELETE CASCADE;
ALTER TABLE Employee_Projects ADD FOREIGN KEY (project_id) REFERENCES Projects(project_name) ON DELETE CASCADE;

ALTER TABLE Salaries DROP CONSTRAINT Salaries_pkey;
ALTER TABLE Salaries DROP COLUMN id;
ALTER TABLE Salaries ADD PRIMARY KEY (employee_id, effective_date);
ALTER TABLE Salaries ADD FOREIGN KEY (employee_id) REFERENCES Employees(name) ON DELETE CASCADE;

COMMIT;
