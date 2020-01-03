
DROP database IF  EXISTS bikedemo;

CREATE DATABASE  IF NOT EXISTS bikedemo CHARSET = utf8 COLLATE = utf8_general_ci;

USE bikedemo;

 
CREATE TABLE Customer_Details(
  Customer_ID int(10) NOT NULL,
  Lname varchar(40) NOT NULL,
  Fname varchar(40) NOT NULL,
  Address varchar(40) NOT NULL,
  County varchar(40) NOT NULL,
  DOB date,
  Joined date NOT NULL,
  PRIMARY KEY (Customer_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

 -- Drop table   Customers;

CREATE TABLE Customers(
  Customer_ID int(10) NOT NULL,
  Username varchar(40) NOT NULL,
  Pass_word varchar(40) NOT NULL,
  Email varchar(50) DEFAULT NULL,
  Phone varchar(20) DEFAULT NULL,
  PRIMARY KEY (Customer_ID),
  FOREIGN KEY (Customer_ID) REFERENCES Customer_Details(Customer_ID)
)ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Payment_Method(
  Method_ID int(10) NOT NULL,
  Method varchar(40) NOT NULL,
  Account_No varchar(40) NOT NULL,
  Bank varchar(50) NOT NULL,
  Address varchar(50) NOT NULL,
  Subscription varchar(50) NOT NULL,
  PRIMARY KEY (Method_ID)
)ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Payments(
  Payment_ID int(10) NOT NULL,
  Customer_ID int (10) NOT NULL,
  Method_ID int(10) NOT NULL,
  Rate decimal (10,2) NOT NULL,
  Date_stamp date NOT NULL,
  Time_stamp varchar(50) NOT NULL,
  Amount decimal (7, 2) NOT NULL,
  PRIMARY KEY (Payment_ID),
  KEY Payments_FK_customer (Customer_ID),
  KEY Payments_FK_method (Method_ID),
  CONSTRAINT Payments_FK_customer FOREIGN KEY (Customer_ID ) REFERENCES Customers (Customer_ID ),
  CONSTRAINT Payments_FK_method FOREIGN KEY (Method_ID ) REFERENCES Payment_Method (Method_ID )
)ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Staff(
  Staff_ID int(10) NOT NULL,
  Lname varchar(40) NOT NULL,
  Fname varchar(40) NOT NULL,
  Address varchar(40) NOT NULL,
  County varchar(40) NOT NULL,
  Phone varchar(40) NOT NULL,
  DOB date NOT NULL,
  Joined date NOT NULL,
  PRIMARY KEY (Staff_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Stations (
    Station_ID INT(10) NOT NULL,
    External_ID VARCHAR(36) CHARACTER SET utf8,
    Name VARCHAR(45) CHARACTER SET utf8,
    Short_Name VARCHAR(7) CHARACTER SET utf8,
    Lat NUMERIC(17, 15),
    Lon NUMERIC(16, 14),
    Region_ID INT,
    Rental_Method VARCHAR(14) CHARACTER SET utf8,
    Capacity INT,
    Rental_URL VARCHAR(58) CHARACTER SET utf8,
    Electric_Bike_Waiver VARCHAR(5) CHARACTER SET utf8,
    Has_Key_Dispenser VARCHAR(5) CHARACTER SET utf8,
    Station_Services VARCHAR(15) CHARACTER SET utf8,
    Has_Kiosk VARCHAR(4) CHARACTER SET utf8,
	PRIMARY KEY (Station_ID)

);
Use bikedemo;
  Drop Table if exists Station_Status;
CREATE TABLE Station_Status(
  S_Status_ID int(10) NOT NULL AUTO_INCREMENT,
  Station_ID int NOT NULL,
  S_Status varchar(40) NOT NULL,
  Capacity int(3) NOT NULL,
  Parking int(3) NOT NULL,
  Bikes int(3) NOT NULL,
  Updated timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (S_Status_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Vans(
  Licence_ID varchar(10) NOT NULL ,
  Station_ID int NOT NULL,
  Staff_ID int NOT NULL,
  Date_stamp date NOT NULL,
  Bikes int(3) NOT NULL,
  Station_end varchar(50) NOT NULL,
  PRIMARY KEY (Licence_ID),
  KEY Staff_FK (Staff_ID),
  CONSTRAINT Staff_FK  FOREIGN KEY (Staff_ID ) REFERENCES Staff (Staff_ID )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Bikes(
  Bike_ID int(10) NOT NULL,
  Station_ID int NOT NULL,
  Model date NOT NULL,
  PRIMARY KEY (Bike_ID)
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Bike_Status(
  B_Status_ID int(10) NOT NULL AUTO_INCREMENT,
  Bike_ID int NOT NULL,
  B_Status varchar(40) NOT NULL DEFAULT "Operational",
  Last_Station int NOT NULL DEFAULT "0" ,
  Distance decimal (10,2) NOT NULL DEFAULT "10",
  Mileage decimal(10, 2) NOT NULL DEFAULT "0",
  PRIMARY KEY (B_Status_ID),
  KEY Bike_FK_status (Bike_ID),
  CONSTRAINT Bike_FK_status  FOREIGN KEY (Bike_ID ) REFERENCES Bikes (Bike_ID )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Repairs(
  Repair_ID int(10) NOT NULL,
  B_Status_ID int NOT NULL,
  Staff_ID int NOT NULL,
  Delivered date NOT NULL,
  Price decimal(9,2) NOT NULL,
  Parts int(5) NOT NULL,
  PRIMARY KEY (Repair_ID),
  KEY Staff_FK_repair (Staff_ID),
  KEY B_Status_FK_repair (B_Status_ID),
  CONSTRAINT B_Status_FK_repair  FOREIGN KEY (B_Status_ID) REFERENCES Bike_Status (B_Status_ID),
  CONSTRAINT Staff_FK_repair  FOREIGN KEY (Staff_ID ) REFERENCES Staff (Staff_ID )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

Use bikedemo;
  Drop Table if exists Bike_Rentals;
CREATE TABLE Bike_Rentals(
  Rental_ID int(10) NOT NULL,
  Customer_ID int NOT NULL,
  Bike_ID int NOT NULL,
  Payment_ID int NOT NULL,
  Station_ID int NOT NULL,
  Start_Time varchar(50) NOT NULL,
  End_Time varchar(50) NOT NULL,
  Start_Station int NOT NULL,
  End_Station int NOT NULL,
  PRIMARY KEY (Rental_ID),
  KEY Customer_FK_rent (Customer_ID),
  KEY Payment_FK_rent (Payment_ID),
  KEY Bike_FK_rent (Bike_ID),
  CONSTRAINT Customer_FK_rent  FOREIGN KEY (Customer_ID ) REFERENCES Customers (Customer_ID ),
  CONSTRAINT Payment_FK_rent  FOREIGN KEY (Payment_ID ) REFERENCES Payments (Payment_ID ),
  CONSTRAINT Bike_FK_rent  FOREIGN KEY (Bike_ID ) REFERENCES Bikes (Bike_ID )
)ENGINE = InnoDB DEFAULT CHARSET = utf8;

CREATE TABLE Old_Staff(
  Old_Staff_ID INT NOT NULL auto_increment,
  Staff_ID int(10) NOT NULL,
  Lname varchar(40) NOT NULL,
  Fname varchar(40) NOT NULL,
  Address varchar(40) NOT NULL,
  County varchar(40) NOT NULL,
  Phone varchar(40) NOT NULL,
  DOB date NOT NULL,
  Joined date NOT NULL,
  PRIMARY KEY (Old_Staff_ID),
  KEY Staff_FK_old (Staff_ID),
  CONSTRAINT Staff_FK_OLD  FOREIGN KEY (Staff_ID ) REFERENCES Staff (Staff_ID )
) ENGINE = InnoDB DEFAULT CHARSET = utf8;


insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (2, 'Lane', 'Arthur', '8854 Kirkland Street ', 'United States', '1946-11-05', '2012-05-18'); 
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (3, 'Bailey', 'Carl', '970 Lillian Drive', 'United States', '1954-07-07', '2012-10-15');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (4, 'Murray', 'Lori', '148 Victoria Parkway', 'United States', '1990-01-14', '2013-09-13');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (5, 'Lewis', 'Nicole', '9 Washington Trail', 'United States', '1981-10-14', '2013-01-20');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (6, 'Hall', 'Carol', '7298 Hanover Street ', 'United States', '1934-06-18', '2011-07-04');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (7, 'Carroll', 'Carol', '16 Bedford Ave. ', 'United States', '1930-05-01', '2015-10-09');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (8, 'Daniels', 'Todd', '9752 E. Evergreen St. ', 'United States', '1944-12-24', '2013-08-08');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (9, 'Flores', 'Debra', '709 South Golf St. ', 'United States', '1953-02-13', '2016-05-17');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (10, 'Reid', 'Evelyn', '62 2nd Avenue', 'United States', '1962-01-07', '2016-10-10');
insert into Customer_Details (Customer_ID, Lname, Fname, Address, County, DOB, Joined) values (11, 'Watkins', 'Lillian', '90 Canal St', 'United States', '1994-05-15', '2014-05-19');    

insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (2, 'g@rdz', 't2hlBwO5i2bT', 'zachgardner@amz.net', '7-(202)256-3821');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (3, 'l0ctr!nh', 'CCch4ln', 'loctr@amz.com', '(720)876-7624');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (4, 'jnelson2', '1I7h500Y', 'mhicks2@yellowpages.com', '(342)834-7891');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (5, 'cholmes3', 'dOmYs7znu', 'ryoung3@unblog', '(517)172-1820');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (6, 'tpierce4', 'P9ZMck', 'loliver4@sbwire.com', '(209)278-7822');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (7, 'wlong5', 'IR2tqayJ', 'ewalker5@abc.net', '(212)824-7249');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (8, 'sgomez6', 'IpzDPeAmz0I', 'wryan6@phpbb.com', '(842)147-9547');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (9, 'jmason7', 'R1nHWzPHkLnr', 'thunter7@dailymotion.com', '(463)783-4797');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (10, 'ekelly8', 'xOIrtSToskF6', 'clynch8@walmart.com', '(139)662-2063');
insert into Customers (Customer_ID, Username, Pass_word, Email, Phone) values (11, 'jfisher9', 'G4iYceHSsy', 'dpatterson9@123-reg.co.uk', '(602)907-2261');    

insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (2, 'americanexpress', 'GB46 WZGX 5802 2377 9984 02', 'Jones-Ritchie', '655 Butternut Alley', 'L');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (3, 'jcb', 'SK70 1477 3896 9950 3644 4474', 'Muller, Treutel and Schmeler', '8636 Sage Trail', 'L');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (4, 'jcb', 'RO61 UVTO YY95 DZVR 45HJ GJLR', 'Flatley-Pfannerstill', '65082 Warbler Hill', 'M');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (5, 'mastercard', 'HU68 9740 5913 8971 2266 9709 7531', 'Rosenbaum, Gutkowski and Dare', '41947 Dayton Drive', '2XL');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (6, 'instapayment', 'PL36 5634 9132 0596 4161 1527 6358', 'Sauer LLC', '06596 Lien Circle', 'M');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (7, 'mastercard', 'MD57 IVXG OBMZ MVJS MLXJ ADMH', 'Bergnaum-Simonis', '31 Elka Place', 'XL');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (8, 'instapayment', 'LB36 0858 NUNL 1CIH IJS4 DFET TIVS', 'Bernier-Maggio', '42295 Butternut Circle', '3XL');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (9, 'jcb', 'FO49 3224 3961 2425 50', 'Medhurst and Sons', '918 Gateway Park', 'S');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (10, 'bankcard', 'CZ58 7610 9220 8817 6130 9000', 'Schimmel, Marks and Grady', '42 Delladonna Plaza', 'S');
insert into Payment_Method (Method_ID, Method, Account_No, Bank, Address, Subscription) values (11, 'jcb', 'HR85 3139 0015 3167 4499 5', 'Wolff-Hilpert', '7 Lakewood Gardens Crossing', '2XL');  

insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (2, 2, 2, 3.13, '2004-04-23', '10:49', 7.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (3, 3, 3, 3.15, '2010-09-22', '21:00', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (4, 4, 4, 3.1, '2011-03-09', '20:42', 5.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (5, 5, 5, 3.07, '2005-06-26', '13:49', 8.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (6, 6, 6, 3.1, '2007-06-26', '12:54', 8.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (7, 7, 7, 3.12, '2001-10-02', '15:57', 6.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (8, 8, 8, 3.06, '2003-12-24', '10:25', 5.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (9, 9, 9, 3.09, '2015-08-04', '11:57', 4.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (10, 10, 10, 3.07, '2004-01-21', '19:06', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID, Rate, Date_stamp, Time_stamp, Amount) values (11, 10, 11, 3.13, '2008-09-07', '12:20', 5.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (12, 7, 11, 3.57, '2015-07-13', '8:37 PM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (13, 4, 2, 4.47, '2017-03-10', '10:27 PM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (14, 4, 7, 4.39, '2015-08-31', '8:49 AM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (15, 4, 8, 3.7, '2015-09-22', '12:17 PM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (16, 8, 7, 3.89, '2016-02-15', '6:23 PM', 3.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (17, 9, 4, 3.64, '2016-07-25', '3:08 PM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (18, 5, 6, 3.82, '2015-06-25', '11:52 AM', 3.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (19, 11, 9, 4.37, '2015-02-06', '1:53 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (20, 9, 3, 4.04, '2016-02-20', '10:39 AM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (21, 3, 8, 3.32, '2015-02-11', '3:50 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (22, 2, 8, 4.05, '2016-02-08', '9:05 AM', 3.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (23, 10, 6, 3.23, '2016-07-06', '10:58 PM', 4.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (24, 3, 8, 3.8, '2016-06-14', '10:15 PM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (25, 3, 5, 3.29, '2016-06-04', '9:54 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (26, 11, 11, 3.5, '2017-02-04', '7:35 AM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (27, 8, 7, 3.74, '2015-12-25', '7:47 PM', 4.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (28, 11, 7, 3.29, '2017-03-07', '12:41 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (29, 4, 8, 4.48, '2016-05-05', '4:27 PM', 3.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (30, 6, 8, 4.41, '2017-02-23', '9:05 AM', 4.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (31, 10, 7, 3.25, '2016-09-26', '6:09 AM', 3.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (32, 9, 7, 3.85, '2016-12-21', '8:08 AM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (33, 3, 4, 3.89, '2016-05-19', '12:22 PM', 2.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (34, 10, 11, 3.9, '2015-06-19', '7:20 AM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (35, 8, 5, 3.15, '2016-12-23', '8:25 PM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (36, 2, 6, 3.99, '2016-09-08', '1:02 PM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (37, 7, 4, 3.58, '2015-05-07', '6:56 PM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (38, 9, 5, 4.4, '2016-04-25', '8:48 PM', 4.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (39, 5, 7, 3.37, '2016-04-12', '3:01 PM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (40, 6, 11, 3.71, '2015-03-09', '7:41 PM', 3.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (41, 10, 2, 3.59, '2017-02-06', '10:52 AM', 4.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (42, 8, 8, 4.18, '2016-08-13', '8:18 AM', 3.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (43, 4, 3, 3.6, '2015-09-10', '11:51 AM', 2.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (44, 4, 4, 3.33, '2017-04-08', '10:27 PM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (45, 9, 4, 3.46, '2015-07-01', '12:44 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (46, 4, 11, 4.27, '2015-03-17', '12:41 PM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (47, 6, 9, 3.29, '2015-12-03', '1:29 PM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (48, 5, 8, 4.04, '2015-01-27', '8:08 PM', 2.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (49, 10, 6, 3.9, '2015-04-20', '2:07 PM', 3.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (50, 10, 6, 3.06, '2015-01-17', '7:07 AM', 3.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (51, 5, 10, 3.04, '2016-02-28', '4:38 PM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (52, 2, 7, 3.66, '2016-03-15', '6:44 PM', 2.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (53, 11, 3, 3.42, '2016-08-01', '2:21 PM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (54, 9, 2, 3.37, '2016-04-21', '3:00 PM', 3.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (55, 10, 3, 3.8, '2015-05-14', '12:55 PM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (56, 4, 2, 3.15, '2015-03-26', '8:55 AM', 2.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (57, 4, 4, 4.38, '2016-03-23', '7:35 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (58, 4, 9, 3.95, '2016-10-03', '10:30 PM', 2.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (59, 5, 3, 4.32, '2016-06-12', '1:07 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (60, 4, 8, 4.14, '2017-04-14', '6:48 PM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (61, 9, 8, 3.89, '2017-04-08', '11:25 AM', 3.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (62, 5, 3, 3.1, '2016-06-12', '10:30 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (63, 8, 10, 3.81, '2016-07-16', '7:29 PM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (64, 4, 3, 4.48, '2017-03-03', '10:37 PM', 3.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (65, 11, 5, 3.27, '2015-01-05', '2:56 PM', 4.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (66, 6, 11, 3.23, '2016-02-09', '5:43 PM', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (67, 7, 3, 3.02, '2017-03-31', '2:16 PM', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (68, 10, 11, 3.15, '2016-01-30', '1:49 PM', 2.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (69, 8, 9, 4.48, '2015-06-01', '11:44 AM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (70, 7, 11, 3.24, '2017-03-06', '3:51 PM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (71, 4, 9, 4.35, '2016-11-03', '6:36 PM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (72, 5, 2, 3.53, '2015-08-20', '7:23 AM', 4.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (73, 8, 8, 3.04, '2016-06-20', '9:05 PM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (74, 5, 4, 3.69, '2015-05-24', '10:31 PM', 3.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (75, 10, 7, 3.25, '2016-09-16', '2:42 PM', 3.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (76, 6, 11, 3.01, '2016-11-05', '10:05 AM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (77, 7, 8, 4.14, '2016-01-11', '5:37 PM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (78, 8, 6, 3.06, '2015-08-25', '10:15 AM', 4.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (79, 6, 11, 3.65, '2016-02-02', '4:08 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (80, 3, 8, 3.07, '2015-03-23', '7:10 AM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (81, 5, 10, 3.88, '2016-09-27', '9:50 AM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (82, 4, 10, 3.48, '2017-01-27', '10:05 PM', 3.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (83, 3, 3, 3.64, '2017-01-01', '8:39 AM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (84, 7, 2, 4.25, '2017-02-05', '10:24 AM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (85, 4, 11, 3.1, '2017-03-31', '4:30 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (86, 2, 6, 3.79, '2016-07-23', '5:39 PM', 2.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (87, 7, 7, 3.64, '2015-04-14', '8:11 PM', 4.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (88, 9, 4, 3.74, '2015-07-11', '1:08 PM', 3.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (89, 6, 3, 3.53, '2015-02-16', '9:00 AM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (90, 6, 5, 3.05, '2015-09-11', '12:06 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (91, 8, 4, 3.5, '2015-03-26', '7:46 PM', 3.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (92, 5, 5, 3.89, '2015-08-01', '4:22 PM', 3.76);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (93, 3, 7, 3.68, '2015-08-05', '12:26 PM', 3.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (94, 2, 2, 3.13, '2015-02-09', '6:00 PM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (95, 9, 2, 3.2, '2017-02-23', '10:04 PM', 4.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (96, 7, 8, 3.53, '2015-01-27', '12:31 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (97, 8, 5, 3.6, '2015-09-03', '5:57 PM', 4.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (98, 3, 11, 3.66, '2015-08-10', '7:15 AM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (99, 7, 5, 3.31, '2016-12-16', '9:18 AM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (100, 4, 2, 3.15, '2017-02-14', '10:07 AM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (101, 4, 3, 4.1, '2016-03-08', '9:08 PM', 3.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (102, 4, 7, 4.27, '2015-10-05', '7:47 AM', 2.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (103, 11, 10, 4.42, '2015-04-03', '12:52 PM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (104, 4, 9, 3.18, '2015-06-12', '7:58 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (105, 4, 10, 3.76, '2015-09-26', '8:25 PM', 4.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (106, 3, 9, 3.51, '2016-09-25', '8:26 PM', 4.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (107, 11, 8, 3.06, '2017-01-10', '2:55 PM', 3.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (108, 2, 3, 4.29, '2015-01-23', '10:36 AM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (109, 4, 11, 3.71, '2015-01-18', '10:05 AM', 3.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (110, 10, 8, 3.74, '2015-05-23', '4:48 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (111, 3, 3, 3.79, '2015-10-08', '10:26 AM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (112, 2, 11, 3.43, '2016-06-30', '11:57 AM', 3.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (113, 4, 3, 4.25, '2016-02-19', '2:46 PM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (114, 7, 11, 3.25, '2015-11-26', '12:38 PM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (115, 2, 6, 4.39, '2015-04-10', '1:38 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (116, 7, 11, 4.14, '2015-10-14', '6:46 AM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (117, 8, 9, 3.63, '2015-09-22', '10:52 AM', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (118, 5, 4, 3.95, '2015-11-15', '7:47 PM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (119, 7, 2, 4.46, '2016-08-28', '8:49 AM', 3.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (120, 4, 7, 4.47, '2015-03-30', '2:12 PM', 4.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (121, 8, 4, 4.27, '2015-12-02', '11:07 AM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (122, 5, 7, 3.35, '2016-07-24', '8:32 PM', 2.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (123, 8, 10, 3.7, '2016-06-26', '6:57 PM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (124, 3, 3, 3.78, '2015-11-23', '6:08 AM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (125, 3, 3, 4.02, '2016-11-03', '1:11 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (126, 4, 5, 4.37, '2016-11-26', '4:57 PM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (127, 3, 11, 4.28, '2017-01-04', '10:55 AM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (128, 8, 11, 3.97, '2017-01-31', '10:37 PM', 3.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (129, 4, 8, 3.05, '2016-11-05', '6:17 AM', 3.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (130, 10, 9, 3.87, '2017-02-05', '11:42 AM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (131, 9, 7, 4.05, '2016-03-10', '6:43 PM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (132, 9, 5, 3.06, '2016-07-24', '12:33 PM', 3.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (133, 8, 10, 3.16, '2016-10-29', '10:14 AM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (134, 4, 10, 3.34, '2016-07-04', '2:05 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (135, 3, 3, 3.57, '2016-08-03', '7:13 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (136, 7, 2, 3.7, '2016-05-01', '11:38 AM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (137, 11, 2, 3.37, '2016-04-05', '6:14 AM', 3.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (138, 7, 4, 4.3, '2016-10-13', '7:42 AM', 3.86);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (139, 8, 4, 4.39, '2016-10-27', '6:38 AM', 2.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (140, 5, 9, 3.52, '2015-08-13', '10:12 AM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (141, 11, 11, 4.42, '2015-01-15', '10:46 AM', 4.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (142, 6, 9, 3.86, '2016-09-26', '11:19 AM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (143, 7, 3, 4.37, '2015-07-16', '2:22 PM', 3.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (144, 6, 2, 3.69, '2017-03-09', '9:26 AM', 3.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (145, 5, 2, 3.57, '2015-09-08', '2:45 PM', 3.76);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (146, 6, 11, 3.62, '2015-12-31', '8:25 PM', 3.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (147, 8, 5, 4.38, '2016-10-31', '10:42 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (148, 7, 9, 3.34, '2017-02-28', '6:32 AM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (149, 7, 9, 3.29, '2015-12-20', '7:44 PM', 3.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (150, 11, 9, 3.93, '2015-01-01', '3:53 PM', 3.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (151, 8, 7, 3.96, '2015-06-10', '6:44 AM', 4.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (152, 8, 2, 3.9, '2015-11-17', '5:31 PM', 3.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (153, 10, 3, 4.14, '2015-03-21', '3:30 PM', 2.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (154, 4, 2, 3.66, '2015-01-31', '12:14 PM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (155, 8, 5, 3.25, '2016-10-24', '3:23 PM', 4.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (156, 5, 4, 3.96, '2015-02-13', '6:05 PM', 4.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (157, 5, 2, 4.21, '2016-06-28', '9:58 PM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (158, 8, 3, 3.68, '2016-10-30', '7:53 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (159, 7, 8, 3.27, '2016-03-28', '1:29 PM', 4.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (160, 5, 2, 4.21, '2015-05-06', '1:42 PM', 3.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (161, 4, 11, 3.52, '2015-08-30', '1:16 PM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (162, 7, 3, 4.32, '2015-12-14', '7:02 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (163, 11, 9, 3.28, '2016-08-24', '9:11 PM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (164, 10, 5, 3.87, '2015-08-10', '7:28 PM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (165, 7, 6, 3.63, '2017-01-20', '6:23 PM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (166, 5, 5, 3.2, '2015-12-07', '4:07 PM', 4.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (167, 10, 3, 3.27, '2015-10-27', '7:39 AM', 2.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (168, 8, 7, 3.45, '2015-08-24', '2:32 PM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (169, 11, 3, 4.02, '2015-07-13', '8:00 PM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (170, 8, 5, 3.88, '2016-06-12', '4:28 PM', 2.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (171, 5, 3, 3.36, '2015-06-12', '9:02 AM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (172, 6, 2, 3.05, '2017-02-06', '4:29 PM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (173, 11, 10, 4.18, '2015-02-12', '3:43 PM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (174, 6, 4, 3.53, '2015-05-22', '10:33 AM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (175, 5, 11, 3.06, '2015-08-28', '2:57 PM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (176, 5, 5, 3.33, '2017-01-25', '1:26 PM', 4.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (177, 6, 3, 4.23, '2015-01-07', '12:51 PM', 3.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (178, 11, 9, 3.29, '2016-08-15', '10:29 PM', 4.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (179, 5, 8, 4.34, '2017-01-12', '7:01 AM', 3.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (180, 9, 11, 3.95, '2016-05-20', '4:41 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (181, 2, 2, 3.03, '2015-11-15', '8:17 PM', 2.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (182, 10, 9, 3.71, '2015-04-29', '2:00 PM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (183, 3, 5, 3.96, '2015-02-11', '3:17 PM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (184, 3, 11, 4.04, '2016-02-25', '9:32 AM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (185, 6, 8, 4.01, '2016-09-15', '2:43 PM', 3.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (186, 11, 7, 4.34, '2015-08-18', '9:29 PM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (187, 4, 5, 3.5, '2017-03-08', '12:34 PM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (188, 4, 10, 3.64, '2016-08-31', '4:54 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (189, 5, 3, 4.14, '2015-08-04', '10:59 AM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (190, 7, 9, 3.53, '2015-11-27', '8:11 AM', 3.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (191, 6, 6, 4.21, '2016-02-23', '8:04 PM', 2.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (192, 6, 8, 3.49, '2016-02-29', '3:44 PM', 2.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (193, 7, 9, 3.56, '2015-09-30', '8:52 PM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (194, 5, 8, 4.12, '2016-01-04', '10:10 PM', 3.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (195, 11, 2, 4.0, '2015-11-26', '11:40 AM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (196, 6, 2, 3.32, '2016-01-23', '1:35 PM', 4.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (197, 8, 10, 4.23, '2016-04-01', '3:45 PM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (198, 6, 8, 3.86, '2016-05-17', '10:19 PM', 4.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (199, 5, 10, 3.7, '2017-03-11', '9:25 AM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (200, 11, 7, 4.04, '2016-06-06', '1:47 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (201, 3, 6, 4.31, '2015-06-19', '2:31 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (202, 3, 10, 3.66, '2016-02-21', '1:58 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (203, 9, 8, 3.85, '2015-10-17', '8:15 PM', 3.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (204, 2, 9, 3.06, '2015-12-08', '3:04 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (205, 7, 2, 3.7, '2015-07-26', '12:28 PM', 4.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (206, 11, 10, 3.86, '2016-11-10', '2:23 PM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (207, 8, 2, 4.19, '2016-09-14', '9:45 AM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (208, 8, 8, 3.31, '2016-12-04', '10:26 AM', 2.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (209, 2, 5, 3.94, '2016-11-24', '4:41 PM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (210, 5, 3, 3.04, '2017-02-26', '7:55 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (211, 11, 5, 3.54, '2016-06-23', '9:16 PM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (212, 6, 10, 4.03, '2015-10-12', '6:24 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (213, 10, 9, 4.07, '2017-04-07', '6:43 PM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (214, 3, 8, 3.06, '2017-01-18', '7:13 PM', 4.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (215, 6, 4, 3.39, '2016-04-16', '11:16 AM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (216, 9, 8, 3.04, '2015-01-30', '5:40 PM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (217, 6, 8, 4.45, '2016-08-07', '7:13 AM', 2.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (218, 7, 10, 4.23, '2016-06-09', '12:23 PM', 3.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (219, 10, 6, 3.76, '2016-08-26', '10:14 PM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (220, 8, 3, 3.22, '2015-03-05', '12:04 PM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (221, 3, 10, 3.44, '2016-09-16', '6:34 AM', 4.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (222, 6, 11, 3.76, '2016-01-02', '7:34 AM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (223, 8, 2, 3.65, '2016-05-13', '4:42 PM', 4.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (224, 7, 5, 3.15, '2016-02-15', '6:28 AM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (225, 2, 2, 4.03, '2015-11-08', '1:10 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (226, 7, 11, 4.4, '2016-06-13', '7:14 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (227, 2, 7, 3.2, '2016-11-17', '8:10 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (228, 3, 4, 4.06, '2015-05-07', '6:50 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (229, 7, 5, 3.5, '2015-03-19', '6:59 AM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (230, 4, 11, 3.88, '2015-10-18', '1:25 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (231, 10, 11, 3.5, '2015-09-07', '2:52 PM', 3.97);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (232, 2, 7, 4.38, '2015-12-20', '5:44 PM', 2.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (233, 4, 11, 4.27, '2016-07-09', '7:08 AM', 3.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (234, 10, 9, 4.13, '2015-10-20', '9:54 PM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (235, 5, 6, 3.65, '2016-06-21', '8:57 AM', 3.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (236, 10, 9, 3.01, '2015-10-09', '12:32 PM', 3.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (237, 5, 2, 3.37, '2016-06-01', '5:45 PM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (238, 4, 6, 3.03, '2015-02-28', '10:48 PM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (239, 4, 5, 3.72, '2016-11-01', '7:25 PM', 3.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (240, 2, 10, 4.11, '2015-06-27', '2:01 PM', 3.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (241, 9, 2, 4.18, '2015-02-22', '8:35 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (242, 9, 10, 3.58, '2016-12-12', '2:01 PM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (243, 11, 11, 4.46, '2015-04-10', '1:16 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (244, 11, 7, 3.59, '2015-07-26', '9:02 PM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (245, 7, 6, 3.27, '2016-04-20', '10:46 PM', 3.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (246, 6, 7, 3.73, '2016-03-06', '10:53 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (247, 11, 7, 3.45, '2017-03-03', '9:16 AM', 4.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (248, 2, 6, 3.22, '2016-07-12', '8:40 AM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (249, 3, 4, 4.28, '2017-01-08', '10:34 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (250, 2, 4, 4.28, '2016-11-11', '8:03 AM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (251, 4, 11, 3.16, '2016-01-08', '8:07 AM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (252, 3, 3, 4.1, '2015-08-18', '10:31 PM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (253, 9, 4, 4.02, '2015-04-30', '12:36 PM', 2.97);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (254, 2, 8, 3.36, '2017-04-08', '11:35 AM', 4.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (255, 3, 6, 4.26, '2016-08-07', '7:25 PM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (256, 10, 5, 3.83, '2015-10-15', '7:17 PM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (257, 7, 10, 3.94, '2015-06-28', '6:49 AM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (258, 10, 8, 3.73, '2016-07-10', '9:32 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (259, 9, 7, 4.48, '2017-01-16', '7:59 PM', 3.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (260, 11, 2, 4.08, '2015-07-23', '1:10 PM', 4.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (261, 2, 2, 3.99, '2017-01-08', '7:59 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (262, 6, 5, 4.43, '2015-12-28', '8:43 PM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (263, 4, 5, 3.34, '2016-03-26', '7:30 AM', 3.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (264, 7, 3, 3.41, '2015-02-16', '1:16 PM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (265, 9, 2, 3.72, '2017-02-04', '9:57 PM', 2.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (266, 11, 9, 4.37, '2016-02-12', '8:22 PM', 4.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (267, 8, 2, 4.32, '2016-02-23', '5:36 PM', 4.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (268, 8, 2, 3.45, '2016-04-04', '10:28 PM', 3.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (269, 11, 5, 3.69, '2015-12-12', '12:59 PM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (270, 3, 2, 4.24, '2017-01-25', '9:26 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (271, 9, 11, 4.13, '2015-09-15', '7:21 AM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (272, 2, 4, 3.85, '2016-07-09', '7:05 AM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (273, 5, 7, 3.11, '2015-11-21', '7:03 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (274, 7, 9, 3.6, '2015-07-08', '10:33 AM', 3.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (275, 3, 5, 4.38, '2015-02-25', '10:09 AM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (276, 5, 8, 3.07, '2016-02-04', '8:32 AM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (277, 7, 7, 3.86, '2016-06-02', '6:27 AM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (278, 9, 5, 3.63, '2016-06-03', '5:39 PM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (279, 2, 9, 4.45, '2016-05-13', '7:11 PM', 4.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (280, 8, 10, 4.15, '2017-03-06', '8:32 PM', 2.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (281, 11, 2, 4.21, '2015-08-30', '12:32 PM', 4.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (282, 11, 7, 3.05, '2015-04-08', '10:22 AM', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (283, 3, 10, 4.23, '2016-07-14', '11:26 AM', 3.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (284, 10, 5, 4.44, '2016-10-21', '7:49 AM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (285, 4, 10, 3.85, '2017-03-23', '9:13 PM', 2.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (286, 7, 10, 3.86, '2016-12-23', '1:26 PM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (287, 8, 8, 3.62, '2015-07-14', '3:55 PM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (288, 4, 11, 3.14, '2015-02-25', '2:29 PM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (289, 8, 3, 3.73, '2016-05-09', '4:44 PM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (290, 2, 4, 4.31, '2017-04-10', '9:10 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (291, 2, 4, 3.84, '2015-12-07', '9:54 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (292, 7, 3, 3.01, '2015-11-20', '12:42 PM', 3.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (293, 3, 11, 4.44, '2015-02-26', '1:03 PM', 2.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (294, 10, 11, 4.31, '2015-10-12', '11:39 AM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (295, 6, 3, 3.13, '2015-09-16', '8:17 PM', 3.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (296, 10, 10, 3.3, '2016-07-08', '10:00 AM', 2.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (297, 2, 5, 3.56, '2016-09-25', '6:41 PM', 3.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (298, 6, 3, 3.2, '2016-10-28', '10:59 AM', 3.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (299, 10, 3, 3.4, '2017-04-03', '3:10 PM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (300, 2, 10, 3.89, '2015-11-16', '12:07 PM', 4.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (301, 5, 5, 4.07, '2016-03-27', '9:55 PM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (302, 5, 9, 3.85, '2016-11-03', '9:52 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (303, 8, 2, 3.45, '2015-07-21', '8:45 PM', 2.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (304, 9, 10, 3.43, '2016-10-22', '9:27 AM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (305, 3, 4, 4.39, '2015-07-14', '12:14 PM', 3.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (306, 7, 9, 4.18, '2015-11-23', '1:20 PM', 4.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (307, 9, 3, 3.97, '2016-09-05', '7:21 AM', 4.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (308, 4, 7, 4.38, '2016-09-04', '5:43 PM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (309, 5, 2, 3.02, '2015-08-03', '10:05 AM', 4.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (310, 3, 2, 3.79, '2015-09-20', '6:03 AM', 4.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (311, 7, 4, 3.17, '2016-09-06', '3:54 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (312, 10, 3, 4.43, '2016-07-14', '10:46 AM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (313, 4, 11, 4.13, '2015-07-07', '9:05 AM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (314, 10, 9, 3.27, '2015-02-03', '3:32 PM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (315, 2, 8, 3.57, '2017-01-03', '10:35 AM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (316, 3, 7, 4.28, '2016-08-19', '11:33 AM', 3.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (317, 10, 8, 4.25, '2015-03-02', '4:45 PM', 4.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (318, 6, 2, 3.64, '2015-09-27', '6:17 PM', 2.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (319, 6, 9, 4.3, '2016-08-29', '8:02 AM', 4.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (320, 9, 6, 3.09, '2015-09-27', '7:38 AM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (321, 5, 5, 4.06, '2016-03-26', '12:05 PM', 2.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (322, 3, 2, 4.16, '2016-03-23', '1:11 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (323, 4, 11, 4.12, '2015-05-30', '10:44 PM', 3.76);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (324, 9, 7, 3.99, '2015-11-20', '2:28 PM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (325, 11, 6, 4.27, '2016-11-18', '1:22 PM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (326, 8, 2, 4.26, '2015-10-22', '7:29 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (327, 5, 3, 4.25, '2016-08-23', '6:49 AM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (328, 2, 6, 3.7, '2016-04-03', '7:36 AM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (329, 9, 11, 3.76, '2017-03-02', '11:22 AM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (330, 2, 7, 3.56, '2015-06-22', '8:21 AM', 2.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (331, 9, 2, 3.0, '2015-12-09', '8:04 AM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (332, 3, 5, 4.31, '2015-10-17', '7:52 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (333, 10, 9, 4.24, '2016-06-21', '2:20 PM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (334, 2, 5, 3.47, '2016-06-13', '7:19 AM', 4.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (335, 2, 3, 3.73, '2016-05-08', '7:19 PM', 3.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (336, 8, 9, 4.11, '2015-05-03', '2:50 PM', 3.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (337, 3, 3, 3.45, '2016-11-13', '9:36 AM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (338, 7, 5, 4.38, '2015-08-29', '2:56 PM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (339, 8, 5, 3.68, '2016-10-10', '6:21 PM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (340, 5, 4, 4.39, '2015-09-14', '10:14 PM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (341, 7, 11, 3.59, '2015-12-01', '7:39 AM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (342, 3, 7, 3.59, '2016-06-01', '11:53 AM', 4.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (343, 10, 8, 3.77, '2016-06-14', '6:24 PM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (344, 2, 3, 3.27, '2015-05-15', '6:01 AM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (345, 2, 10, 4.18, '2015-03-31', '9:17 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (346, 9, 2, 3.24, '2016-02-19', '10:23 PM', 3.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (347, 6, 4, 3.09, '2015-03-13', '10:04 AM', 3.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (348, 8, 9, 3.27, '2015-09-09', '11:48 AM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (349, 8, 5, 3.65, '2015-12-05', '2:07 PM', 3.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (350, 3, 6, 3.54, '2015-10-03', '6:28 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (351, 11, 10, 3.84, '2016-05-16', '7:18 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (352, 5, 2, 3.58, '2016-05-18', '7:13 AM', 2.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (353, 3, 3, 3.03, '2016-09-14', '10:43 AM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (354, 2, 10, 3.32, '2016-04-23', '8:35 PM', 3.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (355, 2, 8, 3.86, '2016-05-01', '8:43 AM', 3.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (356, 6, 8, 3.14, '2016-09-07', '9:26 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (357, 9, 10, 3.06, '2016-08-26', '6:27 AM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (358, 6, 10, 3.46, '2015-08-09', '8:58 AM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (359, 9, 7, 4.0, '2016-09-15', '8:42 PM', 3.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (360, 3, 3, 3.64, '2015-11-15', '4:47 PM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (361, 4, 9, 3.98, '2016-01-21', '5:05 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (362, 10, 2, 3.88, '2015-12-11', '10:59 AM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (363, 3, 3, 4.12, '2015-01-10', '6:18 PM', 2.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (364, 3, 5, 3.73, '2016-06-05', '11:30 AM', 2.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (365, 11, 10, 3.95, '2015-06-09', '12:43 PM', 2.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (366, 10, 2, 3.57, '2016-05-16', '2:10 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (367, 6, 2, 3.32, '2016-04-13', '3:50 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (368, 6, 4, 3.27, '2016-12-24', '9:12 PM', 2.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (369, 11, 7, 4.45, '2015-08-29', '6:20 AM', 3.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (370, 2, 9, 3.64, '2016-07-25', '9:46 AM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (371, 6, 2, 3.63, '2017-02-27', '10:19 AM', 4.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (372, 5, 11, 4.13, '2016-07-21', '12:28 PM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (373, 4, 9, 3.43, '2015-03-08', '7:42 PM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (374, 6, 2, 3.45, '2015-07-20', '7:19 AM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (375, 8, 10, 3.15, '2016-06-22', '6:29 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (376, 8, 6, 3.39, '2016-09-30', '2:39 PM', 2.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (377, 3, 9, 3.72, '2016-10-30', '7:45 PM', 2.97);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (378, 6, 3, 4.45, '2015-08-18', '7:11 AM', 2.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (379, 7, 9, 3.61, '2016-11-12', '6:06 PM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (380, 9, 7, 4.02, '2016-07-01', '9:07 PM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (381, 6, 3, 3.58, '2017-01-15', '8:43 AM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (382, 5, 7, 3.39, '2015-05-10', '5:57 PM', 3.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (383, 3, 9, 4.08, '2016-11-27', '7:02 AM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (384, 8, 4, 4.36, '2015-07-15', '3:36 PM', 4.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (385, 2, 8, 3.58, '2016-06-04', '7:59 AM', 4.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (386, 9, 2, 3.23, '2016-10-31', '10:09 PM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (387, 10, 9, 3.77, '2016-11-21', '7:23 PM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (388, 5, 2, 3.07, '2015-09-16', '12:25 PM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (389, 5, 10, 4.38, '2016-07-13', '9:54 AM', 4.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (390, 11, 10, 4.39, '2015-03-18', '10:32 PM', 3.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (391, 4, 2, 3.6, '2015-04-12', '5:44 PM', 4.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (392, 4, 5, 3.35, '2017-03-22', '11:05 AM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (393, 7, 5, 3.62, '2017-01-02', '5:24 PM', 3.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (394, 9, 9, 3.58, '2015-08-11', '10:10 AM', 3.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (395, 6, 8, 4.11, '2016-11-22', '2:54 PM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (396, 6, 3, 3.93, '2016-08-28', '9:26 AM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (397, 11, 5, 4.21, '2015-10-19', '5:12 PM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (398, 9, 4, 3.33, '2015-11-16', '5:36 PM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (399, 9, 8, 4.32, '2016-07-04', '3:17 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (400, 5, 3, 3.03, '2015-07-09', '11:41 AM', 4.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (401, 7, 10, 3.88, '2015-12-28', '4:56 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (402, 11, 11, 3.36, '2015-11-09', '2:11 PM', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (403, 10, 9, 3.42, '2016-06-15', '12:43 PM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (404, 7, 9, 4.32, '2016-05-31', '9:45 AM', 3.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (405, 3, 8, 3.07, '2016-01-27', '4:24 PM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (406, 9, 10, 4.04, '2016-03-20', '6:46 AM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (407, 5, 3, 3.76, '2015-10-29', '4:30 PM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (408, 2, 6, 3.93, '2015-03-21', '10:50 AM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (409, 7, 11, 4.33, '2015-11-30', '5:17 PM', 2.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (410, 11, 10, 3.98, '2016-08-05', '4:57 PM', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (411, 8, 4, 3.68, '2015-11-29', '10:34 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (412, 8, 5, 3.35, '2015-04-05', '1:49 PM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (413, 3, 3, 3.04, '2016-03-12', '6:11 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (414, 2, 3, 3.43, '2015-03-29', '6:29 AM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (415, 4, 4, 4.09, '2016-12-29', '8:37 AM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (416, 9, 7, 3.57, '2016-04-22', '5:56 PM', 3.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (417, 3, 6, 4.14, '2017-03-10', '8:12 AM', 3.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (418, 3, 3, 4.37, '2017-02-02', '11:30 AM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (419, 6, 11, 3.06, '2016-12-19', '11:10 AM', 3.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (420, 8, 9, 3.7, '2015-10-21', '5:34 PM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (421, 9, 11, 3.08, '2016-03-05', '8:46 PM', 2.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (422, 10, 4, 3.49, '2016-12-18', '11:38 AM', 2.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (423, 5, 10, 4.39, '2015-07-14', '6:48 AM', 2.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (424, 11, 2, 3.08, '2016-04-03', '2:59 PM', 3.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (425, 8, 7, 3.88, '2015-04-16', '8:21 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (426, 9, 10, 3.7, '2015-12-07', '9:59 AM', 3.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (427, 11, 11, 3.83, '2017-01-26', '6:23 PM', 3.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (428, 11, 4, 4.22, '2016-10-10', '6:40 AM', 3.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (429, 3, 7, 3.36, '2016-12-02', '9:12 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (430, 2, 3, 4.35, '2015-09-07', '10:44 AM', 3.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (431, 3, 10, 4.11, '2015-11-26', '6:26 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (432, 3, 2, 3.91, '2016-10-22', '11:21 AM', 4.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (433, 4, 2, 4.28, '2016-06-02', '3:57 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (434, 11, 4, 3.01, '2015-11-06', '3:24 PM', 3.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (435, 10, 3, 3.56, '2016-07-24', '7:56 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (436, 2, 9, 3.5, '2015-08-11', '7:13 PM', 3.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (437, 7, 8, 3.14, '2017-01-26', '10:21 AM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (438, 8, 8, 4.2, '2015-09-07', '12:23 PM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (439, 4, 5, 3.08, '2016-11-28', '1:12 PM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (440, 6, 11, 3.55, '2017-03-24', '10:36 AM', 3.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (441, 4, 7, 3.86, '2015-04-14', '2:45 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (442, 7, 10, 3.18, '2015-10-28', '9:21 PM', 3.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (443, 8, 3, 3.8, '2016-04-14', '8:50 PM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (444, 7, 2, 3.99, '2016-07-21', '7:15 PM', 4.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (445, 8, 6, 3.93, '2015-08-27', '6:12 AM', 4.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (446, 8, 8, 3.81, '2016-01-30', '1:23 PM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (447, 5, 7, 3.07, '2015-02-08', '8:39 AM', 3.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (448, 3, 6, 3.55, '2016-12-30', '6:08 PM', 4.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (449, 3, 5, 3.08, '2015-12-22', '3:00 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (450, 2, 6, 3.14, '2016-05-16', '10:43 AM', 2.84);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (451, 9, 8, 4.43, '2015-03-18', '7:59 PM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (452, 9, 7, 3.45, '2016-09-25', '4:18 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (453, 3, 6, 4.16, '2016-05-28', '8:59 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (454, 5, 10, 4.18, '2016-05-01', '10:55 AM', 3.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (455, 3, 11, 4.29, '2015-02-13', '6:03 AM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (456, 7, 10, 3.26, '2016-10-08', '10:44 AM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (457, 5, 5, 4.2, '2016-01-18', '4:43 PM', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (458, 7, 3, 4.26, '2015-06-02', '12:42 PM', 2.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (459, 5, 4, 3.7, '2016-09-18', '7:21 PM', 2.76);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (460, 7, 3, 4.43, '2015-10-26', '8:07 AM', 3.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (461, 2, 2, 3.93, '2016-05-02', '10:47 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (462, 8, 7, 3.08, '2017-03-22', '5:23 PM', 3.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (463, 5, 7, 4.39, '2015-04-15', '5:48 PM', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (464, 6, 10, 4.16, '2016-12-01', '9:40 PM', 2.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (465, 10, 9, 4.2, '2015-04-24', '5:59 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (466, 11, 4, 4.24, '2016-05-19', '11:44 AM', 2.84);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (467, 11, 2, 3.99, '2016-12-20', '10:57 AM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (468, 11, 9, 3.21, '2016-02-14', '8:43 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (469, 9, 3, 3.43, '2016-02-10', '9:48 PM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (470, 5, 2, 4.18, '2016-11-22', '9:37 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (471, 6, 9, 4.01, '2015-09-28', '3:54 PM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (472, 7, 6, 4.1, '2016-09-17', '1:39 PM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (473, 9, 9, 4.08, '2016-03-19', '12:04 PM', 2.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (474, 5, 9, 4.22, '2015-10-05', '4:49 PM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (475, 10, 2, 3.06, '2016-03-25', '4:59 PM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (476, 10, 8, 4.21, '2017-04-08', '8:52 AM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (477, 2, 9, 3.37, '2015-05-01', '8:56 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (478, 6, 2, 4.05, '2016-11-19', '6:39 PM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (479, 4, 5, 3.58, '2016-10-03', '12:54 PM', 3.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (480, 6, 11, 3.98, '2015-04-07', '7:02 PM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (481, 2, 10, 3.6, '2016-05-14', '10:31 PM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (482, 8, 5, 3.07, '2016-12-29', '10:02 AM', 3.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (483, 3, 10, 4.2, '2016-04-04', '4:49 PM', 3.19);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (484, 4, 2, 3.84, '2015-03-06', '7:01 AM', 2.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (485, 9, 7, 3.38, '2016-05-01', '11:38 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (486, 8, 11, 4.47, '2016-06-03', '5:40 PM', 3.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (487, 3, 9, 3.39, '2017-02-07', '5:16 PM', 3.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (488, 9, 5, 3.96, '2016-11-03', '7:17 PM', 4.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (489, 11, 4, 3.01, '2016-12-18', '6:41 PM', 3.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (490, 10, 3, 4.36, '2016-06-05', '12:25 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (491, 5, 5, 3.04, '2015-09-22', '7:26 AM', 4.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (492, 4, 11, 3.96, '2017-04-21', '8:44 AM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (493, 3, 7, 3.6, '2016-04-17', '8:05 AM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (494, 11, 7, 3.18, '2017-03-25', '1:15 PM', 3.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (495, 10, 5, 3.03, '2015-11-30', '6:46 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (496, 4, 7, 4.05, '2017-02-09', '10:14 AM', 2.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (497, 4, 2, 4.19, '2017-01-29', '1:35 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (498, 9, 8, 4.45, '2017-01-25', '12:39 PM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (499, 5, 6, 3.17, '2017-01-26', '10:35 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (500, 10, 2, 4.49, '2017-04-17', '2:49 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (501, 8, 9, 4.43, '2016-08-25', '10:19 PM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (502, 4, 6, 3.85, '2015-07-06', '2:11 PM', 3.76);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (503, 9, 3, 4.08, '2015-10-11', '12:18 PM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (504, 9, 2, 4.24, '2016-08-16', '8:34 PM', 2.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (505, 10, 7, 3.87, '2015-05-25', '12:26 PM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (506, 5, 10, 3.49, '2015-12-05', '1:45 PM', 2.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (507, 10, 3, 3.7, '2017-02-17', '2:23 PM', 3.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (508, 8, 8, 4.37, '2016-11-22', '8:49 AM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (509, 10, 3, 3.58, '2015-08-04', '6:19 AM', 4.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (510, 7, 4, 3.06, '2015-06-18', '4:08 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (511, 11, 4, 3.63, '2015-02-27', '4:41 PM', 4.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (512, 9, 6, 3.87, '2016-04-09', '6:07 PM', 4.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (513, 11, 9, 4.22, '2017-04-06', '10:59 PM', 2.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (514, 3, 5, 3.79, '2016-06-12', '11:22 AM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (515, 8, 2, 3.56, '2016-06-26', '9:03 PM', 3.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (516, 3, 3, 4.24, '2016-10-20', '9:47 PM', 3.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (517, 10, 10, 3.38, '2015-09-14', '6:34 AM', 4.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (518, 2, 3, 3.66, '2016-03-06', '8:34 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (519, 6, 2, 4.0, '2016-04-14', '6:05 AM', 2.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (520, 10, 5, 4.4, '2017-02-19', '7:43 PM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (521, 6, 7, 3.73, '2016-03-08', '9:29 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (522, 11, 11, 3.95, '2016-03-19', '11:20 AM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (523, 5, 10, 3.03, '2015-09-27', '10:33 AM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (524, 5, 7, 3.22, '2015-02-18', '10:28 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (525, 2, 5, 3.17, '2015-01-11', '6:52 AM', 3.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (526, 10, 11, 4.48, '2016-01-17', '9:55 PM', 3.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (527, 7, 4, 3.76, '2015-09-06', '3:06 PM', 3.84);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (528, 8, 6, 3.49, '2016-10-27', '1:47 PM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (529, 3, 3, 4.05, '2015-03-12', '1:07 PM', 4.19);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (530, 4, 3, 3.02, '2017-02-19', '9:22 AM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (531, 8, 7, 3.04, '2016-08-29', '7:22 AM', 4.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (532, 7, 9, 3.32, '2016-08-19', '11:43 AM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (533, 11, 8, 4.07, '2016-05-11', '7:35 PM', 4.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (534, 5, 10, 3.89, '2017-01-30', '4:44 PM', 4.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (535, 3, 4, 3.17, '2015-05-08', '5:26 PM', 4.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (536, 8, 3, 3.04, '2015-05-28', '2:24 PM', 2.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (537, 9, 6, 3.77, '2016-08-11', '5:04 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (538, 8, 7, 3.0, '2016-11-26', '5:08 PM', 4.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (539, 2, 4, 3.76, '2016-02-15', '7:01 PM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (540, 2, 11, 3.45, '2015-04-23', '7:09 PM', 3.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (541, 4, 10, 3.78, '2015-06-18', '5:44 PM', 3.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (542, 5, 2, 3.16, '2017-04-20', '1:14 PM', 3.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (543, 2, 11, 3.79, '2015-01-21', '9:12 AM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (544, 10, 2, 3.77, '2016-11-05', '6:09 PM', 2.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (545, 6, 8, 4.19, '2016-10-15', '4:24 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (546, 5, 8, 3.3, '2016-10-06', '5:43 PM', 4.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (547, 2, 11, 4.46, '2016-03-28', '12:01 PM', 2.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (548, 8, 2, 4.0, '2015-01-30', '8:50 PM', 3.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (549, 3, 3, 4.49, '2016-02-26', '6:01 PM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (550, 9, 8, 4.02, '2017-02-14', '7:43 AM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (551, 11, 7, 4.38, '2015-11-17', '10:03 AM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (552, 8, 9, 3.78, '2016-12-13', '10:58 AM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (553, 7, 4, 3.13, '2015-05-05', '12:29 PM', 3.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (554, 10, 6, 3.56, '2016-01-25', '10:37 PM', 2.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (555, 5, 5, 3.01, '2016-08-11', '12:22 PM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (556, 4, 9, 3.51, '2015-11-04', '10:44 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (557, 10, 4, 3.25, '2015-05-27', '7:13 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (558, 6, 5, 4.38, '2016-12-25', '8:40 AM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (559, 3, 10, 4.39, '2015-01-30', '5:01 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (560, 2, 3, 4.16, '2017-02-28', '6:26 PM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (561, 8, 7, 4.14, '2017-03-02', '7:52 AM', 2.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (562, 5, 6, 4.0, '2016-05-15', '10:14 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (563, 7, 4, 3.25, '2016-01-26', '7:58 AM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (564, 2, 9, 3.94, '2016-11-16', '11:46 AM', 3.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (565, 4, 5, 3.11, '2016-10-29', '10:28 AM', 2.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (566, 5, 2, 3.3, '2015-12-02', '8:00 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (567, 9, 11, 4.12, '2015-06-29', '9:38 AM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (568, 8, 5, 3.92, '2015-12-22', '12:07 PM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (569, 8, 2, 4.47, '2016-02-14', '7:47 AM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (570, 5, 3, 3.89, '2016-07-06', '5:59 PM', 4.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (571, 4, 8, 3.03, '2016-01-03', '6:30 PM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (572, 4, 11, 3.95, '2015-02-02', '5:21 PM', 2.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (573, 8, 10, 3.27, '2015-09-07', '6:33 AM', 3.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (574, 7, 10, 3.93, '2015-02-26', '10:01 PM', 2.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (575, 2, 8, 3.07, '2015-05-01', '9:57 PM', 4.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (576, 2, 7, 3.56, '2015-04-07', '12:57 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (577, 9, 7, 3.96, '2016-09-25', '9:49 PM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (578, 7, 3, 3.94, '2015-01-06', '1:59 PM', 3.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (579, 6, 7, 4.15, '2015-02-23', '3:25 PM', 4.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (580, 4, 4, 4.14, '2015-03-17', '10:51 AM', 4.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (581, 11, 5, 4.02, '2015-07-26', '12:55 PM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (582, 5, 11, 3.37, '2017-01-29', '1:37 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (583, 5, 2, 3.16, '2015-05-30', '7:40 AM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (584, 9, 11, 4.49, '2016-12-23', '11:58 AM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (585, 10, 11, 4.04, '2016-10-05', '7:01 AM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (586, 7, 11, 3.09, '2015-06-18', '7:20 AM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (587, 2, 4, 3.96, '2015-09-05', '9:01 PM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (588, 9, 5, 3.04, '2015-02-12', '6:41 PM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (589, 7, 2, 3.63, '2015-01-01', '10:49 AM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (590, 2, 10, 4.2, '2016-09-08', '7:44 AM', 2.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (591, 3, 8, 3.82, '2015-06-13', '8:07 AM', 3.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (592, 2, 6, 3.63, '2016-09-29', '7:05 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (593, 8, 5, 3.18, '2015-05-16', '3:34 PM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (594, 7, 5, 3.64, '2015-02-23', '3:43 PM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (595, 4, 9, 3.59, '2016-04-08', '9:35 PM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (596, 9, 8, 3.54, '2017-03-14', '3:26 PM', 2.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (597, 8, 2, 4.49, '2015-10-02', '3:17 PM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (598, 8, 11, 4.35, '2016-01-16', '1:29 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (599, 3, 3, 4.14, '2015-12-15', '9:06 PM', 2.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (600, 3, 7, 3.45, '2016-01-10', '9:23 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (601, 4, 11, 3.92, '2016-09-12', '11:21 AM', 2.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (602, 11, 4, 3.48, '2016-06-13', '1:34 PM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (603, 9, 9, 4.5, '2017-03-28', '4:47 PM', 3.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (604, 10, 11, 3.07, '2015-08-12', '6:50 PM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (605, 3, 7, 4.28, '2015-10-03', '1:22 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (606, 10, 8, 3.26, '2015-06-19', '7:42 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (607, 8, 9, 3.17, '2016-01-28', '4:19 PM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (608, 11, 4, 4.34, '2015-05-01', '11:35 AM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (609, 10, 2, 4.33, '2015-07-27', '11:30 AM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (610, 10, 7, 3.41, '2015-01-08', '7:12 PM', 3.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (611, 10, 7, 3.15, '2015-04-03', '9:11 AM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (612, 8, 2, 3.5, '2016-02-23', '9:17 AM', 4.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (613, 9, 4, 4.25, '2016-01-24', '6:29 PM', 4.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (614, 4, 6, 3.24, '2016-11-24', '10:29 AM', 4.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (615, 11, 5, 3.69, '2015-12-14', '10:10 PM', 3.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (616, 11, 10, 3.28, '2015-02-16', '1:50 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (617, 10, 11, 3.47, '2015-04-22', '1:20 PM', 4.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (618, 3, 9, 4.19, '2015-10-24', '10:34 PM', 3.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (619, 6, 8, 3.37, '2015-02-13', '2:31 PM', 3.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (620, 6, 8, 3.36, '2015-02-11', '8:36 AM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (621, 8, 7, 3.64, '2015-02-01', '9:10 PM', 2.97);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (622, 4, 10, 4.45, '2015-08-11', '12:42 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (623, 6, 4, 3.55, '2016-02-19', '6:06 AM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (624, 7, 5, 3.64, '2015-04-15', '8:17 AM', 2.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (625, 4, 9, 3.06, '2016-10-17', '5:27 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (626, 2, 11, 3.77, '2015-02-17', '3:43 PM', 3.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (627, 6, 3, 3.87, '2016-12-07', '9:53 AM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (628, 5, 2, 3.75, '2016-03-13', '9:47 PM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (629, 7, 3, 3.01, '2015-08-23', '12:56 PM', 4.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (630, 4, 8, 3.55, '2015-07-25', '10:57 AM', 4.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (631, 9, 11, 4.04, '2016-03-18', '6:50 AM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (632, 7, 6, 4.22, '2016-05-18', '8:49 PM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (633, 9, 7, 3.73, '2016-09-25', '9:35 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (634, 4, 3, 3.41, '2015-03-25', '6:33 AM', 2.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (635, 11, 10, 3.02, '2015-07-28', '5:25 PM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (636, 3, 10, 3.15, '2016-07-12', '11:41 AM', 4.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (637, 6, 6, 3.26, '2015-10-13', '9:55 PM', 3.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (638, 3, 10, 3.99, '2016-08-04', '8:49 AM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (639, 2, 10, 4.08, '2015-08-18', '7:02 PM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (640, 5, 10, 3.38, '2016-01-07', '8:55 AM', 3.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (641, 6, 3, 3.57, '2015-09-06', '1:57 PM', 2.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (642, 10, 8, 3.99, '2015-01-06', '9:31 PM', 3.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (643, 11, 11, 4.03, '2015-02-05', '2:32 PM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (644, 7, 6, 3.45, '2016-06-26', '6:35 AM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (645, 3, 8, 3.52, '2016-01-26', '6:54 AM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (646, 3, 10, 4.49, '2016-11-09', '5:07 PM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (647, 9, 3, 3.84, '2015-12-24', '8:07 PM', 3.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (648, 5, 8, 4.16, '2015-05-12', '9:16 AM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (649, 4, 6, 3.34, '2016-08-28', '5:38 PM', 3.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (650, 4, 8, 3.32, '2016-11-12', '7:40 AM', 4.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (651, 2, 9, 4.21, '2016-01-30', '1:49 PM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (652, 3, 7, 3.02, '2017-03-29', '1:52 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (653, 11, 3, 3.85, '2015-03-14', '1:42 PM', 3.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (654, 3, 11, 3.99, '2017-02-25', '6:48 PM', 2.86);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (655, 7, 5, 3.36, '2015-06-01', '10:22 AM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (656, 3, 11, 3.5, '2015-09-16', '1:22 PM', 3.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (657, 7, 6, 3.93, '2015-02-04', '12:13 PM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (658, 10, 11, 3.48, '2015-03-08', '6:53 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (659, 9, 8, 4.39, '2016-10-04', '6:11 AM', 2.84);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (660, 9, 9, 3.33, '2016-04-03', '5:13 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (661, 3, 6, 4.33, '2016-09-15', '7:44 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (662, 4, 11, 3.15, '2017-02-03', '10:23 AM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (663, 7, 5, 3.05, '2016-03-28', '6:00 PM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (664, 11, 6, 4.01, '2015-11-21', '6:03 PM', 2.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (665, 6, 4, 3.35, '2016-01-13', '10:20 AM', 4.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (666, 4, 8, 3.21, '2016-03-03', '6:59 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (667, 7, 6, 4.11, '2016-07-04', '10:37 PM', 3.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (668, 6, 7, 3.01, '2017-03-01', '8:15 AM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (669, 3, 4, 3.86, '2017-04-07', '6:40 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (670, 5, 2, 4.2, '2016-03-12', '9:17 PM', 4.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (671, 7, 5, 4.48, '2015-02-08', '7:10 AM', 3.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (672, 8, 6, 3.73, '2016-09-25', '10:34 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (673, 6, 2, 3.44, '2015-09-15', '9:34 AM', 4.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (674, 7, 9, 3.12, '2016-03-06', '7:33 AM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (675, 8, 5, 3.45, '2015-04-08', '3:56 PM', 2.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (676, 4, 8, 3.49, '2015-05-04', '9:59 AM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (677, 4, 4, 3.39, '2016-12-08', '4:10 PM', 3.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (678, 5, 7, 3.31, '2016-05-23', '10:09 PM', 3.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (679, 10, 8, 3.96, '2015-05-10', '5:06 PM', 2.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (680, 11, 2, 3.3, '2016-01-19', '11:27 AM', 3.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (681, 10, 6, 3.15, '2015-11-23', '6:10 PM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (682, 10, 4, 3.16, '2016-06-10', '9:08 AM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (683, 5, 5, 3.21, '2015-06-20', '1:29 PM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (684, 5, 4, 3.37, '2016-04-22', '10:41 AM', 3.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (685, 5, 5, 4.06, '2017-02-21', '8:28 AM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (686, 3, 11, 3.51, '2015-02-10', '4:56 PM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (687, 3, 6, 3.95, '2017-03-10', '9:17 PM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (688, 3, 2, 4.11, '2015-07-10', '3:34 PM', 2.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (689, 2, 10, 4.17, '2016-11-11', '6:29 PM', 2.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (690, 4, 8, 3.37, '2015-07-18', '8:09 PM', 3.97);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (691, 3, 4, 3.92, '2016-04-16', '10:07 AM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (692, 3, 11, 3.26, '2015-02-02', '6:11 PM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (693, 4, 11, 4.19, '2016-02-19', '1:47 PM', 4.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (694, 7, 7, 3.05, '2016-01-03', '8:56 AM', 3.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (695, 6, 10, 3.51, '2016-05-06', '8:34 AM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (696, 11, 11, 4.15, '2016-10-14', '6:28 AM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (697, 4, 7, 3.73, '2016-04-01', '9:12 AM', 2.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (698, 9, 9, 3.69, '2015-04-19', '3:34 PM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (699, 5, 6, 4.06, '2016-05-19', '9:33 AM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (700, 10, 4, 3.1, '2016-04-24', '5:15 PM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (701, 3, 9, 4.4, '2015-02-08', '6:07 PM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (702, 6, 6, 4.2, '2016-09-08', '12:00 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (703, 6, 10, 3.72, '2015-04-28', '4:07 PM', 3.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (704, 10, 8, 4.29, '2015-12-25', '6:32 PM', 2.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (705, 3, 11, 3.23, '2015-01-22', '10:40 PM', 2.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (706, 6, 2, 4.31, '2016-11-15', '10:16 AM', 4.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (707, 6, 11, 4.11, '2016-05-29', '5:33 PM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (708, 7, 10, 3.11, '2016-10-08', '11:24 AM', 3.84);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (709, 7, 2, 3.23, '2016-02-01', '6:57 AM', 2.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (710, 11, 4, 4.03, '2015-03-15', '9:24 PM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (711, 11, 5, 3.47, '2015-10-02', '7:04 AM', 3.72);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (712, 7, 5, 3.94, '2015-03-16', '5:33 PM', 3.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (713, 6, 7, 4.38, '2015-02-13', '9:25 PM', 3.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (714, 9, 6, 3.91, '2016-04-25', '8:03 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (715, 7, 9, 3.77, '2015-03-27', '2:17 PM', 2.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (716, 3, 6, 3.66, '2016-03-30', '5:31 PM', 2.85);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (717, 4, 11, 4.13, '2015-02-10', '6:49 AM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (718, 6, 3, 3.77, '2015-12-28', '1:37 PM', 4.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (719, 2, 11, 3.32, '2015-05-07', '2:15 PM', 2.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (720, 10, 6, 4.11, '2016-02-18', '5:55 PM', 3.3);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (721, 11, 10, 3.6, '2015-09-15', '10:14 AM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (722, 3, 8, 4.19, '2015-05-04', '2:54 PM', 2.59);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (723, 7, 10, 4.5, '2017-01-11', '6:58 PM', 4.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (724, 5, 2, 4.04, '2016-03-12', '6:22 AM', 2.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (725, 2, 7, 3.29, '2015-02-27', '1:09 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (726, 2, 2, 3.31, '2016-05-23', '8:22 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (727, 3, 5, 4.38, '2016-07-09', '10:20 PM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (728, 3, 3, 3.85, '2015-05-27', '8:50 PM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (729, 10, 10, 4.3, '2016-02-23', '9:35 AM', 3.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (730, 5, 4, 4.37, '2015-06-10', '10:08 PM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (731, 9, 7, 3.41, '2015-06-19', '12:56 PM', 2.83);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (732, 8, 3, 3.63, '2016-08-10', '10:30 PM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (733, 10, 9, 3.32, '2017-01-11', '4:51 PM', 4.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (734, 5, 8, 3.69, '2016-07-09', '2:19 PM', 4.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (735, 5, 10, 3.95, '2016-12-17', '5:19 PM', 3.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (736, 11, 8, 3.07, '2016-03-08', '7:09 AM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (737, 5, 9, 3.3, '2017-02-24', '12:38 PM', 3.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (738, 6, 9, 3.18, '2015-02-21', '12:26 PM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (739, 7, 9, 3.57, '2016-12-29', '5:38 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (740, 7, 7, 4.17, '2015-10-11', '10:18 AM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (741, 6, 8, 3.65, '2015-12-27', '3:16 PM', 4.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (742, 2, 4, 4.36, '2016-01-29', '12:09 PM', 4.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (743, 5, 4, 3.98, '2016-02-04', '3:45 PM', 3.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (744, 9, 4, 3.48, '2015-05-09', '8:10 AM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (745, 7, 11, 4.03, '2015-01-07', '3:49 PM', 4.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (746, 4, 11, 3.21, '2015-04-09', '9:22 AM', 3.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (747, 11, 2, 3.31, '2016-12-20', '8:21 PM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (748, 4, 6, 4.34, '2016-01-27', '10:06 PM', 3.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (749, 6, 4, 4.42, '2016-04-16', '6:41 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (750, 8, 10, 3.38, '2016-03-24', '7:41 AM', 3.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (751, 10, 5, 4.45, '2017-02-02', '9:03 AM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (752, 6, 8, 4.07, '2015-09-15', '7:49 PM', 4.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (753, 11, 7, 3.64, '2016-08-20', '7:49 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (754, 9, 10, 3.41, '2016-07-30', '2:40 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (755, 9, 6, 3.16, '2017-01-13', '9:42 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (756, 7, 7, 3.17, '2015-05-19', '12:59 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (757, 3, 2, 3.47, '2017-03-26', '9:47 AM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (758, 2, 9, 3.19, '2017-03-31', '5:48 PM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (759, 3, 7, 4.4, '2015-01-20', '8:59 AM', 3.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (760, 7, 7, 4.24, '2015-04-27', '9:33 AM', 3.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (761, 8, 9, 3.82, '2016-06-27', '5:44 PM', 4.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (762, 8, 7, 3.86, '2016-06-01', '7:10 PM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (763, 6, 7, 3.36, '2017-04-16', '4:09 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (764, 3, 4, 3.5, '2015-11-09', '1:05 PM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (765, 3, 10, 3.86, '2015-01-18', '1:44 PM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (766, 5, 3, 3.96, '2016-07-26', '7:55 AM', 2.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (767, 8, 5, 4.5, '2015-11-27', '12:26 PM', 4.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (768, 7, 3, 4.16, '2016-05-07', '8:27 AM', 2.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (769, 11, 3, 4.05, '2017-01-03', '2:15 PM', 3.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (770, 5, 2, 3.32, '2016-01-30', '7:45 AM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (771, 2, 8, 3.1, '2016-03-29', '10:50 PM', 2.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (772, 2, 11, 4.43, '2016-08-24', '4:47 PM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (773, 2, 11, 4.32, '2015-03-12', '9:21 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (774, 7, 6, 4.12, '2016-07-21', '8:42 AM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (775, 5, 5, 3.55, '2015-10-25', '7:49 PM', 4.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (776, 11, 4, 3.83, '2016-10-07', '12:43 PM', 3.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (777, 7, 6, 3.65, '2016-11-23', '3:31 PM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (778, 7, 4, 4.08, '2015-06-04', '5:38 PM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (779, 4, 5, 3.53, '2016-10-12', '8:03 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (780, 11, 10, 3.69, '2016-08-03', '7:46 PM', 4.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (781, 7, 11, 4.23, '2016-05-12', '9:17 AM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (782, 2, 10, 3.13, '2016-10-29', '5:45 PM', 3.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (783, 9, 9, 4.35, '2015-03-01', '6:30 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (784, 7, 7, 4.04, '2016-03-10', '12:54 PM', 3.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (785, 11, 2, 4.21, '2016-12-30', '12:14 PM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (786, 6, 10, 3.39, '2016-05-18', '2:16 PM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (787, 3, 11, 4.43, '2016-02-18', '6:27 PM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (788, 4, 8, 3.63, '2015-06-16', '5:32 PM', 4.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (789, 8, 10, 4.08, '2015-03-06', '2:10 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (790, 10, 3, 3.85, '2016-01-31', '8:43 PM', 3.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (791, 9, 10, 3.46, '2016-04-17', '8:16 PM', 3.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (792, 3, 3, 4.43, '2015-09-30', '4:11 PM', 4.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (793, 2, 10, 4.27, '2016-08-16', '9:14 PM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (794, 7, 9, 3.4, '2017-02-16', '3:30 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (795, 11, 5, 3.93, '2016-02-11', '5:08 PM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (796, 7, 8, 4.16, '2015-01-31', '1:51 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (797, 11, 2, 4.14, '2017-01-01', '3:05 PM', 3.93);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (798, 5, 9, 4.45, '2016-11-13', '6:52 AM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (799, 7, 10, 4.15, '2016-07-15', '10:45 PM', 4.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (800, 9, 10, 4.34, '2015-11-17', '4:32 PM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (801, 5, 7, 4.33, '2017-01-26', '10:21 AM', 4.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (802, 10, 11, 3.38, '2016-11-09', '9:32 AM', 3.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (803, 3, 11, 3.03, '2015-10-24', '9:22 PM', 2.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (804, 4, 7, 4.18, '2016-11-26', '1:52 PM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (805, 8, 9, 4.4, '2015-12-21', '6:13 PM', 2.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (806, 5, 7, 4.13, '2016-11-23', '3:13 PM', 2.86);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (807, 11, 11, 3.74, '2016-03-11', '6:18 PM', 2.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (808, 9, 10, 4.44, '2015-06-20', '5:51 PM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (809, 9, 5, 4.08, '2016-06-07', '9:32 AM', 3.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (810, 5, 11, 3.71, '2015-01-30', '10:40 AM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (811, 2, 4, 3.44, '2016-03-22', '7:40 AM', 2.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (812, 4, 7, 4.28, '2015-08-30', '10:21 PM', 2.89);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (813, 8, 4, 3.62, '2016-07-03', '10:43 PM', 2.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (814, 5, 4, 4.34, '2015-01-20', '12:31 PM', 4.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (815, 9, 7, 3.15, '2015-12-22', '10:40 PM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (816, 4, 6, 3.31, '2015-01-17', '3:14 PM', 3.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (817, 7, 3, 3.58, '2015-07-08', '2:06 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (818, 8, 10, 3.93, '2017-03-17', '2:39 PM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (819, 7, 7, 3.39, '2016-05-04', '6:57 PM', 4.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (820, 8, 3, 4.34, '2015-12-17', '12:03 PM', 3.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (821, 8, 9, 3.18, '2016-12-15', '6:55 PM', 4.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (822, 8, 3, 3.07, '2015-07-25', '7:52 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (823, 9, 9, 3.8, '2015-01-06', '3:21 PM', 2.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (824, 9, 8, 4.19, '2016-07-23', '5:22 PM', 3.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (825, 8, 6, 3.96, '2016-09-27', '9:06 PM', 4.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (826, 5, 2, 3.41, '2016-06-05', '8:32 AM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (827, 11, 2, 4.23, '2016-12-08', '6:28 AM', 4.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (828, 7, 7, 4.29, '2015-10-30', '10:50 AM', 3.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (829, 8, 11, 3.91, '2016-08-12', '8:23 AM', 2.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (830, 7, 5, 3.39, '2017-03-15', '10:10 PM', 2.53);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (831, 7, 11, 3.29, '2015-12-16', '3:40 PM', 3.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (832, 7, 4, 3.6, '2015-08-22', '11:48 AM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (833, 7, 6, 3.9, '2016-07-05', '7:41 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (834, 9, 2, 3.89, '2016-05-14', '7:47 PM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (835, 5, 9, 3.42, '2016-04-23', '8:46 PM', 3.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (836, 4, 7, 3.88, '2017-04-03', '9:29 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (837, 10, 9, 4.0, '2015-10-03', '3:20 PM', 3.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (838, 7, 4, 4.08, '2017-04-13', '11:24 AM', 2.65);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (839, 5, 9, 4.21, '2015-12-21', '11:55 AM', 4.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (840, 5, 4, 3.41, '2015-02-08', '6:11 AM', 3.6);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (841, 4, 11, 4.1, '2017-04-18', '6:36 AM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (842, 8, 5, 3.57, '2017-01-06', '9:10 AM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (843, 6, 2, 3.6, '2017-02-18', '9:12 PM', 3.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (844, 4, 8, 3.8, '2016-01-12', '6:04 AM', 4.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (845, 3, 6, 3.11, '2016-08-03', '3:37 PM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (846, 9, 2, 4.38, '2017-04-20', '3:29 PM', 3.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (847, 4, 3, 3.41, '2016-09-17', '5:58 PM', 2.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (848, 3, 6, 4.19, '2015-07-17', '4:14 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (849, 10, 6, 3.37, '2017-02-20', '9:12 PM', 2.77);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (850, 3, 7, 4.01, '2015-08-06', '6:57 PM', 3.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (851, 11, 4, 4.33, '2015-10-07', '3:11 PM', 4.19);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (852, 5, 3, 3.62, '2015-06-07', '8:21 AM', 3.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (853, 2, 2, 3.24, '2017-02-16', '7:13 AM', 3.47);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (854, 5, 2, 3.36, '2016-01-18', '4:50 PM', 2.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (855, 11, 8, 3.92, '2016-11-19', '10:11 PM', 2.61);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (856, 5, 5, 3.71, '2015-10-30', '9:35 PM', 3.33);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (857, 3, 3, 4.41, '2016-09-05', '7:17 PM', 3.27);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (858, 10, 10, 3.42, '2017-01-15', '8:25 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (859, 10, 6, 3.83, '2016-10-01', '2:35 PM', 4.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (860, 8, 9, 3.63, '2015-02-22', '1:28 PM', 3.74);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (861, 11, 4, 3.26, '2017-02-22', '7:41 PM', 3.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (862, 8, 7, 4.16, '2016-03-14', '10:42 AM', 3.9);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (863, 9, 5, 3.44, '2016-09-06', '6:43 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (864, 4, 7, 4.4, '2017-02-15', '4:46 PM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (865, 3, 11, 4.39, '2015-09-01', '6:02 AM', 4.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (866, 2, 10, 3.28, '2015-09-26', '10:22 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (867, 9, 2, 4.33, '2015-10-26', '3:40 PM', 4.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (868, 9, 2, 4.05, '2017-02-06', '10:29 PM', 3.01);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (869, 8, 8, 3.58, '2015-01-29', '5:14 PM', 4.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (870, 9, 6, 3.75, '2015-12-13', '5:35 PM', 4.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (871, 6, 2, 4.23, '2016-09-30', '3:31 PM', 4.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (872, 10, 5, 3.46, '2015-07-04', '6:05 PM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (873, 10, 5, 3.83, '2015-11-04', '4:10 PM', 4.18);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (874, 8, 4, 3.38, '2016-06-13', '8:53 PM', 3.19);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (875, 3, 4, 4.06, '2016-10-13', '4:34 PM', 3.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (876, 3, 6, 4.42, '2017-03-02', '9:19 AM', 3.43);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (877, 5, 8, 3.91, '2017-01-18', '11:39 AM', 3.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (878, 6, 10, 3.21, '2016-12-18', '7:07 AM', 3.31);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (879, 11, 10, 3.73, '2015-01-28', '5:46 PM', 4.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (880, 4, 6, 4.04, '2015-02-07', '10:42 PM', 3.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (881, 3, 10, 3.36, '2015-11-02', '3:07 PM', 3.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (882, 11, 10, 4.28, '2016-12-14', '10:19 AM', 3.22);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (883, 9, 4, 3.51, '2015-07-22', '8:54 AM', 4.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (884, 11, 4, 4.06, '2015-03-26', '9:53 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (885, 5, 8, 4.29, '2016-12-12', '10:34 PM', 4.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (886, 11, 8, 4.5, '2016-06-03', '7:16 PM', 4.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (887, 6, 8, 4.26, '2015-03-24', '8:14 AM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (888, 11, 8, 3.63, '2015-06-09', '1:24 PM', 2.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (889, 4, 3, 3.85, '2016-02-12', '1:13 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (890, 7, 11, 4.49, '2017-01-06', '6:21 PM', 3.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (891, 5, 9, 3.37, '2016-09-19', '2:40 PM', 2.57);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (892, 11, 3, 3.1, '2016-01-19', '3:12 PM', 3.16);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (893, 3, 8, 3.01, '2015-12-28', '8:05 AM', 4.2);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (894, 4, 3, 3.71, '2015-12-08', '10:05 AM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (895, 9, 2, 4.29, '2016-06-25', '10:19 AM', 3.02);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (896, 7, 10, 4.07, '2016-12-04', '4:48 PM', 4.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (897, 2, 11, 3.53, '2015-05-01', '3:48 PM', 4.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (898, 11, 3, 3.64, '2015-03-20', '2:54 PM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (899, 5, 3, 4.1, '2016-12-26', '12:21 PM', 3.63);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (900, 4, 2, 3.57, '2015-10-07', '7:27 AM', 4.0);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (901, 3, 2, 4.45, '2016-11-04', '6:47 AM', 3.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (902, 9, 5, 4.27, '2015-12-15', '6:26 PM', 4.06);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (903, 6, 5, 3.48, '2015-06-10', '8:00 AM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (904, 7, 2, 3.42, '2016-10-07', '4:59 PM', 3.11);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (905, 8, 8, 3.1, '2016-09-16', '5:38 PM', 3.58);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (906, 8, 7, 3.49, '2015-12-03', '5:04 PM', 3.41);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (907, 2, 5, 4.16, '2016-05-04', '6:14 AM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (908, 4, 2, 3.76, '2017-04-08', '7:20 AM', 3.32);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (909, 7, 9, 4.21, '2015-06-12', '3:38 PM', 2.55);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (910, 5, 4, 3.74, '2015-12-30', '4:02 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (911, 4, 9, 3.88, '2016-09-16', '6:25 AM', 3.24);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (912, 11, 4, 3.72, '2016-10-25', '9:54 PM', 3.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (913, 5, 9, 3.21, '2015-04-11', '9:17 AM', 3.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (914, 2, 2, 4.0, '2016-11-01', '8:12 AM', 3.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (915, 10, 7, 4.31, '2017-02-05', '7:28 PM', 4.23);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (916, 4, 5, 3.44, '2016-05-08', '1:15 PM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (917, 2, 2, 4.25, '2015-10-19', '6:09 AM', 4.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (918, 9, 5, 3.42, '2016-06-21', '5:41 PM', 2.71);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (919, 2, 4, 3.9, '2015-09-26', '12:00 PM', 4.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (920, 9, 6, 3.53, '2016-03-06', '8:45 AM', 3.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (921, 11, 11, 4.48, '2016-01-16', '8:26 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (922, 4, 8, 3.07, '2015-10-08', '9:34 PM', 4.04);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (923, 10, 4, 3.9, '2015-08-29', '7:51 PM', 2.96);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (924, 9, 5, 3.17, '2017-03-19', '3:19 PM', 2.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (925, 5, 11, 4.37, '2017-03-21', '10:10 PM', 3.07);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (926, 5, 2, 3.95, '2016-07-26', '7:26 PM', 4.36);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (927, 4, 11, 3.73, '2017-04-08', '6:25 AM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (928, 4, 10, 4.46, '2016-08-16', '8:41 PM', 2.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (929, 3, 4, 4.2, '2015-05-24', '6:59 PM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (930, 7, 4, 4.47, '2016-03-20', '6:29 PM', 3.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (931, 11, 9, 3.85, '2016-07-11', '7:44 PM', 3.39);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (932, 10, 3, 4.23, '2015-03-15', '6:05 AM', 4.37);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (933, 7, 6, 3.04, '2016-11-08', '7:35 PM', 3.75);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (934, 2, 3, 4.36, '2015-08-05', '7:40 PM', 3.26);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (935, 6, 7, 3.37, '2015-10-30', '12:42 PM', 2.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (936, 3, 8, 3.1, '2015-01-09', '5:34 PM', 2.8);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (937, 6, 7, 4.34, '2016-03-21', '7:44 PM', 3.98);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (938, 2, 8, 4.04, '2017-02-26', '5:28 PM', 3.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (939, 6, 10, 4.31, '2016-03-28', '9:22 PM', 3.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (940, 4, 11, 4.07, '2016-06-16', '9:55 AM', 2.88);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (941, 11, 6, 4.36, '2015-05-13', '5:33 PM', 3.66);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (942, 10, 11, 3.66, '2017-04-14', '12:12 PM', 4.28);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (943, 3, 6, 4.11, '2016-03-05', '6:44 AM', 3.38);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (944, 8, 5, 4.22, '2016-11-05', '11:30 AM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (945, 8, 9, 4.1, '2016-11-24', '6:28 PM', 2.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (946, 3, 6, 4.35, '2015-11-22', '9:27 AM', 3.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (947, 3, 3, 3.68, '2016-09-29', '11:11 AM', 2.78);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (948, 11, 4, 3.41, '2015-09-26', '1:54 PM', 3.62);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (949, 5, 11, 4.07, '2017-03-07', '4:47 PM', 4.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (950, 10, 7, 4.41, '2016-02-21', '6:26 PM', 3.34);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (951, 4, 7, 4.49, '2015-11-28', '9:50 AM', 2.7);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (952, 10, 3, 3.9, '2016-02-22', '6:47 AM', 3.73);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (953, 9, 4, 3.64, '2016-02-28', '1:58 PM', 3.95);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (954, 11, 2, 4.18, '2015-10-20', '5:25 PM', 3.1);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (955, 9, 10, 3.37, '2016-03-11', '3:44 PM', 3.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (956, 7, 9, 4.01, '2017-04-09', '12:18 PM', 3.4);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (957, 10, 10, 3.01, '2016-11-06', '7:11 AM', 3.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (958, 11, 11, 3.25, '2015-12-10', '10:19 PM', 2.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (959, 9, 4, 3.06, '2015-09-01', '9:15 PM', 3.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (960, 2, 10, 3.21, '2016-04-17', '3:46 PM', 4.14);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (961, 2, 2, 3.38, '2015-03-01', '10:32 PM', 2.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (962, 6, 8, 4.14, '2016-11-21', '3:44 PM', 4.21);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (963, 9, 5, 4.29, '2016-06-27', '10:55 PM', 3.54);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (964, 7, 7, 4.29, '2016-12-03', '6:28 AM', 3.17);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (965, 10, 9, 3.72, '2016-06-07', '11:37 AM', 2.82);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (966, 7, 5, 3.36, '2015-08-31', '11:12 AM', 3.56);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (967, 10, 8, 4.23, '2017-01-07', '3:22 PM', 4.42);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (968, 3, 4, 3.46, '2016-06-15', '11:31 AM', 3.15);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (969, 8, 9, 3.51, '2016-08-07', '6:51 AM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (970, 5, 2, 4.43, '2015-09-04', '3:31 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (971, 10, 11, 3.85, '2015-03-17', '10:50 PM', 4.29);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (972, 9, 5, 3.59, '2017-01-26', '4:43 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (973, 7, 8, 4.1, '2016-03-13', '9:43 PM', 3.81);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (974, 11, 5, 4.28, '2017-01-19', '3:25 PM', 2.51);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (975, 5, 5, 4.31, '2016-07-16', '3:29 PM', 4.48);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (976, 4, 2, 3.95, '2016-12-24', '10:56 PM', 3.67);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (977, 3, 3, 3.39, '2015-03-18', '9:41 AM', 4.44);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (978, 9, 9, 4.31, '2015-02-01', '10:01 AM', 3.13);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (979, 4, 6, 4.27, '2017-01-20', '2:17 PM', 2.64);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (980, 8, 3, 3.61, '2015-05-29', '1:30 PM', 3.08);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (981, 9, 4, 3.9, '2016-02-09', '6:32 PM', 3.69);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (982, 8, 11, 3.72, '2016-02-29', '7:20 PM', 3.09);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (983, 10, 5, 4.1, '2015-03-15', '6:06 PM', 3.35);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (984, 2, 4, 3.87, '2015-03-06', '6:57 PM', 3.91);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (985, 5, 5, 4.26, '2015-10-26', '12:30 PM', 2.79);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (986, 5, 9, 4.26, '2016-09-17', '5:12 PM', 2.87);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (987, 2, 3, 3.8, '2016-03-04', '8:51 PM', 3.94);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (988, 8, 9, 4.47, '2017-03-08', '1:07 PM', 4.03);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (989, 10, 5, 3.59, '2015-10-16', '7:35 PM', 3.25);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (990, 11, 10, 3.87, '2015-02-09', '3:48 PM', 4.49);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (991, 9, 7, 3.98, '2015-08-06', '8:45 AM', 3.05);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (992, 11, 5, 4.2, '2016-12-24', '8:12 AM', 3.12);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (993, 7, 11, 4.29, '2015-08-15', '3:32 PM', 2.92);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (994, 6, 7, 3.14, '2015-10-31', '7:32 AM', 4.45);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (995, 10, 2, 3.86, '2015-10-06', '10:20 AM', 3.99);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (996, 7, 8, 4.39, '2017-03-02', '3:33 PM', 3.52);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (997, 5, 6, 3.26, '2015-03-24', '2:10 PM', 3.46);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (998, 2, 10, 3.06, '2016-04-23', '12:37 PM', 4.5);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (999, 4, 5, 4.02, '2017-02-19', '9:49 PM', 3.68);
insert into Payments (Payment_ID, Customer_ID, Method_ID , Rate , Date_stamp , Time_stamp , Amount) values (1000, 6, 7, 3.4, '2015-05-22', '7:34 PM', 2.67);



insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (125, 'Gibson', 'Pamela', '64 Smoky Hollow Court ', 'New York', '(594)339-7184', '1952-10-29', '2004-10-21');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (126, 'Rose', 'Larry', '7 Glenwood Dr. ', 'New York', '(788)551-9913', '1982-10-22', '1999-08-28');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (127, 'Torres', 'Jessica', '10 E. Edgemont Street ', 'New York', '(455)311-5431', '1968-04-05', '2008-01-29');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (128, 'Ross', 'Joshua', '5 Buena Vista Street', 'New York', '(338)339-4992', '1977-01-03', '2005-11-26');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (129, 'Carroll', 'Judy', '146 Old Meadowbrook St. ', 'New York', '(436)515-5672', '1970-07-29', '2000-03-27');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (130, 'Gray', 'Kenneth', '269 Oak Meadow St. ', 'New York', '(193)287-2678', '1961-07-28', '2000-07-31');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (131, 'Bradley', 'Ronald', '506 Leeton Ridge Dr. ', 'New York', '(493)294-3499', '1962-03-01', '2002-02-11');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (132, 'Kim', 'Virginia', '564 Glenridge Street ', 'New York', '(258)625-5250', '2002-01-05', '2005-08-05');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (133, 'Marshall', 'Robert', '7275 Lakeshore Street ', 'New York', '33-(420)635-0396', '1956-09-28', '2006-05-08');
insert into Staff (Staff_ID, Lname, Fname, Address, County, Phone, DOB, Joined) values (134, 'Burns', 'Patricia', '9359 Cemetery Road ', 'New York', '(469)410-2271', '1968-09-28', '1999-03-22');        

INSERT INTO Stations VALUES
    (281,'66db5fae-0aca-11e7-82f6-3863bb44ef7c','Grand Army Plaza & Central Park S','6839.10',40.7643971,-73.97371465,71,'KEY,CREDITCARD',66,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=281','false','true','[object Object]','true'),
    (359,'66dbc982-0aca-11e7-82f6-3863bb44ef7c','E 47 St & Park Ave','6584.12',40.75510267,-73.97498696,71,'KEY,CREDITCARD',64,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=359','false','false','[object Object]','true'),
    (367,'66dbcdfc-0aca-11e7-82f6-3863bb44ef7c','E 53 St & Lexington Ave','6617.09',40.75828065,-73.97069431,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=367','false','false','[object Object]','true'),
    (377,'66dbe441-0aca-11e7-82f6-3863bb44ef7c','6 Ave & Canal St','5500.07',40.72243797,-74.00566443,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=377','false','false','[object Object]','true'),
    (402,'66dbf0d0-0aca-11e7-82f6-3863bb44ef7c','Broadway & E 22 St','6098.07',40.7403432,-73.98955109,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=402','false','false','[object Object]','true'),
    (534,'66dc8886-0aca-11e7-82f6-3863bb44ef7c','Water - Whitehall Plaza','4962.04',40.70255065,-74.0127234,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=534','false','false','[object Object]','true'),
    (3443,'66de8a86-0aca-11e7-82f6-3863bb44ef7c','W 52 St & 6 Ave','6740.01',40.76132983124814,-73.97982001304626,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3443','false','false','[object Object]','true'),
    (72,'66db237e-0aca-11e7-82f6-3863bb44ef7c','W 52 St & 11 Ave','6926.01',40.76727216,-73.99392888,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=72','false','false',NULL,'true'),
    (79,'66db269c-0aca-11e7-82f6-3863bb44ef7c','Franklin St & W Broadway','5430.08',40.71911552,-74.00666661,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=79','false','false',NULL,'true'),
    (82,'66db277a-0aca-11e7-82f6-3863bb44ef7c','St James Pl & Pearl St','5167.06',40.71117416,-74.00016545,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=82','false','false',NULL,'true'),
    (83,'66db281e-0aca-11e7-82f6-3863bb44ef7c','Atlantic Ave & Fort Greene Pl','4354.07',40.68382604,-73.97632328,71,'KEY,CREDITCARD',62,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=83','false','false',NULL,'true'),
    (116,'66db28b5-0aca-11e7-82f6-3863bb44ef7c','W 17 St & 8 Ave','6148.02',40.74177603,-74.00149746,71,'KEY,CREDITCARD',50,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=116','false','false',NULL,'true'),
    (119,'66db2953-0aca-11e7-82f6-3863bb44ef7c','Park Ave & St Edwards St','4700.06',40.69608941,-73.97803415,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=119','false','false',NULL,'true'),
    (120,'66db29e6-0aca-11e7-82f6-3863bb44ef7c','Lexington Ave & Classon Ave','4452.03',40.68676793,-73.95928168,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=120','false','false',NULL,'true'),
    (127,'66db2a71-0aca-11e7-82f6-3863bb44ef7c','Barrow St & Hudson St','5805.05',40.73172428,-74.00674436,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=127','false','false',NULL,'true'),
    (128,'66db2afe-0aca-11e7-82f6-3863bb44ef7c','MacDougal St & Prince St','5687.04',40.72710258,-74.00297088,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=128','false','false',NULL,'true'),
    (143,'66db2d2b-0aca-11e7-82f6-3863bb44ef7c','Clinton St & Joralemon St','4605.04',40.69239502,-73.99337909,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=143','false','false',NULL,'true'),
    (144,'66db2db5-0aca-11e7-82f6-3863bb44ef7c','Nassau St & Navy St','4812.02',40.69839895,-73.98068914,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=144','false','false',NULL,'true'),
    (146,'66db2e3a-0aca-11e7-82f6-3863bb44ef7c','Hudson St & Reade St','5359.10',40.71625008,-74.0091059,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=146','false','false',NULL,'true'),
    (150,'66db2f4c-0aca-11e7-82f6-3863bb44ef7c','E 2 St & Avenue C','5476.03',40.7208736,-73.98085795,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=150','false','false',NULL,'true'),
    (151,'66db2fd0-0aca-11e7-82f6-3863bb44ef7c','Cleveland Pl & Spring St','5492.05',40.722103786686034,-73.99724900722504,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=151','false','true',NULL,'true'),
    (157,'66db316a-0aca-11e7-82f6-3863bb44ef7c','Henry St & Atlantic Ave','4531.05',40.69089272,-73.99612349,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=157','false','false',NULL,'true'),
    (161,'66db3273-0aca-11e7-82f6-3863bb44ef7c','LaGuardia Pl & W 3 St','5721.14',40.72917025,-73.99810231,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=161','false','false',NULL,'true'),
    (164,'66db32fb-0aca-11e7-82f6-3863bb44ef7c','E 47 St & 2 Ave','6498.10',40.75323098,-73.97032517,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=164','false','false',NULL,'true'),
    (167,'66db337f-0aca-11e7-82f6-3863bb44ef7c','E 39 St & 3 Ave','6389.03',40.7489006,-73.97604882,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=167','false','false',NULL,'true'),
    (168,'66db33fc-0aca-11e7-82f6-3863bb44ef7c','W 18 St & 6 Ave','6064.08',40.73971301,-73.99456405,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=168','false','false',NULL,'true'),
    (173,'66db347b-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 49 St','6708.02',40.76068327096592,-73.9845272898674,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=173','false','false',NULL,'true'),
    (174,'66db34fc-0aca-11e7-82f6-3863bb44ef7c','E 25 St & 1 Ave','6004.07',40.7381765,-73.97738662,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=174','false','false',NULL,'true'),
    (195,'66db3583-0aca-11e7-82f6-3863bb44ef7c','Liberty St & Broadway','5105.01',40.70905623,-74.01043382,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=195','false','false',NULL,'true'),
    (212,'66db3606-0aca-11e7-82f6-3863bb44ef7c','W 16 St & The High Line','6233.05',40.74334935,-74.00681753,71,'KEY,CREDITCARD',60,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=212','false','false',NULL,'true'),
    (216,'66db3687-0aca-11e7-82f6-3863bb44ef7c','Columbia Heights & Cranberry St','4829.01',40.70037867,-73.99548059,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=216','false','false',NULL,'true'),
    (217,'66db3708-0aca-11e7-82f6-3863bb44ef7c','Old Fulton St','4903.08',40.70277159,-73.99383605,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=217','false','true',NULL,'true'),
    (223,'66db3816-0aca-11e7-82f6-3863bb44ef7c','W 13 St & 7 Ave','6030.04',40.73781509,-73.99994661,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=223','false','false',NULL,'true'),
    (224,'66db3898-0aca-11e7-82f6-3863bb44ef7c','Spruce St & Nassau St','5137.10',40.71146364,-74.00552427,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=224','false','true',NULL,'true'),
    (228,'66db3997-0aca-11e7-82f6-3863bb44ef7c','E 48 St & 3 Ave','6541.03',40.7546011026,-73.971878855,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=228','false','false',NULL,'true'),
    (229,'66db3a1e-0aca-11e7-82f6-3863bb44ef7c','Great Jones St','5636.11',40.72743423,-73.99379025,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=229','false','false',NULL,'true'),
    (236,'66db3ba0-0aca-11e7-82f6-3863bb44ef7c','St Marks Pl & 2 Ave','5669.10',40.7284186,-73.98713956,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=236','false','false',NULL,'true'),
    (237,'66db3c29-0aca-11e7-82f6-3863bb44ef7c','E 11 St & 2 Ave','5746.04',40.73047309,-73.98672378,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=237','false','false',NULL,'true'),
    (238,'66db3cab-0aca-11e7-82f6-3863bb44ef7c','Bank St & Washington St','5964.01',40.7361967,-74.00859207,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=238','false','false',NULL,'true'),
    (239,'66db3d2a-0aca-11e7-82f6-3863bb44ef7c','Willoughby St & Fleet St','4628.05',40.69196566,-73.9813018,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=239','false','false',NULL,'true'),
    (241,'66db3da9-0aca-11e7-82f6-3863bb44ef7c','DeKalb Ave & S Portland Ave','4546.04',40.68981035,-73.97493121,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=241','false','false',NULL,'true'),
    (242,'66db3e32-0aca-11e7-82f6-3863bb44ef7c','Carlton Ave & Flushing Ave','4732.08',40.697787,-73.973736,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=242','false','false',NULL,'true'),
    (243,'66db3e9d-0aca-11e7-82f6-3863bb44ef7c','Fulton St & Rockwell Pl','4513.03',40.68841,-73.979458,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=243','false','false',NULL,'true'),
    (244,'66db3f01-0aca-11e7-82f6-3863bb44ef7c','Willoughby Ave & Hall St','4611.03',40.69196035,-73.96536851,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=244','false','false',NULL,'true'),
    (245,'66db3f62-0aca-11e7-82f6-3863bb44ef7c','Myrtle Ave & St Edwards St','4659.02',40.69327018,-73.97703874,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=245','false','true',NULL,'true'),
    (247,'66db3fc9-0aca-11e7-82f6-3863bb44ef7c','Perry St & Bleecker St','5922.07',40.73535398,-74.00483091,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=247','false','false',NULL,'true'),
    (248,'66db402c-0aca-11e7-82f6-3863bb44ef7c','Laight St & Hudson St','5539.06',40.72185379,-74.00771779,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=248','false','false',NULL,'true'),
    (249,'66db408f-0aca-11e7-82f6-3863bb44ef7c','Harrison St & Hudson St','5400.05',40.71870987,-74.0090009,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=249','false','false',NULL,'true'),
    (250,'66db40ef-0aca-11e7-82f6-3863bb44ef7c','Lafayette St & Jersey St','5561.06',40.72456089,-73.99565293,71,'KEY,CREDITCARD',40,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=250','false','false',NULL,'true'),
    (251,'66db4158-0aca-11e7-82f6-3863bb44ef7c','Mott St & Prince St','5561.04',40.72317958,-73.99480012,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=251','false','false',NULL,'true'),
    (252,'66db41bf-0aca-11e7-82f6-3863bb44ef7c','MacDougal St & Washington Sq','5797.01',40.73226398,-73.99852205,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=252','false','false',NULL,'true'),
    (254,'66db4282-0aca-11e7-82f6-3863bb44ef7c','W 11 St & 6 Ave','5914.03',40.73532427,-73.99800419,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=254','false','false',NULL,'true'),
    (257,'66db4351-0aca-11e7-82f6-3863bb44ef7c','Lispenard St & Broadway','5391.06',40.71939226,-74.00247214,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=257','false','false',NULL,'true'),
    (258,'66db43b5-0aca-11e7-82f6-3863bb44ef7c','DeKalb Ave & Vanderbilt Ave','4461.04',40.68940747,-73.96885458,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=258','false','false',NULL,'true'),
    (259,'66db4417-0aca-11e7-82f6-3863bb44ef7c','South St & Whitehall St','4846.01',40.70122128,-74.01234218,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=259','false','true',NULL,'true'),
    (260,'66db447a-0aca-11e7-82f6-3863bb44ef7c','Broad St & Bridge St','4962.08',40.70365182,-74.01167797,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=260','false','false',NULL,'true'),
    (261,'66db44e5-0aca-11e7-82f6-3863bb44ef7c','Johnson St & Gold St','4668.08',40.69474881,-73.98362464,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=261','false','false',NULL,'true'),
    (262,'66db4549-0aca-11e7-82f6-3863bb44ef7c','Washington Park','4546.05',40.6917823,-73.9737299,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=262','false','false',NULL,'true'),
    (264,'66db460d-0aca-11e7-82f6-3863bb44ef7c','Maiden Ln & Pearl St','5065.10',40.70706456,-74.00731853,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=264','false','false',NULL,'true'),
    (265,'66db4671-0aca-11e7-82f6-3863bb44ef7c','Stanton St & Chrystie St','5523.02',40.72229346,-73.99147535,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=265','false','false',NULL,'true'),
    (266,'66db46d7-0aca-11e7-82f6-3863bb44ef7c','Avenue D & E 8 St','5506.10',40.72368361,-73.97574813,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=266','false','false',NULL,'true'),
    (267,'66db473c-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 36 St','6441.01',40.75097711,-73.98765428,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=267','false','false',NULL,'true'),
    (268,'66db479e-0aca-11e7-82f6-3863bb44ef7c','Howard St & Centre St','5422.04',40.71910537,-73.99973337,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=268','false','false',NULL,'true'),
    (270,'66db5c14-0aca-11e7-82f6-3863bb44ef7c','Adelphi St & Myrtle Ave','4620.02',40.69308257,-73.97178913,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=270','false','false',NULL,'true'),
    (274,'66db5d28-0aca-11e7-82f6-3863bb44ef7c','Lafayette Ave & Fort Greene Pl','4395.04',40.68691865,-73.976682,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=274','false','false',NULL,'true'),
    (275,'66db5d92-0aca-11e7-82f6-3863bb44ef7c','Washington Ave & Greene Ave','4419.03',40.68650065,-73.96563307,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=275','false','false',NULL,'true'),
    (276,'66db5dfb-0aca-11e7-82f6-3863bb44ef7c','Duane St & Greenwich St','5400.08',40.71748752,-74.0104554,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=276','false','false',NULL,'true'),
    (278,'66db5e6a-0aca-11e7-82f6-3863bb44ef7c','Concord St & Bridge St','4781.03',40.69766564,-73.98476437,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=278','false','false',NULL,'true'),
    (279,'66db5ed3-0aca-11e7-82f6-3863bb44ef7c','Peck Slip & Front St','5098.10',40.707873,-74.00167,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=279','false','true',NULL,'true'),
    (280,'66db5f40-0aca-11e7-82f6-3863bb44ef7c','E 10 St & 5 Ave','5872.08',40.73331967,-73.99510132,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=280','false','false',NULL,'true'),
    (282,'66db6299-0aca-11e7-82f6-3863bb44ef7c','Kent Ave & S 11 St','5062.01',40.707644944175705,-73.96841526031494,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=282','false','false',NULL,'true'),
    (284,'66db631c-0aca-11e7-82f6-3863bb44ef7c','Greenwich Ave & 8 Ave','6072.06',40.7390169121,-74.0026376103,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=284','false','false',NULL,'true'),
    (285,'66db6387-0aca-11e7-82f6-3863bb44ef7c','Broadway & E 14 St','5905.12',40.73454567,-73.99074142,71,'KEY,CREDITCARD',53,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=285','false','true',NULL,'true'),
    (289,'66db63f4-0aca-11e7-82f6-3863bb44ef7c','Monroe St & Classon Ave','4336.01',40.6845683,-73.95881081,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=289','false','false',NULL,'true'),
    (291,'66db64d1-0aca-11e7-82f6-3863bb44ef7c','Madison St & Montgomery St','5262.09',40.713126,-73.984844,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=291','false','false',NULL,'true'),
    (293,'66db65aa-0aca-11e7-82f6-3863bb44ef7c','Lafayette St & E 8 St','5788.13',40.73020660529954,-73.99102628231049,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=293','false','false',NULL,'true'),
    (295,'66db6889-0aca-11e7-82f6-3863bb44ef7c','Pike St & E Broadway','5270.05',40.71406667,-73.99293911,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=295','false','false',NULL,'true'),
    (296,'66db68fc-0aca-11e7-82f6-3863bb44ef7c','Division St & Bowery','5238.04',40.71413089,-73.9970468,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=296','false','false',NULL,'true'),
    (297,'66db6963-0aca-11e7-82f6-3863bb44ef7c','E 15 St & 3 Ave','5863.07',40.734232,-73.986923,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=297','false','false',NULL,'true'),
    (298,'66db69d0-0aca-11e7-82f6-3863bb44ef7c','3 Ave & Schermerhorn St','4437.01',40.68683208,-73.9796772,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=298','false','false',NULL,'true'),
    (301,'66db6aae-0aca-11e7-82f6-3863bb44ef7c','E 2 St & Avenue B','5515.02',40.72217444,-73.98368779,71,'KEY,CREDITCARD',58,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=301','false','false',NULL,'true'),
    (302,'66db6cd4-0aca-11e7-82f6-3863bb44ef7c','Avenue D & E 3 St','5436.09',40.72082834,-73.97793172,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=302','false','false',NULL,'true'),
    (303,'66db6d40-0aca-11e7-82f6-3863bb44ef7c','Mercer St & Spring St','5532.01',40.72362738,-73.99949601,71,'KEY,CREDITCARD',67,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=303','false','false',NULL,'true'),
    (305,'66db6e49-0aca-11e7-82f6-3863bb44ef7c','E 58 St & 3 Ave','6762.02',40.76095756,-73.96724467,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=305','false','false',NULL,'true'),
    (307,'66db6f2e-0aca-11e7-82f6-3863bb44ef7c','Canal St & Rutgers St','5303.08',40.71427487,-73.98990025,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=307','false','false',NULL,'true'),
    (308,'66db7152-0aca-11e7-82f6-3863bb44ef7c','St James Pl & Oliver St','5238.05',40.71307916,-73.99851193,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=308','false','false',NULL,'true'),
    (309,'66db71be-0aca-11e7-82f6-3863bb44ef7c','Murray St & West St','5329.06',40.7149787,-74.013012,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=309','false','false',NULL,'true'),
    (310,'66db7221-0aca-11e7-82f6-3863bb44ef7c','State St & Smith St','4565.06',40.68926942,-73.98912867,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=310','false','false',NULL,'true'),
    (311,'66db728c-0aca-11e7-82f6-3863bb44ef7c','Norfolk St & Broome St','5374.01',40.7172274,-73.98802084,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=311','false','false',NULL,'true'),
    (312,'66db72f1-0aca-11e7-82f6-3863bb44ef7c','Allen St & Stanton St','5484.09',40.722055,-73.989111,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=312','false','false',NULL,'true'),
    (313,'66db74a5-0aca-11e7-82f6-3863bb44ef7c','Washington Ave & Park Ave','4724.03',40.69610226,-73.96751037,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=313','false','false',NULL,'true'),
    (315,'66db75cc-0aca-11e7-82f6-3863bb44ef7c','South St & Gouverneur Ln','4953.04',40.70355377,-74.00670227,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=315','false','true',NULL,'true'),
    (316,'66db7637-0aca-11e7-82f6-3863bb44ef7c','Fulton St & William St','5137.11',40.70955958,-74.00653609,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=316','false','false',NULL,'true'),
    (317,'66db76a1-0aca-11e7-82f6-3863bb44ef7c','E 6 St & Avenue B','5584.04',40.72453734,-73.98185424,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=317','false','false',NULL,'true'),
    (319,'66db79a3-0aca-11e7-82f6-3863bb44ef7c','Fulton St & Broadway','5175.08',40.711066,-74.009447,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=319','false','false',NULL,'true'),
    (320,'66db7a0d-0aca-11e7-82f6-3863bb44ef7c','Leonard St & Church St','5359.11',40.717571,-74.005549,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=320','false','false',NULL,'true'),
    (321,'66db7a71-0aca-11e7-82f6-3863bb44ef7c','Cadman Plaza E & Red Cross Pl','4821.06',40.69991755,-73.98971773,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=321','false','true',NULL,'true'),
    (323,'66db88f5-0aca-11e7-82f6-3863bb44ef7c','Lawrence St & Willoughby St','4596.09',40.69236178,-73.98631746,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=323','false','false',NULL,'true'),
    (324,'66db89a3-0aca-11e7-82f6-3863bb44ef7c','DeKalb Ave & Hudson Ave','4513.06',40.689888,-73.981013,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=324','false','false',NULL,'true'),
    (325,'66db8c10-0aca-11e7-82f6-3863bb44ef7c','E 19 St & 3 Ave','5938.01',40.73624527,-73.98473765,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=325','false','false',NULL,'true'),
    (326,'66db8ca4-0aca-11e7-82f6-3863bb44ef7c','E 11 St & 1 Ave','5746.14',40.72953837,-73.98426726,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=326','false','false',NULL,'true'),
    (327,'66db8d89-0aca-11e7-82f6-3863bb44ef7c','Vesey Pl & River Terrace','5297.02',40.7153379,-74.01658354,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=327','false','true',NULL,'true'),
    (328,'66db8fde-0aca-11e7-82f6-3863bb44ef7c','Watts St & Greenwich St','5578.02',40.72405549,-74.00965965,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=328','false','false',NULL,'true'),
    (330,'66db90f1-0aca-11e7-82f6-3863bb44ef7c','Reade St & Broadway','5247.10',40.71450451,-74.00562789,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=330','false','false',NULL,'true'),
    (331,'66db930d-0aca-11e7-82f6-3863bb44ef7c','Pike St & Monroe St','5159.04',40.71173107,-73.99193043,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=331','false','false',NULL,'true'),
    (332,'66db93a1-0aca-11e7-82f6-3863bb44ef7c','Cherry St','5181.04',40.71219906,-73.97948148,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=332','false','false',NULL,'true'),
    (334,'66db95e5-0aca-11e7-82f6-3863bb44ef7c','W 20 St & 7 Ave','6182.02',40.74238787,-73.99726235,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=334','false','false',NULL,'true'),
    (335,'66db9675-0aca-11e7-82f6-3863bb44ef7c','Washington Pl & Broadway','5755.01',40.72903917,-73.99404649,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=335','false','false',NULL,'true'),
    (336,'66db9845-0aca-11e7-82f6-3863bb44ef7c','Sullivan St & Washington Sq','5721.01',40.73047747,-73.99906065,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=336','false','false',NULL,'true'),
    (337,'66db9925-0aca-11e7-82f6-3863bb44ef7c','Old Slip & Front St','4993.12',40.7037992,-74.00838676,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=337','false','false',NULL,'true'),
    (339,'66db9c2e-0aca-11e7-82f6-3863bb44ef7c','Avenue D & E 12 St','5575.08',40.72580614,-73.97422494,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=339','false','false',NULL,'true'),
    (340,'66db9cc4-0aca-11e7-82f6-3863bb44ef7c','Madison St & Clinton St','5190.07',40.71269042,-73.98776323,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=340','false','true',NULL,'true'),
    (341,'66db9e99-0aca-11e7-82f6-3863bb44ef7c','Stanton St & Mangin St','5326.06',40.71782143,-73.97628939,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=341','false','false',NULL,'true'),
    (342,'66dba0ba-0aca-11e7-82f6-3863bb44ef7c','Columbia St & Rivington St','5365.02',40.71739973,-73.98016555,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=342','false','true',NULL,'true'),
    (343,'66dba303-0aca-11e7-82f6-3863bb44ef7c','Clinton Ave & Flushing Ave','4762.04',40.69794,-73.96986848,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=343','false','false',NULL,'true'),
    (344,'66dbb869-0aca-11e7-82f6-3863bb44ef7c','Monroe St & Bedford Ave','4368.05',40.6851443,-73.95380904,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=344','false','false',NULL,'true'),
    (346,'66dbbc4a-0aca-11e7-82f6-3863bb44ef7c','Bank St & Hudson St','5922.08',40.73652889,-74.00618026,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=346','false','false',NULL,'true'),
    (347,'66dbbeda-0aca-11e7-82f6-3863bb44ef7c','Greenwich St & W Houston St','5730.08',40.728846,-74.008591,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=347','false','false',NULL,'true'),
    (349,'66dbc37a-0aca-11e7-82f6-3863bb44ef7c','Rivington St & Ridge St','5406.02',40.71850211,-73.98329859,71,'KEY,CREDITCARD',61,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=349','false','false',NULL,'true'),
    (350,'66dbc420-0aca-11e7-82f6-3863bb44ef7c','Clinton St & Grand St','5303.06',40.71559509,-73.9870295,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=350','false','false',NULL,'true'),
    (351,'66dbc4c2-0aca-11e7-82f6-3863bb44ef7c','Front St & Maiden Ln','5024.08',40.70530954,-74.00612572,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=351','false','false',NULL,'true'),
    (353,'66dbc60f-0aca-11e7-82f6-3863bb44ef7c','S Portland Ave & Hanson Pl','4354.05',40.68539567,-73.97431458,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=353','false','false',NULL,'true'),
    (354,'66dbc6ae-0aca-11e7-82f6-3863bb44ef7c','Emerson Pl & Myrtle Ave','4683.02',40.69363137,-73.96223558,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=354','false','false',NULL,'true'),
    (355,'66dbc745-0aca-11e7-82f6-3863bb44ef7c','Bayard St & Baxter St','5351.03',40.71602118,-73.99974372,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=355','false','false',NULL,'true'),
    (356,'66dbc7d2-0aca-11e7-82f6-3863bb44ef7c','Bialystoker Pl & Delancey St','5335.03',40.71622644,-73.98261206,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=356','false','false',NULL,'true'),
    (358,'66dbc8f5-0aca-11e7-82f6-3863bb44ef7c','Christopher St & Greenwich St','5847.01',40.73291553,-74.00711384,71,'KEY,CREDITCARD',50,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=358','false','false',NULL,'true'),
    (360,'66dbca0f-0aca-11e7-82f6-3863bb44ef7c','William St & Pine St','5065.12',40.70717936,-74.00887308,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=360','false','false',NULL,'true'),
    (361,'66dbca9c-0aca-11e7-82f6-3863bb44ef7c','Allen St & Hester St','5342.10',40.71605866,-73.99190759,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=361','false','false',NULL,'true'),
    (362,'66dbcb2f-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 37 St','6441.02',40.75172632,-73.98753523,71,'KEY,CREDITCARD',57,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=362','false','false',NULL,'true'),
    (363,'66dbcbbc-0aca-11e7-82f6-3863bb44ef7c','West Thames St','5114.06',40.70834698,-74.01713445,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=363','false','false',NULL,'true'),
    (364,'66dbcc49-0aca-11e7-82f6-3863bb44ef7c','Lafayette Ave & Classon Ave','4452.01',40.68900443,-73.96023854,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=364','false','false',NULL,'true'),
    (366,'66dbcd6c-0aca-11e7-82f6-3863bb44ef7c','Clinton Ave & Myrtle Ave','4651.02',40.693261,-73.968896,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=366','false','false',NULL,'true'),
    (368,'66dbce8a-0aca-11e7-82f6-3863bb44ef7c','Carmine St & 6 Ave','5763.03',40.73038599,-74.00214988,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=368','false','true',NULL,'true'),
    (369,'66dbcf18-0aca-11e7-82f6-3863bb44ef7c','Washington Pl & 6 Ave','5838.09',40.73224119,-74.00026394,71,'KEY,CREDITCARD',60,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=369','false','false',NULL,'true'),
    (372,'66dbe15d-0aca-11e7-82f6-3863bb44ef7c','Franklin Ave & Myrtle Ave','4715.01',40.694546087246025,-73.95801365375519,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=372','false','false',NULL,'true'),
    (373,'66dbe250-0aca-11e7-82f6-3863bb44ef7c','Willoughby Ave & Walworth St','4634.02',40.69331716,-73.95381995,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=373','false','false',NULL,'true'),
    (376,'66dbe3a2-0aca-11e7-82f6-3863bb44ef7c','John St & William St','5065.04',40.70862144,-74.00722156,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=376','false','false',NULL,'true'),
    (379,'66dbe4db-0aca-11e7-82f6-3863bb44ef7c','W 31 St & 7 Ave','6331.01',40.749156,-73.9916,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=379','false','false',NULL,'true'),
    (380,'66dbe571-0aca-11e7-82f6-3863bb44ef7c','W 4 St & 7 Ave S','5880.02',40.73401143,-74.00293877,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=380','false','false',NULL,'true'),
    (383,'66dbe68e-0aca-11e7-82f6-3863bb44ef7c','Greenwich Ave & Charles St','5914.08',40.735238,-74.000271,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=383','false','false',NULL,'true'),
    (385,'66dbe7b6-0aca-11e7-82f6-3863bb44ef7c','E 55 St & 2 Ave','6650.07',40.75797322,-73.96603308,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=385','false','false',NULL,'true'),
    (386,'66dbe848-0aca-11e7-82f6-3863bb44ef7c','Centre St & Worth St','5279.03',40.71494807,-74.00234482,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=386','false','false',NULL,'true'),
    (387,'66dbe8d6-0aca-11e7-82f6-3863bb44ef7c','Centre St & Chambers St','5207.01',40.71273266,-74.0046073,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=387','false','true',NULL,'true'),
    (388,'66dbe96d-0aca-11e7-82f6-3863bb44ef7c','W 26 St & 10 Ave','6382.05',40.749717753,-74.002950346,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=388','false','false',NULL,'true'),
    (389,'66dbe9fc-0aca-11e7-82f6-3863bb44ef7c','Broadway & Berry St','5164.04',40.71044554,-73.96525063,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=389','false','false',NULL,'true'),
    (390,'66dbea8d-0aca-11e7-82f6-3863bb44ef7c','Duffield St & Willoughby St','4596.05',40.69221589,-73.9842844,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=390','false','false',NULL,'true'),
    (391,'66dbeb1b-0aca-11e7-82f6-3863bb44ef7c','Clark St & Henry St','4789.03',40.69760127,-73.99344559,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=391','false','false',NULL,'true'),
    (392,'66dbebad-0aca-11e7-82f6-3863bb44ef7c','Jay St & Tech Pl','4710.06',40.695065,-73.987167,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=392','false','false',NULL,'true'),
    (393,'66dbec40-0aca-11e7-82f6-3863bb44ef7c','E 5 St & Avenue C','5545.04',40.72299208,-73.97995466,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=393','false','false',NULL,'true'),
    (394,'66dbecd0-0aca-11e7-82f6-3863bb44ef7c','E 9 St & Avenue C','5616.01',40.72521311,-73.97768752,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=394','false','false',NULL,'true'),
    (396,'66dbeded-0aca-11e7-82f6-3863bb44ef7c','Lefferts Pl & Franklin Ave','4222.02',40.680342423,-73.9557689392,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=396','false','false',NULL,'true'),
    (397,'66dbee85-0aca-11e7-82f6-3863bb44ef7c','Fulton St & Clermont Ave','4386.05',40.68415748,-73.96922273,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=397','false','false',NULL,'true'),
    (398,'66dbef15-0aca-11e7-82f6-3863bb44ef7c','Atlantic Ave & Furman St','4614.04',40.69165183,-73.9999786,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=398','false','false',NULL,'true'),
    (399,'66dbef85-0aca-11e7-82f6-3863bb44ef7c','Lafayette Ave & St James Pl','4494.04',40.68851534,-73.9647628,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=399','false','false',NULL,'true'),
    (400,'66dbefee-0aca-11e7-82f6-3863bb44ef7c','Pitt St & Stanton St','5406.04',40.71926081,-73.98178024,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=400','false','false',NULL,'true'),
    (401,'66dbf062-0aca-11e7-82f6-3863bb44ef7c','Allen St & Rivington St','5414.06',40.72019576,-73.98997825,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=401','false','false',NULL,'true'),
    (403,'66dbf140-0aca-11e7-82f6-3863bb44ef7c','E 2 St & 2 Ave','5593.02',40.72502876,-73.99069656,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=403','false','false',NULL,'true'),
    (405,'66dbf215-0aca-11e7-82f6-3863bb44ef7c','Washington St & Gansevoort St','6039.06',40.739323,-74.008119,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=405','false','true',NULL,'true'),
    (406,'66dbf288-0aca-11e7-82f6-3863bb44ef7c','Hicks St & Montague St','4645.09',40.69512845,-73.99595065,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=406','false','false',NULL,'true'),
    (408,'66dbf362-0aca-11e7-82f6-3863bb44ef7c','Market St & Cherry St','5198.04',40.71076228,-73.99400398,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=408','false','false',NULL,'true'),
    (410,'66dbf442-0aca-11e7-82f6-3863bb44ef7c','Suffolk St & Stanton St','5445.02',40.72066442,-73.98517977,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=410','false','false',NULL,'true'),
    (411,'66dbf4ac-0aca-11e7-82f6-3863bb44ef7c','E 6 St & Avenue D','5506.14',40.72228087,-73.97668709,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=411','false','false',NULL,'true'),
    (412,'66dbf518-0aca-11e7-82f6-3863bb44ef7c','Forsyth St & Canal St','5270.07',40.7158155,-73.99422366,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=412','false','false',NULL,'true'),
    (415,'66dbf667-0aca-11e7-82f6-3863bb44ef7c','Pearl St & Hanover Square','4993.02',40.7047177,-74.00926027,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=415','false','false',NULL,'true'),
    (416,'66dbf6d2-0aca-11e7-82f6-3863bb44ef7c','Cumberland St & Lafayette Ave','4428.02',40.68753406,-73.97265183,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=416','false','false',NULL,'true'),
    (417,'66dbf73d-0aca-11e7-82f6-3863bb44ef7c','Barclay St & Church St','5216.04',40.71291224,-74.01020234,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=417','false','false',NULL,'true'),
    (418,'66dc0bbd-0aca-11e7-82f6-3863bb44ef7c','Front St & Gold St','4927.04',40.70224,-73.982578,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=418','false','false',NULL,'true'),
    (419,'66dc0c53-0aca-11e7-82f6-3863bb44ef7c','Carlton Ave & Park Ave','4732.04',40.69580705,-73.97355569,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=419','false','false',NULL,'true'),
    (420,'66dc0cc7-0aca-11e7-82f6-3863bb44ef7c','Clermont Ave & Lafayette Ave','4461.01',40.68764484,-73.96968902,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=420','false','false',NULL,'true'),
    (421,'66dc0d3a-0aca-11e7-82f6-3863bb44ef7c','Clermont Ave & Park Ave','4692.01',40.69573398,-73.97129668,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=421','false','false',NULL,'true'),
    (422,'66dc0dab-0aca-11e7-82f6-3863bb44ef7c','W 59 St & 10 Ave','7023.04',40.770513,-73.988038,71,'KEY,CREDITCARD',79,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=422','false','false',NULL,'true'),
    (423,'66dc0e24-0aca-11e7-82f6-3863bb44ef7c','W 54 St & 9 Ave','6920.03',40.76584941,-73.98690506,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=423','false','false',NULL,'true'),
    (426,'66dc0e99-0aca-11e7-82f6-3863bb44ef7c','West St & Chambers St','5329.03',40.71754834,-74.01322069,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=426','false','true',NULL,'true'),
    (427,'66dc0f1b-0aca-11e7-82f6-3863bb44ef7c','Bus Slip & State St','4889.06',40.701907,-74.013942,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=427','false','false',NULL,'true'),
    (432,'66dc10d1-0aca-11e7-82f6-3863bb44ef7c','E 7 St & Avenue A','5626.07',40.72621788,-73.98379855,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=432','false','false',NULL,'true'),
    (434,'66dc11a7-0aca-11e7-82f6-3863bb44ef7c','9 Ave & W 18 St','6190.08',40.74317449,-74.00366443,71,'KEY,CREDITCARD',60,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=434','false','false',NULL,'true'),
    (435,'66dc120f-0aca-11e7-82f6-3863bb44ef7c','W 21 St & 6 Ave','6140.05',40.74173969,-73.99415556,71,'KEY,CREDITCARD',50,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=435','false','true',NULL,'true'),
    (436,'66dc1545-0aca-11e7-82f6-3863bb44ef7c','Hancock St & Bedford Ave','4255.05',40.68216564,-73.95399026,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=436','false','false',NULL,'true'),
    (437,'66dc1687-0aca-11e7-82f6-3863bb44ef7c','Macon St & Nostrand Ave','4214.03',40.6809833854,-73.9500479759,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=437','false','false',NULL,'true'),
    (438,'66dc1702-0aca-11e7-82f6-3863bb44ef7c','St Marks Pl & 1 Ave','5626.13',40.72779126,-73.98564945,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=438','false','false',NULL,'true'),
    (439,'66dc176f-0aca-11e7-82f6-3863bb44ef7c','E 4 St & 2 Ave','5593.04',40.7262807,-73.98978041,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=439','false','false',NULL,'true'),
    (440,'66dc17df-0aca-11e7-82f6-3863bb44ef7c','E 45 St & 3 Ave','6464.08',40.75255434,-73.97282625,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=440','false','false',NULL,'true'),
    (442,'66dc18c2-0aca-11e7-82f6-3863bb44ef7c','W 27 St & 7 Ave','6247.06',40.746647,-73.993915,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=442','false','false',NULL,'true'),
    (443,'66dc192f-0aca-11e7-82f6-3863bb44ef7c','Bedford Ave & S 9 St','5093.01',40.70853074,-73.96408963,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=443','false','false',NULL,'true'),
    (445,'66dc1beb-0aca-11e7-82f6-3863bb44ef7c','E 10 St & Avenue A','5659.05',40.72740794,-73.98142006,71,'KEY,CREDITCARD',79,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=445','false','false',NULL,'true'),
    (446,'66dc1c5c-0aca-11e7-82f6-3863bb44ef7c','W 24 St & 7 Ave','6257.03',40.74487634,-73.99529885,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=446','false','false',NULL,'true'),
    (447,'66dc1d0c-0aca-11e7-82f6-3863bb44ef7c','8 Ave & W 52 St','6816.07',40.76370739,-73.9851615,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=447','false','false',NULL,'true'),
    (448,'66dc1d80-0aca-11e7-82f6-3863bb44ef7c','W 37 St & 10 Ave','6611.02',40.75660359,-73.9979009,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=448','false','false',NULL,'true'),
    (450,'66dc1e55-0aca-11e7-82f6-3863bb44ef7c','W 49 St & 8 Ave','6747.06',40.76227205,-73.98788205,71,'KEY,CREDITCARD',67,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=450','false','false',NULL,'true'),
    (453,'66dc209c-0aca-11e7-82f6-3863bb44ef7c','W 22 St & 8 Ave','6224.03',40.74475148,-73.99915362,71,'KEY,CREDITCARD',66,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=453','false','false',NULL,'true'),
    (454,'66dc210e-0aca-11e7-82f6-3863bb44ef7c','E 51 St & 1 Ave','6532.06',40.75455731,-73.96592976,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=454','false','false',NULL,'true'),
    (455,'66dc2172-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 44 St','6379.03',40.75001986,-73.96905301,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=455','false','false',NULL,'true'),
    (456,'66dc21d4-0aca-11e7-82f6-3863bb44ef7c','E 53 St & Madison Ave','6659.03',40.7597108,-73.97402311,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=456','false','false',NULL,'true'),
    (458,'66dc22a7-0aca-11e7-82f6-3863bb44ef7c','11 Ave & W 27 St','6425.04',40.751396,-74.005226,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=458','false','false',NULL,'true'),
    (459,'66dc24b8-0aca-11e7-82f6-3863bb44ef7c','W 20 St & 11 Ave','6306.07',40.746745,-74.007756,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=459','false','true',NULL,'true'),
    (460,'66dc252e-0aca-11e7-82f6-3863bb44ef7c','S 4 St & Wythe Ave','5204.05',40.71285887,-73.96590294,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=460','false','false',NULL,'true'),
    (461,'66dc259a-0aca-11e7-82f6-3863bb44ef7c','E 20 St & 2 Ave','5971.08',40.73587678,-73.98205027,71,'KEY,CREDITCARD',56,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=461','false','false',NULL,'true'),
    (462,'66dc2606-0aca-11e7-82f6-3863bb44ef7c','W 22 St & 10 Ave','6306.06',40.74691959,-74.00451887,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=462','false','false',NULL,'true'),
    (464,'66dc28bd-0aca-11e7-82f6-3863bb44ef7c','E 56 St & 3 Ave','6691.11',40.75934501,-73.96759673,71,'KEY,CREDITCARD',53,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=464','false','false',NULL,'true'),
    (465,'66dc292c-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 41 St','6560.01',40.75513557,-73.98658032,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=465','false','false',NULL,'true'),
    (466,'66dc2995-0aca-11e7-82f6-3863bb44ef7c','W 25 St & 6 Ave','6215.04',40.74395411,-73.99144871,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=466','false','false',NULL,'true'),
    (467,'66dc29f8-0aca-11e7-82f6-3863bb44ef7c','Dean St & 4 Ave','4322.02',40.68312489,-73.97895137,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=467','false','false',NULL,'true'),
    (468,'66dc2bc5-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 56 St','6847.02',40.7652654,-73.98192338,71,'KEY,CREDITCARD',65,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=468','false','false',NULL,'true'),
    (469,'66dc2c78-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 53 St','6779.05',40.76344058,-73.98268129,71,'KEY,CREDITCARD',57,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=469','false','false',NULL,'true'),
    (470,'66dc36c3-0aca-11e7-82f6-3863bb44ef7c','W 20 St & 8 Ave','6224.05',40.74345335,-74.00004031,71,'KEY,CREDITCARD',72,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=470','false','false',NULL,'true'),
    (471,'66dc3782-0aca-11e7-82f6-3863bb44ef7c','Grand St & Havemeyer St','5267.08',40.71286844,-73.95698119,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=471','false','false',NULL,'true'),
    (472,'66dc3a1a-0aca-11e7-82f6-3863bb44ef7c','E 32 St & Park Ave','6280.12',40.7457121,-73.98194829,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=472','false','false',NULL,'true'),
    (473,'66dc3ab9-0aca-11e7-82f6-3863bb44ef7c','Rivington St & Chrystie St','5453.01',40.72110063,-73.9919254,71,'KEY,CREDITCARD',38,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=473','false','false',NULL,'true'),
    (474,'66dc3b97-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 29 St','6248.06',40.7451677,-73.98683077,71,'KEY,CREDITCARD',56,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=474','false','false',NULL,'true'),
    (476,'66dc3e89-0aca-11e7-82f6-3863bb44ef7c','E 31 St & 3 Ave','6239.08',40.74394314,-73.97966069,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=476','false','false',NULL,'true'),
    (477,'66dc3f08-0aca-11e7-82f6-3863bb44ef7c','W 41 St & 8 Ave','6602.03',40.75640548,-73.9900262,71,'KEY,CREDITCARD',71,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=477','false','false',NULL,'true'),
    (478,'66dc41bb-0aca-11e7-82f6-3863bb44ef7c','11 Ave & W 41 St','6726.01',40.76030096,-73.99884222,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=478','false','false',NULL,'true'),
    (479,'66dc42a0-0aca-11e7-82f6-3863bb44ef7c','9 Ave & W 45 St','6717.06',40.76019252,-73.9912551,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=479','false','false',NULL,'true'),
    (480,'66dc4334-0aca-11e7-82f6-3863bb44ef7c','W 53 St & 10 Ave','6890.01',40.76669671,-73.99061728,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=480','false','false',NULL,'true'),
    (481,'66dc4599-0aca-11e7-82f6-3863bb44ef7c','S 3 St & Bedford Ave','5235.05',40.71260486,-73.96264403,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=481','false','false',NULL,'true'),
    (482,'66dc462a-0aca-11e7-82f6-3863bb44ef7c','W 15 St & 7 Ave','6030.06',40.73935542,-73.99931783,71,'KEY,CREDITCARD',77,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=482','false','false',NULL,'true'),
    (483,'66dc481a-0aca-11e7-82f6-3863bb44ef7c','E 12 St & 3 Ave','5788.12',40.73223272,-73.98889957,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=483','false','false',NULL,'true'),
    (484,'66dc48ef-0aca-11e7-82f6-3863bb44ef7c','W 44 St & 5 Ave','6551.02',40.75500254,-73.98014437,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=484','false','false',NULL,'true'),
    (485,'66dc4b4c-0aca-11e7-82f6-3863bb44ef7c','W 37 St & 5 Ave','6398.06',40.75038009,-73.98338988,71,'KEY,CREDITCARD',40,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=485','false','false',NULL,'true'),
    (486,'66dc4bd9-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 29 St','6289.06',40.7462009,-73.98855723,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=486','false','false',NULL,'true'),
    (487,'66dc4dc3-0aca-11e7-82f6-3863bb44ef7c','E 20 St & FDR Drive','5886.02',40.73314259,-73.97573881,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=487','false','false',NULL,'true'),
    (489,'66dc51e9-0aca-11e7-82f6-3863bb44ef7c','10 Ave & W 28 St','6459.04',40.75066386,-74.00176802,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=489','false','false',NULL,'true'),
    (490,'66dc686c-0aca-11e7-82f6-3863bb44ef7c','8 Ave & W 33 St','6450.12',40.751551,-73.993934,71,'KEY,CREDITCARD',66,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=490','false','false',NULL,'true'),
    (491,'66dc6a86-0aca-11e7-82f6-3863bb44ef7c','E 24 St & Park Ave S','6131.10',40.74096374,-73.98602213,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=491','false','false',NULL,'true'),
    (492,'66dc6c79-0aca-11e7-82f6-3863bb44ef7c','W 33 St & 7 Ave','6407.07',40.75019995,-73.99093085,71,'KEY,CREDITCARD',68,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=492','false','false',NULL,'true'),
    (493,'66dc6e6d-0aca-11e7-82f6-3863bb44ef7c','W 45 St & 6 Ave','6593.13',40.7568001,-73.98291153,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=493','false','false',NULL,'true'),
    (494,'66dc7323-0aca-11e7-82f6-3863bb44ef7c','W 26 St & 8 Ave','6297.02',40.74734825,-73.99723551,71,'KEY,CREDITCARD',66,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=494','false','false',NULL,'true'),
    (495,'66dc73b0-0aca-11e7-82f6-3863bb44ef7c','W 47 St & 10 Ave','6824.07',40.76269882,-73.99301222,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=495','false','false',NULL,'true'),
    (496,'66dc741f-0aca-11e7-82f6-3863bb44ef7c','E 16 St & 5 Ave','6022.04',40.73726186,-73.99238967,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=496','false','false',NULL,'true'),
    (497,'66dc748f-0aca-11e7-82f6-3863bb44ef7c','E 17 St & Broadway','5980.07',40.73704984,-73.99009296,71,'KEY,CREDITCARD',66,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=497','false','true',NULL,'true'),
    (499,'66dc7580-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 60 St','6948.11',40.76915505,-73.98191841,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=499','false','true',NULL,'true'),
    (500,'66dc75ec-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 51 St','6779.04',40.76228826,-73.98336183,71,'KEY,CREDITCARD',52,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=500','false','false',NULL,'true'),
    (501,'66dc7659-0aca-11e7-82f6-3863bb44ef7c','FDR Drive & E 35 St','6230.04',40.744219,-73.97121214,71,'KEY,CREDITCARD',79,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=501','false','false',NULL,'true'),
    (502,'66dc76cd-0aca-11e7-82f6-3863bb44ef7c','Henry St & Grand St','5294.04',40.714211,-73.981095,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=502','false','false',NULL,'true'),
    (503,'66dc7773-0aca-11e7-82f6-3863bb44ef7c','E 20 St & Park Ave','6055.08',40.73827428,-73.98751968,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=503','false','false',NULL,'true'),
    (504,'66dc7802-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 16 St','5779.08',40.73221853,-73.98165557,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=504','false','false',NULL,'true'),
    (505,'66dc78c4-0aca-11e7-82f6-3863bb44ef7c','6 Ave & W 33 St','6364.07',40.74901271,-73.98848395,71,'KEY,CREDITCARD',52,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=505','false','false',NULL,'true'),
    (507,'66dc7957-0aca-11e7-82f6-3863bb44ef7c','E 25 St & 2 Ave','6046.02',40.73912601,-73.97973776,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=507','false','false',NULL,'true'),
    (508,'66dc79e6-0aca-11e7-82f6-3863bb44ef7c','W 46 St & 11 Ave','6795.01',40.76341379,-73.99667444,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=508','false','false',NULL,'true'),
    (509,'66dc7a7d-0aca-11e7-82f6-3863bb44ef7c','9 Ave & W 22 St','6266.06',40.7454973,-74.00197139,71,'KEY,CREDITCARD',61,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=509','false','false',NULL,'true'),
    (513,'66dc7cc3-0aca-11e7-82f6-3863bb44ef7c','W 56 St & 10 Ave','6955.01',40.768254,-73.988639,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=513','false','false',NULL,'true'),
    (514,'66dc7d58-0aca-11e7-82f6-3863bb44ef7c','12 Ave & W 40 St','6765.01',40.76087502,-74.00277668,71,'KEY,CREDITCARD',52,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=514','false','true',NULL,'true'),
    (515,'66dc7de9-0aca-11e7-82f6-3863bb44ef7c','W 43 St & 10 Ave','6756.01',40.76009437,-73.99461843,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=515','false','false',NULL,'true'),
    (516,'66dc7e75-0aca-11e7-82f6-3863bb44ef7c','E 47 St & 1 Ave','6498.09',40.75206862,-73.96784384,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=516','false','false',NULL,'true'),
    (517,'66dc7f02-0aca-11e7-82f6-3863bb44ef7c','Pershing Square South','6432.08',40.751581,-73.97791,71,'KEY,CREDITCARD',69,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=517','false','false',NULL,'true'),
    (518,'66dc7f8f-0aca-11e7-82f6-3863bb44ef7c','E 39 St & 2 Ave','6345.01',40.74780373,-73.9734419,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=518','false','false',NULL,'true'),
    (519,'66dc8025-0aca-11e7-82f6-3863bb44ef7c','Pershing Square North','6432.09',40.751873,-73.977706,71,'KEY,CREDITCARD',69,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=519','false','true',NULL,'true'),
    (520,'66dc80b4-0aca-11e7-82f6-3863bb44ef7c','W 52 St & 5 Ave','6700.01',40.75992262,-73.97648516,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=520','false','false',NULL,'true'),
    (522,'66dc81ce-0aca-11e7-82f6-3863bb44ef7c','E 51 St & Lexington Ave','6659.01',40.75714758,-73.97207836,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=522','false','false',NULL,'true'),
    (523,'66dc825c-0aca-11e7-82f6-3863bb44ef7c','W 38 St & 8 Ave','6526.03',40.75466591,-73.99138152,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=523','false','false',NULL,'true');
INSERT INTO Stations VALUES
    (525,'66dc8382-0aca-11e7-82f6-3863bb44ef7c','W 34 St & 11 Ave','6578.01',40.75594159,-74.0021163,71,'KEY,CREDITCARD',56,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=525','false','false',NULL,'true'),
    (526,'66dc840f-0aca-11e7-82f6-3863bb44ef7c','E 33 St & 5 Ave','6322.01',40.74765947,-73.98490707,71,'KEY,CREDITCARD',40,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=526','false','false',NULL,'true'),
    (528,'66dc8527-0aca-11e7-82f6-3863bb44ef7c','2 Ave & E 31 St','6197.02',40.74290902,-73.97706058,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=528','false','false',NULL,'true'),
    (529,'66dc85bb-0aca-11e7-82f6-3863bb44ef7c','W 42 St & 8 Ave','6602.05',40.7575699,-73.99098507,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=529','false','false',NULL,'true'),
    (530,'66dc864c-0aca-11e7-82f6-3863bb44ef7c','11 Ave & W 59 St','7059.01',40.77149671054441,-73.99046033620834,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=530','false','false',NULL,'true'),
    (531,'66dc86d9-0aca-11e7-82f6-3863bb44ef7c','Forsyth St & Broome St','5453.05',40.71893904,-73.99266288,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=531','false','false',NULL,'true'),
    (532,'66dc8768-0aca-11e7-82f6-3863bb44ef7c','S 5 Pl & S 5 St','5125.03',40.710451,-73.960876,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=532','false','true',NULL,'true'),
    (533,'66dc87f1-0aca-11e7-82f6-3863bb44ef7c','Broadway & W 38 St','6441.05',40.75299641,-73.98721619,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=533','false','false',NULL,'true'),
    (536,'66dc89ae-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 30 St','6079.03',40.74144387,-73.97536082,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=536','false','false',NULL,'true'),
    (539,'66dc8b6a-0aca-11e7-82f6-3863bb44ef7c','Metropolitan Ave & Bedford Ave','5308.04',40.71534825,-73.96024116,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=539','false','false',NULL,'true'),
    (540,'66dc8bfd-0aca-11e7-82f6-3863bb44ef7c','Lexington Ave & E 29 St','6164.09',40.74311555376486,-73.98215353488922,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=540','false','false',NULL,'true'),
    (545,'66dc8c90-0aca-11e7-82f6-3863bb44ef7c','E 23 St & 1 Ave','5929.01',40.736502,-73.97809472,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=545','false','false',NULL,'true'),
    (546,'66dc8d1d-0aca-11e7-82f6-3863bb44ef7c','E 30 St & Park Ave S','6206.08',40.74444921,-73.98303529,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=546','false','false',NULL,'true'),
    (2000,'66dc8db1-0aca-11e7-82f6-3863bb44ef7c','Front St & Washington St','4936.01',40.70255088,-73.98940236,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2000','false','false',NULL,'true'),
    (2002,'66dc8eb1-0aca-11e7-82f6-3863bb44ef7c','Wythe Ave & Metropolitan Ave','5348.02',40.716887,-73.963198,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2002','false','false',NULL,'true'),
    (2003,'66dc8f1f-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 18 St','5854.09',40.733812191966315,-73.98054420948029,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2003','false','false',NULL,'true'),
    (2005,'66dc9000-0aca-11e7-82f6-3863bb44ef7c','Railroad Ave & Kay Ave','4990.01',40.70531194,-73.97100056,71,'KEY,CREDITCARD',12,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2005','false','false',NULL,'true'),
    (2006,'66dc9068-0aca-11e7-82f6-3863bb44ef7c','Central Park S & 6 Ave','6876.04',40.76590936,-73.97634151,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2006','false','true',NULL,'true'),
    (2008,'66dc90d5-0aca-11e7-82f6-3863bb44ef7c','Little West St & 1 Pl','5001.08',40.70569254,-74.01677685,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2008','false','true',NULL,'true'),
    (2009,'66dc9143-0aca-11e7-82f6-3863bb44ef7c','Catherine St & Monroe St','5128.04',40.71117444,-73.99682619,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2009','false','false',NULL,'true'),
    (2010,'66dc91b5-0aca-11e7-82f6-3863bb44ef7c','Grand St & Greene St','5500.02',40.72165481,-74.00234737,71,'KEY,CREDITCARD',3,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2010','false','false',NULL,'true'),
    (2012,'66dc9223-0aca-11e7-82f6-3863bb44ef7c','E 27 St & 1 Ave','6004.06',40.739445,-73.976806,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2012','false','false',NULL,'true'),
    (2017,'66dca5f3-0aca-11e7-82f6-3863bb44ef7c','E 43 St & 2 Ave','6422.08',40.75022392,-73.97121414,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2017','false','false',NULL,'true'),
    (2021,'66dca682-0aca-11e7-82f6-3863bb44ef7c','W 45 St & 8 Ave','6676.02',40.75929124,-73.98859651,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2021','false','false',NULL,'true'),
    (2022,'66dca6f4-0aca-11e7-82f6-3863bb44ef7c','E 60 St & York Ave','6682.08',40.759107,-73.959223,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=2022','false','false',NULL,'true'),
    (3002,'66dca92d-0aca-11e7-82f6-3863bb44ef7c','South End Ave & Liberty St','5184.07',40.711512,-74.015756,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3002','false','true',NULL,'true'),
    (3016,'66dcac42-0aca-11e7-82f6-3863bb44ef7c','Kent Ave & N 7 St','5489.03',40.72036775298455,-73.96165072917938,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3016','false','false',NULL,'true'),
    (3041,'66dcb9f7-0aca-11e7-82f6-3863bb44ef7c','Kingston Ave & Herkimer St','4205.06',40.67890679,-73.94142771,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3041','false','false',NULL,'true'),
    (3042,'66dcba5e-0aca-11e7-82f6-3863bb44ef7c','Fulton St & Utica Ave','4228.02',40.6794268,-73.9298911,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3042','false','false',NULL,'true'),
    (3043,'66dcbac5-0aca-11e7-82f6-3863bb44ef7c','Lewis Ave & Decatur St','4237.01',40.6814598,-73.934903,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3043','false','false',NULL,'true'),
    (3044,'66dcbb2c-0aca-11e7-82f6-3863bb44ef7c','Albany Ave & Fulton St','4237.02',40.6800105,-73.938475,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3044','false','false',NULL,'true'),
    (3046,'66dcbbfe-0aca-11e7-82f6-3863bb44ef7c','Marcus Garvey Blvd & Macon St','4278.03',40.682601,-73.938037,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3046','false','false',NULL,'true'),
    (3047,'66dcbdc2-0aca-11e7-82f6-3863bb44ef7c','Halsey St & Tompkins Ave','4319.07',40.6823687,-73.944118,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3047','false','false',NULL,'true'),
    (3048,'66dcbe7c-0aca-11e7-82f6-3863bb44ef7c','Putnam Ave & Nostrand Ave','4327.09',40.68402,-73.94977,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3048','false','false',NULL,'true'),
    (3049,'66dcbefb-0aca-11e7-82f6-3863bb44ef7c','Cambridge Pl & Gates Ave','4377.04',40.68488,-73.96304,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3049','false','false',NULL,'true'),
    (3050,'66dcbf69-0aca-11e7-82f6-3863bb44ef7c','Putnam Ave & Throop Ave','4392.04',40.6851532,-73.94111,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3050','false','false',NULL,'true'),
    (3052,'66dcc047-0aca-11e7-82f6-3863bb44ef7c','Lewis Ave & Madison St','4425.02',40.686312,-73.935775,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3052','false','false',NULL,'true'),
    (3053,'66dcc0b2-0aca-11e7-82f6-3863bb44ef7c','Marcy Ave & Lafayette Ave','4476.03',40.6900815,-73.947915,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3053','false','false',NULL,'true'),
    (3054,'66dcc30b-0aca-11e7-82f6-3863bb44ef7c','Greene Ave & Throop Ave','4510.04',40.6894932,-73.942061,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3054','false','false',NULL,'true'),
    (3055,'66dcc37f-0aca-11e7-82f6-3863bb44ef7c','Greene Ave & Nostrand Ave','4519.02',40.6883337,-73.950916,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3055','false','false',NULL,'true'),
    (3056,'66dcc3e5-0aca-11e7-82f6-3863bb44ef7c','Kosciuszko St & Nostrand Ave','4519.04',40.69072549,-73.95133465,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3056','false','false',NULL,'true'),
    (3057,'66dcc44a-0aca-11e7-82f6-3863bb44ef7c','Kosciuszko St & Tompkins Ave','4553.04',40.69128258,-73.9452416,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3057','false','false',NULL,'true'),
    (3058,'66dcc5ca-0aca-11e7-82f6-3863bb44ef7c','Lewis Ave & Kosciuszko St','4617.01',40.69237074,-73.93705428,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3058','false','false',NULL,'true'),
    (3059,'66dcc65c-0aca-11e7-82f6-3863bb44ef7c','Pulaski St & Marcus Garvey Blvd','4656.03',40.6933982,-73.939877,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3059','false','false',NULL,'true'),
    (3060,'66dcc8b3-0aca-11e7-82f6-3863bb44ef7c','Willoughby Ave & Tompkins Ave','4665.02',40.69425403,-73.94626915,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3060','false','false',NULL,'true'),
    (3061,'66dcc920-0aca-11e7-82f6-3863bb44ef7c','Throop Ave & Myrtle Ave','4697.01',40.69622937,-73.94371094,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3061','false','false',NULL,'true'),
    (3062,'66dcca0d-0aca-11e7-82f6-3863bb44ef7c','Myrtle Ave & Marcy Ave','4707.03',40.69539817,-73.94954908,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3062','false','true',NULL,'true'),
    (3063,'66dcca76-0aca-11e7-82f6-3863bb44ef7c','Nostrand Ave & Myrtle Ave','4707.04',40.69527008,-73.95238108,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3063','false','false',NULL,'true'),
    (3064,'66dccad8-0aca-11e7-82f6-3863bb44ef7c','Myrtle Ave & Lewis Ave','4729.01',40.69681963,-73.93756926,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3064','false','false',NULL,'true'),
    (3065,'66dccc99-0aca-11e7-82f6-3863bb44ef7c','Union Ave & Wallabout St','4818.03',40.70029511,-73.95032283,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3065','false','false',NULL,'true'),
    (3066,'66dcccfe-0aca-11e7-82f6-3863bb44ef7c','Tompkins Ave & Hopkins St','4850.04',40.69957608,-73.94708417,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3066','false','false',NULL,'true'),
    (3067,'66dccd65-0aca-11e7-82f6-3863bb44ef7c','Broadway & Whipple St','4883.03',40.7016657,-73.9437303,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3067','false','false',NULL,'true'),
    (3068,'66dce2a4-0aca-11e7-82f6-3863bb44ef7c','Humboldt St & Varet St','4956.02',40.7031724,-73.940636,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3068','false','false',NULL,'true'),
    (3069,'66dce4fc-0aca-11e7-82f6-3863bb44ef7c','Lorimer St & Broadway','4965.01',40.70411791,-73.94818595,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3069','false','false',NULL,'true'),
    (3070,'66dce567-0aca-11e7-82f6-3863bb44ef7c','McKibbin St & Manhattan Ave','4996.08',40.70510918,-73.94407279,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3070','false','false',NULL,'true'),
    (3071,'66dce5c9-0aca-11e7-82f6-3863bb44ef7c','Boerum St & Broadway','5004.02',40.70538077,-73.94976519,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3071','false','false',NULL,'true'),
    (3072,'66dce660-0aca-11e7-82f6-3863bb44ef7c','Leonard St & Boerum St','5036.06',40.70583339,-73.94644578,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3072','false','false',NULL,'true'),
    (3074,'66dce8db-0aca-11e7-82f6-3863bb44ef7c','Montrose Ave & Bushwick Ave','5068.02',40.70767788,-73.94016171,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3074','false','false',NULL,'true'),
    (3075,'66dce9b5-0aca-11e7-82f6-3863bb44ef7c','Division Ave & Marcy Ave','5084.03',40.70708701,-73.95796783,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3075','false','false',NULL,'true'),
    (3076,'66dcec6b-0aca-11e7-82f6-3863bb44ef7c','Scholes St & Manhattan Ave','5108.01',40.70870368,-73.9448625,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3076','false','false',NULL,'true'),
    (3077,'66dcecfa-0aca-11e7-82f6-3863bb44ef7c','Stagg St & Union Ave','5117.05',40.70877084,-73.95095259,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3077','false','false',NULL,'true'),
    (3078,'66dced76-0aca-11e7-82f6-3863bb44ef7c','Broadway & Roebling St','5125.07',40.70924826276157,-73.96063148975372,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3078','false','false',NULL,'true'),
    (3080,'66dcf023-0aca-11e7-82f6-3863bb44ef7c','S 4 St & Rodney St','5156.05',40.70934,-73.95608,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3080','false','false',NULL,'true'),
    (3081,'66dcf0b3-0aca-11e7-82f6-3863bb44ef7c','Graham Ave & Grand St','5178.06',40.711863,-73.944024,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3081','false','false',NULL,'true'),
    (3082,'66dcf30d-0aca-11e7-82f6-3863bb44ef7c','Hope St & Union Ave','5187.03',40.71167351,-73.95141312,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3082','false','false',NULL,'true'),
    (3083,'66dcf394-0aca-11e7-82f6-3863bb44ef7c','Bushwick Ave & Powers St','5250.05',40.71247661,-73.94100005,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3083','false','false',NULL,'true'),
    (3085,'66dcf640-0aca-11e7-82f6-3863bb44ef7c','Roebling St & N 4 St','5267.09',40.71469,-73.95739,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3085','false','false',NULL,'true'),
    (3086,'66dcf897-0aca-11e7-82f6-3863bb44ef7c','Graham Ave & Conselyea St','5291.05',40.715143,-73.944507,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3086','false','false',NULL,'true'),
    (3087,'66dcf922-0aca-11e7-82f6-3863bb44ef7c','Metropolitan Ave & Meeker Ave','5300.05',40.71413311,-73.95234386,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3087','false','false',NULL,'true'),
    (3088,'66dcfaf6-0aca-11e7-82f6-3863bb44ef7c','Union Ave & Jackson St','5300.06',40.7160751,-73.952029,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3088','false','false',NULL,'true'),
    (3092,'66dd01c5-0aca-11e7-82f6-3863bb44ef7c','Berry St & N 8 St','5379.09',40.7190095,-73.95852515,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3092','false','false',NULL,'true'),
    (3093,'66dd039b-0aca-11e7-82f6-3863bb44ef7c','N 6 St & Bedford Ave','5379.10',40.71745169,-73.95850939,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3093','false','false',NULL,'true'),
    (3094,'66dd056e-0aca-11e7-82f6-3863bb44ef7c','Graham Ave & Withers St','5403.04',40.7169811,-73.94485918,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3094','false','false',NULL,'true'),
    (3095,'66dd0808-0aca-11e7-82f6-3863bb44ef7c','Graham Ave & Herbert St','5403.05',40.71929301,-73.94500379,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3095','false','false',NULL,'true'),
    (3096,'66dd1585-0aca-11e7-82f6-3863bb44ef7c','Union Ave & N 12 St','5411.07',40.71924,-73.95242,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3096','false','false',NULL,'true'),
    (3100,'66dd17a5-0aca-11e7-82f6-3863bb44ef7c','Nassau Ave & Newell St','5623.03',40.724812564400175,-73.94752621650696,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3100','false','false',NULL,'true'),
    (3101,'66dd1846-0aca-11e7-82f6-3863bb44ef7c','N 12 St & Bedford Ave','5450.04',40.72079821,-73.95484712,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3101','false','false',NULL,'true'),
    (3102,'66dd18dd-0aca-11e7-82f6-3863bb44ef7c','Driggs Ave & Lorimer St','5481.04',40.72179134,-73.9504154,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3102','false','false',NULL,'true'),
    (3105,'66dd1ad8-0aca-11e7-82f6-3863bb44ef7c','N 15 St & Wythe Ave','5520.09',40.724055,-73.955736,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3105','false','false',NULL,'true'),
    (3106,'66dd1b65-0aca-11e7-82f6-3863bb44ef7c','Driggs Ave & N Henry St','5542.04',40.72325,-73.94308,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3106','false','false',NULL,'true'),
    (3107,'66dd1bf3-0aca-11e7-82f6-3863bb44ef7c','Bedford Ave & Nassau Ave','5550.05',40.72311651,-73.95212324,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3107','false','false',NULL,'true'),
    (3108,'66dd1c7f-0aca-11e7-82f6-3863bb44ef7c','Nassau Ave & Russell St','5581.01',40.72557,-73.94434,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3108','false','false',NULL,'true'),
    (3109,'66dd1d0f-0aca-11e7-82f6-3863bb44ef7c','Banker St & Meserole Ave','5633.04',40.72606,-73.95621,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3109','false','false',NULL,'true'),
    (3110,'66dd1d9c-0aca-11e7-82f6-3863bb44ef7c','Meserole Ave & Manhattan Ave','5666.04',40.72708584,-73.95299117,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3110','false','false',NULL,'true'),
    (3112,'66dd1eb2-0aca-11e7-82f6-3863bb44ef7c','Milton St & Franklin St','5752.07',40.72906,-73.95779,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3112','false','false',NULL,'true'),
    (3113,'66dd1f44-0aca-11e7-82f6-3863bb44ef7c','Greenpoint Ave & Manhattan Ave','5785.05',40.73026,-73.95394,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3113','false','false',NULL,'true'),
    (3115,'66dd2060-0aca-11e7-82f6-3863bb44ef7c','India St & Manhattan Ave','5826.02',40.73232194,-73.9550858,71,'KEY,CREDITCARD',50,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3115','false','false',NULL,'true'),
    (3116,'66dd20eb-0aca-11e7-82f6-3863bb44ef7c','Huron St & Franklin St','5869.04',40.73266,-73.95826,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3116','false','false',NULL,'true'),
    (3117,'66dd217d-0aca-11e7-82f6-3863bb44ef7c','Franklin St & Dupont St','5944.01',40.73564,-73.95866,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3117','false','false',NULL,'true'),
    (3118,'66dd2208-0aca-11e7-82f6-3863bb44ef7c','McGuinness Blvd & Eagle St','5977.01',40.73555,-73.95284,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3118','false','false',NULL,'true'),
    (3119,'66dd2292-0aca-11e7-82f6-3863bb44ef7c','Vernon Blvd & 50 Ave','6170.02',40.74232744,-73.95411749,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3119','false','false',NULL,'true'),
    (3121,'66dd23a9-0aca-11e7-82f6-3863bb44ef7c','Jackson Ave & 46 Rd','6203.02',40.74524768,-73.94733276,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3121','false','false',NULL,'true'),
    (3122,'66dd243c-0aca-11e7-82f6-3863bb44ef7c','48 Ave & 5 St','6212.04',40.744363287066875,-73.9558732509613,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3122','false','false',NULL,'true'),
    (3123,'66dd24ca-0aca-11e7-82f6-3863bb44ef7c','31 St & Thomson Ave','6227.02',40.74469738,-73.93540375,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3123','false','false',NULL,'true'),
    (3124,'66dd2556-0aca-11e7-82f6-3863bb44ef7c','46 Ave & 5 St','6286.02',40.74731,-73.95451,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3124','false','false',NULL,'true'),
    (3125,'66dd25e0-0aca-11e7-82f6-3863bb44ef7c','45 Rd & 11 St','6319.01',40.74708586,-73.94977234,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3125','false','false',NULL,'true'),
    (3126,'66dd266a-0aca-11e7-82f6-3863bb44ef7c','44 Dr & Jackson Ave','6352.01',40.74718234,-73.9432635,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3126','false','false',NULL,'true'),
    (3127,'66dd26f9-0aca-11e7-82f6-3863bb44ef7c','9 St & 44 Rd','6361.03',40.74966,-73.9521,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3127','false','false',NULL,'true'),
    (3128,'66dd2786-0aca-11e7-82f6-3863bb44ef7c','21 St & 43 Ave','6395.01',40.75052534,-73.94594845,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3128','false','false',NULL,'true'),
    (3129,'66dd2811-0aca-11e7-82f6-3863bb44ef7c','Queens Plaza North & Crescent St','6429.01',40.75110165,-73.94073717,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3129','false','true',NULL,'true'),
    (3130,'66dd3cb4-0aca-11e7-82f6-3863bb44ef7c','21 St & Queens Plaza North','6471.02',40.75325964,-73.94335788,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3130','false','false',NULL,'true'),
    (3131,'66dd3d7f-0aca-11e7-82f6-3863bb44ef7c','E 68 St & 3 Ave','6896.16',40.76712840349542,-73.96224617958069,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3131','false','false',NULL,'true'),
    (3132,'66dd3e14-0aca-11e7-82f6-3863bb44ef7c','E 59 St & Madison Ave','6801.01',40.76350532,-73.97109243,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3132','false','false',NULL,'true'),
    (3134,'66dd3f33-0aca-11e7-82f6-3863bb44ef7c','3 Ave & E 62 St','6762.04',40.76312584,-73.96526895,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3134','false','false',NULL,'true'),
    (3135,'66dd3fc3-0aca-11e7-82f6-3863bb44ef7c','E 75 St & 3 Ave','6991.12',40.77112927,-73.95772297,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3135','false','false',NULL,'true'),
    (3136,'66dd4051-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 63 St','6904.06',40.766368,-73.971518,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3136','false','false',NULL,'true'),
    (3137,'66dd40dd-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 73 St','7100.07',40.77282817,-73.96685276,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3137','false','true',NULL,'true'),
    (3139,'66dd41ef-0aca-11e7-82f6-3863bb44ef7c','E 72 St & Park Ave','6998.08',40.77118287540658,-73.96409422159195,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3139','false','false',NULL,'true'),
    (3140,'66dd427e-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 78 St','7020.09',40.77140426,-73.9535166,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3140','false','false',NULL,'true'),
    (3141,'66dd42eb-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 68 St','6822.09',40.76500525,-73.95818491,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3141','false','false',NULL,'true'),
    (3142,'66dd4356-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 62 St','6753.08',40.7612274,-73.96094022,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3142','false','false',NULL,'true'),
    (3143,'66dd43bd-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 78 St','7161.08',40.77632142182271,-73.96427392959595,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3143','false','false',NULL,'true'),
    (3144,'66dd4423-0aca-11e7-82f6-3863bb44ef7c','E 81 St & Park Ave','7188.10',40.77677702,-73.9590097,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3144','false','false',NULL,'true'),
    (3145,'66dd448f-0aca-11e7-82f6-3863bb44ef7c','E 84 St & Park Ave','7243.04',40.77862688,-73.95772073,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3145','false','false',NULL,'true'),
    (3146,'66dd44f7-0aca-11e7-82f6-3863bb44ef7c','E 81 St & 3 Ave','7154.07',40.77573034,-73.9567526,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3146','false','false',NULL,'true'),
    (3147,'66dd455e-0aca-11e7-82f6-3863bb44ef7c','E 85 St & 3 Ave','7212.05',40.77801203,-73.95407149,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3147','false','false',NULL,'true'),
    (3148,'66dd45c7-0aca-11e7-82f6-3863bb44ef7c','E 84 St & 1 Ave','7180.02',40.77565541,-73.95068615,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3148','false','false',NULL,'true'),
    (3150,'66dd46a2-0aca-11e7-82f6-3863bb44ef7c','E 85 St & York Ave','7146.04',40.77536905,-73.94803392,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3150','false','false',NULL,'true'),
    (3151,'66dd470b-0aca-11e7-82f6-3863bb44ef7c','E 81 St & York Ave','7084.12',40.7728384,-73.94989233,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3151','false','false',NULL,'true'),
    (3152,'66dd4772-0aca-11e7-82f6-3863bb44ef7c','3 Ave & E 71 St','6960.10',40.76873687,-73.96119945,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3152','false','false',NULL,'true'),
    (3154,'66dd4841-0aca-11e7-82f6-3863bb44ef7c','E 77 St & 3 Ave','7092.06',40.77314236,-73.95856158,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3154','false','false',NULL,'true'),
    (3156,'66dd491c-0aca-11e7-82f6-3863bb44ef7c','E 72 St & York Ave','6889.12',40.76663814,-73.95348296,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3156','false','false',NULL,'true'),
    (3157,'66dd4981-0aca-11e7-82f6-3863bb44ef7c','East End Ave & E 86 St','7113.08',40.77518615,-73.94446054,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3157','false','false',NULL,'true'),
    (3158,'66dd49eb-0aca-11e7-82f6-3863bb44ef7c','W 63 St & Broadway','7052.01',40.77163851,-73.98261428,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3158','false','false',NULL,'true'),
    (3159,'66dd4a52-0aca-11e7-82f6-3863bb44ef7c','W 67 St & Broadway','7116.04',40.77492513,-73.98266566,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3159','false','false',NULL,'true'),
    (3160,'66dd4ac1-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 76 St','7253.04',40.77896784,-73.97374737,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3160','false','true',NULL,'true'),
    (3161,'66dd4b2b-0aca-11e7-82f6-3863bb44ef7c','W 76 St & Columbus Ave','7281.09',40.7801839724239,-73.97728532552719,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3161','false','false',NULL,'true'),
    (3162,'66dd4b91-0aca-11e7-82f6-3863bb44ef7c','W 78 St & Broadway','7311.07',40.78339981,-73.98093133,71,'KEY,CREDITCARD',3,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3162','false','false',NULL,'true'),
    (3163,'66dd4bf7-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 68 St','7079.06',40.7734066,-73.97782542,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3163','false','true',NULL,'true'),
    (3164,'66dd4c5f-0aca-11e7-82f6-3863bb44ef7c','Columbus Ave & W 72 St','7175.05',40.7770575,-73.97898475,71,'KEY,CREDITCARD',67,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3164','false','false',NULL,'true'),
    (3165,'66dd4ccc-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 72 St','7141.07',40.77579376683666,-73.9762057363987,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3165','false','true',NULL,'true'),
    (3166,'66dd4d70-0aca-11e7-82f6-3863bb44ef7c','Riverside Dr & W 72 St','7288.04',40.78057799010334,-73.98562431335449,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3166','false','false',NULL,'true'),
    (3167,'66dd4de9-0aca-11e7-82f6-3863bb44ef7c','Amsterdam Ave & W 73 St','7260.09',40.77966809007312,-73.98093044757842,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3167','false','false',NULL,'true'),
    (3168,'66dd4e54-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 85 St','7354.02',40.78472675,-73.96961715,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3168','false','true',NULL,'true'),
    (3169,'66dd4ec7-0aca-11e7-82f6-3863bb44ef7c','Riverside Dr & W 82 St','7388.10',40.78720869,-73.98128127,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3169','false','false',NULL,'true'),
    (3170,'66dd4f31-0aca-11e7-82f6-3863bb44ef7c','W 84 St & Columbus Ave','7382.04',40.78499979,-73.97283406,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3170','false','false',NULL,'true'),
    (3171,'66dd4f9b-0aca-11e7-82f6-3863bb44ef7c','Amsterdam Ave & W 82 St','7360.10',40.78524672,-73.97667321,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3171','false','false',NULL,'true'),
    (3172,'66dd515d-0aca-11e7-82f6-3863bb44ef7c','W 74 St & Columbus Ave','7230.10',40.7785669,-73.97754961,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3172','false','false',NULL,'true'),
    (3173,'66dd51e6-0aca-11e7-82f6-3863bb44ef7c','Riverside Blvd & W 67 St','7183.03',40.777507027547976,-73.98888587951659,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3173','false','false',NULL,'true'),
    (3175,'66dd52c8-0aca-11e7-82f6-3863bb44ef7c','W 70 St & Amsterdam Ave','7207.08',40.77748046,-73.98288594,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3175','false','false',NULL,'true'),
    (3177,'66dd539f-0aca-11e7-82f6-3863bb44ef7c','W 84 St & Broadway','7409.08',40.7867947,-73.977112,71,'KEY,CREDITCARD',63,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3177','false','false',NULL,'true'),
    (3178,'66dd5407-0aca-11e7-82f6-3863bb44ef7c','Riverside Dr & W 78 St','7340.06',40.78414472,-73.98362492,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3178','false','false',NULL,'true'),
    (3179,'66dd546c-0aca-11e7-82f6-3863bb44ef7c','Park Ave & Marcus Garvey Blvd','4768.02',40.698617,-73.941342,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3179','false','false',NULL,'true'),
    (3182,'66dd5814-0aca-11e7-82f6-3863bb44ef7c','Yankee Ferry Terminal','4440.01',40.686931,-74.016966,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3182','false','false',NULL,'true'),
    (3184,'66dd58f2-0aca-11e7-82f6-3863bb44ef7c','Paulus Hook','JC002',40.7141454,-74.0335519,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3184','false','false',NULL,'true'),
    (3185,'66dd5960-0aca-11e7-82f6-3863bb44ef7c','City Hall','JC003',40.7177325,-74.043845,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3185','false','false',NULL,'true'),
    (3186,'66dd59d5-0aca-11e7-82f6-3863bb44ef7c','Grove St PATH','JC005',40.71958611647166,-74.04311746358871,70,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3186','false','false',NULL,'true'),
    (3187,'66dd5a42-0aca-11e7-82f6-3863bb44ef7c','Warren St','JC006',40.7211236,-74.03805095,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3187','false','false',NULL,'true'),
    (3191,'66dd5e69-0aca-11e7-82f6-3863bb44ef7c','Union St','JC051',40.7182113,-74.0836394,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3191','false','false',NULL,'true'),
    (3192,'66dd5f24-0aca-11e7-82f6-3863bb44ef7c','Liberty Light Rail','JC052',40.7112423,-74.0557013,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3192','false','false',NULL,'true'),
    (3193,'66dd5f99-0aca-11e7-82f6-3863bb44ef7c','Lincoln Park','JC053',40.7246050998869,-74.07840594649315,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3193','false','false',NULL,'true'),
    (3194,'66dd6000-0aca-11e7-82f6-3863bb44ef7c','McGinley Square','JC055',40.7253399253558,-74.06762212514877,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3194','false','false',NULL,'true'),
    (3195,'66dd606c-0aca-11e7-82f6-3863bb44ef7c','Sip Ave','JC056',40.73089709786179,-74.06391263008118,70,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3195','false','false',NULL,'true'),
    (3196,'66dd630c-0aca-11e7-82f6-3863bb44ef7c','Riverview Park','JC057',40.7443187,-74.0439909,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3196','false','false',NULL,'true'),
    (3198,'66dd63de-0aca-11e7-82f6-3863bb44ef7c','Heights Elevator','JC059',40.748715945380226,-74.04044330120087,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3198','false','false',NULL,'true'),
    (3199,'66dd6441-0aca-11e7-82f6-3863bb44ef7c','Newport Pkwy','JC008',40.7287448,-74.0321082,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3199','false','false',NULL,'true'),
    (3201,'66dd650d-0aca-11e7-82f6-3863bb44ef7c','Dey St','JC065',40.737711,-74.066921,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3201','false','false',NULL,'true'),
    (3202,'66dd6721-0aca-11e7-82f6-3863bb44ef7c','Newport PATH','JC066',40.7272235,-74.0337589,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3202','false','false',NULL,'true'),
    (3203,'66dd7b37-0aca-11e7-82f6-3863bb44ef7c','Hamilton Park','JC009',40.727595966,-74.044247311,70,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3203','false','false',NULL,'true'),
    (3205,'66dd7c33-0aca-11e7-82f6-3863bb44ef7c','JC Medical Center','JC011',40.71653978099194,-74.0496379137039,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3205','false','false',NULL,'true'),
    (3206,'66dd7cab-0aca-11e7-82f6-3863bb44ef7c','Hilltop','JC019',40.7311689,-74.0575736,70,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3206','false','false',NULL,'true'),
    (3207,'66dd7f10-0aca-11e7-82f6-3863bb44ef7c','Oakland Ave','JC022',40.7376037,-74.0524783,70,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3207','false','false',NULL,'true'),
    (3209,'66dd7fe2-0aca-11e7-82f6-3863bb44ef7c','Brunswick St','JC023',40.7241765,-74.0506564,70,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3209','false','false',NULL,'true'),
    (3210,'66dd8043-0aca-11e7-82f6-3863bb44ef7c','Pershing Field','JC024',40.742677141,-74.051788633,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3210','false','false',NULL,'true'),
    (3211,'66dd80ac-0aca-11e7-82f6-3863bb44ef7c','Newark Ave','JC032',40.72152515,-74.046304543,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3211','false','false',NULL,'true'),
    (3212,'66dd836d-0aca-11e7-82f6-3863bb44ef7c','Christ Hospital','JC034',40.734785818,-74.050443636,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3212','false','false',NULL,'true'),
    (3213,'66dd83fc-0aca-11e7-82f6-3863bb44ef7c','Van Vorst Park','JC035',40.71848892,-74.047726625,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3213','false','false',NULL,'true'),
    (3214,'66dd8479-0aca-11e7-82f6-3863bb44ef7c','Essex Light Rail','JC038',40.7127742,-74.0364857,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3214','false','false',NULL,'true'),
    (3220,'66dd8b48-0aca-11e7-82f6-3863bb44ef7c','5 Corners Library','JC018',40.734961020009514,-74.0595030784607,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3220','false','false',NULL,'true'),
    (3221,'66dd8bd9-0aca-11e7-82f6-3863bb44ef7c','47 Ave & 31 St','6151.03',40.743,-73.93561,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3221','false','false',NULL,'true'),
    (3225,'66dd9183-0aca-11e7-82f6-3863bb44ef7c','Baldwin at Montgomery','JC020',40.7236589,-74.0641943,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3225','false','false',NULL,'true'),
    (3231,'66dd9b0f-0aca-11e7-82f6-3863bb44ef7c','E 67 St & Park Ave','6932.14',40.76780080148132,-73.96592080593109,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3231','false','false',NULL,'true'),
    (3232,'66dd9dba-0aca-11e7-82f6-3863bb44ef7c','Bond St & Fulton St','4479.06',40.68962188790333,-73.98304268717766,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3232','false','false',NULL,'true'),
    (3233,'66dd9fa6-0aca-11e7-82f6-3863bb44ef7c','E 48 St & 5 Ave','6626.01',40.75724567911726,-73.97805914282799,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3233','false','false',NULL,'true'),
    (3235,'66dda376-0aca-11e7-82f6-3863bb44ef7c','E 41 St & Madison Ave','6474.12',40.752165280621966,-73.97992193698882,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3235','false','false',NULL,'true'),
    (3236,'66dda55f-0aca-11e7-82f6-3863bb44ef7c','W 42 St & Dyer Ave','6644.07',40.75898481399634,-73.99379968643188,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3236','false','false',NULL,'true'),
    (3241,'66ddb595-0aca-11e7-82f6-3863bb44ef7c','Monroe St & Tompkins Ave','4434.06',40.686203,-73.944694,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3241','false','false',NULL,'true'),
    (3242,'66ddb605-0aca-11e7-82f6-3863bb44ef7c','Schermerhorn St & Court St','4565.04',40.69102925677968,-73.99183362722397,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3242','false','false',NULL,'true'),
    (3243,'66ddb66e-0aca-11e7-82f6-3863bb44ef7c','E 58 St & 1 Ave (NE Corner)','6682.03',40.75892386377695,-73.96226227283478,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3243','false','false',NULL,'true'),
    (3244,'66ddb6d9-0aca-11e7-82f6-3863bb44ef7c','University Pl & E 8 St','5755.14',40.73143724085228,-73.99490341544151,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3244','false','false',NULL,'true'),
    (3246,'66ddb7bf-0aca-11e7-82f6-3863bb44ef7c','Montague St & Clinton St','4677.06',40.694281141397326,-73.99230033159256,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3246','false','false',NULL,'true'),
    (3249,'66ddb95a-0aca-11e7-82f6-3863bb44ef7c','Verona Pl & Fulton St','4124.04',40.6803560840434,-73.9476791024208,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3249','false','false',NULL,'true'),
    (3254,'66ddbc89-0aca-11e7-82f6-3863bb44ef7c','Soissons Landing','4590.01',40.69231660719192,-74.01486575603485,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3254','false','false',NULL,'true'),
    (3255,'66ddbd20-0aca-11e7-82f6-3863bb44ef7c','8 Ave & W 31 St','6450.05',40.7505853470215,-73.9946848154068,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3255','false','false',NULL,'true'),
    (3256,'66ddbdb1-0aca-11e7-82f6-3863bb44ef7c','Pier 40 - Hudson River Park','5696.03',40.7277140777778,-74.01129573583603,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3256','false','false',NULL,'true'),
    (3259,'66ddbf5a-0aca-11e7-82f6-3863bb44ef7c','9 Ave & W 28 St','6416.08',40.74937024193277,-73.99923384189606,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3259','false','false',NULL,'true'),
    (3260,'66ddd369-0aca-11e7-82f6-3863bb44ef7c','Mercer St & Bleecker St','5679.05',40.72706363348306,-73.99662137031554,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3260','false','false',NULL,'true'),
    (3263,'66ddd545-0aca-11e7-82f6-3863bb44ef7c','Cooper Square & Astor Pl','5712.03',40.72951496224949,-73.99075269699097,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3263','false','false',NULL,'true'),
    (3267,'66ddd78e-0aca-11e7-82f6-3863bb44ef7c','Morris Canal','JC072',40.7124188237569,-74.03852552175522,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3267','false','false',NULL,'true'),
    (3268,'66ddd81a-0aca-11e7-82f6-3863bb44ef7c','Lafayette Park','JC078',40.71346382669195,-74.06285852193832,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3268','false','false',NULL,'true'),
    (3269,'66ddd8a8-0aca-11e7-82f6-3863bb44ef7c','Brunswick & 6th','JC081',40.72601172964625,-74.05038893222809,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3269','false','false',NULL,'true'),
    (3270,'66ddd93e-0aca-11e7-82f6-3863bb44ef7c','Jersey & 6th St','JC027',40.72528910781132,-74.04557168483734,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3270','false','false',NULL,'true'),
    (3272,'66ddda59-0aca-11e7-82f6-3863bb44ef7c','Jersey & 3rd','JC074',40.72333158646436,-74.04595255851744,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3272','false','false',NULL,'true'),
    (3273,'66dddae7-0aca-11e7-82f6-3863bb44ef7c','Manila & 1st','JC082',40.721650724879986,-74.04288411140442,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3273','false','false',NULL,'true'),
    (3275,'66dddc08-0aca-11e7-82f6-3863bb44ef7c','Columbus Drive','JC014',40.71835519823214,-74.03891444206238,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3275','false','false',NULL,'true'),
    (3276,'66dddc98-0aca-11e7-82f6-3863bb44ef7c','Marin Light Rail','JC013',40.71458403535893,-74.04281705617905,70,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3276','false','false',NULL,'true'),
    (3277,'66dddd28-0aca-11e7-82f6-3863bb44ef7c','Communipaw & Berry Lane','JC084',40.71435836870427,-74.06661093235016,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3277','false','false',NULL,'true'),
    (3278,'66ddddb4-0aca-11e7-82f6-3863bb44ef7c','Monmouth and 6th','JC075',40.72568548362901,-74.04879033565521,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3278','false','false',NULL,'true'),
    (3279,'66ddde40-0aca-11e7-82f6-3863bb44ef7c','Dixon Mills','JC076',40.721630142638354,-74.04996782541275,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3279','false','false',NULL,'true'),
    (3280,'66ddded0-0aca-11e7-82f6-3863bb44ef7c','Astor Place','JC077',40.71928220070702,-74.07126188278198,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3280','false','false',NULL,'true'),
    (3281,'66dddf5f-0aca-11e7-82f6-3863bb44ef7c','Leonard Gordon Park','JC080',40.74590996631558,-74.0572714805603,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3281','false','false',NULL,'true'),
    (3282,'66dddfed-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 88 St','7323.10',40.78307,-73.95939,71,'KEY,CREDITCARD',38,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3282','false','true',NULL,'true'),
    (3283,'66dde079-0aca-11e7-82f6-3863bb44ef7c','W 89 St & Columbus Ave','7432.09',40.7882213,-73.97041561,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3283','false','false',NULL,'true'),
    (3284,'66dde103-0aca-11e7-82f6-3863bb44ef7c','E 88 St & Park Ave','7293.10',40.781410700190015,-73.95595908164978,71,'KEY,CREDITCARD',38,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3284','false','false',NULL,'true'),
    (3285,'66dde197-0aca-11e7-82f6-3863bb44ef7c','W 87 St & Amsterdam Ave','7458.03',40.78839,-73.9747,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3285','false','false',NULL,'true'),
    (3286,'66dde208-0aca-11e7-82f6-3863bb44ef7c','E 89 St & 3 Ave','7265.10',40.7806284,-73.9521667,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3286','false','false',NULL,'true'),
    (3287,'66dde271-0aca-11e7-82f6-3863bb44ef7c','W 87 St & West End Ave','7484.05',40.789622,-73.97757,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3287','false','false',NULL,'true'),
    (3288,'66dde2d9-0aca-11e7-82f6-3863bb44ef7c','E 88 St & 1 Ave','7235.13',40.778301,-73.9488134,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3288','false','false',NULL,'true'),
    (3289,'66dde343-0aca-11e7-82f6-3863bb44ef7c','W 90 St & Amsterdam Ave','7432.04',40.79017948095081,-73.97288918495178,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3289','false','false',NULL,'true'),
    (3290,'66dde3b1-0aca-11e7-82f6-3863bb44ef7c','E 89 St & York Ave','7204.08',40.7779453,-73.946041,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3290','false','false',NULL,'true'),
    (3292,'66dde484-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 93 St','7372.10',40.7857851,-73.957481,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3292','false','true',NULL,'true'),
    (3293,'66dde4ef-0aca-11e7-82f6-3863bb44ef7c','W 92 St & Broadway','7502.01',40.7921,-73.9739,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3293','false','false',NULL,'true'),
    (3294,'66dde559-0aca-11e7-82f6-3863bb44ef7c','E 91 St & Park Ave','7344.05',40.7835016,-73.955327,71,'KEY,CREDITCARD',38,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3294','false','true',NULL,'true'),
    (3295,'66dde5c6-0aca-11e7-82f6-3863bb44ef7c','Central Park W & W 96 St','7499.05',40.79127,-73.964839,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3295','false','true',NULL,'true'),
    (3296,'66dde630-0aca-11e7-82f6-3863bb44ef7c','E 93 St & 2 Ave','7286.02',40.782454175279874,-73.9489196240902,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3296','false','true',NULL,'true'),
    (3297,'66dde69c-0aca-11e7-82f6-3863bb44ef7c','6 St & 7 Ave','3834.10',40.6686627,-73.97988067,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3297','false','false',NULL,'true'),
    (3298,'66dde703-0aca-11e7-82f6-3863bb44ef7c','Warren St & Court St','4413.08',40.686371,-73.99383324,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3298','false','false',NULL,'true'),
    (3299,'66dde76a-0aca-11e7-82f6-3863bb44ef7c','E 98 St & Park Ave','7443.17',40.78813,-73.95206,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3299','false','false',NULL,'true'),
    (3300,'66dde7dc-0aca-11e7-82f6-3863bb44ef7c','Prospect Park West & 8 St','3722.04',40.66514681533792,-73.97637605667114,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3300','false','true',NULL,'true'),
    (3301,'66dde845-0aca-11e7-82f6-3863bb44ef7c','Columbus Ave & W 95 St','7520.07',40.7919557,-73.968087,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3301','false','false',NULL,'true'),
    (3302,'66dde8ac-0aca-11e7-82f6-3863bb44ef7c','Columbus Ave & W 103 St','7595.17',40.7969347,-73.9643412291,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3302','false','false',NULL,'true'),
    (3303,'66dde914-0aca-11e7-82f6-3863bb44ef7c','Butler St & Court St','4339.01',40.6849894,-73.99440329,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3303','false','false',NULL,'true'),
    (3304,'66dde9af-0aca-11e7-82f6-3863bb44ef7c','6 Ave & 9 St','3803.09',40.668127,-73.98377641,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3304','false','false',NULL,'true'),
    (3305,'66ddea2a-0aca-11e7-82f6-3863bb44ef7c','E 91 St & 2 Ave','7286.01',40.78112229934166,-73.94965589046478,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3305','false','false',NULL,'true'),
    (3306,'66ddea99-0aca-11e7-82f6-3863bb44ef7c','10 St & 7 Ave','3762.08',40.6662078,-73.98199886,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3306','false','false',NULL,'true'),
    (3307,'66ddeaff-0aca-11e7-82f6-3863bb44ef7c','West End Ave & W 94 St','7524.09',40.7941654,-73.974124,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3307','false','false',NULL,'true'),
    (3308,'66ddeb67-0aca-11e7-82f6-3863bb44ef7c','Kane St & Clinton St','4455.11',40.6861758,-73.99645295,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3308','false','false',NULL,'true'),
    (3309,'66ddebce-0aca-11e7-82f6-3863bb44ef7c','E 97 St & 3 Ave','7365.08',40.7859201,-73.94860294,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3309','false','false',NULL,'true'),
    (3310,'66ddec3e-0aca-11e7-82f6-3863bb44ef7c','14 St & 7 Ave','3731.11',40.663779,-73.98396846,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3310','false','false',NULL,'true'),
    (3311,'66ddeca9-0aca-11e7-82f6-3863bb44ef7c','Columbia St & Kane St','4422.05',40.68763155,-74.0016256,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3311','false','false',NULL,'true'),
    (3312,'66dded11-0aca-11e7-82f6-3863bb44ef7c','1 Ave & E 94 St','7286.05',40.7817212,-73.94594,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3312','false','false',NULL,'true'),
    (3313,'66dded7a-0aca-11e7-82f6-3863bb44ef7c','6 Ave & 12 St','3803.05',40.6663181,-73.9854617,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3313','false','false',NULL,'true'),
    (3314,'66ddede1-0aca-11e7-82f6-3863bb44ef7c','W 95 St & Broadway','7541.01',40.7937704,-73.971888,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3314','false','false',NULL,'true'),
    (3315,'66ddee56-0aca-11e7-82f6-3863bb44ef7c','Henry St & Degraw St','4380.08',40.6847514,-73.99917254,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3315','false','false',NULL,'true'),
    (3317,'66ddef2d-0aca-11e7-82f6-3863bb44ef7c','10 St & 5 Ave','3842.08',40.6686273,-73.98700053,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3317','false','false',NULL,'true'),
    (3318,'66ddef96-0aca-11e7-82f6-3863bb44ef7c','2 Ave & E 96 St','7338.02',40.7839636,-73.9471673,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3318','false','false',NULL,'true'),
    (3319,'66ddeffd-0aca-11e7-82f6-3863bb44ef7c','14 St & 5 Ave','3771.06',40.666287,-73.98895053,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3319','false','false',NULL,'true'),
    (3320,'66ddf06e-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 100 St','7538.12',40.79406660818552,-73.96286845207214,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3320','false','true',NULL,'true'),
    (3321,'66ddf310-0aca-11e7-82f6-3863bb44ef7c','Clinton St & Union St','4266.03',40.6831164,-73.99785267,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3321','false','false',NULL,'true'),
    (3322,'66de06ef-0aca-11e7-82f6-3863bb44ef7c','12 St & 4 Ave','3882.01',40.668603,-73.9904394,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3322','false','false',NULL,'true'),
    (3323,'66de077f-0aca-11e7-82f6-3863bb44ef7c','W 106 St & Central Park West','7606.01',40.7981856,-73.9605909006,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3323','false','true',NULL,'true'),
    (3324,'66de07ec-0aca-11e7-82f6-3863bb44ef7c','3 Ave & 14 St','3850.03',40.6685455,-73.99333264,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3324','false','false',NULL,'true'),
    (3325,'66de0861-0aca-11e7-82f6-3863bb44ef7c','E 95 St & 3 Ave','7365.13',40.7849032,-73.950503,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3325','false','false',NULL,'true'),
    (3326,'66de08c9-0aca-11e7-82f6-3863bb44ef7c','Clinton St & Centre St','4045.01',40.67434,-74.00194698,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3326','false','false',NULL,'true'),
    (3327,'66de0933-0aca-11e7-82f6-3863bb44ef7c','3 Ave & E 100 St','7414.17',40.7877214,-73.94728331,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3327','false','false',NULL,'true'),
    (3328,'66de099d-0aca-11e7-82f6-3863bb44ef7c','W 100 St & Manhattan Ave','7538.14',40.795,-73.9645,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3328','false','false',NULL,'true'),
    (3329,'66de0a0a-0aca-11e7-82f6-3863bb44ef7c','Degraw St & Smith St','4298.05',40.6829151,-73.99318208,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3329','false','false',NULL,'true'),
    (3330,'66de0a78-0aca-11e7-82f6-3863bb44ef7c','Henry St & Bay St','3972.08',40.6725058,-74.00494695,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3330','false','false',NULL,'true'),
    (3331,'66de0bcb-0aca-11e7-82f6-3863bb44ef7c','Riverside Dr & W 104 St','7623.13',40.8013434,-73.9711457439,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3331','false','true',NULL,'true'),
    (3332,'66de0c43-0aca-11e7-82f6-3863bb44ef7c','Degraw St & Hoyt St','4258.07',40.681990442707026,-73.99079024791718,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3332','false','false',NULL,'true');
INSERT INTO Stations VALUES
    (3333,'66de0cab-0aca-11e7-82f6-3863bb44ef7c','Columbia St & Lorraine St','4103.08',40.6747055,-74.0075572,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3333','false','false',NULL,'true'),
    (3335,'66de0d91-0aca-11e7-82f6-3863bb44ef7c','Union St & 4 Ave','4175.15',40.6772744,-73.98282002,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3335','false','false',NULL,'true'),
    (3336,'66de0dfd-0aca-11e7-82f6-3863bb44ef7c','E 97 St & Madison Ave','7393.09',40.787801,-73.953559,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3336','false','false',NULL,'true'),
    (3337,'66de103b-0aca-11e7-82f6-3863bb44ef7c','Dwight St & Van Dyke St','3981.10',40.67363551341504,-74.01195555925369,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3337','false','false',NULL,'true'),
    (3338,'66de10a8-0aca-11e7-82f6-3863bb44ef7c','2 Ave & E 99 St','7386.10',40.7862586,-73.94552579,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3338','false','false',NULL,'true'),
    (3339,'66de110b-0aca-11e7-82f6-3863bb44ef7c','Berkeley Pl & 6 Ave','4134.06',40.6765304,-73.97846879,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3339','false','false',NULL,'true'),
    (3340,'66de11bc-0aca-11e7-82f6-3863bb44ef7c','Wolcott St & Dwight St','4054.02',40.6753274,-74.0100698,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3340','false','false',NULL,'true'),
    (3341,'66de122e-0aca-11e7-82f6-3863bb44ef7c','Central Park West & W 102 St','7577.24',40.795346,-73.96186,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3341','false','true',NULL,'true'),
    (3342,'66de1295-0aca-11e7-82f6-3863bb44ef7c','Pioneer St & Richards St','4128.08',40.6777748,-74.0094613,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3342','false','false',NULL,'true'),
    (3343,'66de12ff-0aca-11e7-82f6-3863bb44ef7c','W 107 St & Columbus Ave','7619.05',40.7997568,-73.9621128676,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3343','false','false',NULL,'true'),
    (3344,'66de1368-0aca-11e7-82f6-3863bb44ef7c','Pioneer St & Van Brunt St','4169.04',40.679043,-74.011169,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3344','false','false',NULL,'true'),
    (3345,'66de13dc-0aca-11e7-82f6-3863bb44ef7c','Madison Ave & E 99 St','7443.01',40.78948541553215,-73.95242929458618,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3345','false','false',NULL,'true'),
    (3346,'66de1448-0aca-11e7-82f6-3863bb44ef7c','Berkeley Pl & 7 Ave','4051.01',40.675146838709786,-73.97523209452629,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3346','false','false',NULL,'true'),
    (3347,'66de14af-0aca-11e7-82f6-3863bb44ef7c','Van Brunt St & Wolcott St','4095.03',40.6773429,-74.01275056,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3347','false','false',NULL,'true'),
    (3348,'66de1516-0aca-11e7-82f6-3863bb44ef7c','Coffey St & Conover St','4137.10',40.677236,-74.015665,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3348','false','false',NULL,'true'),
    (3349,'66de1580-0aca-11e7-82f6-3863bb44ef7c','Grand Army Plaza & Plaza St West','4010.15',40.6729679,-73.97087984,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3349','false','false',NULL,'true'),
    (3350,'66de17f7-0aca-11e7-82f6-3863bb44ef7c','W 100 St & Broadway','7580.01',40.7973721,-73.97041192,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3350','false','false',NULL,'true'),
    (3351,'66de186f-0aca-11e7-82f6-3863bb44ef7c','E 102 St & 1 Ave','7407.13',40.7869946,-73.94164802,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3351','false','false',NULL,'true'),
    (3352,'66de18d7-0aca-11e7-82f6-3863bb44ef7c','Sigourney St & Columbia St','3940.04',40.67267243410948,-74.0087952464819,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3352','false','false',NULL,'true'),
    (3354,'66de19ab-0aca-11e7-82f6-3863bb44ef7c','3 St & Prospect Park West','3865.05',40.668132,-73.97363831,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3354','false','true',NULL,'true'),
    (3355,'66de1a1f-0aca-11e7-82f6-3863bb44ef7c','E 66 St & Madison Ave','6969.08',40.76800889305947,-73.96845281124115,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3355','false','false',NULL,'true'),
    (3356,'66de1a8a-0aca-11e7-82f6-3863bb44ef7c','Amsterdam Ave & W 66 St','7149.05',40.7746671,-73.98470567,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3356','false','false',NULL,'true'),
    (3357,'66de1af4-0aca-11e7-82f6-3863bb44ef7c','W 106 St & Amsterdam Ave','7634.01',40.8008363,-73.9664492472,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3357','false','false',NULL,'true'),
    (3358,'66de1b5b-0aca-11e7-82f6-3863bb44ef7c','Garfield Pl & 8 Ave','3978.13',40.6711978,-73.97484126,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3358','false','false',NULL,'true'),
    (3359,'66de1bc3-0aca-11e7-82f6-3863bb44ef7c','E 68 St & Madison Ave','6932.15',40.7691572,-73.96703464,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3359','false','false',NULL,'true'),
    (3360,'66de1c33-0aca-11e7-82f6-3863bb44ef7c','Amsterdam Ave & W 79 St','7311.02',40.7829391,-73.9786517,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3360','false','false',NULL,'true'),
    (3361,'66de1ea2-0aca-11e7-82f6-3863bb44ef7c','Carroll St & 6 Ave','4019.06',40.6740886,-73.9787282,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3361','false','false',NULL,'true'),
    (3362,'66de1f17-0aca-11e7-82f6-3863bb44ef7c','Madison Ave & E 82 St','7188.13',40.7781314,-73.96069399,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3362','false','false',NULL,'true'),
    (3363,'66de1f7f-0aca-11e7-82f6-3863bb44ef7c','E 102 St & Park Ave','7488.24',40.7904828,-73.95033068,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3363','false','false',NULL,'true'),
    (3364,'66de1fe7-0aca-11e7-82f6-3863bb44ef7c','Carroll St & 5 Ave','4060.09',40.6751622,-73.9814832,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3364','false','false',NULL,'true'),
    (3365,'66de205d-0aca-11e7-82f6-3863bb44ef7c','3 St & 7 Ave','3905.15',40.6703837,-73.97839676,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3365','false','false',NULL,'true'),
    (3366,'66de20c8-0aca-11e7-82f6-3863bb44ef7c','West End Ave & W 107 St','7650.05',40.8021174,-73.9681805305,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3366','false','false',NULL,'true'),
    (3367,'66de2131-0aca-11e7-82f6-3863bb44ef7c','5 Ave & E 103 St','7511.19',40.7922553,-73.95249933,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3367','false','true',NULL,'true'),
    (3368,'66de2199-0aca-11e7-82f6-3863bb44ef7c','5 Ave & 3 St','3987.06',40.6728155,-73.98352355,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3368','false','false',NULL,'true'),
    (3369,'66de2201-0aca-11e7-82f6-3863bb44ef7c','E 82 St & East End Ave','7049.04',40.7724607,-73.9468208,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3369','false','false',NULL,'true'),
    (3370,'66de2274-0aca-11e7-82f6-3863bb44ef7c','E 78 St & 2 Ave','7057.07',40.7727966,-73.95577801,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3370','false','false',NULL,'true'),
    (3372,'66de2556-0aca-11e7-82f6-3863bb44ef7c','E 74 St & 1 Ave','6953.08',40.7689738,-73.95482273,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3372','false','false',NULL,'true'),
    (3373,'66de25bd-0aca-11e7-82f6-3863bb44ef7c','3 St & 3 Ave','4028.03',40.6750705,-73.98775226,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3373','false','false',NULL,'true'),
    (3374,'66de2625-0aca-11e7-82f6-3863bb44ef7c','Central Park North & Adam Clayton Powell Blvd','7617.07',40.799484,-73.955613,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3374','false','true',NULL,'true'),
    (3375,'66de269c-0aca-11e7-82f6-3863bb44ef7c','3 Ave & E 72 St','7028.04',40.7699426,-73.96060712,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3375','false','false',NULL,'true'),
    (3376,'66de2707-0aca-11e7-82f6-3863bb44ef7c','E 65 St & 2 Ave','6860.12',40.76471851944339,-73.96222069859505,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3376','false','false',NULL,'true'),
    (3377,'66de2771-0aca-11e7-82f6-3863bb44ef7c','Carroll St & Bond St','4184.07',40.6786115,-73.99037292,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3377','false','false',NULL,'true'),
    (3378,'66de27da-0aca-11e7-82f6-3863bb44ef7c','E 76 St & Park Ave','7128.08',40.773763,-73.96222088,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3378','false','false',NULL,'true'),
    (3379,'66de2a00-0aca-11e7-82f6-3863bb44ef7c','E 103 St & Lexington Ave','7463.09',40.7903051,-73.94755757,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3379','false','false',NULL,'true'),
    (3381,'66de2b2f-0aca-11e7-82f6-3863bb44ef7c','3 St & Hoyt St','4110.10',40.6777287,-73.99364123,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3381','false','false',NULL,'true'),
    (3382,'66de2b97-0aca-11e7-82f6-3863bb44ef7c','Carroll St & Smith St','4225.14',40.680611,-73.99475825,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3382','false','false',NULL,'true'),
    (3383,'66de3fde-0aca-11e7-82f6-3863bb44ef7c','Cathedral Pkwy & Broadway','7680.03',40.804213,-73.96699104,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3383','false','false',NULL,'true'),
    (3384,'66de4078-0aca-11e7-82f6-3863bb44ef7c','Smith St & 3 St','4151.01',40.6787242,-73.99599099,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3384','false','false',NULL,'true'),
    (3386,'66de4336-0aca-11e7-82f6-3863bb44ef7c','1 Pl & Clinton St','4193.14',40.6809591,-73.99905709,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3386','false','false',NULL,'true'),
    (3387,'66de43a5-0aca-11e7-82f6-3863bb44ef7c','E 106 St & Madison Ave','7528.31',40.7934337,-73.94945003,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3387','false','false',NULL,'true'),
    (3388,'66de4408-0aca-11e7-82f6-3863bb44ef7c','President St & Henry St','4307.13',40.6828003,-73.99990419,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3388','false','false',NULL,'true'),
    (3389,'66de44ba-0aca-11e7-82f6-3863bb44ef7c','Carroll St & Columbia St','4348.07',40.6830456,-74.00348559,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3389','false','false',NULL,'true'),
    (3390,'66de452c-0aca-11e7-82f6-3863bb44ef7c','E 109 St & 3 Ave','7504.12',40.79329668,-73.9432083,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3390','false','false',NULL,'true'),
    (3391,'66de4594-0aca-11e7-82f6-3863bb44ef7c','E 106 St & 1 Ave','7456.03',40.7892529,-73.93956237,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3391','false','false',NULL,'true'),
    (3392,'66de47bf-0aca-11e7-82f6-3863bb44ef7c','Commerce St & Van Brunt St','4243.01',40.6812117,-74.00860912,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3392','false','false',NULL,'true'),
    (3393,'66de482a-0aca-11e7-82f6-3863bb44ef7c','Richards St & Delavan St','4202.04',40.6794327,-74.00785041,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3393','false','false',NULL,'true'),
    (3394,'66de4897-0aca-11e7-82f6-3863bb44ef7c','Columbia St & W 9 St','4086.05',40.6769993,-74.00647134,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3394','false','false',NULL,'true'),
    (3395,'66de48f9-0aca-11e7-82f6-3863bb44ef7c','Henry St & W 9 St','4086.06',40.6763744,-74.00324957,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3395','false','false',NULL,'true'),
    (3396,'66de4959-0aca-11e7-82f6-3863bb44ef7c','Clinton St & 4 Place','4119.04',40.6783563,-74.00014502,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3396','false','false',NULL,'true'),
    (3397,'66de4b0b-0aca-11e7-82f6-3863bb44ef7c','Court St & Nelson St','4077.07',40.6763947,-73.99869893,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3397','false','false',NULL,'true'),
    (3398,'66de4bbb-0aca-11e7-82f6-3863bb44ef7c','Smith St & 9 St','4077.04',40.6746957,-73.99785768,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3398','false','false',NULL,'true'),
    (3399,'66de4c32-0aca-11e7-82f6-3863bb44ef7c','7 St & 3 Ave','3996.01',40.67260298150126,-73.98983001708984,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3399','false','false',NULL,'true'),
    (3400,'66de4c9c-0aca-11e7-82f6-3863bb44ef7c','E 110 St & Madison Ave','7587.14',40.7961535,-73.94782145,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3400','false','true',NULL,'true'),
    (3402,'66de4f30-0aca-11e7-82f6-3863bb44ef7c','Court St & State St','4488.08',40.6902375,-73.99203074,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3402','false','false',NULL,'true'),
    (3403,'66de4f9c-0aca-11e7-82f6-3863bb44ef7c','4 Ave & 9 St','3955.05',40.6705135,-73.98876585,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3403','false','false',NULL,'true'),
    (3404,'66de5005-0aca-11e7-82f6-3863bb44ef7c','7 St & 5 Ave','3914.02',40.6704922,-73.98541675,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3404','false','false',NULL,'true'),
    (3405,'66de5095-0aca-11e7-82f6-3863bb44ef7c','5 St & 6 Ave','3874.01',40.6704836,-73.98208968,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3405','false','false',NULL,'true'),
    (3407,'66de5320-0aca-11e7-82f6-3863bb44ef7c','Union St & Nevins St','4143.03',40.67909799721684,-73.98765474557877,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3407','false','false',NULL,'true'),
    (3408,'66de53aa-0aca-11e7-82f6-3863bb44ef7c','Congress St & Clinton St','4455.07',40.6881529,-73.99520919,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3408','false','false',NULL,'true'),
    (3409,'66de542a-0aca-11e7-82f6-3863bb44ef7c','Bergen St & Smith St','4446.01',40.6867443,-73.99063168,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3409','false','false',NULL,'true'),
    (3410,'66de5613-0aca-11e7-82f6-3863bb44ef7c','Dean St & Hoyt St','4446.05',40.6864442,-73.98759104,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3410','false','false',NULL,'true'),
    (3411,'66de56e5-0aca-11e7-82f6-3863bb44ef7c','Bond St & Bergen St','4404.10',40.6849668,-73.98620772,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3411','false','false',NULL,'true'),
    (3412,'66de5773-0aca-11e7-82f6-3863bb44ef7c','Pacific St & Nevins St','4362.04',40.6853761,-73.98302136,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3412','false','false',NULL,'true'),
    (3413,'66de59bd-0aca-11e7-82f6-3863bb44ef7c','Wyckoff St & 3 Ave','4290.06',40.6827549,-73.98258555,71,'KEY,CREDITCARD',0,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3413','false','false',NULL,'true'),
    (3414,'66de5a47-0aca-11e7-82f6-3863bb44ef7c','Bergen St & Flatbush Ave','4281.08',40.680944723477296,-73.97567331790923,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3414','false','false',NULL,'true'),
    (3415,'66de5ace-0aca-11e7-82f6-3863bb44ef7c','Prospect Pl & 6 Ave','4166.08',40.6793307,-73.97519523,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3415','false','false',NULL,'true'),
    (3416,'66de5d57-0aca-11e7-82f6-3863bb44ef7c','7 Ave & Park Pl','4125.07',40.6776147,-73.97324283,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3416','false','false',NULL,'true'),
    (3417,'66de5dde-0aca-11e7-82f6-3863bb44ef7c','Baltic St & 5 Ave','4208.11',40.6795766,-73.97854971,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3417','false','false',NULL,'true'),
    (3418,'66de5e5b-0aca-11e7-82f6-3863bb44ef7c','Plaza St West & Flatbush Ave','4010.13',40.6750207,-73.97111473,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3418','false','true',NULL,'true'),
    (3419,'66de602e-0aca-11e7-82f6-3863bb44ef7c','Douglass St & 4 Ave','4175.14',40.6792788,-73.98154004,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3419','false','false',NULL,'true'),
    (3420,'66de6100-0aca-11e7-82f6-3863bb44ef7c','Douglass St & 3 Ave','4217.02',40.6802133,-73.98432695,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3420','false','false',NULL,'true'),
    (3422,'66de63cd-0aca-11e7-82f6-3863bb44ef7c','Columbia St & Degraw St','4422.04',40.6859296,-74.00242364,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3422','false','false',NULL,'true'),
    (3423,'66de65a4-0aca-11e7-82f6-3863bb44ef7c','West Drive & Prospect Park West','3651.04',40.6610633719006,-73.97945255041122,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3423','false','true',NULL,'true'),
    (3424,'66de677e-0aca-11e7-82f6-3863bb44ef7c','E 106 St & Lexington Ave','7504.18',40.791976,-73.945993,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3424','false','false',NULL,'true'),
    (3425,'66de6a0f-0aca-11e7-82f6-3863bb44ef7c','2 Ave & E 104 St','7436.11',40.7892105,-73.94370784,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3425','false','false',NULL,'true'),
    (3429,'66de71af-0aca-11e7-82f6-3863bb44ef7c','Hanson Pl & Ashland Pl','4395.07',40.68506807308177,-73.97790759801863,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3429','false','false',NULL,'true'),
    (3430,'66de73fd-0aca-11e7-82f6-3863bb44ef7c','Richardson St & N Henry St','5433.03',40.71907891179564,-73.94223690032959,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3430','false','false',NULL,'true'),
    (3435,'66de85d2-0aca-11e7-82f6-3863bb44ef7c','Grand St & Elizabeth St','5382.06',40.718822,-73.99596,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3435','false','false',NULL,'true'),
    (3437,'66de871c-0aca-11e7-82f6-3863bb44ef7c','Riverside Dr & W 91 St','7524.16',40.79313480986663,-73.97700369358063,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3437','false','false',NULL,'true'),
    (3440,'66de88d7-0aca-11e7-82f6-3863bb44ef7c','Fulton St & Adams St','4637.06',40.692418292578466,-73.98949474096298,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3440','false','false',NULL,'true'),
    (3452,'66dea4bf-0aca-11e7-82f6-3863bb44ef7c','Bayard St & Leonard St','5442.05',40.71915571696044,-73.94885390996933,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3452','false','false',NULL,'true'),
    (3453,'66dea52b-0aca-11e7-82f6-3863bb44ef7c','Devoe St & Lorimer St','5259.06',40.71335226222875,-73.9491033554077,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3453','false','false',NULL,'true'),
    (3454,'66dea596-0aca-11e7-82f6-3863bb44ef7c','Leonard St & Maujer St','5148.03',40.7103685423523,-73.94705951213837,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3454','false','false',NULL,'true'),
    (3456,'66dea674-0aca-11e7-82f6-3863bb44ef7c','Jackson St & Leonard St','5332.10',40.71638031973561,-73.94821286201477,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3456','false','false',NULL,'true'),
    (3457,'66dea6e1-0aca-11e7-82f6-3863bb44ef7c','E 58 St & Madison Ave','6839.04',40.76302594280519,-73.97209525108337,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3457','false','false',NULL,'true'),
    (3461,'66dea894-0aca-11e7-82f6-3863bb44ef7c','Murray St & Greenwich St','5288.12',40.714851505262516,-74.01122331619263,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3461','false','false',NULL,'true'),
    (3463,'647a2a80-9630-41b0-9b91-1f464b0bf3cc','E 16 St & Irving Pl','5938.11',40.735367055605394,-73.98797392845154,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3463','false','false',NULL,'true'),
    (3467,'bde94a25-6089-4490-af3a-8cc5702230b8','W Broadway & Spring St','5569.06',40.72494672359416,-74.00165855884552,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3467','false','false',NULL,'true'),
    (3469,'a75ba4d2-b8e6-482d-844a-df20fe8cf97a','India St & West St','5794.03',40.73181401720966,-73.95995020866394,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3469','false','false',NULL,'true'),
    (3472,'2527619f-ef89-425c-bf3b-60cc0ec519bf','W 15 St & 10 Ave','6115.09',40.742753828659026,-74.00747358798981,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3472','false','false',NULL,'true'),
    (3477,'5a5a38d1-f28d-4e51-bf85-27bb384135c7','39 St & 2 Ave - Citi Bike HQ at Industry City','3501.01',40.65539977447831,-74.01062786579132,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3477','false','false',NULL,'true'),
    (3478,'dd482585-3028-453f-a98d-55019db9b26c','2 Ave & 36 St - Citi Bike HQ at Industry City','3460.01',40.65708866668485,-74.00870203971863,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3478','false','false',NULL,'true'),
    (3479,'324af152-33ea-48a7-8bb0-ad8b6f31571f','Picnic Point','4374.01',40.68512559515415,-74.02535319328308,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3479','false','false',NULL,'true'),
    (3481,'4b0a681b-465e-4aca-8fe5-1342c06dbba9','York St','JC096',40.71649,-74.04105,70,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3481','false','false',NULL,'true'),
    (3483,'6107e75a-2493-4e3d-a3e0-d4886d3416e5','Montgomery St','JC099',40.71942,-74.05099,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3483','false','false',NULL,'true'),
    (3486,'b3cab614-16ad-459b-abeb-4d5109a2d84e','Schermerhorn St & Bond St','4479.08',40.688417427540834,-73.98451656103134,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3486','false','false',NULL,'true'),
    (3490,'9b7e3b8b-97ef-4038-820c-7cd1c1a34fc7','E 116 St & 2 Ave','7563.06',40.796879,-73.937261,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3490','false','false',NULL,'true'),
    (3491,'dee309e7-b7f8-4ee7-8999-e9f4e63ecc3b','E 118 St & 1 Ave','7596.10',40.79747,-73.93504,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3491','false','false',NULL,'true'),
    (3492,'7a15d81b-357e-42e0-b208-93ffd562fd63','E 118 St & Park Ave','7625.18',40.8005385,-73.9419949,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3492','false','false',NULL,'true'),
    (3493,'e73cf71b-db05-44f9-b57a-689d65320d68','E 118 St & 3 Ave','7611.02',40.799139,-73.9389152,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3493','false','false',NULL,'true'),
    (3494,'bf317efc-13f1-42be-8243-373a29354033','E 115 St & Lexington Ave','7599.09',40.797911,-73.9423,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3494','false','false',NULL,'true'),
    (3495,'566935d6-4d66-4b42-9822-f2a816e357b9','E 114 St & 1 Ave','7540.02',40.7945663,-73.9362541,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3495','false','false',NULL,'true'),
    (3496,'0b613329-b8c8-4b8c-ad40-79952aa41157','1 Ave & E 110 St','7522.02',40.7923272,-73.9383,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3496','false','false',NULL,'true'),
    (3497,'1aa5c287-0f0d-4697-ba4b-4f2daa6b2adf','Pleasant Ave & E 116 St','7450.05',40.7949879,-73.9333349,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3497','false','false',NULL,'true'),
    (3498,'20ff5447-eac3-43b7-820f-f6fa3a2e12a8','Pleasant Ave & E 120 St','7579.01',40.7974772,-73.9311847,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3498','false','false',NULL,'true'),
    (3499,'625711ba-3b5d-46a7-a8f9-7f4eb17ec1be','2 Ave & E 122 St','7622.12',40.8006721,-73.9349,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3499','false','false',NULL,'true'),
    (3500,'b976906e-81c4-44c5-a160-e17815c0d47b','E 115 St & Madison Ave','7599.02',40.7989445,-73.944846,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3500','false','false',NULL,'true'),
    (3501,'d3f51f51-7e51-4c75-8600-d76916608707','E 118 St & Madison Ave','7640.04',40.8014866,-73.9442507,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3501','false','false',NULL,'true'),
    (3502,'c05cd2e2-74e8-4526-a62b-d631e005fdd8','Lexington Ave & E 111 St','7567.06',40.7954121,-73.9441232,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3502','false','false',NULL,'true'),
    (3503,'bacfe3c2-7946-45ed-91f9-f5b91791de75','Madison Ave & E 120 St','7667.04',40.80295,-73.942954,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3503','false','false',NULL,'true'),
    (3504,'16a4effc-282e-4053-b47b-31f734d50c08','E 123 St & Lexington Ave','7636.05',40.8029263,-73.9379,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3504','false','true',NULL,'true'),
    (3505,'5f63411c-91ce-4788-a567-d388cc812a15','Lexington Ave & E 127 St','7662.13',40.805726,-73.936322,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3505','false','false',NULL,'true'),
    (3506,'d9bc0b3e-1af8-4cb6-a082-8ef1245ef329','Lexington Ave & E 120 St','7652.04',40.8013066,-73.9398167,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3506','false','false',NULL,'true'),
    (3507,'66880044-5411-4143-af39-eaa0a0fd0528','Park Ave & E 124 St','7682.01',40.8045555,-73.9396861,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3507','false','false',NULL,'true'),
    (3508,'dccaeeb5-c53a-4f48-80e6-05675b71a8c8','St Nicholas Ave & Manhattan Ave','7723.01',40.809725,-73.953149,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3508','false','false',NULL,'true'),
    (3509,'897e8739-ee1d-4b2e-b151-ad7e64e87697','Lenox Ave & W 115 St','7627.10',40.8011939,-73.9500739,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3509','false','false',NULL,'true'),
    (3510,'b55f9b55-7fa7-4f0f-9732-78cbe07452e1','Adam Clayton Powell Blvd & W 123 St','7704.04',40.8078316,-73.949373,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3510','false','false',NULL,'true'),
    (3511,'760ebaea-f7c7-45ad-aa3b-395d97adcf8f','Adam Clayton Powell Blvd & W 115 St','7643.18',40.802535,-73.9532423,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3511','false','false',NULL,'true'),
    (3513,'ff9581d3-3e1a-463a-bdab-d8150c468be2','21 St & Hoyt Ave S','7126.01',40.774645,-73.923706,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3513','false','false',NULL,'true'),
    (3514,'fc774664-3c9b-4a8f-a79e-f6907db00a1d','Astoria Park S & Shore Blvd','7159.08',40.7767,-73.927631,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3514','false','false',NULL,'true'),
    (3515,'387e2863-83ad-4589-8004-794a7b624801','24 Ave & 26 St','7152.10',40.774591,-73.918544,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3515','false','false',NULL,'true'),
    (3516,'b506be9e-45d3-43d1-a262-27d8fa91e974','31 St & Astoria Blvd','6989.07',40.7699176,-73.9184057,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3516','false','false',NULL,'true'),
    (3517,'6cd10426-b4e9-40e1-9b35-61f609190ac0','31 St & Hoyt Ave N','7018.01',40.7711528,-73.9170074,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3517','false','false',NULL,'true'),
    (3518,'7e36cd9b-b271-42e5-b344-b7a3771c795e','Lenox Ave & W 126 St','7720.03',40.808442,-73.9452087,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3518','false','true',NULL,'true'),
    (3520,'138094a0-cd7d-4014-9b21-4fb2afd3980e','Adam Clayton Powell Blvd & W 118 St','7670.09',40.804372,-73.951475,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3520','false','false',NULL,'true'),
    (3521,'0e003543-3656-448f-8a93-029d265f2e26','Lenox Ave & W 111 St','7602.05',40.7987859,-73.9523,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3521','false','false',NULL,'true'),
    (3522,'0630217a-3913-47d9-9540-cf85688296a5','37 St & 24 Ave','6981.16',40.7701477,-73.9120938,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3522','false','false',NULL,'true'),
    (3523,'3299ff79-36aa-42ef-b7f1-c40e95c8f570','24 Ave & 29 St','7119.04',40.7729,-73.916142,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3523','false','false',NULL,'true'),
    (3524,'3e1bdcec-e762-4e83-b447-007f05923cce','19 St & 24 Ave','7186.15',40.7774552,-73.9225403,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3524','false','false',NULL,'true'),
    (3525,'a04bf523-3c76-4fad-88bf-e99037f9b796','23 Ave & 27 St','7178.02',40.776165,-73.9153175,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3525','false','false',NULL,'true'),
    (3526,'5671825f-3eef-46c4-9e56-86add83d3a30','31 St & 23 Ave','7144.01',40.7747878,-73.9125551,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3526','false','false',NULL,'true'),
    (3527,'553ada94-8679-403c-ae41-6e679ee4812a','5 Ave & E 126 St','7701.19',40.80698,-73.941747,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3527','false','false',NULL,'true'),
    (3528,'cc758f1a-8b28-4ff5-bc75-fbe62c453378','Steinway St & 23 Ave','7009.02',40.7713937,-73.9077436,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3528','false','false',NULL,'true'),
    (3529,'14f928c6-9a51-40a2-b7e6-a74e8b351dbf','Lenox Ave & W 130 St','7753.13',40.8107922,-73.9430681,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3529','false','false',NULL,'true'),
    (3530,'9e99abca-c679-4788-9a4e-39066660bd6a','Crescent St & Ditmars Blvd','7233.05',40.7787185,-73.9145645,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3530','false','false',NULL,'true'),
    (3531,'bfea6c5b-2e1a-42c5-8199-2ded6042d57b','Frederick Douglass Blvd & W 129 St','7795.09',40.8125511,-73.9492286,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3531','false','false',NULL,'true'),
    (3532,'550153a5-2ea1-4c76-b1cd-77667005f55d','Ditmars Blvd & 19 St','7291.06',40.78145,-73.9183302,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3532','false','false',NULL,'true'),
    (3533,'dd8627c8-4190-4a30-8758-e77a7b010437','St. Nicholas Ave & W 126 St','7756.10',40.8114323,-73.9518776,71,'KEY,CREDITCARD',34,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3533','false','false',NULL,'true'),
    (3534,'0f6fd186-656a-41b3-ba4a-456d22da177c','Frederick Douglass Blvd & W 117 St','7688.12',40.805159,-73.954692,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3534','false','false',NULL,'true'),
    (3535,'668ef22c-4665-4f42-bf6a-ab9e8a2899b1','Mt Morris Park W & W 120 St','7685.14',40.804038,-73.945925,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3535','false','false',NULL,'true'),
    (3536,'8e631be4-1e0c-4627-a261-18f0003d0ba2','W 116 St & Broadway','7713.11',40.8082,-73.9641,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3536','false','false',NULL,'true'),
    (3537,'c3189056-8eda-4278-891f-e8e15c2d759a','Carlton Ave & Dean St','4199.12',40.6809741,-73.9710097,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3537','false','false',NULL,'true'),
    (3538,'4d79bdb9-7c35-4d35-9f6e-3c1b849c453a','W 110 St & Amsterdam Ave','7646.04',40.802692,-73.96295,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3538','false','false',NULL,'true'),
    (3539,'7efcb97f-6c8f-4445-86a9-3f758a822f17','W 116 St & Amsterdam Ave','7692.11',40.8067581,-73.9607082,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3539','false','false',NULL,'true'),
    (3540,'23539f3b-fb83-4f34-b8b8-9f1f37b5e646','Morningside Ave & W 123 St','7741.01',40.81,-73.9551508,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3540','false','false',NULL,'true'),
    (3541,'7f8cb36a-2bf4-4d57-afbd-331310f25355','Amsterdam Ave & W 125 St','7800.03',40.813358,-73.956461,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3541','false','false',NULL,'true'),
    (3542,'1b00fb53-da32-4b14-9a9a-84a391c8951c','Amsterdam Ave & W 119 St','7727.07',40.8086249,-73.9596214,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3542','false','false',NULL,'true'),
    (3543,'d80c274e-d17d-4a00-9b76-274c9fe4d0e1','Morningside Dr & Amsterdam Ave','7741.04',40.81028506306003,-73.95736455917358,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3543','false','false',NULL,'true'),
    (3544,'284b08f2-3d26-4f52-9463-25e4a07c16f7','Underhill Ave & Pacific St','4231.04',40.6804836,-73.9646795,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3544','false','false',NULL,'true'),
    (3545,'32d3adc3-c3dd-4a97-a4db-95d467f3c3aa','Broadway & W 122 St','7783.18',40.8120562,-73.9612547,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3545','false','false',NULL,'true'),
    (3546,'292ad4f3-9fb0-44ec-9e61-613c711f73c1','Pacific St & Classon Ave','4148.07',40.6791944,-73.9587903,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3546','false','false',NULL,'true'),
    (3547,'bc5235a5-7f10-4a27-806e-9c25fa700959','Broadway & Moylan Pl','7823.03',40.8143256,-73.9590255,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3547','false','false',NULL,'true'),
    (3549,'1d32e684-602b-46b6-8c96-ab47b57a03f3','Grand Ave & Bergen St','4190.06',40.678045,-73.962408,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3549','false','false',NULL,'true'),
    (3551,'594b4656-9d83-4301-8967-3b92c126531c','3 Ave & E 112 St','7543.15',40.795508,-73.941606,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3551','false','false',NULL,'true'),
    (3552,'5b4a90b8-426d-4a40-a7ca-87e51d690883','W 113 St & Broadway','7713.01',40.805973,-73.964928,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3552','false','false',NULL,'true'),
    (3553,'46bdd925-fb6c-4654-85d8-e0db4da62abf','Frederick Douglass Blvd & W 112 St','7631.23',40.801694,-73.957145,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3553','false','false',NULL,'true'),
    (3554,'0687075b-cf2d-4130-a859-fe841aafbd3f','Vernon Blvd & 41 Rd','6514.08',40.7552433,-73.9485678,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3554','false','false',NULL,'true'),
    (3555,'9a40cb60-6ede-4c9e-9d64-dc55cae57f31','28 St & 41 Ave','6462.19',40.751047,-73.93797,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3555','false','false',NULL,'true'),
    (3556,'3bfc859b-5c5f-43bc-b2e7-b64ed8ea9ede','24 St & 41 Ave','6505.01',40.7527085,-73.9397405,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3556','false','false',NULL,'true'),
    (3557,'5db1fefa-0f10-4c58-a7ce-113f3164ced8','40 Ave & 9 St','6664.05',40.75742,-73.945133,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3557','false','false',NULL,'true'),
    (3558,'8caf71df-76c3-43fb-be98-d555d2291460','Bergen St & Vanderbilt Ave','4157.10',40.6794388,-73.9680438,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3558','false','false',NULL,'true'),
    (3559,'49d2cd03-f508-483f-a7c9-7fd450e5e6db','21 St & 38 Ave','6656.05',40.7576314,-73.9391224,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3559','false','false',NULL,'true'),
    (3561,'12279d2b-29f6-4e02-a7f0-244970f7edd5','37 Ave & 35 St','6529.02',40.7531106,-73.9279917,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3561','false','false',NULL,'true'),
    (3562,'ab1dd03c-7669-4280-a533-47c369a8ca4d','Classon Ave & St Marks Ave','4074.03',40.6765198,-73.9596082,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3562','false','false',NULL,'true'),
    (3563,'35b8b636-18d3-4860-b0a9-39c0bce96a10','28 St & 36 Ave','6614.01',40.757186,-73.932719,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3563','false','false',NULL,'true'),
    (3564,'b94d0241-bce7-44a9-ab1c-ece0740a4134','21 St & 36 Ave','6729.02',40.7601853,-73.9362726,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3564','false','false',NULL,'true'),
    (3565,'822d96e8-fb6c-463a-b866-aec9e408ad5e','36 Ave & 10 St','6737.03',40.7614376,-73.9411265,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3565','false','false',NULL,'true'),
    (3566,'d265dbc7-ef55-4f5b-8a2b-f2015dc71fb8','Crescent St & 35 Ave','6688.01',40.7596276,-73.9321455,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3566','false','false',NULL,'true'),
    (3567,'a1dccb78-9993-4363-a7a9-20aa59df39e2','11 St & 35 Ave','6768.04',40.7627442,-73.9391141,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3567','false','false',NULL,'true'),
    (3568,'f6143531-4a16-4aac-9b55-573ef7ef162e','34 St & 35 Ave','6605.08',40.7569332,-73.9262231,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3568','false','false',NULL,'true'),
    (3569,'66f68197-4897-4576-896a-48e0312104c5','Franklin Ave & St Marks Ave','4107.05',40.6758324,-73.9561677,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3569','false','false',NULL,'true'),
    (3570,'60c5a043-1367-4a27-96ee-394ba60e2154','35 Ave & 37 St','6563.12',40.7557327,-73.9236611,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3570','false','false',NULL,'true'),
    (3571,'a2f71eea-05a2-4fe7-99ab-f74535c880ae','Bedford Ave & Bergen St','4066.15',40.676368,-73.952918,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3571','false','false',NULL,'true'),
    (3572,'548cb08c-4ec1-46d9-8978-1a8d3bf42454','34 Ave & 38 St','6638.01',40.756913,-73.921631,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3572','false','false',NULL,'true'),
    (3573,'d5788cfa-817e-4b65-b43f-edda222a3c3c','35 St & 34 Ave','6679.11',40.7580583,-73.9242751,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3573','false','false',NULL,'true'),
    (3574,'69f84045-48f9-4c6c-90d3-0503e5ed39e9','Prospect Pl & Underhill Ave','4116.08',40.6769694,-73.96579,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3574','false','false',NULL,'true'),
    (3575,'91ca68bd-5ac1-470b-a26d-1ec98ea9cca4','Crescent St & 34 Ave','6759.15',40.76108,-73.930562,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3575','false','false',NULL,'true'),
    (3576,'699d3378-6ea8-465f-888b-c49c60089ce8','Park Pl & Vanderbilt Ave','4083.13',40.6767,-73.969024,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3576','false','false',NULL,'true'),
    (3577,'0fa27bd7-b182-4e7a-b5bb-90f4249cb368','34 Ave & 21 St','6798.01',40.7628138,-73.9342862,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3577','false','false',NULL,'true'),
    (3578,'8d5c4ef9-e18c-4216-ac46-c64dde8015be','Park Pl & Franklin Ave','4033.06',40.6741806,-73.9564947,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3578','false','false',NULL,'true'),
    (3579,'dd351a72-4241-4275-843d-0fffa8a1f414','Sterling Pl & Bedford Ave','3993.03',40.672695,-73.954131,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3579','false','false',NULL,'true'),
    (3580,'add829db-2feb-4e81-af61-056791a6e53b','St Johns Pl & Washington Ave','4001.09',40.6737236,-73.9631611,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3580','false','false',NULL,'true'),
    (3581,'c83e1ef5-776e-417e-8ee2-d08ca121f884','Underhill Ave & Lincoln Pl','4042.08',40.6740123,-73.9671457,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3581','false','false',NULL,'true'),
    (3582,'2b54cb2c-31be-4620-a13c-0fa72b58c90a','Lincoln Pl & Classon Ave','3960.01',40.6721683,-73.9609,71,'KEY,CREDITCARD',28,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3582','false','false',NULL,'true'),
    (3583,'e63c8dac-ab44-48c8-83a0-92c53a00f12e','Eastern Pkwy & Washington Ave','3928.08',40.6716493,-73.9631145,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3583','false','false',NULL,'true'),
    (3584,'1dacb0f6-29f5-4d1b-b910-92ffa5b4ca5d','Eastern Pkwy & Franklin Ave','3919.07',40.6707767,-73.9576801,71,'KEY,CREDITCARD',42,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3584','false','false',NULL,'true'),
    (3585,'17aeb1e3-fd18-4cf9-9473-17dfa5b0a312','Union St & Bedford Ave','3879.04',40.6691783,-73.9554162,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3585','false','false',NULL,'true'),
    (3586,'ec42fb3a-af54-46aa-a8b3-b17d72ed4475','34 Ave & 13 St','6836.07',40.7638753,-73.9364848,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3586','false','false',NULL,'true'),
    (3587,'74a1dc19-f894-4246-99f1-476a92452995','Carroll St & Washington Ave','3887.03',40.6686744,-73.9618148,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3587','false','false',NULL,'true'),
    (3588,'32c60668-a192-4d06-aa7c-6d6f7aed6b45','Vernon Blvd & 10 St','6937.07',40.7671863,-73.9373554,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3588','false','false',NULL,'true'),
    (3589,'9bd28b11-cf11-4938-abb2-dfa5ec800e32','Broadway & 12 St','6901.01',40.7668,-73.9347774,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3589','false','false',NULL,'true'),
    (3590,'b90574d1-e9e7-45be-8adb-e38cb285fea5','Carroll St & Franklin Ave','3847.04',40.6679411,-73.9588,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3590','false','false',NULL,'true'),
    (3591,'2ec1235f-a043-4e3a-9ba1-56f7dd4624b7','21 St & 31 Dr','6865.03',40.7659,-73.930819,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3591','false','false',NULL,'true'),
    (3592,'9d95a4a9-bcfe-4189-bb7d-abd9992ecbaf','Crescent St & Broadway','6827.11',40.7633589,-73.9286471,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3592','false','false',NULL,'true'),
    (3593,'3f36c26d-c57f-47cc-9672-20f19babb36a','31 St & Broadway','6789.04',40.761584,-73.925921,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3593','false','false',NULL,'true'),
    (3595,'8c2ed08f-1660-4db8-9168-4709427c23ed','35 St & Broadway','6750.16',40.760339,-73.9222427,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3595','false','false',NULL,'true'),
    (3596,'1208a3c2-8f70-4af9-8362-648e5845fe9e','Sullivan Pl & Bedford Ave','3736.04',40.6642406,-73.9574686,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3596','false','false',NULL,'true'),
    (3597,'e4645d0d-8b76-4c46-b2b9-be25592e0659','43 St & Broadway','6670.03',40.7577284,-73.9166368,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3597','false','false',NULL,'true'),
    (3598,'305c221f-4e0b-4a5a-902c-3d1043dfe606','Newton Rd & 44 St','6743.06',40.7595701,-73.9142678,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3598','false','false',NULL,'true'),
    (3599,'56b3ca32-104a-4920-a879-a97a820858c4','Franklin Ave & Empire Blvd','3704.01',40.66314,-73.9605695,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3599','false','false',NULL,'true'),
    (3601,'981f1311-004f-41c3-ba5b-3679f78aeb70','Sterling St & Bedford Ave','3665.06',40.6627059,-73.9569115,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3601','false','false',NULL,'true'),
    (3602,'0e5be726-2452-42a0-9be8-ea85c8408e4c','31 Ave & 34 St','6819.15',40.763154,-73.920827,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3602','false','false',NULL,'true'),
    (3603,'42032bf9-4599-4035-bc01-c80bec1a7122','31 Ave & 30 St','6857.09',40.7647,-73.9240312,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3603','false','false',NULL,'true'),
    (3604,'6dec8948-44c7-4085-9682-446a891feb42','Rogers Ave & Sterling St','3696.05',40.6630619,-73.9538746,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3604','false','false',NULL,'true'),
    (3605,'a6287af0-9a9e-4708-b61f-8e758be4b914','31 Ave & Crescent St','6893.10',40.7658346,-73.9265474,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3605','false','false',NULL,'true'),
    (3606,'9e0b3452-ef6d-4e94-8c05-7bef199cdb74','49 Ave & 21 St','6128.04',40.74252,-73.948852,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3606','false','false',NULL,'true'),
    (3607,'d7904cd0-4b1b-47d0-8103-937bcf5ff845','31 Ave & 14 St','6966.04',40.7682,-73.9322662,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3607','false','false',NULL,'true'),
    (3608,'40eaa69a-d3ab-48fc-b395-b5bdc6a1aa85','5 St & 51 Ave','6137.04',40.7423737,-73.9566,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3608','false','false',NULL,'true'),
    (3609,'4d4a3e7b-1005-4bfd-8680-340a20cacbee','Vernon Blvd & 31 Ave','7003.06',40.7692475,-73.9354504,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3609','false','false',NULL,'true'),
    (3610,'73ee0bab-fb54-4e9a-880e-ac6b946f804f','Vernon Blvd & 30 Rd','7003.03',40.770845,-73.934171,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3610','false','true',NULL,'true'),
    (3611,'4753c1ba-a86e-431e-94fb-06403cdee4d7','Vernon Blvd & 47 Rd','6212.08',40.7449067,-73.9534573,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3611','false','false',NULL,'true'),
    (3612,'914e3e7c-87da-4f52-aa03-5449c6361fa2','30 Ave & 21 St','6996.01',40.7703743,-73.9286078,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3612','false','false',NULL,'true'),
    (3613,'c3d5f47f-cfc3-4c1f-86bb-bcf770d2949b','Center Blvd & 48 Ave','6254.06',40.745038,-73.957539,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3613','false','false',NULL,'true'),
    (3614,'fe93b3ae-1d86-4ee9-9eb6-9e11808966aa','Crescent St & 30 Ave','6958.06',40.768692,-73.9249574,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3614','false','false',NULL,'true'),
    (3615,'0eae62b5-0de3-4d69-9872-2cd53c509d0e','44 Dr & 21 St','6278.04',40.748,-73.9460927,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3615','false','false',NULL,'true'),
    (3664,'c1e24edf-7192-433f-8d38-be5b6b3647c5','North Moore St & Greenwich St','5470.12',40.72019521437465,-74.0103006362915,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3664','false','false','[object Object]','true'),
    (3616,'08bf2fe0-219d-48cd-87c5-6163b3a2eafd','Steinway St & 28 Ave','6915.02',40.7656251,-73.9136695,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3616','false','false',NULL,'true'),
    (3617,'3575749f-123a-4a80-870d-7ca7c7f9c8a9','28 Ave & 35 St','6951.03',40.7671,-73.9169858,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3617','false','false',NULL,'true'),
    (3618,'72796825-88b1-43a0-bb6d-2b41d337b1fc','27 St & Hunter St','6310.06',40.7485,-73.941275,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3618','false','false',NULL,'true'),
    (3619,'d56a8542-048a-4aca-ac7f-f27a9e6c908b','Newtown Ave & 23 St','7026.08',40.7713615,-73.9246145,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3619','false','false',NULL,'true'),
    (3620,'a617924a-31b7-45ed-8793-099b7274f34c','11 St & 43 Ave','6438.04',40.7519071,-73.9479119,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3620','false','false',NULL,'true'),
    (3621,'0927e331-866f-4d99-99b4-04edde99117a','27 Ave & 9 St','7098.05',40.7739825,-73.9309134,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3621','false','false',NULL,'true'),
    (3622,'c63a83a0-bda1-40a6-835b-f82c363543b9','E 128 St & Madison Ave','7735.23',40.80756,-73.939182,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3622','false','false',NULL,'true'),
    (3623,'bb32aad7-8308-4ff8-b073-d5b518ffdd09','W 120 St & Claremont Ave','7745.07',40.8109494,-73.9634,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3623','false','false',NULL,'true'),
    (3628,'dc8223ad-4108-40a8-9ff5-35e8490b4077','Lenox Ave & W 117 St','7655.22',40.8025566,-73.9490782,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3628','false','false',NULL,'true'),
    (3629,'18eccc71-66be-4e4c-8335-095a9bf0df94','Adam Clayton Powell Blvd & W 126 St','7738.04',40.809495347779475,-73.94776493310928,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3629','false','false',NULL,'true'),
    (3630,'ca4e4962-2169-4559-8f60-b05ab7809750','Frederick Douglass Blvd & W 115 St','7658.13',40.8038654,-73.9559308,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3630','false','false',NULL,'true'),
    (3637,'2a47ef14-1cbe-4ec6-841d-cc277627fe20','Fulton St & Waverly Ave','4345.11',40.683238654603414,-73.96599590778351,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3637','false','false',NULL,'true'),
    (3638,'f841ae52-0bbb-49db-b6eb-f898fbce6108','Washington St','JC098',40.7242941,-74.0354826,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3638','false','false',NULL,'true'),
    (3639,'2de92329-48d0-4cf7-85df-172f91bbb320','Harborside','JC104',40.7192517,-74.034234,70,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3639','false','false',NULL,'true'),
    (3640,'dd8b2f53-8b94-4082-9576-994a4962f9d5','Journal Square','JC103',40.73367,-74.0625,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3640','false','false',NULL,'true'),
    (3641,'daefc84c-1b16-4220-8e1f-10ea4866fdc7','Broadway & W 25 St','6173.08',40.74286877312112,-73.98918628692627,71,'KEY,CREDITCARD',54,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3641','false','false',NULL,'true'),
    (3646,'43f3d3c7-46b0-4812-879d-15afe8804c5f','35 Ave & 10 St','6806.06',40.76315481910373,-73.93985509872437,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3646','false','false',NULL,'true'),
    (3647,'b2caefee-e912-4783-971e-fff21dc170a5','48 Ave & 30 Pl','6076.01',40.74128309355993,-73.93725872039794,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3647','false','false',NULL,'true'),
    (3648,'999865d2-0735-4e85-a9d4-00810231530e','Flushing Ave & Vanderbilt Ave','4762.05',40.697950315695444,-73.97077560424805,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3648','false','false',NULL,'true'),
    (3649,'f15ccc6e-5a7c-46e7-b505-0bfc9cae3d83','W 129 St & Convent Ave','7818.17',40.814394437915816,-73.95324736833572,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3649','false','false',NULL,'true'),
    (3654,'1e83ffdc-8e72-45c0-8210-4f37e60505c9','31 St & Northern Blvd','6495.17',40.75186951421875,-73.93349289894103,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3654','false','false',NULL,'true'),
    (3656,'93e2e1a5-49c5-41f8-a6bf-b399b6a5140d','E 2 St & Avenue A','5553.10',40.72307749068673,-73.98583620786667,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3656','false','false',NULL,'true'),
    (3658,'73b403cf-86fd-4f93-a484-5cb06a2abeea','W 18 St & 9 Ave','6190.03',40.7435337324616,-74.00367558002472,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3658','false','false',NULL,'true'),
    (3661,'81a98b0b-cfd6-48b4-90bd-806ebbc264a0','Montgomery St & Franklin Ave','3776.05',40.666439306870814,-73.9605563879013,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3661','false','false',NULL,'true');
INSERT INTO Stations VALUES
    (3662,'160091ea-0d19-494a-9c17-c5abdd574bcf','31 Ave & Steinway St','6782.07',40.761293897289086,-73.916916847229,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3662','false','false',NULL,'true'),
    (3668,'7a771842-c090-4da1-8c13-72b7f4f50a87','Leonard St & Nassau Ave','5550.09',40.7239567849954,-73.94984364509583,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3668','false','false',NULL,'true'),
    (3671,'c111b8a6-9511-4842-b015-d39721f7b89c','E 81 St & 2 Ave','7121.05',40.774779448957275,-73.95427465438843,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3671','false','false',NULL,'true'),
    (3673,'26176e86-8362-4c91-a693-6aa3f9ce0b73','Dean St & Franklin Ave','4107.13',40.67759206937376,-73.955637216568,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3673','false','false',NULL,'true'),
    (3674,'43eac213-4603-4bc2-b6d6-b45013396282','Jay St & York St','4895.09',40.701403172577244,-73.98672670125961,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3674','false','false',NULL,'true'),
    (3676,'633fbc4c-7617-47ba-a393-aad7a8d26a3e','Van Brunt St & Van Dyke St','4095.10',40.6758329439129,-74.01472628116608,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3676','false','false',NULL,'true'),
    (3677,'915057d4-edbc-4c73-8d81-dda33d600d58','Glenwood Ave','JC094',40.72755146730012,-74.07106071710587,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3677','false','false',NULL,'true'),
    (3678,'5aa81a37-ea1d-4bf6-ab40-4751c6b4fb08','Fairmount Ave','JC093',40.72572613742557,-74.07195925712585,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3678','false','false',NULL,'true'),
    (3679,'e2c00264-9eea-446d-a1b7-27cef3aed403','Bergen Ave','JC095',40.722103786686034,-74.07145500183105,70,'KEY,CREDITCARD',14,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3679','false','false',NULL,'true'),
    (3680,'a2030439-c91f-466d-9584-f82c99279cee','E 43 St & 5 Ave','6551.03',40.754120810779256,-73.98025184869766,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3680','false','false',NULL,'true'),
    (3681,'a59f4f11-5d52-43a2-8a32-ae71137a6af8','Grand St','JC102',40.71517767732029,-74.03768330812454,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3681','false','false',NULL,'true'),
    (3686,'dbf79506-a4ec-4ee4-8a74-5e4d697dde9e','Gansevoort St & Hudson St','6072.14',40.739448201304036,-74.00507032871246,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3686','false','false',NULL,'true'),
    (3687,'61c82689-3f4c-495d-8f44-e71de8f04088','E 33 St & 1 Ave','6197.08',40.74322681432173,-73.97449783980846,71,'KEY,CREDITCARD',59,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3687','false','false',NULL,'true'),
    (3689,'ab5585c8-c2cf-4bab-96cf-d02eced4f6e3','W 104 St & Amsterdam Ave','7610.13',40.799041392882984,-73.96649479866028,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3689','false','false',NULL,'true'),
    (3690,'18fcd2c1-dc8b-4a52-9f18-e9b9003bbea5','Park Pl & Church St','5288.08',40.71334184275907,-74.00935515761375,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3690','false','false',NULL,'true'),
    (3691,'00284700-9d22-42ce-8485-113fed9879c1','28 Ave & 44 St','6879.04',40.76408932350688,-73.91065120697021,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3691','false','false',NULL,'true'),
    (3692,'918af7b2-e05c-477a-a8c0-7dcff984c566','5 St & Market St','4843.01',40.699997484388504,-73.97440128028393,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3692','false','false',NULL,'true'),
    (3693,'0e3dedfb-df10-4900-a67b-95349a81bc5c','N 11 St & Kent Ave','5489.04',40.72248188638219,-73.95921930670738,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3693','false','false',NULL,'true'),
    (3694,'1ec24ce3-2b69-4f3a-a153-c73e583d11f3','Jackson Square','JC063',40.71113,-74.0789,70,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3694','false','false',NULL,'true'),
    (3697,'b0cc08dc-e7dd-48d1-8901-ba496f3ff2f5','W 64 St & Thelonious Monk Circle','7123.04',40.77515953434235,-73.98918695747852,71,'KEY,CREDITCARD',43,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3697','false','false',NULL,'true'),
    (3699,'b442a648-e9f4-4893-951a-64d258bc0e55','W 50 St & 9 Ave','6854.05',40.763604677958625,-73.98917958140373,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3699','false','false',NULL,'true'),
    (3704,'c72970e7-7f1a-4671-bf55-fc34be7c9413','47 Ave & Skillman Ave','6237.01',40.7437524099784,-73.94176483154297,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3704','false','false',NULL,'true'),
    (3707,'454b4a83-d0b1-42a2-8163-261e2a9d6ab9','Lexington Ave & E 26 St','6089.08',40.741459,-73.983293,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3707','false','false',NULL,'true'),
    (3708,'eafa19ed-88c2-4efc-bd73-3961f85b6063','W 13 St & 5 Ave','5947.04',40.735445,-73.99431,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3708','false','false',NULL,'true'),
    (3709,'09dfc0e3-a448-477c-bb3c-9467dc51ef8d','W 15 St & 6 Ave','5989.02',40.738046142482766,-73.99642959237099,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3709','false','false',NULL,'true'),
    (3711,'d9160982-2d9b-4f08-9469-a559a7b62809','E 13 St & Avenue A','5779.09',40.72966729392978,-73.98067966103554,71,'KEY,CREDITCARD',47,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3711','false','false',NULL,'true'),
    (3712,'a47f77a2-9008-4652-a4f1-b95eee723a1b','W 35 St & Dyer Ave','6569.08',40.754691750226016,-73.99740189313889,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3712','false','false',NULL,'true'),
    (3714,'e58234a3-5b23-427e-948f-c1e4571b2bfa','Division Av & Hooper St','5045.05',40.70684203101325,-73.9544353965357,71,'KEY,CREDITCARD',61,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3714','false','false',NULL,'true'),
    (3715,'1b28836b-29fd-47a7-9a98-44cd792918fb','Driggs Ave & N 9 St','5411.08',40.71816969454208,-73.95520135760307,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3715','false','false',NULL,'true'),
    (3716,'c36cfa58-29fe-4c0c-a14f-41c3463487fd','40 Ave & Crescent St','6462.05',40.753599202005596,-73.93795609474182,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3716','false','false',NULL,'true'),
    (3718,'99d149f9-ad40-461e-beea-fcbf086f9b5a','E 11 St & Avenue B','5659.11',40.72746420692392,-73.97950418293476,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3718','false','false',NULL,'true'),
    (3720,'8ea59fa2-6f09-4dac-b27d-abfa5ee15ccf','Wyckoff St & Bond St','4330.08',40.68461653897949,-73.98721285164356,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3720','false','false',NULL,'true'),
    (3721,'cae4f2f4-9642-474c-95cc-6cc07592f120','31 St & Newtown Ave','6923.20',40.7675487799971,-73.9209334552288,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3721','false','false',NULL,'true'),
    (3723,'25d256fe-15a7-4d97-ad27-56885e7c0491','Cadman Plaza E & Johnson St','4677.10',40.695317277669034,-73.99015724658966,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3723','false','true',NULL,'true'),
    (3724,'b94cc90e-9ca2-4471-8371-23be051e0157','7 Ave & Central Park South','6912.01',40.7667405590595,-73.9790689945221,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3724','false','false',NULL,'true'),
    (3725,'e36b5913-8e46-4c2a-b9be-73bdf8ee548b','2 Ave & E 72 St','6925.09',40.7687620293096,-73.95840793848038,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3725','false','false',NULL,'true'),
    (3726,'79399e32-a6c6-4732-8ad4-9f9140a86b21','Center Blvd & 51 Ave','6179.07',40.743366080270214,-73.95960688591003,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3726','false','false',NULL,'true'),
    (3727,'3863f086-ae35-4d0e-8c91-2b6e3e5827a1','Frost St & Meeker Ave','5371.07',40.71766197083994,-73.94880026578903,71,'KEY,CREDITCARD',38,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3727','false','false',NULL,'true'),
    (3728,'78e93937-53d1-4c9b-99ad-0460f908ed2d','Pierrepont St & Monroe Pl','4718.08',40.69535693320225,-73.99344027042389,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3728','false','false',NULL,'true'),
    (3731,'0b009276-767c-47ee-a4d2-7633d4f95d95','W 47 St & 6 Ave','6667.04',40.758397,-73.98255,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3731','false','false',NULL,'true'),
    (3733,'346621b1-0316-4a89-a364-1364194c2c51','Avenue C & E 18 St','5769.04',40.730563,-73.973984,71,'KEY,CREDITCARD',46,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3733','false','false',NULL,'true'),
    (3734,'2bf9addc-038b-48fe-8794-dde085c5e5dc','E 58 St &  1 Ave (NW Corner)','6723.10',40.759125,-73.962658,71,'KEY,CREDITCARD',50,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3734','false','false',NULL,'true'),
    (3737,'9394fb49-583f-4426-8d2f-a2b0ffb584d2','Stanton St & Norfolk St','5445.07',40.720747,-73.986274,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3737','false','false',NULL,'true'),
    (3739,'00d3e65e-b614-4408-aaa9-939ed96ce645','Perry St & Greenwich Ave','5955.12',40.735918,-74.000939,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3739','false','false',NULL,'true'),
    (3740,'af72781c-fe0b-4b73-a7df-201f9780ea9c','W Broadway & W Houston St','5644.05',40.726378,-74.000472,71,'KEY,CREDITCARD',36,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3740','false','false',NULL,'true'),
    (3744,'389c3d35-6770-4819-ba87-71951c93b00f','1 Ave & E 5 St','5626.14',40.725864,-73.986389,71,'KEY,CREDITCARD',51,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3744','false','false',NULL,'true'),
    (3745,'59ad8f95-32a4-43de-b1c3-79c667b2d2df','36 Ave & 31 St','6572.08',40.75651272984955,-73.92957486212252,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3745','false','false',NULL,'true'),
    (3746,'90c35466-db3c-4b0d-993e-6e92883773b4','6 Ave & Broome St','5610.09',40.724308321602166,-74.00473035871983,71,'KEY,CREDITCARD',48,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3746','false','false',NULL,'true'),
    (3749,'93c28953-7e65-436e-9c5a-9d7ca0e3729f','Lexington Ave & E 36 St','6313.10',40.747573958954796,-73.9788007736206,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3749','false','false',NULL,'true'),
    (3755,'a35d03cf-bd72-4da4-a4ac-bd25b3f8dce3','DeKalb Ave & Franklin Ave','4528.01',40.69064807082943,-73.95746178925037,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3755','false','false',NULL,'true'),
    (3756,'9a52fbc1-d87a-4a65-941d-12fd55dbcdde','White St & Moore St','4987.06',40.704508,-73.9351,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3756','false','false',NULL,'true'),
    (3757,'ab6aadd8-fa45-43aa-abea-c8e01ec5a0c8','Stagg St & Morgan Ave','5170.01',40.710681,-73.93372,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3757','false','false',NULL,'true'),
    (3758,'f3b359e2-7983-4aaf-b6b0-e3b7d30816a4','George St & Wilson Ave','4906.07',40.702997,-73.92997,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3758','false','false',NULL,'true'),
    (3759,'2868db5b-df51-4c36-8515-ef77a5b092c2','Irving Ave & Jefferson St','5051.02',40.70538,-73.92535,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3759','false','false',NULL,'true'),
    (3760,'e612122d-e0fd-4ebf-8d51-0f48f9d1b580','Willoughby Ave & Wyckoff Ave','5010.02',40.705614,-73.92153,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3760','false','false',NULL,'true'),
    (3761,'21361381-fd4a-44a4-bfa7-61f075192ce9','Cedar St & Myrtle Ave','4751.01',40.697842,-73.926241,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3761','false','false',NULL,'true'),
    (3762,'bdcbd89b-9ae0-461b-aa1d-7db7ead07400','3 Ave & Carroll St','4143.04',40.677027,-73.9865,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3762','false','false',NULL,'true'),
    (3763,'9b721468-3b28-429d-9e13-580cdf00a6a4','Wyckoff Av & Jefferson St','5051.01',40.707165,-73.923711,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3763','false','false',NULL,'true'),
    (3764,'56e18295-f760-4bf3-8aa3-5a1e4ebf606f','Bushwick Ave & McKibbin St','5027.02',40.705517,-73.93936,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3764','false','false',NULL,'true'),
    (3765,'e35c42c6-8b73-4528-b08d-c94b75624b40','Bushwick Ave & Stagg St','5140.06',40.709897,-73.94008,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3765','false','false',NULL,'true'),
    (3766,'f93a02e2-ce16-4364-8cf3-1c16b6dbe4c2','Sharon St & Olive St','5323.05',40.715353,-73.93856,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3766','false','false',NULL,'true'),
    (3767,'fc5ee04d-710b-45ba-aae0-303b8e95ea89','Powers St & Olive St','5210.01',40.71323,-73.93894,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3767','false','false',NULL,'true'),
    (3768,'bfbd1f09-afd2-49d2-8674-3a07b3c929a4','Waterbury St & Stagg St','5099.02',40.71019,-73.93734,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3768','false','false',NULL,'true'),
    (3769,'de6f4206-3aa9-4cb9-aae0-8547d2cd6854','White St & Johnson Ave','5099.03',40.707174,-73.93581,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3769','false','false',NULL,'true'),
    (3770,'3a89411a-0bc6-4ba3-bc56-fab950c8eba1','Central Ave & Flushing Ave','4947.04',40.702831,-73.9333,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3770','false','false',NULL,'true'),
    (3771,'b03adb87-2bd9-43a5-a822-7d06a9ee2d81','McKibbin St & Bogart St','5059.02',40.706237,-73.933871,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3771','false','false',NULL,'true'),
    (3772,'84a7baff-415b-4ab9-a859-74c2801483ce','Devoe St & Morgan Ave','5282.02',40.713811,-73.93515,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3772','false','false',NULL,'true'),
    (3773,'29223935-a682-411c-9f25-577bbb9804fc','Knickerbocker Ave & Thames St','5018.06',40.70539,-73.92976,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3773','false','false',NULL,'true'),
    (3774,'7af717b9-99ce-4cce-94b4-b445a40537a1','Knickerbocker Ave & George St','4979.07',40.704425,-73.92836,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3774','false','false',NULL,'true'),
    (3775,'145bbc0d-8976-45ae-9565-158ba564d3d1','Suydam St & Knickerbocker Ave','4939.07',40.702013,-73.923769,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3775','false','false',NULL,'true'),
    (3776,'d11b9869-8964-4b79-aafc-4b60ad1b44c4','Central Ave & Starr Street','4792.03',40.700003,-73.92834,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3776','false','false',NULL,'true'),
    (3777,'8c700e85-cfdb-4eef-ba49-53bd69c004ed','Stockholm St & Wilson Ave','4824.03',40.699304,-73.923044,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3777','false','false',NULL,'true'),
    (3778,'d5d589e6-457f-4cd4-bf78-59165dce28b2','Irving Ave & DeKalb Ave','4898.02',40.7027,-73.92095,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3778','false','false',NULL,'true'),
    (3779,'c4e9905f-457b-4be0-a878-2aa53fa0b09b','Hart St & Wyckoff Ave','4971.01',40.704876,-73.919911,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3779','false','false',NULL,'true'),
    (3780,'f6cf3ecc-b3ad-4291-8c24-277f28f64ba1','Wyckoff Av & Stanhope St','4931.05',40.703545,-73.917775,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3780','false','false',NULL,'true'),
    (3781,'20f3a578-4dfa-45ca-a917-b394d77ee08e','Greene Av & Myrtle Av','4784.02',40.698568,-73.918877,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3781','false','false',NULL,'true'),
    (3782,'d47c856e-8cda-4da0-b8eb-1ccf0e6ef7ab','Brooklyn Bridge Park - Pier 2','4756.04',40.698458,-73.997178,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3782','false','true',NULL,'true'),
    (3783,'e8df73bd-5d3d-47c9-b04d-bcec4db5540f','Cliff St & Fulton St','5065.14',40.70838,-74.00495,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3783','false','false',NULL,'true'),
    (3785,'2c366f4b-8319-41bf-ab8e-2fba3a952feb','W 42 St & 6 Ave','6517.08',40.75492,-73.98455,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3785','false','false',NULL,'true'),
    (3787,'17ba4945-b202-4667-965f-211d80622646','Dock 72 Way & Market St','4804.02',40.69985,-73.97141,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3787','false','false',NULL,'true'),
    (3788,'eb43baf2-a568-43c3-9127-c896aa007063','E 12 St & 4 Av','5788.14',40.73269,-73.98974,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3788','false','false',NULL,'true'),
    (3789,'47bcbcc1-9241-4e65-99f1-07c15543be1b','Fulton St & Irving Pl','4263.12',40.68186,-73.959432,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3789','false','false',NULL,'true'),
    (3790,'c1c33a35-751f-4dd6-baef-82db46f7ab46','Henry St & Middagh St','4861.05',40.7003,-73.991581,71,'KEY,CREDITCARD',37,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3790','false','false',NULL,'true'),
    (3791,'5faf99b8-9046-450f-9d2a-d13279b3d016','Hoboken Ave at Monmouth St','JC105',40.73520838045357,-74.04696375131607,70,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3791','false','false',NULL,'true'),
    (3792,'ff555e68-617a-415b-82dc-e9ce525a2c11','Columbus Dr at Exchange Pl','JC106',40.71687,-74.03281,70,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3792','false','false',NULL,'true'),
    (3795,'3f878b81-324e-4673-9221-43d34647e76f','10 St & 2 Ave','3922.02',40.671907,-73.993612,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3795','false','false',NULL,'true'),
    (3798,'06f62897-af28-4673-b3d5-6a8b85dbbfa2','W 40 St & 5 Ave','6474.02',40.752269,-73.982079,71,'KEY,CREDITCARD',55,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3798','false','false',NULL,'true'),
    (3799,'547cdccc-7864-4898-97c9-8798d924ef54','6 Ave & W 34 St','6364.10',40.74964,-73.98805,71,'KEY,CREDITCARD',67,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3799','false','false',NULL,'true'),
    (3803,'2f580cf9-14e2-4300-ba22-f6d88d0312a5','Bedford Ave & Montgomery St','3736.03',40.665816,-73.956934,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3803','false','false',NULL,'true'),
    (3804,'9505c2b7-0c3a-4791-8471-d2092a86291f','Front St & Jay St','4895.03',40.702461,-73.986842,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3804','false','false',NULL,'true'),
    (3809,'581d8683-c217-4f96-89cb-b5a94d780b83','W 55 St & 6 Ave','6809.09',40.763189,-73.978434,71,'KEY,CREDITCARD',53,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3809','false','false',NULL,'true'),
    (3810,'5baaa766-a96a-4899-87eb-6ebeb67af868','Central Park West & W 82 St','7304.04',40.782593,-73.971211,71,'KEY,CREDITCARD',45,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3810','false','true',NULL,'true'),
    (3811,'285ad3c2-3ffe-45bb-8765-9c20a69641a6','27 Ave & 3 St','7132.08',40.77485,-73.9342,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3811','false','false',NULL,'true'),
    (3812,'b30815c0-99b6-451b-be15-902992cb8abb','University Pl & E 14 St','5905.14',40.734814,-73.992085,71,'KEY,CREDITCARD',49,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3812','false','false',NULL,'true'),
    (3814,'6fd61eee-d0ef-4580-9704-bd06b82bcb61','E 56 St & Madison Ave','6732.01',40.761573,-73.972628,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3814','false','false',NULL,'true'),
    (3815,'632b140c-65de-4f50-9cc2-c001ae011aea','E 51 St & 2 Ave','6575.03',40.755293,-73.967641,71,'KEY,CREDITCARD',41,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3815','false','false',NULL,'true'),
    (3816,'faf021ad-9de5-44bd-b7f5-48127e8d5fea','Metropolitan Ave & Vandervoort Ave','5241.02',40.71429,-73.93323,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3816','false','false',NULL,'true'),
    (3817,'3c5a8531-4eec-4695-b4f8-8a1158890e78','Withers St & Kingsland Ave','5362.08',40.71773,-73.94051,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3817','false','false',NULL,'true'),
    (3818,'606c7384-75e9-4988-858a-07b88b3a9413','Calyer St & Jewel St','5743.02',40.72984,-73.94839,71,'KEY,CREDITCARD',40,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3818','false','false',NULL,'true'),
    (3819,'63a838a8-9acf-4ba1-91f5-c676f6ef2f7d','Green St & McGuinness Blvd','5860.02',40.73396,-73.95204,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3819','false','false',NULL,'true'),
    (3820,'493e046c-5d62-4772-90c4-b6a9f4afcd39','Willoughby Ave & Myrtle Ave','4759.02',40.69757,-73.93098,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3820','false','false',NULL,'true'),
    (3821,'2c2cdc55-52a3-4140-b4d3-8409a98f130f','Evergreen Ave & Noll St','4873.08',40.70106,-73.93318,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3821','false','false',NULL,'true'),
    (3822,'0575e356-72f4-4251-8e15-574cf60bd190','Bushwick Ave & Forrest St','4914.03',40.70076,-73.93641,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3822','false','false',NULL,'true'),
    (3823,'29b21bd8-2459-4727-b1f0-d73592db3321','Beaver St & Fayette St','4840.06',40.70099,-73.93921,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3823','false','false',NULL,'true'),
    (3824,'ef6216aa-d3c8-46bb-8c6b-b62f8ba51b16','Van Sinderen Ave & Truxton St','4161.01',40.6786,-73.90369,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3824','false','false',NULL,'true'),
    (3825,'ace80a8c-6196-484e-8dd0-061e3c90389b','Broadway & Furman Ave','4244.06',40.68139,-73.90756,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3825','false','false',NULL,'true'),
    (3826,'d473f31f-68f2-4777-a364-ed127db04345','Moffat St & Bushwick','4357.01',40.68458,-73.90925,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3826','false','false',NULL,'true'),
    (3827,'fd081854-3f37-420a-9785-ea63c09c12ad','Halsey St & Broadway','4366.01',40.68565,-73.91564,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3827','false','false',NULL,'true'),
    (3828,'5f968a1b-ee60-43a0-ad25-05211e09e436','Eldert St & Bushwick Ave','4399.03',40.68652,-73.91321,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3828','false','false',NULL,'true'),
    (3829,'3c8847a6-c12a-40fd-9b22-4582ac1a0d9d','Central Ave & Decatur St','4432.10',40.6882,-73.90798,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3829','false','false',NULL,'true'),
    (3830,'61f2ffd4-159a-42b3-a4d9-3fdfc3349074','Halsey St & Evergreen Ave','4474.01',40.68858,-73.91227,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3830','false','false',NULL,'true'),
    (3831,'9092515e-eef6-478f-910f-1cd19d06bebb','Broadway & Hancock St','4441.06',40.68663,-73.9168,71,'KEY,CREDITCARD',35,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3831','false','false',NULL,'true'),
    (3832,'720c0d64-7828-4dba-bff9-4d99f4e3a9fc','Central Ave & Weirfield St','4591.04',40.69055,-73.91181,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3832','false','false',NULL,'true'),
    (3833,'bcb08532-f0d5-4c0e-ad8a-4ddacc204791','Madison St & Evergreen Ave','4560.01',40.69122,-73.91693,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3833','false','false',NULL,'true'),
    (3834,'4cfd4097-0aee-4f11-9aea-55f99397bf33','Irving Ave & Halsey St','4695.04',40.69467,-73.90663,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3834','false','false',NULL,'true'),
    (3835,'0ebdda6a-37e4-4ff4-94e8-3947f49d8e24','Knickerbocker Ave & Hancock St','4663.02',40.69385,-73.90974,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3835','false','false',NULL,'true'),
    (3836,'74723006-b32f-4590-8cc7-f15eec3808fe','Bushwick Ave & Linden St','4600.09',40.69146,-73.92146,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3836','false','false',NULL,'true'),
    (3837,'d5ca6311-7471-480f-9c79-38baaafe34ba','Broadway & Kosciuszko St','4608.01',40.69329,-73.92852,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3837','false','false',NULL,'true'),
    (3838,'5f0aa684-a1c5-4119-827f-7860f1cd4ccd','Bushwick Ave & Harman St','4640.01',40.69356,-73.92524,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3838','false','false',NULL,'true'),
    (3839,'18b19467-28ac-4496-b3e4-f6028b1c5105','Putnam Ave & Knickerbocker Ave','4663.06',40.69545,-73.91164,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3839','false','false',NULL,'true'),
    (3840,'6ca15d94-897a-4c81-ab47-366829afb7c4','Putnam Ave & Wyckoff Ave','4735.03',40.69811,-73.90904,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3840','false','false',NULL,'true'),
    (3841,'77463580-6421-403d-b170-f2660c216175','Menahan St & Central Ave','4672.01',40.69543,-73.9196,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3841','false','false',NULL,'true'),
    (3842,'a3d72b5b-9587-4f33-9722-c01e20a9b358','Bushwick Ave & Dekalb Ave','4680.05',40.69502,-73.92825,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3842','false','false',NULL,'true'),
    (3843,'b1f67e5c-7c26-4bf3-a90e-1500a3160d60','Myrtle Ave & Grove St','4816.05',40.69905,-73.91516,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3843','false','false',NULL,'true'),
    (3844,'6c3b486e-603c-4158-91ac-adc06ac01535','Myrtle Ave & Linden St','4816.02',40.69943,-73.91337,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3844','false','false',NULL,'true'),
    (3845,'45e8c326-b12d-4be6-b040-bb6de9986d25','Irving Ave & Harman St','4856.05',40.70108,-73.9179,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3845','false','false',NULL,'true'),
    (3846,'372c592e-09d8-400c-9595-2aa3510f39b0','Central Ave & Himrod St','4713.01',40.69676,-73.92302,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3846','false','false',NULL,'true'),
    (3847,'ee70b21e-4a95-4bdf-802c-50f83a76971d','Cedar St & Evergreen Ave','4721.01',40.69671,-73.92807,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3847','false','false',NULL,'true'),
    (3848,'7603028c-8b04-4918-8a25-a087ce57aea4','Suydam St & Broadway','4689.03',40.69544,-73.93223,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3848','false','false',NULL,'true'),
    (3849,'498d7e8e-5164-4f26-9ce6-399947d73b1a','Suydam St & St. Nicholas Ave','5043.06',40.70636,-73.91945,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3849','false','false',NULL,'true'),
    (3850,'5ffde991-1125-443e-bc97-6827b2b9c97b','Jefferson St & Cypress Ave','5082.08',40.70907,-73.92157,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3850','false','false',NULL,'true'),
    (3851,'201edb67-d071-4b67-bafd-131e5c273e9f','Metropolitan Ave & Stewart Ave','5273.01',40.71401,-73.92793,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3851','false','false',NULL,'true'),
    (3852,'cd4b8e12-b2c7-479b-900d-59cf7d8c4276','Stewart Ave & Johnson Ave','5123.07',40.70869,-73.92587,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3852','false','false',NULL,'true'),
    (3853,'cac843c2-8b21-47bb-a3b9-712f95d7f7aa','Harrison Pl & Porter Ave','5090.06',40.70686,-73.92851,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3853','false','false',NULL,'true'),
    (3854,'467e1de6-73a6-480f-9e83-fd1b03b71047','Morgan Ave & Maspeth Ave','5354.01',40.716657,-73.93637,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3854','false','false',NULL,'true'),
    (3855,'a958a8af-a0cc-4bca-9114-93c74ce3c693','Frost St & Debevoise Ave','5433.04',40.71882,-73.93948,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3855','false','false',NULL,'true'),
    (3856,'457ea5d7-d643-4028-87db-46dee0b81555','Kingsland Ave & Nassau Ave','5613.04',40.72577,-73.94173,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3856','false','false',NULL,'true'),
    (3857,'74feba30-26a5-4949-b3a0-d6e13ba1a20c','Engert Ave & McGuinness Blvd','5473.03',40.72158,-73.94546,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3857','false','false',NULL,'true'),
    (3858,'c3b255d8-b690-4825-b1e9-a1d1680e5542','Kent St & McGuinness Blvd','5785.10',40.73124,-73.95161,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3858','false','false',NULL,'true'),
    (3859,'dba67615-a7e0-4c44-ab1b-b464033ec9b9','Lorimer St & Calyer St','5709.04',40.72795,-73.95414,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3859','false','false',NULL,'true'),
    (3860,'f401cd5f-cb41-41f8-a857-4a4dfe778f94','Wilson Ave & Troutman St','4864.09',40.70166,-73.92754,71,'KEY,CREDITCARD',26,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3860','false','false',NULL,'true'),
    (3861,'db02e1ea-acc1-4f45-8e3c-d37468b0b5a6','Menahan St & Wyckoff Ave','4890.11',40.70113,-73.91422,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3861','false','false',NULL,'true'),
    (3862,'807e9f5a-49b6-4b7e-847b-4a60cff330ed','Linden St & Knickerbocker Ave','4743.04',40.69714,-73.91566,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3862','false','false',NULL,'true'),
    (3863,'3134bce7-0bb9-4a45-9c87-60a8cb681d72','Central Ave & Woodbine St','4632.10',40.69296,-73.91605,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3863','false','false',NULL,'true'),
    (3864,'2576805f-9732-4c74-8f1d-57715e8cdfa2','Central Ave & Covert St','4550.05',40.68929,-73.90951,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3864','false','false',NULL,'true'),
    (3865,'46fa17cb-743d-438b-b280-0092dc5adb10','Knickerbocker Ave & Cooper St','4582.05',40.69081,-73.90448,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3865','false','false',NULL,'true'),
    (3866,'78aabb95-6195-4aa7-ab0d-5748eeb26bd1','Wilson Ave & Moffat St','4507.07',40.68906,-73.90506,71,'KEY,CREDITCARD',32,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3866','false','false',NULL,'true'),
    (3867,'7dcc5a03-5997-4250-9207-fa8b6f027c86','Somers St & Broadway','4203.04',40.67945,-73.90474,71,'KEY,CREDITCARD',29,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3867','false','false',NULL,'true'),
    (3868,'c0f952d9-538e-4836-b936-fa97123cbf13','Knickerbocker Ave & Halsey St','4623.02',40.693,-73.90824,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3868','false','false',NULL,'true'),
    (3869,'2a9e2320-083d-4044-aedf-0c15ecfefe61','Van Buren St & Broadway','4568.01',40.692,-73.92617,71,'KEY,CREDITCARD',24,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3869','false','false',NULL,'true'),
    (3870,'50e7c057-9c78-47d2-b66a-8a9180ce9734','Melrose St & Broadway','4801.04',40.697481,-73.935877,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3870','false','false',NULL,'true'),
    (3871,'9341ee1c-d456-4858-a451-70cbbd73d084','Bushwick Ave & Furman Ave','4317.05',40.68281,-73.90623,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3871','false','false',NULL,'true'),
    (3872,'1318e05a-2506-43c6-b49d-4c1f7f69a267','Hancock St & Wyckoff Ave','4735.16',40.6972,-73.90674,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3872','false','false',NULL,'true'),
    (3873,'74e104fb-1ddc-4f3e-a60b-220b6c4f300b','Madison St & Cypress Ave','4807.02',40.70068,-73.90742,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3873','false','false',NULL,'true'),
    (3874,'e9b3a725-6963-4151-8f7f-9beeb51fa20f','Menahan St & Seneca Ave','4963.13',40.70461,-73.91054,71,'KEY,CREDITCARD',16,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3874','false','false',NULL,'true'),
    (3875,'24f431ca-c2a5-46be-966b-b8d4c3e4b346','Stephen St & Seneca Ave','4798.10',40.6988,-73.9007,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3875','false','false',NULL,'true'),
    (3876,'9d23b0e9-a478-407c-a0e0-0aff1b0398fc','Forest Ave & Summerfield St','4798.02',40.69922,-73.89795,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3876','false','false',NULL,'true'),
    (3877,'272c0389-5e4a-41a9-ad6c-2dccdfa55af9','Madison St & Forest Ave','5025.02',40.70555,-73.90245,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3877','false','false',NULL,'true'),
    (3878,'a6a132f9-89bf-42a4-afe6-1ca449b7f570','Cypress Ave & George St','4765.07',40.69812,-73.90271,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3878','false','false',NULL,'true'),
    (3879,'679dcf08-d88c-4d1b-b81d-fe9f4aabbff7','Broadway & Madison St','4483.10',40.68822,-73.91966,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3879','false','false',NULL,'true'),
    (3880,'ee1ba75f-baf5-4852-929c-8b7ad310f55a','Willoughby Ave & Onderdonk Ave','5115.05',40.7098,-73.91727,71,'KEY,CREDITCARD',27,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3880','false','false',NULL,'true'),
    (3881,'eab2749b-2f79-4797-a0a6-0579b27e6929','12 Ave & W 125 St','7886.02',40.818299,-73.960405,71,'KEY,CREDITCARD',39,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3881','false','false',NULL,'true'),
    (3882,'141ba25c-f4ea-4cec-ae7e-022401e23087','Norman St & Wyckoff Ave','4654.01',40.69517,-73.90311,71,'KEY,CREDITCARD',15,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3882','false','false',NULL,'true'),
    (3883,'a3e2b360-f050-48ea-b8c8-57d897b8f7fc','Harman St & Seneca Ave','5002.09',40.70577,-73.91292,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3883','false','false',NULL,'true'),
    (3884,'a7c09fde-76e8-4a56-b61d-8ca940432efd','Centre St & Seneca Ave','4837.03',40.69969,-73.9022,71,'KEY,CREDITCARD',23,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3884','false','false',NULL,'true'),
    (3885,'1057229c-f8f8-4014-80cd-f40421c61cf0','Onderdonk Ave & Gates Ave','4994.10',40.70413,-73.90737,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3885','false','false',NULL,'true'),
    (3886,'8f3a6711-fd05-4ce1-acf8-9d72b4a1bf97','Menahan St & Onderdonk Ave','5034.03',40.70553,-73.9096,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3886','false','false',NULL,'true'),
    (3887,'d89dc10f-9be3-45a5-9c3c-06c04c963436','Flushing Ave & Woodward Ave','5225.02',40.71246,-73.91873,71,'KEY,CREDITCARD',21,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3887','false','false',NULL,'true'),
    (3888,'55a4dc76-d839-4e06-9bf4-2f343391343c','Woodward Ave & Harman St','5074.08',40.70793,-73.91092,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3888','false','false',NULL,'true'),
    (3890,'ad57266c-34da-43da-8b48-2ba856002fbf','Grove St & Broadway','4526.01',40.69047,-73.923511,71,'KEY,CREDITCARD',31,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3890','false','false',NULL,'true'),
    (3891,'b35ba3c0-d3e8-4b1a-b63b-73a7bb518c9e','Irving Ave & Palmetto St','4775.01',40.698,-73.9127,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3891','false','false',NULL,'true'),
    (3892,'ad41e353-033e-484f-8d76-78014e11e9d7','38 Ave & 29 St','6538.11',40.75473,-73.93367,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3892','false','false',NULL,'true'),
    (3893,'59e3766c-0629-4ff1-a1d9-bc0514a55487','Rockaway Ave & Bainbridge St','4285.09',40.68319988172761,-73.91166642308235,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3893','false','false',NULL,'true'),
    (3895,'87091002-cc25-452a-b5d9-f8d0c3fce422','Cypress Ave & Palmetto St','4921.04',40.701573408737914,-73.90876293182373,71,'KEY,CREDITCARD',25,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3895','false','false',NULL,'true'),
    (3896,'26cae473-0e59-4af7-bad5-bb6fec85c8bc','Madison St & Seneca Ave','4880.11',40.70183,-73.90625,71,'KEY,CREDITCARD',22,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3896','false','false',NULL,'true'),
    (3897,'be8e6f1c-e8b5-40bd-896d-423052ba3bbc','Onderdonk Ave & Dekalb Ave','5115.01',40.70863,-73.91497,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3897','false','false',NULL,'true'),
    (3898,'199ea9dd-8f7e-4e05-a730-55edaacd8787','E 63 St & 3 Ave','6830.02',40.763954,-73.9646,71,'KEY,CREDITCARD',57,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3898','false','false',NULL,'true'),
    (3899,'bd30f2a1-38ec-474d-9e36-07f688e87427','Manhattan Av & Leonard St','5442.09',40.72084,-73.94844,71,'KEY,CREDITCARD',18,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3899','false','false',NULL,'true'),
    (3900,'344064f8-e82f-40fb-b235-aff506b77ae5','Morgan Ave & Lombardy St','5503.01',40.72226,-73.93889,71,'KEY,CREDITCARD',30,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3900','false','false',NULL,'true'),
    (3901,'837b7db3-55c6-4595-a497-834972631752','Stanhope St & Fairview Ave','5146.03',40.70998,-73.91116,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3901','false','false',NULL,'true'),
    (3902,'1abd4668-ed6b-4930-8177-17239ae75a9e','Fairview Ave & Linden St','5066.03',40.70694,-73.90632,71,'KEY,CREDITCARD',19,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3902','false','false',NULL,'true'),
    (3903,'88ee054e-bdeb-4305-8f3b-76eb964f2c84','Jefferson Ave & Evergreen Ave','4517.03',40.68989,-73.91458,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3903','false','false',NULL,'true'),
    (3907,'75352ab4-8a31-4926-8b59-048a9e506452','Central Ave & Melrose St','4832.07',40.70112,-73.93039,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3907','false','false',NULL,'true'),
    (3908,'d95c4666-2f80-4cb2-9cf1-9c5acc49bc6c','Battery Pl & Greenwich St','5001.09',40.70463,-74.01507,71,'KEY,CREDITCARD',33,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3908','false','true',NULL,'true'),
    (3909,'16836c76-c412-4ec3-bac8-3c6a5a3d9745','Madison St & Woodward Ave','4954.07',40.70408,-73.90408,71,'KEY,CREDITCARD',20,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3909','false','false',NULL,'true'),
    (3910,'30985a9c-afe4-4b98-a72c-2c72bb35603e','Greene Ave & Grandview Ave','5106.04',40.709697,-73.907856,71,'KEY,CREDITCARD',17,'http://app.citibikenyc.com/S6Lr/IBV092JufD?station_id=3910','false','false',NULL,'true');

insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('ZM-157-f', 3, 129, '2015-12-21', 16, 17);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('GZ-139-d', 11, 131, '2015-09-24', 22, 5);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('US-041-f', 10, 134, '2015-10-29', 25, 12);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('NP-805-q', 21, 133, '2016-02-07', 17, 15);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('FU-430-a', 19, 133, '2015-12-08', 14, 17);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('EB-134-z', 6, 132, '2015-09-26', 21, 25);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('WJ-778-k', 14, 130, '2015-11-26', 16, 17);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('FH-146-z', 16, 128, '2015-11-13', 17, 23);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('XG-197-i', 8, 126, '2015-12-18', 23, 26);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('DM-264-c', 13, 133, '2016-01-04', 21, 19);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('KR-199-a', 11, 130, '2016-02-10', 18, 10);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('XQ-344-l', 5, 134, '2015-10-23', 12, 11);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('LE-766-m', 21, 134, '2016-01-13', 24, 22);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('QP-535-n', 13, 131, '2015-04-06', 19, 25);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('ZB-895-i', 20, 128, '2015-05-23', 23, 3);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('QY-518-f', 11, 127, '2015-04-30', 14, 15);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('OL-511-t', 7, 125, '2016-03-08', 27, 27);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('FZ-355-a', 17, 128, '2015-04-17', 22, 12);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('TF-763-s', 6, 133, '2015-04-12', 26, 19);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('HK-119-z', 27, 129, '2015-08-28', 30, 21);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('DP-700-k', 7, 126, '2015-08-16', 12, 21);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('OD-745-s', 2, 133, '2015-07-11', 26, 24);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('ON-443-b', 27, 131, '2015-09-05', 23, 11);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('AY-377-y', 28, 128, '2016-01-01', 15, 14);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('KF-908-y', 10, 125, '2016-01-08', 15, 14);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('RH-672-f', 29, 125, '2015-07-25', 15, 18);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('XP-587-v', 2, 128, '2015-10-16', 28, 21);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('NO-951-m', 25, 133, '2015-11-18', 24, 15);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('MY-737-o', 9, 125, '2015-08-06', 16, 23);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('JO-404-s', 20, 129, '2015-07-06', 28, 13);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('MS-241-w', 4, 129, '2015-11-14', 15, 10);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('EQ-804-g', 12, 128, '2015-03-25', 28, 19);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('BT-920-v', 1, 127, '2015-10-10', 27, 17);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('PQ-003-k', 13, 125, '2015-06-22', 19, 23);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('HO-624-t', 30, 127, '2015-08-15', 13, 16);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('TM-182-e', 21, 127, '2015-09-18', 28, 26);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('YF-758-h', 13, 130, '2015-08-07', 26, 4);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('IL-257-w', 20, 130, '2015-04-14', 18, 16);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('VO-236-t', 2, 127, '2015-05-23', 22, 13);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('ZL-663-y', 17, 126, '2015-10-18', 27, 28);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('FG-369-i', 13, 131, '2015-10-12', 16, 26);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('CA-945-z', 30, 127, '2015-09-14', 12, 8);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('CM-623-x', 28, 129, '2016-02-21', 18, 18);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('IH-684-z', 9, 131, '2015-08-01', 22, 27);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('WI-853-n', 24, 130, '2015-11-30', 30, 17);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('BM-427-i', 30, 129, '2016-03-04', 18, 5);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('FM-703-a', 9, 130, '2015-05-30', 25, 28);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('IC-235-g', 18, 128, '2015-04-18', 25, 4);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('EN-751-y', 16, 132, '2015-12-23', 28, 29);
insert into Vans (Licence_ID, Station_ID, Staff_ID, Date_Stamp, Bikes, Station_End) values ('AR-690-m', 27, 130, '2015-04-25', 15, 12);

insert into Bikes  (Bike_ID, Station_ID, Model) values (1, 7, '2011/01/15');
insert into Bikes  (Bike_ID, Station_ID, Model) values (2, 28, '2012/08/28');
insert into Bikes  (Bike_ID, Station_ID, Model) values (3, 6, '2012/03/04');
insert into Bikes  (Bike_ID, Station_ID, Model) values (4, 19, '2011/01/14');
insert into Bikes  (Bike_ID, Station_ID, Model) values (5, 8, '2011/03/19');
insert into Bikes  (Bike_ID, Station_ID, Model) values (6, 18, '2011/08/23');
insert into Bikes  (Bike_ID, Station_ID, Model) values (7, 10, '2011/08/21');
insert into Bikes  (Bike_ID, Station_ID, Model) values (8, 19, '2012/04/06');
insert into Bikes  (Bike_ID, Station_ID, Model) values (9, 10, '2011/04/02');
insert into Bikes  (Bike_ID, Station_ID, Model) values (10, 12, '2011/04/28');
insert into Bikes  (Bike_ID, Station_ID, Model) values (11, 29, '2010/08/02');
insert into Bikes  (Bike_ID, Station_ID, Model) values (12, 15, '2010/03/15');
insert into Bikes  (Bike_ID, Station_ID, Model) values (13, 4, '2010/07/07');
insert into Bikes  (Bike_ID, Station_ID, Model) values (14, 7, '2011/07/04');
insert into Bikes  (Bike_ID, Station_ID, Model) values (15, 24, '2010/11/02');
insert into Bikes  (Bike_ID, Station_ID, Model) values (16, 8, '2010/07/31');
insert into Bikes  (Bike_ID, Station_ID, Model) values (17, 24, '2011/05/11');
insert into Bikes  (Bike_ID, Station_ID, Model) values (18, 10, '2011/08/07');
insert into Bikes  (Bike_ID, Station_ID, Model) values (19, 9, '2010/09/16');
insert into Bikes  (Bike_ID, Station_ID, Model) values (20, 19, '2012/01/18');
insert into Bikes  (Bike_ID, Station_ID, Model) values (21, 28, '2010/08/06');
insert into Bikes  (Bike_ID, Station_ID, Model) values (22, 13, '2010/05/13');
insert into Bikes  (Bike_ID, Station_ID, Model) values (23, 20, '2012/06/18');
insert into Bikes  (Bike_ID, Station_ID, Model) values (24, 29, '2011/03/20');
insert into Bikes  (Bike_ID, Station_ID, Model) values (25, 5, '2012/04/10');
insert into Bikes  (Bike_ID, Station_ID, Model) values (26, 7, '2011/06/10');
insert into Bikes  (Bike_ID, Station_ID, Model) values (27, 20, '2010/12/30');
insert into Bikes  (Bike_ID, Station_ID, Model) values (28, 6, '2011/08/15');
insert into Bikes  (Bike_ID, Station_ID, Model) values (29, 22, '2011/11/23');
insert into Bikes  (Bike_ID, Station_ID, Model) values (30, 28, '2012/06/26');
insert into Bikes  (Bike_ID, Station_ID, Model) values (31, 24, '2012/02/19');
insert into Bikes  (Bike_ID, Station_ID, Model) values (32, 18, '2011/04/24');
insert into Bikes  (Bike_ID, Station_ID, Model) values (33, 15, '2010/08/28');
insert into Bikes  (Bike_ID, Station_ID, Model) values (34, 23, '2012/09/27');
insert into Bikes  (Bike_ID, Station_ID, Model) values (35, 24, '2010/06/15');
insert into Bikes  (Bike_ID, Station_ID, Model) values (36, 26, '2011/07/04');
insert into Bikes  (Bike_ID, Station_ID, Model) values (37, 5, '2010/11/11');
insert into Bikes  (Bike_ID, Station_ID, Model) values (38, 21, '2012/09/28');
insert into Bikes  (Bike_ID, Station_ID, Model) values (39, 21, '2010/12/07');
insert into Bikes  (Bike_ID, Station_ID, Model) values (40, 23, '2011/06/16');
insert into Bikes  (Bike_ID, Station_ID, Model) values (41, 24, '2012/04/03');
insert into Bikes  (Bike_ID, Station_ID, Model) values (42, 10, '2010/11/13');
insert into Bikes  (Bike_ID, Station_ID, Model) values (43, 26, '2010/06/03');
insert into Bikes  (Bike_ID, Station_ID, Model) values (44, 7, '2012/07/21');
insert into Bikes  (Bike_ID, Station_ID, Model) values (45, 19, '2010/10/13');
insert into Bikes  (Bike_ID, Station_ID, Model) values (46, 14, '2010/07/15');
insert into Bikes  (Bike_ID, Station_ID, Model) values (47, 15, '2011/12/04');
insert into Bikes  (Bike_ID, Station_ID, Model) values (48, 22, '2011/07/30');
insert into Bikes  (Bike_ID, Station_ID, Model) values (49, 3, '2011/09/19');
insert into Bikes  (Bike_ID, Station_ID, Model) values (50, 24, '2010/09/23');

insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (1, 8, 'tertiary', 4.25, 21.64);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (2, 4, 'support', 3.89, 34.7);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (3, 10, 'bi-directional', 4.67, 40.41);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (4, 3, 'Synergized', 4.59, 33.88);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (5, 7, 'Self-enabling', 3.28, 31.96);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (6, 7, 'tangible', 4.22, 27.6);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (7, 10, 'Stand-alone', 4.3, 41.4);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (8, 7, 'firmware', 4.37, 44.7);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (9, 7, 'Team-oriented', 4.7, 22.51);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (10, 4, 'actuating', 3.84, 44.45);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (11, 5, 'bandwidth-monitored', 3.8, 42.72);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (12, 9, 'Public-key', 4.1, 34.93);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (13, 6, 'instruction set', 3.45, 42.78);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (14, 2, 'heuristic', 3.6, 48.26);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (15, 2, 'context-sensitive', 3.27, 36.77);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (16, 8, 'optimizing', 4.09, 21.2);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (17, 4, 'groupware', 3.68, 31.66);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (18, 2, 'exuding', 3.24, 37.93);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (19, 12, 'array', 4.64, 26.94);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (20, 8, 'Graphic Interface', 3.86, 32.46);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (21, 11, 'Monitored', 4.66, 24.29);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (22, 6, '6th generation', 3.82, 39.94);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (23, 10, 'Exclusive', 3.85, 37.14);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (24, 11, 'contingency', 3.63, 24.96);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (25, 10, 'pricing structure', 4.32, 28.83);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (26, 7, 'Multi-tiered', 3.65, 25.51);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (27, 11, 'knowledge user', 3.44, 22.02);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (28, 12, 'alliance', 4.16, 46.04);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (29, 11, 'explicit', 3.25, 48.7);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (30, 2, 'scalable', 3.76, 24.66);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (31, 2, 'definition', 4.67, 42.83);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (32, 2, 'artificial intelligence', 4.56, 33.29);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (33, 5, '3rd generation', 4.69, 36.11);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (34, 4, 'mobile', 4.6, 35.25);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (35, 5, 'Ameliorated', 3.36, 43.22);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (36, 3, 'product', 4.76, 41.86);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (37, 9, 'Triple-buffered', 3.97, 23.28);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (38, 7, 'system-worthy', 4.13, 36.58);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (39, 7, 'complexity', 4.71, 30.23);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (40, 11, 'asynchronous', 4.26, 47.94);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (41, 10, 'Front-line', 3.68, 24.02);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (42, 12, 'budgetary management', 4.15, 27.32);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (43, 10, 'Reverse-engineered', 4.13, 32.4);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (44, 10, 'explicit', 3.51, 48.99);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (45, 6, 'asynchronous', 4.73, 41.11);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (46, 8, 'process improvement', 4.36, 22.08);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (47, 8, 'neural-net', 3.64, 38.94);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (48, 3, 'composite', 4.32, 49.58);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (49, 2, 'Integrated', 3.24, 31.0);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (50, 50, 'zero tolerance', 3.91, 32.84);
insert into Bike_Status (B_Status_ID, Bike_ID, B_Status, Distance, Mileage) values (51, 50, 'zero tolerance', 3.91, 32.84);

insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (1, 17, 132, '2011/01/31', 4.3, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (2, 1, 131, '2012/05/13', 4.27, 21);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (3, 6, 130, '2011/03/24', 4.48, 24);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (4, 36, 133, '2012/08/12', 3.88, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (5, 36, 131, '2012/01/06', 4.37, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (6, 3, 133, '2011/08/26', 3.29, 30);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (7, 41, 131, '2012/10/05', 4.72, 27);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (8, 19, 131, '2010/08/05', 4.1, 21);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (9, 21, 133, '2011/01/30', 3.32, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (10, 6, 130, '2011/07/17', 3.21, 32);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (11, 26, 133, '2012/07/15', 3.67, 25);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (12, 17, 132, '2010/09/24', 3.26, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (13, 36, 133, '2011/08/16', 3.64, 21);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (14, 26, 130, '2010/07/31', 4.15, 27);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (15, 36, 133, '2011/06/15', 4.72, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (16, 10, 131, '2010/04/07', 4.05, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (17, 48, 132, '2011/12/26', 4.8, 24);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (18, 15, 131, '2011/03/27', 4.63, 29);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (19, 13, 132, '2010/05/17', 4.72, 33);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (20, 15, 133, '2011/10/12', 3.95, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (21, 39, 130, '2012/05/29', 3.86, 35);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (22, 25, 133, '2010/08/28', 3.38, 18);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (23, 30, 132, '2010/09/11', 4.61, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (24, 6, 130, '2011/06/19', 3.58, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (25, 25, 130, '2011/08/20', 3.65, 19);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (26, 8, 130, '2012/02/19', 3.79, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (27, 34, 132, '2011/09/23', 3.67, 16);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (28, 13, 133, '2010/07/27', 4.03, 21);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (29, 11, 131, '2012/02/27', 3.51, 35);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (30, 48, 133, '2010/05/08', 3.66, 18);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (31, 7, 133, '2010/12/01', 3.81, 22);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (32, 40, 133, '2012/04/13', 3.22, 33);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (33, 26, 131, '2011/03/28', 3.6, 23);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (34, 26, 131, '2010/04/14', 3.62, 16);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (35, 21, 130, '2012/07/24', 3.32, 31);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (36, 39, 133, '2011/04/27', 4.65, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (37, 51, 131, '2010/09/03', 4.18, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (38, 24, 132, '2011/12/24', 4.66, 19);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (39, 18, 132, '2012/03/09', 4.79, 22);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (40, 35, 131, '2010/09/10', 3.76, 35);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (41, 1, 130, '2012/07/12', 4.5, 32);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (42, 21, 132, '2011/07/09', 3.34, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (43, 32, 133, '2012/09/12', 3.87, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (44, 20, 130, '2010/03/17', 4.09, 20);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (45, 27, 133, '2012/04/22', 3.7, 25);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (46, 2, 130, '2011/05/08', 3.61, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (47, 22, 131, '2011/12/11', 3.8, 17);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (48, 10, 133, '2011/04/18', 3.45, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (49, 26, 131, '2011/02/28', 3.98, 26);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (50, 45, 132, '2010/10/31', 4.64, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (51, 19, 129, '2015-11-21', 2.66, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (52, 18, 127, '2016-11-29', 3.89, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (53, 22, 126, '2015-12-19', 3.25, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (54, 3, 134, '2015-02-11', 3.82, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (55, 13, 127, '2015-04-20', 4.14, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (56, 34, 125, '2015-01-24', 3.5, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (57, 7, 125, '2016-01-05', 3.92, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (58, 48, 134, '2016-08-07', 3.47, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (59, 38, 133, '2017-03-11', 3.83, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (60, 2, 130, '2016-04-22', 3.25, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (61, 35, 128, '2016-04-27', 4.48, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (62, 9, 133, '2016-01-16', 4.47, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (63, 48, 134, '2017-01-20', 4.34, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (64, 30, 128, '2015-12-10', 3.74, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (65, 40, 128, '2016-08-18', 3.9, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (66, 31, 125, '2017-02-13', 4.02, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (67, 44, 126, '2015-07-04', 2.86, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (68, 9, 130, '2016-11-18', 3.33, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (69, 42, 126, '2015-11-30', 4.0, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (70, 6, 129, '2015-10-02', 3.71, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (71, 34, 132, '2016-04-09', 2.99, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (72, 25, 130, '2016-10-18', 2.71, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (73, 19, 125, '2016-12-16', 2.83, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (74, 18, 131, '2015-08-29', 4.34, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (75, 44, 130, '2016-07-04', 3.36, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (76, 1, 129, '2015-12-11', 3.82, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (77, 35, 130, '2015-08-01', 3.43, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (78, 5, 134, '2016-09-11', 3.72, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (79, 3, 130, '2015-08-24', 3.95, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (80, 43, 126, '2017-02-24', 3.24, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (81, 19, 129, '2016-01-31', 3.06, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (82, 42, 131, '2016-12-04', 4.36, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (83, 36, 129, '2016-11-06', 2.99, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (84, 34, 132, '2015-03-05', 3.09, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (85, 31, 127, '2015-01-30', 2.79, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (86, 23, 131, '2015-04-17', 3.3, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (87, 24, 125, '2015-11-25', 2.69, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (88, 4, 130, '2015-10-24', 4.0, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (89, 24, 133, '2015-03-23', 3.01, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (90, 44, 126, '2017-01-12', 2.96, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (91, 40, 133, '2016-03-01', 2.89, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (92, 9, 131, '2015-08-16', 3.68, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (93, 27, 133, '2015-05-12', 3.69, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (94, 31, 130, '2015-07-04', 4.09, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (95, 14, 130, '2016-05-26', 2.64, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (96, 25, 126, '2016-02-09', 2.59, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (97, 28, 130, '2017-04-20', 2.8, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (98, 43, 129, '2015-02-28', 4.06, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (99, 46, 133, '2016-09-27', 3.2, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (100, 37, 131, '2017-01-23', 3.02, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (101, 50, 130, '2015-06-14', 4.05, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (102, 17, 130, '2015-08-05', 3.61, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (103, 35, 125, '2016-10-29', 3.47, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (104, 47, 125, '2016-06-22', 3.69, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (105, 35, 131, '2017-04-16', 3.02, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (106, 2, 130, '2017-03-15', 3.15, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (107, 26, 125, '2016-12-27', 2.51, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (108, 29, 125, '2015-10-18', 2.99, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (109, 41, 127, '2015-02-14', 3.54, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (110, 9, 130, '2015-02-12', 4.16, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (111, 25, 134, '2016-11-15', 3.4, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (112, 12, 133, '2015-10-08', 3.67, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (113, 46, 134, '2016-08-26', 2.91, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (114, 46, 128, '2015-02-22', 3.68, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (115, 46, 134, '2017-03-16', 3.87, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (116, 45, 125, '2015-10-19', 3.53, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (117, 48, 130, '2015-12-02', 2.51, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (118, 40, 132, '2015-12-19', 4.03, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (119, 20, 134, '2017-03-25', 3.17, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (120, 49, 132, '2016-04-12', 3.5, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (121, 47, 128, '2016-12-04', 4.04, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (122, 2, 129, '2016-04-04', 3.21, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (123, 49, 132, '2016-02-17', 4.3, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (124, 37, 132, '2015-08-03', 3.24, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (125, 11, 134, '2015-11-09', 4.44, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (126, 45, 132, '2015-04-14', 3.09, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (127, 11, 130, '2015-03-09', 3.45, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (128, 46, 130, '2015-05-15', 3.09, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (129, 47, 129, '2015-02-08', 4.04, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (130, 35, 134, '2015-11-25', 2.94, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (131, 50, 132, '2015-01-24', 3.9, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (132, 21, 133, '2016-11-14', 3.12, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (133, 33, 130, '2017-02-08', 3.69, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (134, 11, 126, '2015-04-05', 4.46, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (135, 21, 128, '2015-08-01', 2.89, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (136, 48, 126, '2016-12-01', 4.19, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (137, 5, 134, '2016-08-01', 2.89, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (138, 4, 132, '2016-03-28', 2.78, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (139, 21, 128, '2017-02-26', 3.49, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (140, 27, 129, '2016-10-06', 2.76, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (141, 13, 133, '2015-10-03', 2.68, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (142, 26, 131, '2015-08-14', 4.49, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (143, 35, 128, '2015-06-28', 2.66, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (144, 50, 128, '2016-05-01', 2.68, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (145, 8, 130, '2017-04-05', 3.09, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (146, 50, 126, '2016-12-30', 2.91, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (147, 47, 130, '2016-08-16', 4.44, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (148, 30, 133, '2015-10-30', 4.45, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (149, 50, 128, '2015-05-05', 4.5, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (150, 38, 126, '2015-12-21', 2.75, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (151, 37, 129, '2016-02-10', 3.04, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (152, 19, 127, '2016-08-31', 2.65, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (153, 4, 129, '2017-01-01', 3.4, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (154, 7, 130, '2017-03-05', 3.09, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (155, 10, 129, '2016-10-23', 3.37, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (156, 31, 126, '2015-05-10', 3.77, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (157, 4, 126, '2016-05-03', 2.55, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (158, 30, 132, '2016-08-26', 3.92, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (159, 26, 133, '2017-02-18', 3.55, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (160, 40, 128, '2015-10-23', 2.7, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (161, 15, 132, '2015-05-13', 3.33, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (162, 33, 125, '2015-06-17', 3.69, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (163, 45, 132, '2015-01-17', 3.72, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (164, 36, 126, '2015-08-19', 2.92, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (165, 7, 126, '2015-01-18', 2.96, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (166, 33, 131, '2015-10-19', 3.15, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (167, 38, 126, '2016-04-27', 4.43, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (168, 37, 129, '2015-02-20', 4.11, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (169, 4, 126, '2016-02-29', 3.77, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (170, 41, 132, '2016-01-06', 3.11, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (171, 46, 129, '2015-05-02', 3.35, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (172, 49, 125, '2016-10-09', 4.35, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (173, 21, 132, '2016-12-31', 4.34, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (174, 14, 128, '2015-09-15', 4.19, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (175, 12, 134, '2016-10-21', 3.28, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (176, 11, 134, '2015-12-12', 4.07, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (177, 40, 127, '2015-01-16', 3.5, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (178, 17, 126, '2015-10-19', 3.14, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (179, 6, 132, '2017-01-17', 4.07, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (180, 8, 131, '2016-11-09', 2.78, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (181, 27, 125, '2016-09-08', 3.05, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (182, 51, 134, '2017-03-05', 4.22, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (183, 33, 129, '2016-09-09', 2.67, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (184, 45, 125, '2016-07-17', 3.6, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (185, 15, 134, '2015-09-30', 2.68, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (186, 41, 132, '2016-07-05', 2.9, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (187, 11, 126, '2016-04-14', 3.24, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (188, 42, 131, '2015-12-30', 4.18, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (189, 20, 129, '2017-03-05', 2.68, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (190, 44, 126, '2015-11-12', 4.34, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (191, 16, 132, '2015-12-24', 3.29, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (192, 2, 132, '2016-07-05', 4.02, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (193, 24, 128, '2016-06-06', 4.38, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (194, 43, 129, '2016-04-09', 3.6, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (195, 16, 133, '2016-09-16', 4.1, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (196, 9, 134, '2016-09-24', 4.05, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (197, 47, 127, '2015-11-22', 2.66, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (198, 30, 133, '2015-02-27', 3.73, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (199, 4, 125, '2016-06-07', 4.23, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (200, 21, 133, '2016-10-24', 4.16, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (201, 49, 128, '2015-06-06', 2.9, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (202, 34, 126, '2016-07-17', 3.48, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (203, 51, 128, '2015-05-27', 2.76, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (204, 12, 128, '2015-03-12', 4.44, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (205, 19, 126, '2015-03-13', 3.56, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (206, 22, 133, '2017-04-07', 3.26, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (207, 9, 133, '2016-09-05', 4.04, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (208, 26, 129, '2016-06-01', 3.27, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (209, 37, 129, '2015-07-12', 3.94, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (210, 11, 126, '2016-09-11', 2.6, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (211, 50, 130, '2017-03-02', 2.83, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (212, 12, 127, '2016-11-02', 3.86, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (213, 8, 133, '2016-08-18', 3.83, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (214, 49, 129, '2015-07-08', 4.48, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (215, 4, 128, '2015-04-18', 4.45, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (216, 3, 130, '2015-01-20', 3.8, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (217, 38, 130, '2015-02-06', 2.68, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (218, 51, 133, '2016-04-26', 3.11, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (219, 28, 125, '2015-09-18', 3.61, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (220, 4, 125, '2016-11-27', 3.12, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (221, 25, 126, '2015-12-20', 3.87, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (222, 33, 126, '2016-12-22', 2.95, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (223, 29, 128, '2016-12-13', 3.82, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (224, 42, 130, '2015-10-05', 3.09, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (225, 29, 133, '2015-04-18', 4.26, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (226, 47, 134, '2017-02-10', 3.59, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (227, 50, 129, '2017-02-13', 3.8, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (228, 39, 128, '2016-05-25', 3.19, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (229, 32, 125, '2016-02-26', 2.73, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (230, 50, 132, '2015-01-03', 4.33, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (231, 1, 132, '2015-05-19', 3.1, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (232, 37, 128, '2016-03-18', 2.79, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (233, 28, 132, '2015-06-12', 4.4, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (234, 51, 132, '2015-11-29', 3.16, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (235, 48, 134, '2016-06-26', 4.12, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (236, 33, 132, '2016-12-27', 3.44, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (237, 17, 131, '2015-01-07', 3.9, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (238, 26, 127, '2015-07-02', 3.98, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (239, 29, 133, '2016-09-10', 3.66, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (240, 46, 130, '2016-01-09', 2.51, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (241, 43, 127, '2015-06-03', 3.4, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (242, 48, 126, '2015-04-09', 3.62, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (243, 20, 126, '2015-10-05', 3.71, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (244, 11, 134, '2017-03-10', 4.49, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (245, 22, 133, '2015-04-03', 2.97, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (246, 36, 129, '2017-02-28', 2.63, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (247, 21, 133, '2017-02-18', 2.91, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (248, 13, 126, '2015-08-01', 3.61, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (249, 2, 129, '2015-11-19', 2.67, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (250, 43, 133, '2015-03-01', 4.13, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (251, 39, 131, '2016-04-24', 2.65, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (252, 48, 132, '2016-06-30', 4.08, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (253, 26, 130, '2016-10-25', 2.76, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (254, 43, 131, '2015-07-15', 4.35, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (255, 10, 129, '2015-06-28', 4.28, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (256, 22, 126, '2017-01-14', 3.91, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (257, 34, 134, '2016-07-08', 3.4, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (258, 12, 131, '2015-10-11', 3.84, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (259, 7, 129, '2015-08-09', 4.39, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (260, 28, 130, '2015-05-13', 4.44, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (261, 8, 132, '2016-05-30', 3.72, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (262, 16, 127, '2016-08-29', 3.41, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (263, 42, 128, '2016-06-23', 3.41, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (264, 29, 130, '2016-11-28', 3.47, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (265, 46, 134, '2015-05-03', 3.99, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (266, 34, 125, '2016-04-03', 4.12, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (267, 45, 125, '2016-03-16', 4.39, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (268, 44, 126, '2015-01-18', 3.22, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (269, 42, 133, '2016-05-02', 3.88, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (270, 21, 133, '2015-01-15', 4.01, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (271, 49, 134, '2016-07-13', 3.57, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (272, 32, 128, '2015-04-11', 2.71, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (273, 18, 131, '2015-04-22', 4.48, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (274, 25, 131, '2015-01-01', 4.02, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (275, 15, 130, '2015-07-08', 2.6, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (276, 51, 127, '2016-11-08', 4.04, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (277, 12, 130, '2015-03-30', 4.07, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (278, 36, 125, '2015-09-17', 3.55, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (279, 25, 134, '2016-04-22', 3.62, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (280, 34, 133, '2015-02-05', 3.81, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (281, 3, 127, '2016-01-06', 4.39, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (282, 16, 128, '2015-07-16', 3.04, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (283, 7, 129, '2015-05-07', 3.39, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (284, 1, 131, '2016-01-06', 4.19, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (285, 1, 128, '2015-08-07', 3.91, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (286, 46, 130, '2017-03-19', 3.01, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (287, 3, 129, '2016-02-25', 2.51, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (288, 46, 130, '2015-10-31', 3.75, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (289, 3, 125, '2016-01-26', 3.37, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (290, 16, 130, '2015-11-18', 3.12, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (291, 15, 127, '2015-09-14', 3.24, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (292, 48, 133, '2016-01-28', 3.49, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (293, 26, 130, '2016-04-30', 3.15, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (294, 29, 130, '2016-08-06', 4.16, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (295, 7, 126, '2016-11-18', 4.21, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (296, 46, 133, '2016-10-12', 2.79, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (297, 50, 128, '2016-10-09', 4.4, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (298, 21, 132, '2016-09-13', 3.06, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (299, 36, 130, '2016-07-13', 3.43, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (300, 40, 128, '2015-07-31', 2.95, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (301, 17, 133, '2016-02-10', 3.17, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (302, 44, 133, '2015-07-06', 3.2, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (303, 14, 127, '2017-04-03', 4.09, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (304, 32, 131, '2016-07-31', 3.66, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (305, 1, 130, '2015-09-19', 4.42, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (306, 1, 125, '2016-08-06', 4.48, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (307, 15, 128, '2016-12-08', 3.08, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (308, 1, 131, '2016-10-19', 4.04, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (309, 4, 134, '2015-12-10', 3.17, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (310, 40, 129, '2016-07-15', 2.69, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (311, 31, 129, '2017-01-16', 3.52, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (312, 6, 132, '2016-05-28', 3.22, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (313, 1, 125, '2015-04-17', 2.75, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (314, 23, 128, '2015-12-20', 3.73, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (315, 18, 129, '2016-03-14', 2.82, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (316, 33, 131, '2015-12-02', 2.85, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (317, 34, 125, '2016-10-19', 4.06, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (318, 43, 129, '2016-06-03', 4.44, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (319, 2, 127, '2015-06-08', 2.6, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (320, 37, 127, '2015-08-11', 3.71, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (321, 39, 131, '2017-04-13', 4.28, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (322, 43, 126, '2015-01-31', 3.73, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (323, 30, 133, '2015-06-09', 2.66, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (324, 46, 129, '2015-09-25', 3.04, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (325, 33, 132, '2016-03-28', 3.85, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (326, 31, 128, '2015-04-16', 3.96, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (327, 8, 127, '2015-06-11', 2.67, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (328, 4, 125, '2016-04-25', 3.1, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (329, 30, 131, '2015-06-21', 3.22, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (330, 26, 132, '2017-03-17', 3.95, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (331, 23, 131, '2015-09-04', 3.24, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (332, 7, 133, '2016-01-16', 2.75, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (333, 5, 130, '2017-01-28', 4.45, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (334, 33, 125, '2016-04-02', 4.06, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (335, 21, 131, '2015-03-08', 3.01, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (336, 43, 128, '2016-08-04', 3.38, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (337, 37, 134, '2015-07-15', 3.16, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (338, 28, 130, '2015-07-02', 3.16, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (339, 26, 131, '2017-04-12', 3.61, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (340, 45, 133, '2015-08-30', 4.23, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (341, 15, 133, '2015-07-17', 4.5, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (342, 3, 131, '2015-05-22', 2.6, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (343, 33, 129, '2015-12-22', 2.71, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (344, 37, 134, '2016-08-03', 3.93, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (345, 31, 129, '2017-04-07', 3.66, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (346, 42, 130, '2015-08-17', 3.8, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (347, 20, 130, '2015-02-24', 4.45, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (348, 15, 128, '2015-12-04', 3.91, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (349, 41, 129, '2015-06-02', 2.78, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (350, 31, 130, '2016-05-18', 3.04, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (351, 7, 129, '2015-02-23', 2.84, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (352, 28, 130, '2016-08-16', 2.59, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (353, 23, 130, '2015-11-28', 4.36, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (354, 12, 125, '2016-08-23', 3.15, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (355, 31, 132, '2015-11-16', 3.03, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (356, 36, 129, '2016-11-01', 4.37, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (357, 17, 127, '2015-02-05', 3.83, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (358, 40, 130, '2015-08-13', 3.88, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (359, 16, 132, '2017-01-17', 3.17, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (360, 27, 126, '2016-07-26', 3.66, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (361, 9, 127, '2016-03-30', 3.01, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (362, 49, 129, '2016-10-20', 3.17, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (363, 22, 127, '2016-11-25', 3.0, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (364, 12, 125, '2016-06-28', 4.33, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (365, 15, 128, '2015-01-16', 2.63, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (366, 42, 133, '2015-10-28', 2.97, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (367, 2, 126, '2016-09-03', 2.66, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (368, 24, 126, '2016-06-17', 4.3, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (369, 27, 129, '2016-02-03', 4.0, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (370, 2, 128, '2016-05-30', 4.44, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (371, 26, 126, '2016-12-07', 3.93, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (372, 50, 126, '2015-05-23', 4.15, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (373, 13, 130, '2016-11-08', 3.81, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (374, 48, 133, '2015-01-06', 2.56, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (375, 21, 131, '2015-10-19', 2.65, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (376, 10, 132, '2016-05-29', 2.96, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (377, 21, 125, '2016-12-25', 4.09, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (378, 47, 134, '2016-12-31', 4.02, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (379, 41, 129, '2015-09-14', 2.66, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (380, 39, 128, '2016-07-22', 2.68, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (381, 38, 128, '2017-03-27', 3.48, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (382, 39, 128, '2017-02-27', 2.65, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (383, 33, 131, '2015-03-09', 3.5, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (384, 2, 132, '2015-11-22', 4.01, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (385, 15, 133, '2015-06-18', 3.91, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (386, 7, 128, '2015-02-19', 3.48, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (387, 50, 127, '2016-06-14', 4.09, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (388, 41, 130, '2016-03-21', 4.45, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (389, 22, 127, '2015-08-31', 3.74, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (390, 36, 129, '2016-07-15', 2.52, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (391, 18, 129, '2017-03-02', 4.21, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (392, 48, 126, '2015-04-10', 4.41, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (393, 39, 127, '2015-01-09', 4.1, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (394, 12, 132, '2015-08-02', 3.02, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (395, 27, 132, '2016-02-26', 3.39, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (396, 30, 129, '2016-11-15', 3.37, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (397, 35, 126, '2016-11-16', 3.65, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (398, 5, 133, '2015-08-31', 3.61, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (399, 4, 130, '2015-10-09', 3.62, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (400, 7, 129, '2015-03-10', 2.64, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (401, 35, 128, '2016-11-22', 3.1, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (402, 13, 132, '2015-06-16', 4.28, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (403, 4, 132, '2017-03-22', 3.53, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (404, 37, 134, '2017-02-09', 3.99, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (405, 9, 133, '2015-02-23', 3.65, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (406, 32, 130, '2016-09-27', 4.33, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (407, 25, 125, '2017-03-19', 2.63, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (408, 1, 127, '2016-12-16', 2.92, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (409, 15, 129, '2015-10-21', 4.25, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (410, 47, 133, '2016-12-23', 3.1, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (411, 16, 129, '2015-02-01', 4.29, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (412, 43, 129, '2015-02-17', 3.9, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (413, 40, 128, '2016-09-02', 3.82, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (414, 22, 132, '2017-02-17', 3.63, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (415, 3, 127, '2015-04-14', 3.63, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (416, 25, 129, '2015-03-14', 4.34, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (417, 16, 130, '2016-02-13', 4.21, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (418, 36, 134, '2015-05-02', 3.86, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (419, 1, 134, '2015-12-08', 4.27, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (420, 5, 129, '2015-12-26', 4.2, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (421, 19, 133, '2015-06-17', 4.29, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (422, 29, 133, '2016-05-27', 2.74, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (423, 3, 134, '2015-05-06', 3.4, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (424, 37, 130, '2017-02-03', 4.08, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (425, 12, 132, '2015-06-03', 3.02, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (426, 14, 132, '2015-03-10', 3.98, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (427, 7, 128, '2017-01-06', 4.44, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (428, 25, 130, '2015-02-03', 2.73, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (429, 21, 129, '2016-08-08', 2.68, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (430, 35, 133, '2015-07-24', 3.99, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (431, 21, 126, '2016-06-09', 3.14, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (432, 44, 127, '2016-05-16', 3.94, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (433, 29, 129, '2015-03-02', 2.88, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (434, 42, 131, '2016-07-04', 3.45, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (435, 23, 133, '2015-10-30', 4.23, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (436, 41, 130, '2015-06-24', 3.34, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (437, 17, 133, '2016-12-25', 4.26, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (438, 50, 132, '2015-11-24', 3.1, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (439, 22, 127, '2016-09-17', 4.29, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (440, 20, 130, '2016-07-01', 3.96, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (441, 50, 130, '2016-07-06', 3.55, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (442, 36, 130, '2017-02-15', 3.23, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (443, 46, 134, '2016-01-09', 3.48, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (444, 45, 128, '2016-01-13', 4.13, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (445, 32, 127, '2016-12-08', 4.16, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (446, 38, 132, '2016-12-05', 3.94, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (447, 15, 129, '2015-12-29', 3.66, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (448, 41, 132, '2015-03-16', 3.95, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (449, 35, 133, '2016-01-01', 2.66, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (450, 18, 134, '2015-11-23', 4.35, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (451, 19, 133, '2015-08-08', 2.54, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (452, 20, 132, '2015-11-14', 2.91, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (453, 17, 125, '2016-09-28', 2.86, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (454, 49, 134, '2017-01-05', 3.57, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (455, 33, 131, '2015-04-01', 3.24, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (456, 17, 126, '2016-01-16', 3.19, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (457, 45, 126, '2015-09-07', 2.97, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (458, 21, 133, '2015-08-21', 3.86, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (459, 10, 125, '2016-01-16', 4.26, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (460, 21, 132, '2015-08-24', 3.93, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (461, 22, 125, '2017-03-24', 3.37, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (462, 26, 133, '2016-11-04', 2.93, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (463, 24, 129, '2017-01-20', 2.7, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (464, 2, 127, '2015-01-30', 4.1, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (465, 21, 129, '2016-07-17', 3.44, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (466, 16, 134, '2015-02-23', 4.04, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (467, 8, 130, '2016-06-29', 3.63, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (468, 14, 126, '2015-04-30', 3.37, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (469, 42, 133, '2016-05-29', 2.6, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (470, 9, 134, '2015-04-30', 3.3, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (471, 19, 133, '2016-10-30', 3.1, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (472, 27, 129, '2017-01-21', 4.11, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (473, 25, 131, '2016-01-18', 4.35, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (474, 40, 125, '2015-08-16', 2.92, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (475, 10, 127, '2016-07-02', 2.9, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (476, 27, 126, '2017-03-12', 2.54, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (477, 43, 134, '2015-10-02', 3.55, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (478, 42, 127, '2016-08-06', 3.78, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (479, 30, 133, '2017-03-17', 2.52, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (480, 31, 132, '2016-11-27', 3.62, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (481, 51, 126, '2015-03-09', 3.53, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (482, 25, 131, '2015-01-25', 3.18, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (483, 42, 129, '2015-04-28', 3.36, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (484, 38, 129, '2015-03-20', 3.05, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (485, 37, 128, '2016-09-06', 3.31, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (486, 4, 125, '2015-03-12', 3.67, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (487, 21, 132, '2015-03-24', 2.87, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (488, 26, 127, '2015-08-19', 3.53, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (489, 26, 130, '2017-03-12', 3.61, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (490, 23, 132, '2016-06-11', 2.71, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (491, 47, 127, '2015-10-16', 3.98, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (492, 23, 127, '2016-04-17', 4.11, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (493, 29, 131, '2016-02-16', 3.52, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (494, 25, 131, '2017-02-01', 3.73, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (495, 6, 132, '2016-01-29', 4.37, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (496, 38, 129, '2015-12-19', 3.61, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (497, 44, 134, '2016-05-02', 4.41, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (498, 32, 133, '2015-09-14', 3.71, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (499, 9, 128, '2016-12-09', 2.82, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (500, 1, 129, '2016-07-02', 2.7, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (501, 28, 133, '2015-08-22', 3.06, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (502, 35, 128, '2015-06-08', 3.65, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (503, 1, 127, '2017-01-30', 3.3, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (504, 12, 125, '2016-04-12', 4.18, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (505, 17, 127, '2016-03-08', 2.78, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (506, 40, 125, '2015-05-23', 3.11, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (507, 25, 134, '2015-03-12', 4.01, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (508, 9, 128, '2015-01-16', 3.31, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (509, 11, 125, '2016-04-05', 2.65, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (510, 4, 127, '2017-01-19', 4.18, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (511, 16, 134, '2017-04-10', 2.81, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (512, 27, 130, '2015-12-07', 4.12, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (513, 21, 125, '2015-11-01', 3.29, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (514, 33, 126, '2016-11-20', 3.76, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (515, 23, 133, '2015-10-14', 3.48, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (516, 28, 130, '2015-03-24', 2.66, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (517, 36, 126, '2016-05-10', 3.68, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (518, 35, 133, '2017-04-19', 4.26, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (519, 42, 125, '2016-04-05', 4.01, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (520, 12, 125, '2016-09-23', 4.15, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (521, 8, 127, '2016-10-14', 2.64, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (522, 50, 127, '2016-01-21', 2.6, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (523, 17, 130, '2016-04-16', 2.71, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (524, 41, 128, '2016-01-15', 2.82, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (525, 22, 128, '2015-06-02', 2.87, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (526, 15, 129, '2015-05-04', 3.95, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (527, 43, 129, '2015-03-03', 4.37, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (528, 33, 125, '2015-02-03', 4.22, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (529, 32, 126, '2015-10-19', 3.99, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (530, 34, 125, '2017-01-20', 3.57, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (531, 45, 133, '2016-07-16', 3.17, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (532, 50, 134, '2016-04-08', 2.8, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (533, 46, 129, '2016-09-15', 3.55, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (534, 11, 130, '2016-03-19', 4.4, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (535, 15, 134, '2017-01-17', 3.64, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (536, 17, 130, '2015-09-16', 3.15, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (537, 46, 133, '2016-01-26', 4.33, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (538, 11, 129, '2015-05-25', 3.72, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (539, 27, 128, '2015-04-17', 4.33, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (540, 11, 127, '2015-08-27', 4.01, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (541, 51, 133, '2015-07-24', 2.91, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (542, 44, 131, '2016-08-20', 2.91, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (543, 40, 129, '2016-09-29', 3.31, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (544, 18, 130, '2015-11-11', 3.29, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (545, 30, 133, '2015-08-22', 3.1, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (546, 34, 127, '2015-04-26', 4.34, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (547, 21, 127, '2016-11-20', 3.98, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (548, 25, 125, '2016-08-12', 2.78, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (549, 1, 133, '2017-01-09', 4.16, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (550, 25, 131, '2017-04-08', 2.69, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (551, 18, 134, '2017-01-14', 2.97, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (552, 27, 125, '2016-10-24', 4.21, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (553, 49, 133, '2015-10-18', 3.27, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (554, 4, 130, '2017-02-20', 3.64, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (555, 4, 126, '2016-11-26', 3.31, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (556, 4, 127, '2017-01-31', 3.34, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (557, 14, 131, '2017-03-19', 2.75, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (558, 9, 127, '2015-08-08', 3.33, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (559, 23, 133, '2015-05-21', 3.12, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (560, 51, 133, '2015-12-30', 3.64, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (561, 9, 130, '2015-09-16', 2.86, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (562, 22, 127, '2015-02-11', 3.17, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (563, 37, 128, '2015-09-19', 3.93, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (564, 5, 131, '2015-05-26', 2.64, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (565, 11, 129, '2016-06-05', 3.26, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (566, 35, 133, '2016-09-27', 3.47, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (567, 36, 127, '2016-12-11', 4.11, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (568, 7, 131, '2017-03-03', 4.36, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (569, 42, 128, '2015-02-01', 3.77, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (570, 21, 129, '2015-10-28', 2.97, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (571, 51, 125, '2017-04-14', 3.73, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (572, 9, 131, '2016-10-14', 3.08, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (573, 5, 126, '2015-04-23', 3.44, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (574, 19, 128, '2015-12-31', 3.67, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (575, 33, 133, '2016-07-06', 4.11, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (576, 32, 129, '2015-09-26', 2.58, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (577, 48, 129, '2016-04-12', 3.46, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (578, 29, 132, '2016-12-24', 3.97, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (579, 31, 129, '2016-06-10', 3.6, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (580, 41, 130, '2015-01-03', 2.87, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (581, 45, 132, '2015-03-26', 3.95, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (582, 10, 133, '2016-02-25', 2.73, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (583, 44, 126, '2015-07-23', 2.52, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (584, 29, 125, '2017-04-05', 4.44, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (585, 14, 128, '2016-03-12', 4.49, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (586, 9, 132, '2015-04-01', 4.4, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (587, 38, 133, '2016-08-20', 2.78, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (588, 16, 131, '2015-10-05', 3.65, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (589, 8, 130, '2015-03-05', 4.46, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (590, 26, 134, '2015-03-23', 2.67, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (591, 40, 127, '2015-03-27', 4.09, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (592, 35, 130, '2016-03-27', 4.04, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (593, 12, 130, '2015-12-27', 3.39, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (594, 50, 134, '2015-11-12', 4.49, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (595, 32, 129, '2016-09-30', 2.67, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (596, 27, 134, '2017-01-19', 3.18, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (597, 15, 133, '2016-12-01', 3.28, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (598, 44, 127, '2017-03-06', 3.16, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (599, 45, 125, '2016-12-11', 3.02, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (600, 22, 132, '2015-07-23', 4.49, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (601, 30, 126, '2015-11-01', 3.64, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (602, 6, 133, '2015-04-19', 3.3, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (603, 26, 131, '2015-09-19', 3.5, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (604, 2, 129, '2017-01-05', 3.95, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (605, 10, 133, '2015-11-29', 3.59, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (606, 37, 134, '2017-03-14', 4.03, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (607, 2, 125, '2015-12-12', 3.61, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (608, 24, 133, '2015-01-16', 3.8, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (609, 15, 126, '2015-01-21', 2.54, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (610, 44, 129, '2016-12-30', 4.21, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (611, 32, 125, '2016-04-20', 3.3, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (612, 42, 133, '2015-08-28', 4.03, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (613, 40, 130, '2016-03-29', 4.08, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (614, 12, 130, '2015-05-30', 2.59, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (615, 11, 131, '2015-01-03', 3.89, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (616, 49, 128, '2015-05-18', 3.19, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (617, 8, 133, '2017-04-05', 4.3, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (618, 45, 131, '2015-11-04', 2.91, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (619, 35, 130, '2017-01-01', 4.47, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (620, 10, 131, '2015-05-26', 3.68, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (621, 45, 132, '2016-02-11', 4.15, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (622, 32, 134, '2015-04-15', 3.41, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (623, 25, 133, '2015-12-02', 2.77, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (624, 26, 133, '2015-02-02', 2.58, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (625, 49, 131, '2016-10-12', 3.43, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (626, 31, 131, '2016-11-17', 4.18, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (627, 48, 131, '2015-06-13', 4.43, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (628, 51, 133, '2016-04-28', 2.98, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (629, 31, 128, '2015-04-24', 4.08, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (630, 29, 128, '2016-10-06', 3.3, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (631, 26, 126, '2016-06-14', 3.1, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (632, 24, 125, '2016-08-20', 3.85, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (633, 40, 127, '2015-03-20', 4.02, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (634, 30, 133, '2015-12-22', 3.27, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (635, 29, 134, '2015-01-30', 4.1, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (636, 32, 126, '2015-12-11', 4.42, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (637, 1, 130, '2016-09-09', 2.96, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (638, 46, 130, '2015-02-02', 2.51, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (639, 35, 130, '2016-12-03', 3.99, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (640, 44, 131, '2015-05-18', 3.63, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (641, 39, 130, '2015-07-22', 3.01, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (642, 2, 134, '2016-05-15', 2.88, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (643, 11, 130, '2016-02-23', 4.16, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (644, 36, 126, '2015-03-12', 4.2, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (645, 3, 134, '2016-01-12', 2.98, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (646, 30, 127, '2016-09-06', 2.74, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (647, 4, 129, '2016-03-21', 4.1, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (648, 26, 126, '2015-04-14', 3.53, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (649, 2, 126, '2016-09-03', 4.15, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (650, 32, 128, '2016-09-27', 3.63, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (651, 19, 127, '2016-05-06', 3.73, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (652, 3, 134, '2017-03-06', 3.7, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (653, 24, 131, '2016-09-29', 4.43, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (654, 23, 130, '2015-03-11', 2.58, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (655, 18, 126, '2015-02-06', 2.52, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (656, 28, 134, '2016-12-02', 4.36, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (657, 9, 131, '2015-02-18', 3.68, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (658, 28, 125, '2015-10-21', 2.58, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (659, 23, 125, '2015-06-04', 2.78, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (660, 35, 132, '2016-05-14', 2.6, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (661, 32, 132, '2017-01-18', 3.23, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (662, 17, 132, '2015-02-03', 4.45, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (663, 48, 126, '2016-02-26', 2.79, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (664, 49, 128, '2016-08-20', 3.94, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (665, 12, 132, '2016-11-25', 3.29, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (666, 28, 130, '2015-08-18', 4.23, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (667, 50, 130, '2016-03-15', 2.97, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (668, 13, 126, '2016-05-19', 3.8, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (669, 25, 130, '2015-02-09', 3.68, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (670, 13, 130, '2017-02-11', 3.84, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (671, 11, 134, '2016-09-22', 3.77, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (672, 51, 127, '2015-11-30', 2.61, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (673, 1, 125, '2016-01-07', 2.85, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (674, 44, 126, '2015-11-17', 3.86, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (675, 7, 126, '2015-06-21', 3.19, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (676, 28, 127, '2015-06-27', 3.49, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (677, 7, 131, '2015-07-05', 3.05, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (678, 27, 126, '2015-12-22', 3.14, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (679, 40, 132, '2017-01-27', 3.13, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (680, 40, 133, '2017-02-16', 4.46, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (681, 28, 132, '2016-06-11', 3.75, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (682, 39, 125, '2016-02-20', 4.2, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (683, 22, 133, '2015-05-13', 4.06, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (684, 42, 130, '2016-08-07', 2.59, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (685, 50, 129, '2015-09-02', 2.57, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (686, 42, 129, '2015-08-12', 2.97, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (687, 25, 133, '2016-08-27', 3.48, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (688, 14, 130, '2016-03-02', 4.03, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (689, 24, 125, '2017-02-15', 3.02, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (690, 36, 129, '2016-07-22', 2.81, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (691, 9, 127, '2016-05-29', 3.77, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (692, 19, 129, '2016-12-26', 4.32, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (693, 18, 127, '2016-06-28', 2.63, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (694, 46, 130, '2015-08-25', 3.97, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (695, 11, 125, '2016-03-08', 4.34, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (696, 3, 132, '2015-08-03', 3.12, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (697, 47, 130, '2015-11-21', 3.94, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (698, 11, 125, '2016-04-08', 3.24, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (699, 20, 127, '2017-02-19', 4.46, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (700, 13, 127, '2016-01-12', 3.42, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (701, 6, 125, '2016-12-07', 3.27, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (702, 2, 125, '2015-06-21', 4.25, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (703, 13, 133, '2016-04-12', 3.93, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (704, 35, 131, '2016-05-05', 2.64, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (705, 40, 126, '2016-07-06', 4.42, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (706, 13, 132, '2015-02-02', 3.69, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (707, 38, 133, '2015-09-13', 4.44, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (708, 12, 125, '2015-07-10', 2.72, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (709, 34, 134, '2017-01-22', 2.71, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (710, 22, 125, '2017-02-13', 3.8, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (711, 50, 134, '2016-02-14', 3.62, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (712, 15, 126, '2017-03-05', 2.82, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (713, 44, 125, '2016-07-25', 3.44, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (714, 22, 132, '2017-02-09', 2.75, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (715, 38, 125, '2016-04-24', 3.67, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (716, 31, 126, '2015-07-24', 3.61, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (717, 24, 129, '2016-04-12', 3.96, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (718, 44, 125, '2016-12-06', 4.05, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (719, 26, 132, '2016-08-02', 2.96, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (720, 43, 128, '2016-01-29', 3.67, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (721, 32, 129, '2016-01-29', 2.52, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (722, 15, 133, '2016-01-10', 4.05, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (723, 19, 133, '2016-10-04', 3.32, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (724, 18, 128, '2016-09-30', 3.9, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (725, 29, 128, '2017-01-13', 3.35, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (726, 10, 131, '2017-01-31', 4.27, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (727, 7, 128, '2017-01-22', 3.96, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (728, 6, 132, '2016-11-04', 3.62, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (729, 19, 130, '2015-01-17', 3.72, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (730, 9, 130, '2016-11-29', 3.44, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (731, 29, 126, '2016-08-24', 3.17, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (732, 22, 129, '2015-12-01', 3.21, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (733, 42, 127, '2016-04-12', 3.7, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (734, 21, 134, '2015-09-20', 3.98, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (735, 28, 127, '2016-04-15', 3.0, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (736, 46, 125, '2016-11-15', 4.45, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (737, 43, 132, '2016-09-28', 2.72, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (738, 48, 128, '2015-12-26', 3.79, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (739, 7, 126, '2016-12-21', 3.13, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (740, 12, 132, '2015-11-05', 3.71, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (741, 23, 125, '2015-09-03', 3.83, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (742, 23, 133, '2016-03-30', 3.81, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (743, 36, 132, '2016-10-23', 3.95, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (744, 2, 126, '2016-10-05', 3.01, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (745, 23, 126, '2016-05-24', 3.15, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (746, 2, 128, '2015-05-29', 3.36, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (747, 28, 133, '2015-01-16', 3.63, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (748, 5, 134, '2016-02-29', 2.57, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (749, 22, 130, '2016-08-29', 3.97, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (750, 46, 129, '2015-03-14', 4.04, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (751, 37, 134, '2017-04-05', 4.33, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (752, 25, 128, '2016-12-06', 2.99, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (753, 30, 134, '2016-07-10', 2.83, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (754, 31, 134, '2016-12-22', 2.81, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (755, 44, 130, '2016-06-18', 4.14, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (756, 33, 126, '2016-01-28', 4.4, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (757, 13, 129, '2016-05-04', 3.37, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (758, 12, 129, '2016-07-24', 2.72, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (759, 35, 134, '2015-06-05', 3.33, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (760, 15, 132, '2016-12-18', 4.48, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (761, 7, 134, '2015-04-02', 4.38, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (762, 49, 131, '2015-07-28', 3.67, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (763, 47, 127, '2015-06-30', 3.88, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (764, 2, 127, '2015-09-07', 3.76, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (765, 38, 127, '2015-06-09', 4.41, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (766, 26, 131, '2015-07-21', 3.89, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (767, 40, 130, '2017-01-23', 2.91, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (768, 42, 133, '2017-03-12', 4.26, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (769, 20, 126, '2015-12-04', 2.99, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (770, 22, 130, '2017-02-15', 2.53, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (771, 9, 132, '2016-06-05', 2.57, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (772, 32, 131, '2016-08-27', 4.19, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (773, 40, 126, '2016-12-08', 2.5, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (774, 26, 130, '2016-08-07', 3.5, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (775, 13, 128, '2016-06-13', 3.95, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (776, 17, 131, '2016-11-04', 2.59, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (777, 4, 130, '2015-08-03', 3.93, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (778, 26, 126, '2015-08-07', 2.8, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (779, 24, 125, '2016-11-23', 2.8, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (780, 10, 127, '2015-07-26', 2.8, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (781, 34, 134, '2015-01-28', 4.05, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (782, 48, 134, '2016-10-20', 3.96, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (783, 24, 127, '2015-06-02', 4.29, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (784, 32, 128, '2016-08-08', 3.57, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (785, 30, 130, '2016-04-02', 2.52, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (786, 29, 125, '2016-04-11', 3.44, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (787, 3, 133, '2015-03-12', 4.14, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (788, 39, 129, '2015-10-04', 3.86, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (789, 21, 132, '2015-06-05', 2.51, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (790, 12, 130, '2015-03-07', 3.9, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (791, 40, 126, '2016-09-23', 3.08, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (792, 48, 130, '2016-09-14', 3.46, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (793, 38, 129, '2015-08-16', 4.49, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (794, 31, 134, '2016-02-23', 2.78, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (795, 7, 130, '2015-08-01', 4.34, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (796, 4, 131, '2016-01-03', 4.41, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (797, 10, 127, '2015-08-14', 3.18, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (798, 14, 132, '2015-05-15', 3.8, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (799, 4, 133, '2015-05-15', 2.89, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (800, 39, 128, '2015-08-22', 2.76, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (801, 46, 130, '2016-03-29', 3.88, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (802, 11, 128, '2016-10-24', 2.7, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (803, 5, 131, '2017-02-21', 3.79, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (804, 34, 132, '2016-11-26', 4.43, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (805, 18, 127, '2015-06-11', 3.41, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (806, 13, 126, '2016-08-27', 2.61, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (807, 37, 125, '2015-01-04', 3.91, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (808, 47, 133, '2015-07-15', 3.38, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (809, 1, 128, '2016-04-12', 3.0, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (810, 20, 130, '2015-05-15', 2.67, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (811, 30, 132, '2016-09-25', 2.71, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (812, 6, 129, '2015-11-03', 2.91, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (813, 18, 131, '2016-06-10', 3.11, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (814, 17, 134, '2016-11-22', 3.81, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (815, 23, 125, '2015-12-05', 4.45, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (816, 51, 128, '2017-04-02', 4.31, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (817, 6, 132, '2015-08-17', 3.25, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (818, 18, 127, '2016-08-03', 2.82, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (819, 2, 131, '2015-11-01', 3.03, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (820, 32, 133, '2016-11-02', 4.05, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (821, 22, 132, '2015-12-06', 3.27, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (822, 45, 134, '2017-01-16', 3.0, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (823, 20, 132, '2017-04-10', 2.53, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (824, 22, 129, '2015-02-10', 3.42, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (825, 51, 134, '2015-12-29', 4.42, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (826, 4, 127, '2015-09-07', 3.19, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (827, 23, 126, '2015-12-06', 3.63, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (828, 42, 130, '2016-01-18', 3.57, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (829, 14, 129, '2016-10-19', 4.38, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (830, 12, 130, '2016-11-20', 3.08, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (831, 1, 127, '2015-07-02', 3.72, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (832, 39, 131, '2017-03-03', 3.51, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (833, 39, 130, '2015-12-23', 3.24, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (834, 48, 132, '2015-12-06', 3.35, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (835, 46, 125, '2016-06-08', 4.45, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (836, 30, 128, '2017-01-17', 4.04, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (837, 33, 132, '2017-02-12', 4.35, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (838, 23, 131, '2017-02-02', 3.65, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (839, 24, 130, '2015-04-08', 3.18, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (840, 20, 132, '2015-12-24', 4.38, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (841, 9, 131, '2015-09-09', 3.85, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (842, 7, 125, '2015-04-11', 3.49, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (843, 35, 131, '2017-01-21', 3.01, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (844, 46, 130, '2016-08-27', 3.89, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (845, 27, 132, '2015-03-12', 4.29, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (846, 19, 126, '2017-01-08', 3.51, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (847, 8, 132, '2016-10-12', 3.17, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (848, 23, 129, '2017-01-12', 2.81, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (849, 34, 128, '2016-09-04', 4.05, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (850, 51, 125, '2017-02-28', 2.58, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (851, 27, 125, '2017-01-20', 3.04, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (852, 49, 134, '2016-03-14', 3.05, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (853, 20, 130, '2015-03-17', 4.27, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (854, 17, 127, '2016-03-17', 4.08, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (855, 41, 130, '2016-03-31', 2.97, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (856, 36, 134, '2015-05-20', 4.18, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (857, 46, 126, '2016-08-16', 3.91, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (858, 21, 134, '2016-03-15', 3.57, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (859, 18, 133, '2015-11-27', 3.03, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (860, 2, 127, '2016-10-28', 4.12, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (861, 27, 130, '2015-05-20', 3.88, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (862, 6, 125, '2015-02-05', 3.53, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (863, 36, 129, '2016-10-21', 3.17, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (864, 12, 126, '2016-04-13', 3.82, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (865, 46, 127, '2015-07-15', 3.36, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (866, 39, 130, '2016-01-16', 3.76, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (867, 22, 130, '2016-09-27', 3.92, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (868, 49, 125, '2016-06-18', 3.02, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (869, 25, 125, '2016-07-28', 4.39, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (870, 1, 134, '2016-08-04', 4.18, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (871, 31, 132, '2016-08-14', 2.79, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (872, 51, 127, '2015-09-22', 3.06, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (873, 31, 126, '2015-01-30', 3.31, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (874, 28, 126, '2016-03-23', 2.95, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (875, 23, 133, '2015-06-06', 3.94, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (876, 50, 126, '2016-08-12', 3.05, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (877, 6, 133, '2016-02-23', 4.3, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (878, 28, 126, '2015-08-22', 2.87, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (879, 28, 126, '2016-03-06', 4.14, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (880, 27, 125, '2015-09-22', 2.93, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (881, 16, 128, '2016-04-25', 3.41, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (882, 45, 133, '2015-02-07', 3.94, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (883, 8, 134, '2016-04-21', 4.17, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (884, 12, 127, '2016-01-13', 4.12, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (885, 28, 126, '2016-02-09', 4.45, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (886, 19, 126, '2017-02-20', 2.62, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (887, 14, 132, '2016-04-07', 3.36, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (888, 3, 132, '2016-10-18', 3.14, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (889, 1, 134, '2015-07-15', 3.48, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (890, 39, 125, '2016-03-04', 4.28, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (891, 27, 131, '2015-11-14', 2.99, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (892, 33, 132, '2017-02-06', 4.06, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (893, 8, 132, '2015-02-15', 3.52, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (894, 16, 130, '2015-09-23', 3.04, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (895, 17, 133, '2015-10-02', 4.26, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (896, 27, 126, '2015-03-09', 4.12, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (897, 44, 128, '2015-05-30', 3.29, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (898, 12, 126, '2016-08-16', 3.93, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (899, 47, 125, '2015-03-04', 2.84, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (900, 39, 131, '2017-02-21', 2.75, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (901, 47, 129, '2016-07-29', 3.04, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (902, 10, 130, '2016-12-05', 3.79, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (903, 25, 132, '2016-01-10', 4.45, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (904, 30, 125, '2015-01-15', 3.2, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (905, 9, 134, '2016-11-05', 3.47, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (906, 21, 133, '2016-02-04', 4.07, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (907, 50, 126, '2015-03-25', 3.3, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (908, 12, 129, '2016-05-04', 4.33, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (909, 20, 125, '2016-08-27', 4.11, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (910, 33, 130, '2015-02-19', 3.02, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (911, 40, 132, '2015-04-20', 2.82, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (912, 34, 134, '2015-06-06', 2.95, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (913, 14, 131, '2015-05-19', 3.78, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (914, 17, 126, '2016-10-01', 4.13, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (915, 3, 126, '2017-04-01', 2.61, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (916, 7, 128, '2017-01-17', 3.61, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (917, 6, 134, '2015-06-01', 3.79, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (918, 16, 133, '2016-12-16', 2.95, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (919, 1, 125, '2016-01-11', 4.4, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (920, 3, 130, '2017-04-10', 3.63, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (921, 16, 131, '2016-10-05', 3.94, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (922, 2, 133, '2015-06-03', 2.79, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (923, 12, 130, '2015-01-24', 3.37, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (924, 7, 127, '2015-09-21', 3.51, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (925, 13, 132, '2016-07-25', 4.06, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (926, 44, 132, '2016-01-07', 2.59, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (927, 7, 125, '2015-07-19', 3.31, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (928, 44, 133, '2015-10-06', 2.96, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (929, 25, 130, '2016-06-06', 3.34, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (930, 50, 125, '2017-04-21', 4.02, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (931, 22, 131, '2016-06-03', 2.81, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (932, 19, 129, '2017-02-13', 2.7, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (933, 22, 125, '2016-12-03', 4.36, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (934, 41, 134, '2015-10-22', 2.72, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (935, 44, 125, '2015-03-06', 3.25, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (936, 18, 130, '2016-08-27', 3.08, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (937, 32, 131, '2016-04-14', 4.35, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (938, 35, 128, '2015-06-10', 4.4, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (939, 21, 127, '2016-01-18', 3.53, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (940, 51, 131, '2015-07-14', 2.73, 6);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (941, 2, 131, '2016-08-28', 2.78, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (942, 18, 126, '2016-10-08', 4.06, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (943, 23, 130, '2016-10-24', 4.38, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (944, 49, 125, '2015-07-12', 3.22, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (945, 32, 134, '2015-05-04', 3.8, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (946, 19, 126, '2015-02-08', 2.7, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (947, 35, 132, '2015-04-21', 4.45, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (948, 42, 131, '2015-05-09', 4.46, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (949, 28, 132, '2015-05-27', 2.98, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (950, 46, 134, '2016-08-07', 3.94, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (951, 32, 125, '2016-08-12', 4.16, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (952, 12, 127, '2017-04-02', 4.43, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (953, 3, 126, '2016-07-14', 3.63, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (954, 8, 130, '2015-07-25', 4.33, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (955, 14, 127, '2015-01-04', 2.9, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (956, 11, 125, '2015-03-21', 2.99, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (957, 26, 126, '2015-04-13', 3.65, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (958, 15, 130, '2016-12-26', 3.27, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (959, 28, 130, '2016-12-15', 3.82, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (960, 17, 127, '2016-10-06', 4.02, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (961, 12, 125, '2015-12-23', 3.24, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (962, 6, 125, '2016-02-13', 4.27, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (963, 21, 125, '2016-12-18', 3.26, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (964, 14, 133, '2016-09-12', 3.89, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (965, 49, 128, '2016-12-15', 3.15, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (966, 46, 131, '2017-03-21', 3.12, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (967, 9, 127, '2016-12-17', 4.49, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (968, 26, 134, '2016-01-13', 3.37, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (969, 3, 128, '2015-04-06', 4.42, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (970, 2, 125, '2017-03-14', 3.6, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (971, 32, 134, '2015-02-26', 4.07, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (972, 1, 131, '2015-08-17', 3.42, 12);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (973, 50, 131, '2016-03-24', 3.77, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (974, 34, 131, '2016-11-24', 2.81, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (975, 22, 125, '2015-12-08', 2.92, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (976, 42, 131, '2017-03-22', 3.23, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (977, 14, 127, '2017-01-15', 4.36, 5);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (978, 47, 126, '2015-08-28', 2.74, 15);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (979, 2, 128, '2015-09-21', 3.64, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (980, 27, 133, '2015-01-15', 3.11, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (981, 23, 131, '2016-12-30', 2.83, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (982, 30, 128, '2015-02-25', 2.55, 4);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (983, 46, 126, '2016-12-29', 3.44, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (984, 44, 125, '2016-07-08', 3.81, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (985, 25, 134, '2016-05-30', 2.78, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (986, 1, 131, '2016-09-11', 4.2, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (987, 3, 125, '2015-12-12', 3.96, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (988, 29, 132, '2016-10-10', 4.32, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (989, 4, 133, '2016-07-05', 2.64, 9);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (990, 36, 129, '2015-04-06', 3.94, 7);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (991, 5, 125, '2015-04-08', 4.02, 3);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (992, 44, 126, '2015-05-24', 3.96, 14);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (993, 43, 128, '2016-04-30', 3.45, 2);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (994, 22, 134, '2015-09-14', 3.02, 10);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (995, 25, 133, '2016-11-05', 2.9, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (996, 49, 129, '2016-12-23', 4.04, 1);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (997, 7, 134, '2015-10-27', 4.43, 13);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (998, 49, 129, '2016-01-17', 4.31, 11);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (999, 21, 129, '2016-10-22', 3.36, 8);
insert into Repairs (Repair_ID, B_Status_ID, Staff_ID, Delivered, Price, Parts) values (1000, 13, 131, '2015-12-29', 3.81, 14);


insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (2, 2, 33, 2, 5, '15:27', '2:23 PM', 16, 2);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (3, 3, 11, 3, 7, '15:19', '1:13 PM', 6, 28);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (4, 4, 2, 4, 8, '17:33', '6:33 AM', 30, 26);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (5, 5, 35, 5, 9, '12:51', '3:49 PM', 15, 9);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (6, 6, 45, 6, 12,'11:39', '10:58 AM', 16, 13);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (7, 7, 22, 7, 7,'18:45', '10:35 AM', 3, 5);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (8, 8, 3, 8, 2, '16:24', '6:13 AM', 16, 12);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (9, 9, 2, 9, 4,'20:29', '5:13 AM', 5, 8);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (10, 10, 35, 10, 6, '12:45', '6:11 PM', 2, 13);
insert into Bike_Rentals (Rental_ID, Customer_ID, Bike_ID, Payment_ID, Station_ID, Start_time, End_time, Start_Station, End_Station) values (11, 10, 41, 11, 1,'12:47', '5:58 PM', 17, 18);

insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (1, 1, true, 43, 32, 41, '1970-01-01 6:40:07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (2, 12, true, 38, 0, 24, '1970-01-01 15:19:36');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (3, 14, true, 35, 17, 20, '1970-01-01 17:46:31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (4, 4, false, 40, 34, 12, '1970-01-01 9:46:58');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (5, 19, false, 40, 10, 2, '1970-01-01 6:25:00');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (6, 16, true, 46, 25, 35, '1970-01-01 8:50:29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (7, 26, true, 47, 11, 13, '1970-01-01 9:05:35');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (8, 13, true, 28, 8, 49, '1970-01-01 6:46:05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (9, 12, false, 35, 28, 31, '1970-01-01 18:47:37');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (10, 10, true, 40, 39, 24, '1970-01-01 20:59:26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (11, 18, false, 28, 6, 47, '2015-08-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (12, 18, false, 47, 7, 1, '2015-05-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (13, 15, true, 36, 36, 8, '2016-10-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (14, 27, true, 49, 10, 7, '2017-03-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (15, 26, false, 42, 22, 9, '2016-03-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (16, 11, false, 39, 15, 41, '2016-03-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (17, 24, true, 38, 47, 44, '2015-11-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (18, 17, true, 40, 26, 38, '2016-04-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (19, 3, false, 32, 45, 50, '2015-01-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (20, 20, false, 49, 14, 24, '2015-04-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (21, 27, true, 35, 26, 39, '2015-05-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (22, 26, false, 49, 45, 6, '2016-05-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (23, 19, true, 26, 7, 45, '2015-10-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (24, 5, true, 30, 32, 23, '2017-03-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (25, 7, false, 46, 43, 39, '2015-08-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (26, 17, true, 25, 40, 14, '2017-02-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (27, 10, true, 37, 10, 7, '2016-08-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (28, 30, true, 41, 3, 30, '2015-09-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (29, 15, false, 28, 12, 23, '2015-09-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (30, 24, false, 32, 37, 8, '2016-12-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (31, 11, false, 41, 9, 5, '2016-11-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (32, 16, false, 34, 33, 19, '2015-11-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (33, 14, false, 38, 48, 35, '2015-11-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (34, 10, true, 41, 2, 13, '2015-11-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (35, 21, false, 49, 29, 13, '2017-03-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (36, 16, false, 40, 38, 2, '2017-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (37, 28, true, 43, 14, 15, '2015-07-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (38, 30, false, 28, 20, 48, '2016-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (39, 26, false, 32, 50, 17, '2016-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (40, 27, true, 32, 38, 5, '2015-05-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (41, 28, false, 42, 11, 20, '2015-01-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (42, 2, true, 46, 38, 24, '2016-09-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (43, 13, false, 31, 29, 42, '2016-05-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (44, 18, true, 47, 16, 28, '2016-05-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (45, 16, false, 50, 35, 13, '2016-04-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (46, 12, true, 49, 26, 35, '2016-05-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (47, 1, false, 26, 46, 49, '2015-07-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (48, 10, false, 43, 3, 7, '2016-07-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (49, 24, true, 49, 19, 34, '2016-07-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (50, 12, true, 34, 20, 40, '2016-03-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (51, 29, false, 30, 13, 47, '2015-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (52, 3, true, 49, 50, 23, '2015-04-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (53, 8, true, 31, 43, 33, '2016-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (54, 20, false, 46, 8, 37, '2015-12-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (55, 25, false, 41, 47, 15, '2015-01-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (56, 3, true, 47, 30, 34, '2015-11-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (57, 3, true, 36, 41, 2, '2016-02-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (58, 8, true, 31, 38, 47, '2016-06-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (59, 12, true, 25, 10, 13, '2015-12-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (60, 29, false, 37, 31, 9, '2016-05-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (61, 21, true, 41, 0, 40, '2017-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (62, 27, false, 29, 19, 18, '2016-06-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (63, 9, true, 46, 30, 48, '2015-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (64, 22, true, 26, 16, 40, '2015-03-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (65, 5, true, 28, 20, 46, '2016-05-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (66, 22, false, 46, 27, 39, '2016-12-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (67, 22, true, 41, 2, 32, '2017-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (68, 30, true, 42, 43, 5, '2016-10-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (69, 20, false, 36, 15, 7, '2015-10-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (70, 24, false, 47, 45, 4, '2015-05-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (71, 8, true, 30, 31, 48, '2015-01-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (72, 11, true, 36, 48, 41, '2016-10-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (73, 8, true, 34, 25, 39, '2016-03-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (74, 29, false, 38, 46, 17, '2016-06-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (75, 20, false, 31, 33, 22, '2017-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (76, 10, true, 31, 33, 50, '2017-01-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (77, 25, true, 38, 34, 12, '2016-10-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (78, 5, false, 28, 32, 41, '2015-10-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (79, 27, false, 47, 12, 11, '2015-07-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (80, 13, true, 27, 24, 25, '2015-02-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (81, 19, false, 35, 3, 36, '2016-10-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (82, 4, false, 48, 47, 19, '2017-03-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (83, 14, true, 25, 31, 23, '2015-01-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (84, 22, false, 30, 4, 45, '2016-08-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (85, 21, false, 25, 22, 37, '2015-10-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (86, 10, false, 32, 33, 26, '2016-03-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (87, 30, false, 46, 38, 36, '2017-03-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (88, 15, false, 50, 47, 43, '2015-07-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (89, 9, false, 44, 32, 46, '2017-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (90, 29, false, 40, 6, 27, '2015-09-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (91, 6, true, 36, 10, 16, '2015-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (92, 21, false, 36, 44, 31, '2015-10-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (93, 1, true, 48, 40, 24, '2017-03-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (94, 20, false, 42, 32, 20, '2016-07-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (95, 26, false, 27, 41, 13, '2016-08-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (96, 23, true, 36, 2, 15, '2015-12-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (97, 19, false, 32, 35, 38, '2016-04-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (98, 14, true, 43, 12, 0, '2017-01-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (99, 8, false, 31, 47, 41, '2015-09-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (100, 17, true, 35, 18, 23, '2015-05-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (101, 9, true, 39, 19, 37, '2017-03-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (102, 24, true, 32, 44, 48, '2015-11-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (103, 9, false, 33, 26, 37, '2015-06-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (104, 12, true, 42, 44, 29, '2017-01-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (105, 10, true, 38, 15, 27, '2015-06-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (106, 13, true, 48, 35, 14, '2015-10-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (107, 17, true, 38, 36, 48, '2015-10-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (108, 18, false, 34, 35, 40, '2016-06-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (109, 19, true, 35, 28, 5, '2017-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (110, 9, false, 30, 19, 46, '2015-10-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (111, 7, true, 40, 31, 28, '2016-02-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (112, 2, false, 36, 5, 4, '2016-05-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (113, 7, false, 28, 35, 2, '2016-05-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (114, 18, true, 31, 37, 2, '2015-03-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (115, 5, true, 29, 48, 35, '2016-10-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (116, 23, false, 26, 16, 3, '2015-07-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (117, 8, true, 35, 0, 37, '2015-12-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (118, 20, false, 36, 5, 22, '2016-12-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (119, 14, true, 50, 9, 43, '2016-09-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (120, 16, false, 40, 33, 47, '2016-10-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (121, 17, true, 50, 28, 13, '2016-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (122, 7, false, 26, 4, 29, '2016-11-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (123, 19, true, 45, 43, 7, '2015-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (124, 21, false, 45, 25, 35, '2016-10-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (125, 22, false, 44, 29, 33, '2016-10-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (126, 17, false, 46, 44, 42, '2016-06-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (127, 4, true, 31, 36, 36, '2016-08-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (128, 22, false, 43, 50, 15, '2015-08-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (129, 5, true, 26, 1, 27, '2016-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (130, 6, true, 31, 38, 34, '2017-04-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (131, 7, true, 44, 6, 11, '2017-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (132, 5, false, 31, 24, 1, '2017-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (133, 11, false, 28, 18, 45, '2016-07-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (134, 4, true, 46, 13, 12, '2015-02-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (135, 24, true, 26, 42, 43, '2016-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (136, 14, false, 44, 27, 3, '2015-01-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (137, 20, false, 42, 25, 24, '2016-05-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (138, 11, true, 33, 21, 14, '2015-12-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (139, 8, true, 45, 44, 13, '2015-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (140, 7, true, 31, 44, 40, '2015-02-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (141, 19, true, 26, 49, 46, '2016-05-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (142, 15, true, 38, 39, 40, '2015-09-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (143, 6, true, 33, 28, 17, '2016-08-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (144, 13, false, 33, 38, 25, '2015-12-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (145, 14, true, 28, 34, 30, '2016-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (146, 25, false, 40, 8, 14, '2015-12-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (147, 3, true, 46, 50, 15, '2016-07-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (148, 23, false, 48, 9, 43, '2017-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (149, 3, false, 44, 31, 18, '2015-08-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (150, 24, true, 29, 27, 16, '2015-08-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (151, 8, false, 31, 43, 25, '2016-04-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (152, 4, true, 35, 43, 17, '2017-02-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (153, 2, true, 47, 18, 11, '2016-12-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (154, 7, false, 39, 7, 3, '2016-05-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (155, 2, false, 28, 26, 2, '2016-01-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (156, 14, true, 38, 10, 15, '2016-07-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (157, 26, true, 43, 4, 19, '2016-10-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (158, 27, true, 37, 36, 16, '2016-10-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (159, 12, true, 27, 12, 23, '2016-05-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (160, 23, false, 35, 42, 17, '2015-10-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (161, 11, true, 41, 30, 3, '2015-06-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (162, 12, false, 45, 31, 34, '2016-09-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (163, 9, true, 35, 1, 17, '2015-01-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (164, 3, true, 29, 15, 17, '2015-05-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (165, 7, true, 26, 21, 17, '2016-02-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (166, 6, true, 29, 3, 24, '2017-01-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (167, 16, false, 45, 21, 45, '2016-03-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (168, 20, true, 44, 26, 11, '2015-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (169, 17, false, 32, 39, 1, '2015-06-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (170, 19, false, 40, 21, 23, '2017-01-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (171, 20, true, 29, 9, 38, '2017-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (172, 17, true, 35, 42, 13, '2015-03-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (173, 7, false, 40, 3, 16, '2016-04-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (174, 23, false, 42, 24, 46, '2016-02-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (175, 29, true, 39, 17, 21, '2017-04-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (176, 7, true, 49, 29, 25, '2017-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (177, 2, true, 46, 42, 29, '2015-10-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (178, 2, false, 28, 12, 40, '2015-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (179, 9, true, 40, 20, 47, '2016-12-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (180, 8, false, 30, 2, 14, '2016-12-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (181, 11, false, 36, 28, 11, '2015-10-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (182, 8, true, 48, 13, 50, '2016-11-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (183, 10, true, 43, 41, 28, '2017-01-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (184, 10, true, 45, 49, 9, '2017-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (185, 10, false, 48, 5, 48, '2016-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (186, 13, true, 48, 39, 50, '2015-10-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (187, 19, true, 25, 22, 22, '2015-02-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (188, 21, false, 47, 36, 33, '2015-02-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (189, 23, false, 30, 45, 44, '2015-10-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (190, 3, false, 31, 41, 22, '2017-03-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (191, 12, false, 26, 28, 13, '2017-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (192, 11, false, 48, 10, 48, '2015-06-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (193, 7, false, 29, 44, 36, '2016-03-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (194, 22, false, 37, 7, 45, '2015-10-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (195, 28, true, 32, 10, 41, '2017-03-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (196, 15, true, 48, 12, 36, '2015-07-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (197, 17, true, 29, 4, 12, '2015-12-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (198, 25, true, 39, 47, 48, '2016-12-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (199, 27, true, 27, 14, 39, '2015-12-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (200, 21, true, 48, 20, 4, '2016-05-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (201, 3, false, 39, 14, 11, '2015-07-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (202, 10, true, 47, 45, 4, '2016-10-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (203, 1, false, 35, 50, 9, '2016-09-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (204, 12, true, 29, 26, 41, '2016-10-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (205, 14, false, 28, 15, 13, '2016-08-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (206, 14, false, 45, 23, 23, '2015-02-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (207, 29, false, 36, 14, 38, '2016-09-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (208, 17, true, 47, 15, 25, '2016-10-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (209, 23, false, 41, 28, 41, '2016-11-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (210, 8, false, 31, 31, 0, '2016-03-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (211, 14, false, 25, 50, 9, '2015-11-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (212, 16, true, 37, 20, 29, '2015-01-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (213, 20, true, 48, 39, 30, '2016-12-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (214, 2, true, 38, 33, 23, '2016-07-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (215, 24, true, 39, 3, 20, '2016-07-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (216, 4, false, 49, 34, 16, '2016-04-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (217, 13, false, 30, 50, 34, '2015-05-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (218, 10, true, 46, 27, 6, '2015-12-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (219, 10, true, 29, 13, 48, '2015-12-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (220, 23, false, 26, 32, 13, '2015-02-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (221, 26, false, 27, 49, 48, '2016-06-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (222, 11, true, 45, 1, 7, '2016-04-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (223, 26, true, 38, 43, 5, '2015-10-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (224, 19, true, 50, 2, 25, '2015-12-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (225, 23, true, 50, 15, 40, '2016-09-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (226, 16, true, 31, 0, 4, '2016-05-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (227, 7, true, 25, 45, 37, '2016-04-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (228, 18, true, 32, 2, 6, '2016-10-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (229, 25, true, 44, 34, 2, '2015-12-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (230, 3, true, 38, 27, 29, '2016-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (231, 13, false, 49, 0, 47, '2016-09-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (232, 21, true, 50, 14, 22, '2016-11-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (233, 14, true, 43, 30, 46, '2015-05-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (234, 26, false, 50, 29, 26, '2015-07-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (235, 13, false, 38, 32, 36, '2016-10-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (236, 24, true, 50, 44, 7, '2016-12-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (237, 29, false, 27, 17, 9, '2015-10-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (238, 29, true, 43, 49, 8, '2015-02-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (239, 28, false, 47, 28, 18, '2015-03-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (240, 4, true, 28, 23, 20, '2015-05-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (241, 13, false, 34, 19, 24, '2016-11-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (242, 22, true, 32, 40, 48, '2016-11-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (243, 10, false, 38, 1, 47, '2015-01-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (244, 30, true, 29, 34, 44, '2016-02-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (245, 21, true, 50, 2, 0, '2017-01-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (246, 7, true, 29, 11, 43, '2016-05-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (247, 8, false, 44, 10, 40, '2016-02-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (248, 25, false, 36, 22, 25, '2016-06-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (249, 9, false, 47, 19, 34, '2016-12-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (250, 22, true, 39, 19, 30, '2016-04-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (251, 19, false, 28, 29, 11, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (252, 18, true, 36, 26, 11, '2016-08-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (253, 9, false, 26, 20, 18, '2016-02-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (254, 11, false, 47, 42, 31, '2015-09-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (255, 1, false, 40, 18, 45, '2015-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (256, 21, false, 34, 3, 15, '2015-02-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (257, 21, true, 38, 7, 12, '2016-04-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (258, 7, false, 28, 46, 27, '2016-03-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (259, 27, true, 34, 25, 48, '2016-07-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (260, 17, true, 42, 22, 32, '2017-01-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (261, 29, false, 38, 27, 4, '2015-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (262, 27, false, 48, 31, 50, '2015-01-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (263, 20, false, 48, 38, 38, '2017-04-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (264, 22, false, 27, 50, 19, '2015-03-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (265, 24, true, 29, 2, 16, '2016-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (266, 7, true, 41, 47, 45, '2016-01-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (267, 15, false, 39, 30, 3, '2016-11-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (268, 18, true, 30, 14, 39, '2016-02-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (269, 29, true, 32, 33, 38, '2016-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (270, 12, false, 47, 34, 21, '2015-07-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (271, 17, false, 43, 19, 35, '2016-07-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (272, 28, false, 27, 32, 36, '2016-09-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (273, 23, false, 41, 11, 9, '2015-03-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (274, 19, false, 25, 3, 13, '2015-04-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (275, 24, true, 38, 12, 22, '2016-10-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (276, 10, false, 45, 29, 26, '2016-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (277, 10, true, 41, 30, 41, '2017-01-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (278, 13, true, 47, 39, 46, '2015-03-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (279, 7, false, 29, 44, 46, '2017-01-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (280, 21, true, 49, 17, 1, '2015-12-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (281, 18, true, 47, 5, 18, '2015-03-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (282, 19, true, 30, 5, 47, '2016-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (283, 21, false, 25, 43, 2, '2017-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (284, 20, true, 43, 30, 36, '2015-12-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (285, 17, false, 40, 49, 6, '2015-06-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (286, 25, true, 25, 5, 29, '2015-06-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (287, 26, true, 38, 2, 14, '2016-04-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (288, 14, true, 37, 29, 27, '2016-09-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (289, 24, false, 29, 26, 4, '2016-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (290, 22, false, 32, 30, 25, '2016-12-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (291, 15, false, 32, 18, 2, '2016-07-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (292, 18, false, 40, 33, 6, '2016-07-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (293, 12, false, 32, 8, 45, '2017-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (294, 2, true, 47, 10, 32, '2015-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (295, 13, false, 37, 39, 21, '2016-08-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (296, 25, false, 50, 37, 27, '2015-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (297, 27, false, 40, 34, 17, '2015-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (298, 6, false, 38, 43, 6, '2016-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (299, 29, false, 29, 30, 24, '2017-02-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (300, 12, true, 44, 38, 36, '2017-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (301, 9, true, 37, 35, 30, '2017-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (302, 5, true, 38, 3, 20, '2015-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (303, 17, true, 50, 19, 5, '2017-01-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (304, 27, true, 50, 12, 1, '2016-06-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (305, 19, true, 46, 18, 17, '2017-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (306, 29, true, 29, 16, 17, '2016-09-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (307, 21, false, 44, 20, 7, '2016-11-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (308, 17, true, 46, 40, 26, '2016-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (309, 11, true, 41, 48, 13, '2015-05-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (310, 3, true, 29, 29, 50, '2016-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (311, 27, true, 36, 49, 17, '2016-10-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (312, 2, true, 40, 37, 22, '2016-01-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (313, 25, false, 37, 13, 39, '2016-11-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (314, 1, false, 32, 44, 26, '2015-11-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (315, 27, false, 30, 15, 16, '2016-07-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (316, 22, true, 44, 42, 39, '2015-07-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (317, 13, true, 26, 37, 15, '2016-11-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (318, 11, true, 37, 19, 25, '2017-01-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (319, 21, true, 27, 42, 28, '2017-04-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (320, 1, true, 38, 35, 14, '2015-06-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (321, 3, true, 31, 9, 26, '2015-09-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (322, 3, true, 34, 24, 19, '2015-09-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (323, 9, true, 31, 43, 17, '2016-05-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (324, 29, false, 41, 0, 42, '2016-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (325, 19, false, 47, 13, 26, '2015-12-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (326, 30, false, 50, 16, 29, '2016-11-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (327, 17, true, 50, 39, 3, '2015-08-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (328, 20, false, 47, 49, 48, '2016-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (329, 15, false, 42, 44, 31, '2016-05-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (330, 11, false, 47, 6, 28, '2016-07-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (331, 19, true, 46, 18, 13, '2015-04-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (332, 12, false, 50, 29, 21, '2016-12-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (333, 13, true, 33, 0, 0, '2015-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (334, 1, true, 39, 36, 43, '2016-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (335, 17, false, 38, 45, 17, '2016-09-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (336, 17, false, 39, 31, 26, '2016-10-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (337, 1, true, 27, 37, 0, '2015-05-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (338, 25, true, 37, 19, 8, '2016-12-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (339, 28, true, 29, 28, 47, '2015-12-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (340, 5, false, 46, 36, 8, '2016-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (341, 18, true, 41, 40, 15, '2017-03-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (342, 8, false, 37, 25, 43, '2015-03-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (343, 16, false, 40, 14, 12, '2015-02-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (344, 9, false, 48, 47, 30, '2016-05-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (345, 1, true, 26, 2, 21, '2016-04-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (346, 11, true, 38, 18, 4, '2016-09-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (347, 5, false, 37, 33, 22, '2017-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (348, 27, false, 29, 5, 11, '2015-09-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (349, 27, false, 50, 14, 13, '2015-10-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (350, 11, true, 29, 19, 29, '2015-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (351, 29, false, 25, 38, 45, '2017-02-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (352, 7, false, 33, 49, 19, '2016-12-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (353, 20, true, 45, 2, 16, '2015-04-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (354, 9, false, 37, 0, 23, '2015-12-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (355, 18, false, 38, 12, 31, '2015-06-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (356, 19, false, 49, 22, 32, '2015-02-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (357, 19, false, 43, 36, 46, '2016-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (358, 22, true, 40, 3, 16, '2015-10-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (359, 23, false, 33, 48, 18, '2016-05-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (360, 26, true, 40, 22, 35, '2015-03-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (361, 11, false, 42, 17, 26, '2016-11-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (362, 12, true, 45, 25, 30, '2017-03-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (363, 18, true, 46, 3, 29, '2015-08-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (364, 26, true, 48, 23, 40, '2015-08-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (365, 19, true, 48, 45, 47, '2016-05-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (366, 18, false, 28, 44, 42, '2015-06-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (367, 22, false, 43, 41, 23, '2016-11-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (368, 13, true, 29, 6, 39, '2017-04-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (369, 21, false, 49, 4, 26, '2015-06-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (370, 10, true, 40, 42, 27, '2017-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (371, 24, false, 41, 32, 29, '2017-02-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (372, 12, false, 42, 40, 21, '2015-07-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (373, 11, false, 33, 19, 31, '2015-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (374, 4, true, 29, 50, 41, '2015-10-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (375, 1, false, 45, 32, 23, '2016-10-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (376, 6, true, 29, 24, 31, '2016-02-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (377, 29, true, 42, 50, 10, '2016-11-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (378, 27, true, 44, 32, 15, '2017-02-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (379, 12, false, 46, 18, 39, '2016-08-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (380, 14, false, 28, 0, 32, '2015-10-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (381, 21, false, 25, 24, 15, '2015-06-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (382, 23, true, 33, 13, 5, '2015-07-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (383, 26, true, 28, 3, 46, '2015-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (384, 10, true, 35, 7, 21, '2016-02-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (385, 12, true, 41, 15, 48, '2016-08-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (386, 21, true, 46, 6, 4, '2016-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (387, 11, false, 50, 36, 50, '2015-02-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (388, 25, true, 25, 43, 28, '2015-08-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (389, 19, false, 35, 14, 17, '2015-05-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (390, 19, false, 49, 11, 31, '2016-10-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (391, 17, true, 27, 45, 44, '2015-11-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (392, 7, false, 36, 38, 41, '2017-01-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (393, 12, true, 35, 9, 15, '2015-11-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (394, 5, true, 28, 47, 44, '2017-03-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (395, 29, true, 32, 50, 23, '2015-12-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (396, 2, true, 50, 31, 37, '2016-02-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (397, 5, false, 29, 10, 24, '2015-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (398, 11, false, 31, 29, 9, '2015-10-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (399, 3, true, 31, 30, 15, '2015-05-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (400, 22, true, 25, 34, 30, '2016-12-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (401, 2, false, 25, 5, 35, '2017-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (402, 25, true, 32, 37, 14, '2015-08-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (403, 25, true, 26, 48, 12, '2016-08-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (404, 12, true, 45, 30, 45, '2016-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (405, 7, true, 34, 5, 13, '2015-06-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (406, 25, false, 37, 47, 40, '2017-03-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (407, 5, false, 47, 22, 12, '2015-06-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (408, 26, false, 38, 27, 35, '2016-12-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (409, 30, true, 25, 40, 13, '2015-02-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (410, 18, false, 47, 47, 19, '2015-09-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (411, 4, false, 30, 30, 8, '2016-05-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (412, 18, false, 35, 25, 50, '2017-03-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (413, 9, true, 46, 1, 29, '2016-09-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (414, 28, true, 33, 44, 50, '2016-10-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (415, 1, false, 45, 22, 32, '2015-05-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (416, 10, false, 27, 25, 4, '2016-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (417, 8, true, 43, 20, 39, '2015-04-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (418, 5, true, 35, 14, 13, '2015-03-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (419, 10, false, 39, 29, 2, '2016-03-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (420, 24, true, 37, 1, 24, '2016-02-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (421, 14, true, 43, 0, 44, '2016-06-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (422, 18, true, 49, 39, 42, '2015-07-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (423, 26, false, 36, 38, 7, '2016-06-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (424, 16, false, 27, 10, 37, '2017-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (425, 8, true, 37, 11, 4, '2016-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (426, 7, false, 42, 5, 3, '2015-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (427, 26, false, 43, 3, 33, '2017-04-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (428, 9, true, 38, 32, 11, '2016-08-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (429, 18, true, 28, 15, 12, '2016-11-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (430, 3, true, 38, 12, 10, '2015-04-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (431, 20, false, 48, 25, 0, '2015-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (432, 27, true, 40, 42, 46, '2016-07-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (433, 22, true, 28, 5, 36, '2016-02-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (434, 25, true, 49, 15, 37, '2015-09-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (435, 16, false, 48, 32, 33, '2016-07-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (436, 11, false, 26, 19, 33, '2017-02-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (437, 28, true, 26, 14, 32, '2017-02-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (438, 12, true, 38, 3, 12, '2015-05-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (439, 10, true, 36, 23, 20, '2016-04-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (440, 22, false, 37, 40, 30, '2015-07-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (441, 3, false, 27, 28, 9, '2017-03-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (442, 25, false, 27, 15, 24, '2015-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (443, 21, true, 36, 19, 27, '2015-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (444, 8, true, 31, 39, 19, '2016-06-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (445, 30, true, 27, 21, 31, '2016-04-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (446, 18, true, 44, 17, 40, '2015-10-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (447, 6, true, 47, 10, 28, '2015-09-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (448, 23, false, 42, 18, 8, '2017-04-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (449, 17, true, 41, 15, 29, '2016-11-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (450, 18, true, 41, 19, 22, '2015-05-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (451, 20, false, 27, 2, 23, '2015-02-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (452, 5, true, 32, 26, 37, '2017-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (453, 4, false, 42, 2, 46, '2015-05-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (454, 5, true, 31, 34, 26, '2017-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (455, 12, true, 29, 25, 40, '2015-12-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (456, 28, true, 32, 23, 14, '2016-12-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (457, 2, true, 33, 7, 3, '2015-07-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (458, 9, true, 26, 43, 6, '2016-01-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (459, 18, true, 34, 23, 30, '2016-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (460, 8, false, 36, 16, 2, '2015-12-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (461, 24, false, 46, 48, 21, '2016-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (462, 7, true, 36, 13, 7, '2015-12-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (463, 23, true, 42, 12, 40, '2016-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (464, 6, true, 49, 5, 32, '2017-03-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (465, 8, true, 50, 4, 50, '2015-06-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (466, 20, true, 25, 2, 21, '2017-01-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (467, 4, false, 42, 27, 26, '2017-02-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (468, 2, true, 39, 44, 6, '2016-02-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (469, 24, true, 42, 25, 38, '2015-12-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (470, 4, true, 42, 39, 4, '2016-05-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (471, 12, true, 45, 14, 49, '2015-06-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (472, 27, true, 38, 49, 26, '2015-06-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (473, 23, false, 25, 27, 14, '2016-01-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (474, 28, false, 45, 13, 46, '2016-05-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (475, 17, false, 28, 8, 31, '2015-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (476, 16, true, 30, 0, 23, '2016-03-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (477, 9, false, 33, 37, 0, '2017-01-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (478, 4, true, 39, 49, 4, '2016-08-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (479, 27, true, 32, 5, 34, '2015-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (480, 15, false, 48, 6, 44, '2015-02-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (481, 21, false, 40, 17, 20, '2016-12-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (482, 1, false, 32, 7, 28, '2015-09-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (483, 13, true, 44, 3, 6, '2017-03-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (484, 6, true, 40, 19, 25, '2016-05-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (485, 30, false, 49, 16, 9, '2017-03-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (486, 21, true, 33, 6, 37, '2016-05-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (487, 5, false, 39, 38, 17, '2016-06-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (488, 14, false, 43, 32, 39, '2015-08-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (489, 14, true, 44, 2, 50, '2015-08-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (490, 21, true, 32, 13, 13, '2015-03-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (491, 9, true, 26, 42, 43, '2017-02-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (492, 19, true, 44, 9, 23, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (493, 5, true, 44, 17, 1, '2017-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (494, 25, true, 41, 25, 13, '2016-07-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (495, 4, true, 25, 39, 45, '2015-07-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (496, 2, true, 26, 7, 42, '2016-11-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (497, 7, true, 29, 13, 10, '2015-05-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (498, 25, false, 28, 17, 35, '2016-08-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (499, 6, true, 44, 23, 8, '2015-07-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (500, 23, true, 47, 43, 9, '2016-01-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (501, 6, false, 49, 17, 25, '2016-11-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (502, 1, false, 50, 20, 43, '2016-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (503, 8, true, 36, 8, 19, '2017-04-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (504, 6, true, 38, 21, 17, '2016-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (505, 3, true, 30, 50, 29, '2016-02-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (506, 3, false, 32, 41, 24, '2015-01-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (507, 30, true, 46, 44, 25, '2015-06-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (508, 9, false, 37, 26, 48, '2017-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (509, 3, false, 33, 23, 33, '2016-12-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (510, 16, false, 35, 34, 46, '2015-10-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (511, 6, false, 29, 30, 10, '2015-03-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (512, 30, true, 39, 50, 0, '2016-02-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (513, 11, true, 25, 23, 35, '2016-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (514, 12, false, 47, 4, 20, '2016-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (515, 7, false, 28, 20, 24, '2016-04-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (516, 11, false, 25, 16, 10, '2017-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (517, 1, true, 30, 50, 45, '2015-05-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (518, 15, true, 28, 21, 22, '2015-02-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (519, 16, true, 30, 17, 40, '2016-03-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (520, 1, true, 36, 16, 2, '2016-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (521, 20, false, 43, 2, 12, '2016-05-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (522, 6, true, 29, 49, 26, '2015-04-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (523, 12, true, 36, 16, 19, '2015-07-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (524, 21, true, 25, 24, 25, '2017-03-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (525, 22, true, 29, 27, 45, '2015-10-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (526, 25, false, 39, 32, 24, '2015-12-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (527, 27, false, 35, 24, 48, '2016-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (528, 4, false, 25, 1, 29, '2015-10-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (529, 14, false, 45, 8, 48, '2016-07-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (530, 20, false, 42, 20, 31, '2016-08-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (531, 20, true, 39, 34, 30, '2016-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (532, 19, false, 33, 30, 44, '2016-09-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (533, 29, false, 25, 38, 11, '2016-10-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (534, 22, false, 32, 49, 3, '2016-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (535, 6, false, 32, 0, 23, '2015-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (536, 7, false, 47, 2, 37, '2016-05-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (537, 17, true, 29, 16, 35, '2017-04-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (538, 22, false, 42, 24, 8, '2017-01-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (539, 8, true, 43, 33, 39, '2015-03-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (540, 21, true, 49, 38, 1, '2015-10-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (541, 11, true, 31, 13, 23, '2017-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (542, 11, false, 38, 19, 10, '2015-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (543, 17, true, 36, 27, 29, '2016-03-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (544, 19, false, 39, 7, 17, '2016-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (545, 6, false, 45, 25, 29, '2015-11-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (546, 25, false, 29, 26, 26, '2016-12-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (547, 21, false, 40, 15, 26, '2016-09-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (548, 21, false, 47, 46, 8, '2017-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (549, 10, true, 35, 35, 46, '2017-02-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (550, 29, true, 45, 13, 50, '2016-11-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (551, 7, true, 39, 27, 27, '2015-05-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (552, 27, false, 38, 9, 30, '2015-01-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (553, 26, false, 34, 7, 2, '2016-09-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (554, 30, false, 31, 12, 48, '2016-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (555, 1, true, 48, 43, 22, '2016-09-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (556, 30, false, 48, 21, 47, '2015-03-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (557, 22, true, 30, 15, 10, '2016-09-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (558, 19, true, 47, 38, 50, '2015-02-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (559, 1, true, 43, 48, 13, '2016-09-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (560, 29, false, 36, 27, 3, '2016-04-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (561, 4, true, 50, 6, 30, '2015-04-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (562, 25, true, 46, 1, 42, '2015-09-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (563, 9, false, 31, 11, 46, '2015-11-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (564, 12, true, 36, 24, 3, '2015-09-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (565, 24, true, 49, 34, 11, '2015-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (566, 25, false, 39, 20, 3, '2016-06-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (567, 26, true, 49, 35, 45, '2017-04-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (568, 24, true, 30, 27, 24, '2015-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (569, 1, false, 33, 4, 47, '2016-05-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (570, 7, false, 27, 27, 19, '2016-10-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (571, 16, true, 33, 25, 39, '2016-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (572, 10, false, 36, 32, 32, '2015-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (573, 11, true, 37, 0, 38, '2015-08-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (574, 3, false, 45, 14, 3, '2015-05-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (575, 12, true, 41, 16, 38, '2015-06-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (576, 19, true, 34, 9, 31, '2016-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (577, 18, true, 44, 38, 4, '2015-02-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (578, 12, false, 44, 32, 14, '2015-07-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (579, 20, false, 35, 40, 44, '2016-01-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (580, 18, true, 41, 28, 2, '2016-08-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (581, 20, true, 30, 47, 49, '2015-11-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (582, 28, true, 29, 45, 15, '2015-03-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (583, 13, false, 48, 21, 2, '2015-07-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (584, 3, true, 33, 18, 46, '2016-03-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (585, 18, true, 45, 44, 4, '2015-08-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (586, 10, true, 39, 25, 40, '2017-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (587, 15, true, 40, 24, 9, '2015-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (588, 27, false, 25, 43, 5, '2015-08-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (589, 14, false, 42, 25, 16, '2017-03-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (590, 5, false, 34, 48, 11, '2017-01-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (591, 14, true, 30, 19, 33, '2015-09-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (592, 1, true, 32, 31, 36, '2016-01-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (593, 15, true, 43, 42, 26, '2016-07-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (594, 24, true, 46, 32, 8, '2015-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (595, 1, false, 35, 47, 3, '2016-08-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (596, 21, false, 44, 48, 3, '2015-01-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (597, 17, false, 29, 19, 26, '2016-07-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (598, 6, true, 40, 11, 15, '2016-03-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (599, 24, true, 48, 10, 42, '2015-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (600, 21, false, 40, 43, 30, '2017-02-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (601, 22, false, 42, 8, 30, '2015-01-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (602, 7, false, 38, 0, 40, '2015-05-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (603, 26, false, 44, 44, 11, '2016-04-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (604, 30, false, 48, 41, 19, '2016-07-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (605, 14, false, 45, 30, 13, '2017-03-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (606, 11, true, 35, 25, 42, '2016-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (607, 1, true, 50, 50, 32, '2016-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (608, 18, true, 33, 45, 29, '2015-11-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (609, 8, false, 50, 27, 43, '2015-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (610, 18, false, 48, 17, 14, '2017-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (611, 7, true, 25, 5, 19, '2015-06-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (612, 28, true, 26, 49, 12, '2015-11-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (613, 19, false, 49, 8, 14, '2017-01-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (614, 10, true, 36, 21, 35, '2016-05-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (615, 18, true, 28, 12, 33, '2016-08-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (616, 23, true, 39, 49, 30, '2016-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (617, 8, true, 35, 35, 25, '2015-06-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (618, 15, true, 41, 7, 14, '2016-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (619, 19, false, 39, 16, 48, '2015-01-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (620, 17, true, 27, 47, 5, '2016-02-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (621, 30, false, 25, 2, 8, '2015-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (622, 24, true, 28, 35, 40, '2016-08-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (623, 3, false, 42, 16, 24, '2015-09-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (624, 6, false, 47, 34, 0, '2017-04-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (625, 13, true, 26, 30, 36, '2015-04-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (626, 6, false, 38, 50, 18, '2016-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (627, 7, false, 46, 22, 40, '2015-12-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (628, 3, false, 27, 5, 13, '2015-10-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (629, 26, true, 39, 34, 29, '2015-01-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (630, 11, false, 39, 5, 22, '2017-01-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (631, 18, true, 43, 21, 45, '2016-06-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (632, 14, false, 33, 36, 45, '2015-01-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (633, 26, false, 25, 20, 22, '2015-06-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (634, 22, true, 50, 20, 29, '2015-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (635, 10, true, 48, 44, 38, '2015-04-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (636, 8, false, 30, 38, 16, '2015-05-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (637, 19, true, 40, 5, 25, '2016-12-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (638, 24, false, 30, 45, 42, '2015-07-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (639, 19, false, 31, 17, 42, '2015-07-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (640, 7, true, 44, 22, 14, '2017-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (641, 22, true, 43, 20, 46, '2015-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (642, 2, true, 31, 42, 25, '2016-09-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (643, 15, true, 39, 35, 50, '2016-10-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (644, 22, false, 49, 50, 20, '2015-08-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (645, 19, true, 25, 45, 17, '2016-06-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (646, 16, true, 30, 22, 18, '2015-07-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (647, 18, false, 31, 16, 28, '2016-04-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (648, 20, true, 25, 32, 32, '2015-09-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (649, 5, false, 38, 37, 33, '2016-01-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (650, 25, true, 25, 2, 8, '2015-09-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (651, 29, true, 34, 39, 47, '2015-03-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (652, 6, false, 42, 17, 34, '2016-08-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (653, 3, true, 49, 6, 28, '2015-08-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (654, 3, true, 38, 30, 14, '2015-06-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (655, 12, true, 34, 20, 0, '2015-07-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (656, 7, false, 38, 41, 4, '2016-10-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (657, 8, true, 44, 16, 37, '2016-11-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (658, 18, true, 34, 50, 21, '2016-03-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (659, 18, false, 39, 27, 32, '2017-02-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (660, 15, true, 27, 21, 50, '2016-12-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (661, 22, true, 50, 49, 49, '2016-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (662, 14, true, 36, 29, 30, '2017-02-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (663, 12, false, 44, 45, 49, '2015-03-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (664, 29, true, 47, 17, 15, '2017-02-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (665, 15, false, 50, 17, 29, '2015-11-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (666, 16, false, 44, 15, 32, '2016-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (667, 21, false, 35, 39, 0, '2016-10-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (668, 23, true, 49, 26, 41, '2015-09-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (669, 18, false, 37, 12, 10, '2016-05-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (670, 7, true, 29, 13, 36, '2015-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (671, 12, false, 43, 19, 7, '2016-09-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (672, 9, false, 26, 23, 27, '2015-07-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (673, 21, false, 37, 37, 33, '2016-03-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (674, 21, true, 35, 17, 30, '2015-08-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (675, 1, false, 38, 0, 43, '2015-04-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (676, 3, false, 48, 38, 32, '2015-09-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (677, 8, false, 38, 13, 42, '2016-09-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (678, 14, true, 41, 9, 42, '2015-05-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (679, 23, false, 42, 42, 26, '2016-01-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (680, 8, true, 44, 9, 34, '2016-10-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (681, 12, false, 39, 36, 4, '2016-04-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (682, 10, false, 45, 17, 22, '2016-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (683, 3, false, 48, 28, 9, '2015-03-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (684, 21, true, 34, 13, 40, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (685, 5, false, 49, 37, 45, '2015-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (686, 25, false, 43, 7, 6, '2016-05-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (687, 8, true, 48, 36, 5, '2015-10-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (688, 5, true, 35, 40, 30, '2017-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (689, 14, true, 32, 40, 37, '2016-09-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (690, 30, false, 48, 27, 10, '2016-02-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (691, 15, false, 26, 8, 29, '2017-01-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (692, 25, false, 36, 1, 41, '2015-02-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (693, 25, false, 30, 46, 28, '2015-03-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (694, 15, false, 28, 44, 22, '2015-09-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (695, 29, true, 27, 43, 11, '2017-02-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (696, 6, false, 34, 27, 42, '2016-02-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (697, 16, false, 43, 37, 16, '2015-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (698, 26, true, 49, 42, 39, '2016-10-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (699, 17, false, 28, 28, 12, '2015-04-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (700, 11, false, 45, 43, 16, '2016-06-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (701, 11, true, 34, 30, 43, '2015-08-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (702, 27, true, 47, 15, 29, '2015-10-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (703, 27, true, 28, 43, 41, '2015-07-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (704, 11, false, 46, 16, 13, '2015-03-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (705, 8, false, 49, 29, 19, '2015-12-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (706, 28, true, 43, 20, 14, '2016-01-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (707, 19, true, 49, 24, 30, '2016-09-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (708, 1, false, 38, 16, 17, '2016-02-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (709, 22, false, 25, 16, 23, '2016-10-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (710, 2, true, 46, 4, 46, '2016-08-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (711, 26, false, 26, 23, 11, '2015-09-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (712, 25, false, 45, 29, 22, '2015-07-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (713, 24, true, 28, 31, 22, '2015-12-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (714, 25, false, 36, 44, 49, '2016-10-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (715, 17, false, 40, 20, 33, '2016-03-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (716, 25, true, 41, 47, 42, '2016-09-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (717, 22, true, 36, 42, 33, '2016-01-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (718, 21, true, 45, 39, 48, '2015-11-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (719, 12, false, 34, 42, 47, '2016-10-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (720, 10, false, 48, 1, 20, '2015-01-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (721, 5, false, 38, 33, 31, '2015-07-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (722, 25, false, 30, 49, 3, '2016-03-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (723, 13, false, 50, 3, 0, '2015-08-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (724, 5, false, 31, 7, 48, '2016-07-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (725, 22, false, 30, 0, 40, '2016-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (726, 3, false, 30, 46, 22, '2017-02-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (727, 10, true, 33, 3, 0, '2016-02-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (728, 3, false, 27, 33, 6, '2016-03-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (729, 23, true, 45, 26, 2, '2017-01-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (730, 5, false, 39, 31, 11, '2016-01-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (731, 23, false, 39, 17, 37, '2015-09-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (732, 27, true, 48, 3, 39, '2015-08-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (733, 6, true, 50, 10, 42, '2015-07-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (734, 4, false, 44, 19, 14, '2015-11-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (735, 16, true, 28, 43, 34, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (736, 9, false, 43, 32, 11, '2015-07-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (737, 30, true, 31, 42, 31, '2015-05-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (738, 8, true, 44, 39, 18, '2015-01-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (739, 11, false, 49, 26, 5, '2015-12-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (740, 6, true, 43, 21, 11, '2016-03-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (741, 1, true, 40, 20, 41, '2015-08-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (742, 20, false, 27, 11, 10, '2015-08-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (743, 9, false, 39, 16, 43, '2017-01-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (744, 30, true, 43, 33, 40, '2015-01-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (745, 18, true, 39, 27, 0, '2016-10-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (746, 20, true, 32, 28, 8, '2016-12-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (747, 27, false, 26, 7, 17, '2016-02-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (748, 17, true, 29, 49, 43, '2017-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (749, 4, false, 34, 9, 27, '2017-03-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (750, 30, false, 50, 37, 36, '2016-03-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (751, 26, true, 33, 14, 2, '2016-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (752, 4, true, 50, 39, 18, '2016-11-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (753, 23, false, 42, 31, 41, '2016-01-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (754, 28, false, 50, 7, 16, '2016-07-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (755, 4, false, 46, 8, 7, '2015-04-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (756, 10, false, 50, 39, 50, '2016-09-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (757, 25, false, 37, 22, 46, '2016-10-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (758, 13, false, 29, 45, 11, '2015-08-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (759, 26, false, 26, 12, 4, '2017-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (760, 16, true, 40, 37, 2, '2015-08-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (761, 14, true, 44, 25, 50, '2015-02-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (762, 21, false, 29, 46, 26, '2015-10-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (763, 1, false, 30, 41, 0, '2015-02-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (764, 25, false, 36, 50, 15, '2016-04-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (765, 8, true, 45, 22, 42, '2016-09-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (766, 3, false, 39, 25, 17, '2016-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (767, 12, false, 28, 18, 46, '2016-12-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (768, 13, false, 40, 30, 11, '2015-01-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (769, 12, false, 32, 41, 44, '2016-04-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (770, 3, true, 49, 49, 0, '2017-01-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (771, 17, true, 31, 2, 22, '2015-03-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (772, 25, false, 25, 50, 25, '2016-07-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (773, 25, true, 48, 32, 49, '2015-12-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (774, 4, false, 50, 13, 47, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (775, 1, true, 39, 5, 27, '2015-09-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (776, 12, false, 33, 25, 8, '2016-04-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (777, 3, false, 31, 24, 21, '2016-05-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (778, 15, false, 45, 32, 48, '2015-05-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (779, 28, true, 37, 18, 49, '2015-07-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (780, 5, true, 32, 19, 15, '2015-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (781, 27, true, 25, 36, 2, '2017-03-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (782, 25, false, 44, 44, 43, '2015-12-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (783, 27, true, 26, 0, 17, '2015-08-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (784, 26, false, 45, 16, 49, '2016-09-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (785, 9, false, 33, 20, 15, '2017-01-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (786, 8, false, 35, 32, 49, '2017-04-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (787, 25, false, 35, 15, 26, '2015-03-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (788, 13, false, 29, 46, 34, '2015-05-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (789, 11, false, 31, 28, 0, '2015-01-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (790, 11, false, 35, 26, 46, '2017-03-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (791, 20, true, 48, 39, 13, '2017-04-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (792, 20, false, 32, 33, 22, '2016-12-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (793, 17, false, 28, 29, 38, '2016-02-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (794, 28, true, 39, 39, 50, '2016-06-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (795, 18, false, 30, 33, 31, '2016-05-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (796, 3, false, 44, 34, 39, '2015-05-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (797, 6, false, 50, 15, 42, '2015-09-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (798, 7, false, 43, 38, 14, '2015-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (799, 29, false, 41, 17, 14, '2016-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (800, 2, true, 29, 39, 34, '2015-07-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (801, 20, true, 43, 32, 42, '2016-05-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (802, 25, false, 47, 19, 42, '2016-01-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (803, 5, false, 37, 13, 50, '2015-11-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (804, 16, false, 30, 17, 14, '2015-09-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (805, 18, true, 34, 23, 35, '2017-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (806, 28, true, 40, 0, 6, '2015-09-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (807, 21, true, 41, 1, 43, '2017-03-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (808, 18, true, 26, 50, 32, '2015-07-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (809, 27, true, 35, 2, 15, '2016-09-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (810, 23, false, 28, 9, 3, '2016-06-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (811, 29, false, 50, 1, 25, '2015-09-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (812, 5, true, 33, 26, 40, '2016-01-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (813, 17, true, 35, 37, 26, '2016-08-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (814, 6, false, 40, 37, 0, '2015-09-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (815, 17, false, 40, 50, 48, '2016-07-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (816, 29, false, 46, 1, 50, '2015-11-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (817, 24, true, 44, 33, 27, '2015-11-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (818, 18, true, 31, 47, 1, '2016-11-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (819, 11, true, 39, 14, 44, '2017-03-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (820, 22, false, 32, 26, 17, '2015-10-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (821, 18, false, 49, 13, 33, '2015-11-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (822, 19, true, 32, 42, 13, '2016-04-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (823, 9, false, 41, 26, 34, '2016-11-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (824, 22, false, 39, 0, 27, '2015-12-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (825, 5, true, 36, 15, 22, '2016-02-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (826, 17, true, 37, 28, 35, '2016-07-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (827, 17, true, 30, 2, 50, '2016-11-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (828, 25, false, 31, 13, 22, '2017-03-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (829, 10, true, 27, 18, 24, '2015-03-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (830, 20, false, 41, 19, 14, '2015-06-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (831, 22, true, 46, 14, 26, '2016-11-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (832, 3, false, 31, 31, 41, '2016-04-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (833, 11, false, 48, 50, 46, '2016-06-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (834, 7, true, 32, 39, 6, '2017-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (835, 27, false, 38, 19, 28, '2016-02-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (836, 8, true, 42, 28, 40, '2015-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (837, 6, false, 50, 21, 33, '2015-07-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (838, 10, true, 43, 38, 32, '2016-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (839, 16, true, 50, 40, 36, '2015-01-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (840, 14, true, 35, 7, 43, '2015-06-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (841, 10, true, 39, 6, 6, '2017-03-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (842, 5, true, 40, 21, 45, '2015-12-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (843, 29, true, 42, 10, 49, '2016-04-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (844, 6, true, 26, 31, 21, '2015-10-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (845, 8, true, 46, 42, 36, '2015-07-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (846, 5, false, 50, 29, 27, '2017-01-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (847, 25, true, 48, 38, 41, '2015-01-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (848, 24, false, 37, 31, 18, '2017-02-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (849, 5, true, 33, 23, 3, '2015-07-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (850, 1, false, 27, 35, 12, '2016-05-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (851, 7, true, 48, 40, 18, '2015-11-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (852, 2, true, 40, 31, 18, '2017-03-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (853, 25, true, 47, 11, 48, '2015-03-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (854, 29, false, 33, 2, 26, '2016-04-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (855, 10, true, 38, 36, 48, '2016-08-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (856, 14, false, 26, 46, 40, '2016-05-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (857, 2, false, 27, 31, 19, '2015-07-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (858, 18, false, 26, 33, 27, '2015-10-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (859, 21, true, 40, 34, 0, '2015-03-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (860, 9, false, 42, 25, 32, '2016-04-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (861, 4, true, 38, 2, 22, '2016-10-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (862, 17, false, 49, 38, 38, '2016-12-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (863, 10, true, 30, 27, 19, '2016-06-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (864, 2, false, 48, 25, 13, '2016-01-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (865, 8, true, 34, 22, 14, '2017-01-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (866, 5, true, 33, 22, 7, '2015-09-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (867, 29, false, 48, 21, 19, '2015-08-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (868, 13, false, 33, 44, 20, '2017-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (869, 28, true, 40, 5, 30, '2016-09-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (870, 29, true, 42, 34, 44, '2015-06-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (871, 19, false, 26, 47, 16, '2016-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (872, 1, false, 37, 28, 5, '2015-11-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (873, 13, true, 25, 29, 32, '2015-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (874, 2, true, 40, 0, 11, '2017-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (875, 25, false, 34, 21, 36, '2016-05-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (876, 22, true, 50, 41, 18, '2015-05-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (877, 26, false, 28, 15, 10, '2016-02-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (878, 25, true, 48, 1, 42, '2016-02-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (879, 30, true, 50, 2, 36, '2016-03-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (880, 12, true, 47, 40, 39, '2017-01-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (881, 8, false, 32, 37, 30, '2016-08-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (882, 24, true, 25, 32, 38, '2016-05-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (883, 25, true, 36, 21, 17, '2015-04-27');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (884, 6, false, 32, 16, 18, '2016-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (885, 27, true, 47, 4, 3, '2015-11-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (886, 18, false, 33, 14, 6, '2016-10-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (887, 21, false, 44, 47, 23, '2015-06-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (888, 13, false, 39, 4, 14, '2017-02-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (889, 7, true, 31, 28, 35, '2015-04-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (890, 9, false, 25, 15, 14, '2015-07-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (891, 12, true, 38, 17, 36, '2017-03-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (892, 8, false, 38, 15, 29, '2017-03-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (893, 22, false, 48, 45, 27, '2016-09-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (894, 24, false, 28, 42, 33, '2016-01-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (895, 6, true, 45, 19, 39, '2015-08-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (896, 9, false, 34, 40, 35, '2016-01-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (897, 15, false, 46, 3, 50, '2015-11-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (898, 30, true, 35, 33, 46, '2015-03-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (899, 15, false, 50, 49, 36, '2015-01-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (900, 12, true, 48, 31, 21, '2016-04-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (901, 28, false, 38, 14, 16, '2015-02-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (902, 27, false, 27, 31, 37, '2017-03-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (903, 4, true, 25, 2, 25, '2015-06-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (904, 29, true, 44, 33, 48, '2016-05-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (905, 23, true, 49, 11, 36, '2016-06-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (906, 28, false, 45, 26, 6, '2017-04-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (907, 17, false, 35, 39, 32, '2016-07-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (908, 21, false, 50, 30, 27, '2016-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (909, 28, true, 25, 41, 33, '2016-12-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (910, 4, false, 25, 18, 6, '2016-05-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (911, 18, false, 41, 35, 1, '2015-09-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (912, 3, false, 39, 15, 10, '2015-11-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (913, 3, true, 36, 3, 23, '2016-06-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (914, 28, false, 31, 20, 22, '2017-04-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (915, 11, true, 34, 11, 19, '2016-08-22');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (916, 11, false, 37, 25, 39, '2015-05-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (917, 11, false, 35, 21, 5, '2016-06-24');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (918, 21, true, 50, 25, 30, '2015-03-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (919, 11, true, 43, 1, 35, '2015-03-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (920, 7, false, 49, 18, 37, '2016-07-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (921, 28, false, 35, 19, 45, '2015-05-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (922, 29, true, 29, 13, 7, '2016-10-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (923, 18, false, 42, 21, 28, '2016-06-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (924, 11, false, 47, 14, 20, '2016-04-06');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (925, 25, false, 40, 42, 32, '2016-06-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (926, 10, false, 25, 3, 50, '2016-08-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (927, 24, false, 49, 47, 4, '2015-10-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (928, 30, false, 38, 36, 24, '2016-09-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (929, 12, true, 43, 31, 28, '2015-01-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (930, 18, true, 37, 26, 8, '2015-12-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (931, 11, false, 43, 4, 25, '2015-07-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (932, 1, false, 30, 25, 45, '2017-01-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (933, 24, false, 31, 20, 45, '2015-07-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (934, 1, false, 34, 20, 22, '2015-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (935, 1, true, 47, 28, 15, '2016-08-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (936, 11, false, 45, 25, 8, '2016-02-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (937, 29, false, 50, 30, 37, '2016-07-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (938, 16, true, 45, 32, 18, '2016-04-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (939, 4, true, 50, 7, 45, '2017-04-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (940, 3, true, 48, 2, 41, '2015-06-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (941, 24, true, 38, 40, 12, '2016-12-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (942, 26, true, 28, 41, 15, '2016-06-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (943, 26, false, 44, 4, 50, '2016-03-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (944, 19, false, 43, 8, 9, '2016-11-26');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (945, 28, true, 34, 6, 41, '2015-01-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (946, 27, true, 47, 3, 22, '2015-01-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (947, 24, false, 29, 44, 35, '2016-01-10');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (948, 21, true, 31, 21, 47, '2016-03-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (949, 12, true, 44, 16, 21, '2015-12-23');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (950, 18, true, 34, 4, 1, '2016-12-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (951, 7, true, 35, 3, 14, '2015-10-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (952, 1, false, 31, 7, 0, '2017-01-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (953, 1, false, 50, 42, 16, '2015-10-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (954, 29, true, 27, 36, 35, '2016-06-01');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (955, 19, false, 29, 20, 22, '2016-12-31');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (956, 20, true, 47, 2, 48, '2016-05-18');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (957, 10, true, 25, 2, 28, '2017-03-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (958, 24, false, 48, 25, 7, '2017-01-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (959, 26, true, 35, 48, 5, '2015-07-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (960, 23, true, 50, 18, 0, '2016-07-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (961, 23, false, 48, 13, 19, '2016-07-21');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (962, 3, true, 27, 21, 3, '2015-08-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (963, 4, true, 36, 34, 29, '2015-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (964, 1, false, 50, 47, 50, '2015-09-09');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (965, 26, false, 27, 40, 7, '2015-09-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (966, 28, false, 42, 5, 49, '2015-01-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (967, 5, true, 49, 32, 23, '2015-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (968, 5, true, 50, 3, 6, '2015-05-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (969, 2, true, 37, 39, 4, '2016-07-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (970, 17, false, 47, 50, 38, '2015-01-07');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (971, 30, true, 45, 20, 41, '2015-09-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (972, 28, true, 41, 21, 14, '2016-12-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (973, 8, true, 38, 46, 21, '2016-04-16');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (974, 12, true, 48, 13, 24, '2016-04-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (975, 12, false, 30, 28, 39, '2016-11-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (976, 14, false, 40, 4, 9, '2015-04-19');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (977, 1, true, 50, 20, 31, '2016-08-17');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (978, 3, true, 43, 3, 39, '2015-02-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (979, 26, true, 29, 27, 35, '2017-02-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (980, 16, false, 44, 12, 2, '2016-06-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (981, 9, false, 26, 40, 38, '2015-03-30');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (982, 6, false, 33, 22, 25, '2015-02-05');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (983, 8, true, 45, 5, 9, '2016-05-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (984, 18, true, 32, 7, 17, '2016-06-11');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (985, 4, true, 49, 3, 18, '2016-01-25');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (986, 5, false, 26, 41, 8, '2016-06-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (987, 23, false, 36, 17, 32, '2015-02-13');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (988, 11, true, 32, 27, 0, '2015-04-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (989, 1, false, 27, 5, 26, '2015-07-14');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (990, 12, false, 25, 30, 33, '2016-09-03');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (991, 6, false, 26, 3, 46, '2015-11-29');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (992, 6, true, 37, 9, 30, '2017-04-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (993, 10, false, 38, 23, 0, '2015-10-20');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (994, 6, false, 47, 3, 38, '2016-04-15');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (995, 7, true, 33, 16, 7, '2016-11-02');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (996, 17, true, 36, 37, 44, '2016-04-04');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (997, 22, false, 26, 33, 38, '2017-02-12');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (998, 29, true, 39, 45, 38, '2015-01-28');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (999, 9, false, 43, 50, 34, '2015-11-08');
insert into Station_Status (S_Status_ID, Station_ID, S_Status, Capacity, Parking, Bikes, Updated) values (1000, 25, false, 39, 44, 3, '2016-07-27');


