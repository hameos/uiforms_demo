CREATE TABLE customer (
    id INT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    title VARCHAR(10) NOT NULL,
    email VARCHAR(250) NOT NULL,
    address VARCHAR(1000) NOT NULL,
    city VARCHAR(100) NOT NULL,
    zip_code VARCHAR(50),
    phone_number VARCHAR(100) NOT NULL,
    notes VARCHAR(1000),
    history VARCHAR(10000),
    PRIMARY KEY (id)
) ENGINE = InnoDB;

LOAD DATA INFILE '/data/customers.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
IGNORE 1 ROWS;
