Restaurant Table
CREATE TABLE Restaurant (
    RestaurantID INTEGER PRIMARY KEY,
    RestaurantName VARCHAR2(150) NOT NULL,
    OpenTime DATE,
    CloseTime DATE
);

Customer Table
CREATE TABLE Customer (
    CustomerID INTEGER PRIMARY KEY,
    CustomerName VARCHAR2(100) NOT NULL,
    PhoneNumber VARCHAR2(10)
);

Admin Table
CREATE TABLE Admin (
    AdminID INTEGER PRIMARY KEY,
    AdminName VARCHAR2(100) NOT NULL,
    Email VARCHAR2(100),
    PhoneNumber VARCHAR2(100)
);

-- Menu Table
CREATE TABLE Menu (
    MenuID INTEGER PRIMARY KEY,
    MenuName VARCHAR2(150) NOT NULL,
    Price NUMBER(10, 2),
    RestaurantID INTEGER NOT NULL,
    CONSTRAINT fk_restaurant FOREIGN KEY (RestaurantID) REFERENCES Restaurant(RestaurantID)
);

-- "Order" Table (Order is a reserved keyword in some systems, using Quotes or renaming)
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    OrderDateTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PickupTime TIMESTAMP,
    Status VARCHAR2(30),
    CustomerID INTEGER NOT NULL,
    CONSTRAINT fk_customer_order FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

-- OrderDetail Table
CREATE TABLE OrderDetail (
    OrderDetailID INTEGER PRIMARY KEY,
    Quantity INTEGER NOT NULL,
    OrderID INTEGER NOT NULL,
    MenuID INTEGER NOT NULL,
    CONSTRAINT fk_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    CONSTRAINT fk_menu FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)
);

-- Payment Table
CREATE TABLE Payment (
    PaymentID INTEGER PRIMARY KEY,
    Amount NUMBER(10, 2) NOT NULL,
    PaymentMethod VARCHAR2(50),
    PaymentStatus VARCHAR2(30),
    OrderID INTEGER NOT NULL,
    CONSTRAINT fk_payment_order FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Review Table
CREATE TABLE Review (
    ReviewID INTEGER PRIMARY KEY,
    Rating INTEGER CHECK (Rating BETWEEN 1 AND 5),
    Comments CLOB,
    CustomerID INTEGER NOT NULL,
    MenuID INTEGER NOT NULL,
    CONSTRAINT fk_customer_review FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    CONSTRAINT fk_menu_review FOREIGN KEY (MenuID) REFERENCES Menu(MenuID)
);

-- Sequences for Auto-increment (Oracle doesn't have AUTO_INCREMENT like MySQL)
CREATE SEQUENCE restaurant_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE customer_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE admin_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE menu_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE order_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE order_detail_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE payment_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;