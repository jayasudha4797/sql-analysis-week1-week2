CREATE DATABASE IF NOT EXISTS consumer360_dw;
CREATE SCHEMA staging;

CREATE TABLE staging.raw_sales (
    order_id VARCHAR(20),
    payment_id VARCHAR(20),
    customer_id VARCHAR(20),
    time_id VARCHAR(20),
    item_id VARCHAR(20),
    store_id VARCHAR(20),
    quantity INT,
    unit VARCHAR(20),
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2)
);

CREATE TABLE staging.raw_customer (
    customer_id VARCHAR(20),
    c_name VARCHAR(100),
    contact VARCHAR(50)
);

CREATE TABLE staging.raw_time (
    time_id VARCHAR(20),
    date_time VARCHAR(30),
    hour INT,
    day INT,
    week_of_month INT,
    week_of_year INT,
    month INT,
    quarter INT,
    year INT
);

CREATE TABLE staging.raw_item (
    item_id VARCHAR(20),
    item_name VARCHAR(100),
    category VARCHAR(30),
    description TEXT,
    price DECIMAL(10,2),
    manufacture_country VARCHAR(50),
    supplier VARCHAR(100),
	unit varchar(20)
);



CREATE TABLE staging.raw_store (
    store_id VARCHAR(20),
    region VARCHAR(50),
    district VARCHAR(50),
    upazila VARCHAR(50)
);

CREATE TABLE staging.raw_payment (
    payment_id VARCHAR(20),
    payment_type VARCHAR(50),
    bank_name VARCHAR(50)
);
---------------------------------------------------------------

SHOW VARIABLES LIKE 'secure_file_priv';

SET GLOBAL local_infile = 1;
SHOW VARIABLES LIKE 'local_infile';

LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/time_dim.csv'
INTO TABLE staging.raw_time
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(time_id, date_time, hour, day, week_of_month, week_of_year, month, quarter, year);


LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/fact_table.csv'
INTO TABLE staging.raw_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_id, payment_id, customer_id, time_id, item_id, store_id,
 quantity, unit, unit_price, total_price);
------------------------------------------------------
#next for dim table
use consumer360_dw;
CREATE TABLE consumer360_dw.Dim_Customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id VARCHAR(20) UNIQUE,
    customer_name VARCHAR(100),
    contact VARCHAR(50)
);
CREATE TABLE consumer360_dw.Dim_Time (
    time_key INT AUTO_INCREMENT PRIMARY KEY,
    time_id VARCHAR(20),
    date_time DATETIME,
    hour INT,
    day INT,
    week_of_month INT,
    week_of_year INT,
    month INT,
    quarter INT,
    year INT    
);

CREATE TABLE Dim_Item (
    item_key INT AUTO_INCREMENT PRIMARY KEY,
    item_id VARCHAR(20) UNIQUE,
    item_name VARCHAR(100),
    category VARCHAR(30),
    description TEXT,
    price DECIMAL(10,2),
    manufacture_country VARCHAR(50),
    supplier VARCHAR(100),
    unit VARCHAR(20)
);

CREATE TABLE Dim_Store (
    store_key INT AUTO_INCREMENT PRIMARY KEY,
    store_id VARCHAR(20) UNIQUE,
    region VARCHAR(50),
    district VARCHAR(50),
    upazila VARCHAR(50)
);

CREATE TABLE Dim_Payments (
    payment_key INT AUTO_INCREMENT PRIMARY KEY,
    payment_id VARCHAR(20) UNIQUE,
    payment_type VARCHAR(50),
    bank_name VARCHAR(50)
);
----------------------------------------------
#load data into dim from raw
INSERT INTO dim_customer (customer_id, customer_name, contact)
SELECT DISTINCT
    customer_id,
    c_name,
    contact
FROM staging.raw_customer;

INSERT INTO consumer360_dw.dim_time
(time_id, date_time, hour, day, week_of_month, week_of_year, month, quarter, year)
SELECT
time_id,
STR_TO_DATE(date_time, '%d-%m-%Y %H:%i'),
hour,
day,
week_of_month,
week_of_year,
month,
quarter,
year
FROM staging.raw_time;

INSERT INTO dim_item (item_id, item_name, category, description, price, manufacture_country, supplier, unit)
SELECT DISTINCT
    item_id,
    item_name,
    category,
    description,
    price,
    manufacture_country,
    supplier,
    unit
FROM staging.raw_item;

INSERT INTO dim_store (store_id, region, district, upazila)
SELECT DISTINCT
    store_id,
    region,
    district,
    upazila
FROM staging.raw_store;

INSERT INTO dim_payments (payment_id, payment_type, bank_name)
SELECT DISTINCT
    payment_id,
    payment_type,
    bank_name
FROM staging.raw_payment;

select * from dim_time;
---------------------------#create fact table
CREATE TABLE Fact_Sales (
    order_id VARCHAR(20),
    
    payment_key INT,
    customer_key INT,
    time_key INT,
    item_key INT,
    store_key INT,

    quantity INT,
    unit VARCHAR(20),
    unit_price DECIMAL(10,2),
    total_price DECIMAL(10,2),

    FOREIGN KEY (customer_key) REFERENCES Dim_Customer(customer_key),
    FOREIGN KEY (time_key) REFERENCES Dim_Time(time_key),
    FOREIGN KEY (item_key) REFERENCES Dim_Item(item_key),
    FOREIGN KEY (payment_key) REFERENCES Dim_payments(payment_key),
    FOREIGN KEY (store_key) REFERENCES Dim_Store(store_key)
);

#----------------------------populate the fact table
use consumer360_dw;
INSERT INTO consumer360_dw.fact_sales
SELECT
    r.order_id,
    
    p.payment_key,
    c.customer_key,
    t.time_key,
    i.item_key,
    s.store_key,

    r.quantity,
    r.unit,
    r.unit_price,
    r.total_price
FROM staging.raw_sales r
JOIN Dim_Customer c ON r.customer_id = c.customer_id
JOIN Dim_Time t ON r.time_id = t.time_id
JOIN Dim_Item i ON r.item_id = i.item_id
JOIN Dim_payments p ON r.payment_id = p.payment_id
JOIN Dim_Store s ON r.store_id = s.store_id;

#------------------------------------------------ add index
CREATE INDEX idx_fact_customer ON Fact_Sales(customer_key);
CREATE INDEX idx_fact_time ON Fact_Sales(time_key);
CREATE INDEX idx_fact_item ON Fact_Sales(item_key);
CREATE INDEX idx_fact_store ON Fact_Sales(store_key);
CREATE INDEX idx_fact_payment ON Fact_Sales(payment_key);

CREATE INDEX idx_customer_id ON consumer360_dw.dim_customer(customer_id);
CREATE INDEX idx_item_id ON consumer360_dw.dim_item(item_id);
CREATE INDEX idx_store_id ON consumer360_dw.dim_store(store_id);
CREATE INDEX idx_time_id ON consumer360_dw.dim_time(time_id);
CREATE INDEX idx_payment_id ON consumer360_dw.dim_payments(payment_id);

DESC consumer360_dw.fact_sales;

------------------------
SELECT COUNT(*) AS invalid_customers
FROM Fact_Sales f
LEFT JOIN Dim_Customer c
ON f.customer_key = c.customer_key
WHERE c.customer_key IS NULL;
-------------------
SELECT
    s.region,
    SUM(f.total_price) AS revenue
FROM Fact_Sales f
JOIN Dim_Store s ON f.store_key = s.store_key
GROUP BY  s.region;
---------------------
SELECT
    t.year,
    SUM(f.total_price) AS revenue
FROM fact_sales f
JOIN dim_time t ON f.time_key = t.time_key
GROUP BY t.year;
-----------------------
SELECT
    s.region,
    SUM(f.total_price) AS total_revenue
FROM consumer360_dw.fact_sales f
JOIN consumer360_dw.dim_store s
    ON f.store_key = s.store_key
GROUP BY s.region;

-----------------------
SELECT
    t.month,
    SUM(f.total_price) AS total_revenue
FROM consumer360_dw.fact_sales f
JOIN consumer360_dw.dim_time t ON f.time_key = t.time_key
GROUP BY t.month;

----------------#aggrigate table
CREATE TABLE consumer360_dw.fact_sales_region_agg AS
SELECT
    s.region,
    SUM(f.total_price) AS total_revenue
FROM consumer360_dw.fact_sales f
JOIN consumer360_dw.dim_store s
  ON f.store_key = s.store_key
GROUP BY s.region;

SELECT * FROM consumer360_dw.fact_sales_region_agg;
-------------------------

CREATE INDEX idx_fact_time_price
ON consumer360_dw.fact_sales (time_key, total_price);

SELECT
    c.customer_id,
    f.order_id,
    t.date_time AS order_date,
    f.total_price
FROM consumer360_dw.fact_sales f
JOIN consumer360_dw.dim_customer c
    ON f.customer_key = c.customer_key
JOIN consumer360_dw.dim_time t
    ON f.time_key = t.time_key;
use consumer360_dw
