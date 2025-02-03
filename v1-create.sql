/**
 @author
*/
-- Create Customers table
CREATE TABLE Clients (
    client_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    telefone VARCHAR(15),
    email VARCHAR(100)
);

-- Create Customers table
CREATE TABLE Services (
    service_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    duration INT NOT NULL -- Duration in minutes
);

-- Create Employees table
CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    specialty VARCHAR(100)
);

-- Create Appointments table
CREATE TABLE Appointments (
    scheduling_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES Clients(client_id) ON DELETE CASCADE,
    service_id INT REFERENCES Services(service_id) ON DELETE CASCADE,
    employee_id INT REFERENCES Employees(employee_id) ON DELETE SET NULL,
    date_hour TIMESTAMP NOT NULL
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id SERIAL PRIMARY KEY,
    scheduling_id INT REFERENCES Appointments(scheduling_id) ON DELETE CASCADE,
    value DECIMAL(10, 2) NOT NULL,
    date_payment TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
