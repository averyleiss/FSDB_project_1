-- =============================================================
-- Authors: Avery Leiss, Chloe Lerch, and Salma Bhar
-- Submission Date: 1 March 2024
-- Description: Files and Databases: Project 1
    -- Creating all the tables from our ER diagram
    -- Adding all the attributes, their types and foreign keys      
-- =============================================================



------------ PRODUCT ------------
-- ADD CHECKS =============================================================
CREATE TABLE PRODUCT (
    prod_id VARCHAR(20)
        ADD CONSTRAINT product_pk PRIMARY KEY(prod_id),
    name VARCHAR(50),
    coffea VARCHAR(20),
    varietal VARCHAR(30),
    origin VARCHAR(15),
    roast_type VARCHAR(30),
    decaf BOOLEAN,
    track VARCHAR(20)
        ADD CONSTRAINT fk_track_product 
        FOREIGN KEY(track) REFERENCES TRACK(track_id), 
    retail_price VARCHAR(14),
    format_id VARCHAR(20) 
        ADD CONSTRAINT fk_format_id_product 
        FOREIGN KEY (format_id) REFERENCES FORMAT(format_id), 
);

------------ TRACK ------------
CREATE TABLE TRACK (
    track_id VARCHAR(20) 
        ADD CONSTRAINT pk_track_id PRIMARY KEY(track_id),
    barcode VARCHAR(15),
    packg_desc VARCHAR(100),
    retail_price VARCHAR(20),
    stock VARCHAR(20) 
        ADD CONSTRAINT fk_stock_id_track 
        FOREIGN KEY(stock) REFERENCES STOCK(stock_id),
    order_info VARCHAR(20)
        ADD CONSTRAINT fk_order_info_track 
        FOREIGN KEY(order_info) REFERENCES ORDER_INFO(order_id),
    format VARCHAR(20)
        ADD CONSTRAINT fk_format_id_track 
        FOREIGN KEY(format) REFERENCES FORMAT(format_id),
);

------------ STOCK ------------
-- ADD CHECKS =============================================================
CREATE TABLE STOCK (
    stock_id VARCHAR(20) 
        ADD CONSTRAINT stock_pk PRIMARY KEY(stock_id),
    avail_units VARCHAR(10),
    min_thrshld VARCHAR(10),
    max_thrshld VARCHAR(10),
    min_stock VARCHAR(10)
);

------------ FORMAT ------------
-- ADD CHECKS =============================================================
CREATE TABLE FORMAT (
    format_id VARCHAR(20) 
        ADD CONSTRAINT pk_format_id PRIMARY KEY(format_id),
    weight VARCHAR(20),
    volume VARCHAR(20)
);

------------ ORDER_INFO ------------
CREATE TABLE ORDER_INFO (
    order_id VARCHAR(20)
        ADD CONSTRAINT pk_order_id_order_info PRIMARY KEY(order_id),
    cust_id VARCHAR(20)
        ADD CONSTRAINT fk_cust_id_order_info 
        FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
    bill_id VARCHAR(20)
        ADD CONSTRAINT fk_bill_id_order_info 
        FOREIGN KEY(bill_id) REFERENCES BILLING(bill_id),
    ship_add VARCHAR(10),
    deliv_date VARCHAR(10),
);

------------ PURCHASES ------------
CREATE TABLE PURCHASES (
    purchase_id VARCHAR(20) 
        ADD CONSTRAINT pk_purchase_id 
        PRIMARY KEY(purchase_id),
    order_id VARCHAR(20)
        ADD CONSTRAINT fk_order_id_purchases 
        FOREIGN KEY(order_id) REFERENCES ORDER_INFO(order_id),
    cust_id VARCHAR(20)
        ADD CONSTRAINT fk_cust_id_purchases 
        FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
);

------------ BILLING ------------
-- ADD CHECKS =============================================================
CREATE TABLE BILLING (
    bill_id VARCHAR(20) 
        ADD CONSTRAINT pk_bill_id_billing PRIMARY KEY(bill_id),
    cust_id VARCHAR(20)
        ADD CONSTRAINT fk_cust_id_billing FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
    cc_id VARCHAR(20)
        ADD CONSTRAINT fk_cc_id_billing FOREIGN KEY(cc_id) REFERENCES CREDIT_CARD(cc_id),
    pymnt_type VARCHAR(40),
    pymnt_date VARCHAR(10),
    bill_add VARCHAR(10),
);

------------ CREDIT_CARD ------------
CREATE TABLE CREDIT_CARD (
    cc_id VARCHAR(20) 
        ADD CONSTRAINT pk_cc_id PRIMARY KEY(cc_id),
    cust_id VARCHAR(20)
        ADD CONSTRAINT fk_cc_cust_id 
        FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
    cc_num VARCHAR(20),
    exp_date VARCHAR(10),
    fin_comp VARCHAR(30),
    FOREIGN KEY (cust_id) REFERENCES Customer(cust_id),
    cardholder VARCHAR(30);
);

------------ CUSTOMER ------------
-- ADD CHECKS =============================================================
CREATE TABLE CUSTOMER (
    cust_id VARCHAR(20) 
        ADD CONSTRAINT pk_cust_id PRIMARY KEY(cust_id),
    add_id VARCHAR(20)
        ADD CONSTRAINT fk_add_id_customer 
        FOREIGN KEY(add_id) REFERENCES ADDRESS(add_id),
    bill_info VARCHAR(20)
        ADD CONSTRAINT fk_bill_info_customer 
        FOREIGN KEY(bill_info) REFERENCES BILLING(bill_id),
    login_id VARCHAR(10),
    email VARCHAR(100),
    phone VARCHAR(15),
);

------------ ADDRESS ------------
-- ADD CHECKS (optional gtwy etc) =============================================================
CREATE TABLE ADDRESS (
    add_id VARCHAR(20) 
        ADD CONSTRAINT pk_add_id PRIMARY KEY(add_id),
    cust_id VARCHAR(20)
        ADD CONSTRAINT fk_cust_id_add 
        FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
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
);

------------ LOGIN_DATA ------------
CREATE TABLE LOGIN_DATA (
    login_id VARCHAR(20) 
        ADD CONSTRAINT pk_login_id PRIMARY KEY(login_id),
    personal_data VARCHAR(20)
        ADD CONSTRAINT fk_personal_data_login_data 
        FOREIGN KEY(personal_data) REFERENCES PERSONAL_DATA(pd_id),
    username VARCHAR(50),
    passwd VARCHAR(50),
    reg_date VARCHAR(10),
    reg_time VARCHAR(10),
);

------------ PERSONAL_DATA ------------
-- ADD CHECKS (optional surname 2) =============================================================
CREATE TABLE PERSONAL_DATA (
    pd_id VARCHAR(20) 
        ADD CONSTRAINT pk_pd_id PRIMARY KEY(pd_id),
    contact_info VARCHAR(20)
        ADD CONSTRAINT fk_contact_info_personal_data 
        FOREIGN KEY(contact_info) REFERENCES CONTACT_INFO(cont_id),
    name VARCHAR(15),
    surname VARCHAR(20),
    surname_2 VARCHAR(20) NULL,
);

------------ CONTACT_INFO ------------
-- ADD CHECKS =============================================================
CREATE TABLE CONTACT_INFO (
    cont_id VARCHAR(20) 
        ADD CONSTRAINT pk_cont_id PRIMARY KEY(cont_id),
    add_id VARCHAR(20)
        ADD CONSTRAINT fk_add_id_contact_info 
        FOREIGN KEY(add_id) REFERENCES ADDRESS(add_id),
    cc_id VARCHAR(20)
        ADD CONSTRAINT fk_cc_id_contact_info
        FOREIGN KEY(cc_id) REFERENCES CREDIT_CARD(cc_id),
    loyalty_id VARCHAR(20)
        ADD CONSTRAINT fk_loyalty_id_contact_info
        FOREIGN KEY(loyalty_id) REFERENCES LOYALTY_DISC(loyalty_id),
    purchases VARCHAR(20)
        ADD CONSTRAINT fk_purchase_id_contact_info 
        FOREIGN KEY(purchases) REFERENCES PURCHASES(purchase_id),
    phone VARCHAR(15) NULL,
    email VARCHAR(30) NULL,
    contact_pref VARCHAR(20),
);

------------ LOYALTY_DISC ------------
-- ADD CHECKS (type? in here and in code but not in er diag) =============================================================
CREATE TABLE LOYALTY_DISC (
    loyalty_id VARCHAR(20) 
        ADD CONSTRAINT pk_loyalty_id PRIMARY KEY(loyalty_id),
    percent_disc VARCHAR(5),
    disc_date VARCHAR(10),
    disc_counter VARCHAR(20),
    type VARCHAR(50) 
);

------------ POST ------------
-- ADD CHECKS (also, score /1?))=============================================================
CREATE TABLE POST (
    post_id VARCHAR(20)
        ADD CONSTRAINT pk_post_id PRIMARY KEY(prod_id),
    prod_id VARCHAR(20)
        ADD CONSTRAINT fk_prod_id_post 
        FOREIGN KEY(prod_id) REFERENCES PRODUCT(prod_id),
    cust_id VARCHAR(20) 
        ADD CONSTRAINT fk_cust_id_post 
        FOREIGN KEY(cust_id) REFERENCES CUSTOMER(cust_id),
    username VARCHAR(30), 
    post_date VARCHAR(14), 
    post_time VARCHAR(14),
    title VARCHAR(50), 
    text VARCHAR(2000),
    score VARCHAR(1),
    likes VARCHAR(9),
    endorsed VARCHAR(50)
);


