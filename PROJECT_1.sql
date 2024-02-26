-- Creating all the tables from the ER diagram
-- Adding all the attributes, their types and foreign keys
CREATE TABLE Product (
    prod_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(50),
    coffea VARCHAR(20),
    varietal VARCHAR(30),
    origin VARCHAR(15),
    roast_type VARCHAR(30),
    decaf BOOLEAN,
    marketing VARCHAR(30),
    track VARCHAR(20),
    FOREIGN KEY (track) REFERENCES Track(track_id)
);

CREATE TABLE Track (
    track_id VARCHAR(20) PRIMARY KEY,
    barcode VARCHAR(15),
    packg_desc VARCHAR(100),
    retail_price VARCHAR(20),
    stock INT,
    order_info VARCHAR(20),
    format VARCHAR(20),
    FOREIGN KEY (order_info) REFERENCES OrderInfo(order_id),
    FOREIGN KEY (format) REFERENCES Format(format_id)
);

CREATE TABLE Stock (
    stock_id VARCHAR(20) PRIMARY KEY,
    avail_units VARCHAR(10),
    min_thrshld VARCHAR(10),
    max_thrshld VARCHAR(10),
    min_stock VARCHAR(10)
);

CREATE TABLE Format (
    format_id VARCHAR(20) PRIMARY KEY,
    weight VARCHAR(20),
    volume VARCHAR(20)
);

CREATE TABLE Order_Info (
    order_id VARCHAR(20) PRIMARY KEY,
    cust_id VARCHAR(20),
    bill_id VARCHAR(20),
    ship_add VARCHAR(10),
    deliv_date VARCHAR(10),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    FOREIGN KEY (bill_id) REFERENCES BillingInformation(bill_id)
);

CREATE TABLE Purchases (
    purchase_id VARCHAR(20) PRIMARY KEY,
    order_id VARCHAR(20),
    cust_id VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES Order_Info(order_id),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Billing (
    bill_id VARCHAR(20) PRIMARY KEY,
    cust_id VARCHAR(20),
    cc_id VARCHAR(20),
    pymnt_type VARCHAR(40),
    pymnt_date VARCHAR(10),
    bill_add VARCHAR(10),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    FOREIGN KEY (cc_id) REFERENCES CreditCard(cc_id)
);

CREATE TABLE Credit_Card (
    cc_id VARCHAR(20) PRIMARY KEY,
    cust_id VARCHAR(20),
    cc_num VARCHAR(20),
    exp_date VARCHAR(10),
    fin_comp VARCHAR(30),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Customer (
    cust_id VARCHAR(20) PRIMARY KEY,
    add_id VARCHAR(20),
    bill_info VARCHAR(20),
    login_id VARCHAR(10),
    email VARCHAR(100),
    phone VARCHAR(15),
    FOREIGN KEY (add_id) REFERENCES Address(add_id),
    FOREIGN KEY (bill_info) REFERENCES Billing(bill_id)
);

CREATE TABLE Address (
    add_id VARCHAR(20) PRIMARY KEY,
    cust_id VARCHAR(20),
    street VARCHAR(30),
    town VARCHAR(10),
    zip VARCHAR(10),
    country VARCHAR(15),
    type VARCHAR(20),
    gtwy VARCHAR(20) NULL,
    block_num VARCHAR(20) NULL,
    stair_id VARCHAR(20) NULL,
    floor VARCHAR(20) NULL,
    door VARCHAR(20) NULL,
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id)
);

CREATE TABLE Login_Data (
    login_id VARCHAR(20) PRIMARY KEY,
    personal_data VARCHAR(20),
    username VARCHAR(50),
    passwd VARCHAR(50),
    reg_date VARCHAR(10),
    reg_time VARCHAR(10),
    FOREIGN KEY (personal_data) REFERENCES Customer(cust_id)
);

CREATE TABLE Personal_Data (
    pd_id VARCHAR(20) PRIMARY KEY,
    contact_info VARCHAR(20),
    name VARCHAR(15),
    surname VARCHAR(20),
    surname_2 VARCHAR(20) NULL,
    FOREIGN KEY (contact_info) REFERENCES Customer(cust_id)
);

CREATE TABLE Contact_Info (
    cont_id VARCHAR(20) PRIMARY KEY,
    add_id VARCHAR(20),
    cc_id VARCHAR(20),
    loyalty_id VARCHAR(20) NULL,
    purchases VARCHAR(20),
    phone VARCHAR(15) NULL,
    email VARCHAR(30) NULL,
    contact_pref VARCHAR(20),
    FOREIGN KEY (add_id) REFERENCES Address(add_id),
    FOREIGN KEY (cc_id) REFERENCES Customer(cust_id),
    FOREIGN KEY (loyalty_id) REFERENCES LoyaltyProgram(loyalty_id),
    FOREIGN KEY (purchases) REFERENCES PurchaseHistory(purchase_id)
);

CREATE TABLE Loyalty_Disc (
    loyalty_id VARCHAR(20) PRIMARY KEY,
    percent_disc VARCHAR(5),
    disc_date VARCHAR(10),
    disc_counter INT,
    type VARCHAR(50) 
);

CREATE TABLE Opinion (
    op_id VARCHAR(20) PRIMARY KEY,
    prod_id VARCHAR(20),
    score VARCHAR(10),
    op_text VARCHAR(100),
    likes VARCHAR(10),
    endorsement VARCHAR(30),
    FOREIGN KEY (prod_id) REFERENCES Product(prod_id)
);


