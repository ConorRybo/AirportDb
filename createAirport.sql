--
-- Conor Rybacki + Lleyton Seymour
-- Database: Airport
-- File name: Airport.sql
--

BEGIN;

DROP TABLE IF EXISTS ARRIVING;
DROP TABLE IF EXISTS FLIGHTS;
DROP TABLE IF EXISTS LUGGAGE;
DROP TABLE IF EXISTS TERMINAL;
DROP TABLE IF EXISTS AIRCRAFT;
DROP TABLE IF EXISTS MANUFACTURER;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS AIRLINE;
DROP TABLE IF EXISTS PILOT;
DROP TABLE IF EXISTS GROUNDCREW;
DROP TABLE IF EXISTS AIRTRAFFIC;
DROP TABLE IF EXISTS FAALICENSE;

-- 
-- TERMINAL table: hold terminal information
-- 
CREATE TABLE TERMINAL(
Term_Letter     CHAR(1) NOT NULL,
Gate_Num        INTEGER NOT NULL,

PRIMARY KEY (Term_Letter, Gate_Num)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- MANUFACTURER table to hold airplan manufacturer information
-- 
CREATE TABLE MANUFACTURER(
Man_ID      INTEGER NOT NULL,
Man_Name    VARCHAR(50) NOT NULL,
Man_Country VARCHAR(50) NOT NULL,
Man_Phone   VARCHAR(50) NOT NULL,
Man_ContactName VARCHAR(50) DEFAULT NULL,

PRIMARY KEY (Man_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- AIRCRAFT table to hold info about aircraft
-- 
CREATE TABLE AIRCRAFT(
Aircraft_ID     INTEGER NOT NULL,
Aircraft_Model  VARCHAR(50) NOT NULL,
Aircraft_Variant VARCHAR(50) DEFAULT NULL,
Aircraft_Capacity VARCHAR(5) NOT NULL,
Aircraft_Registration VARCHAR(25) NOT NULL,
Man_ID      INTEGER NOT NULL,

PRIMARY KEY (Aircraft_ID),
FOREIGN KEY (Man_ID) REFERENCES MANUFACTURER(Man_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- EMPLOYEE table holding emoloyee information
-- 
CREATE TABLE EMPLOYEE(
Emp_ID      INTEGER NOT NULL AUTO_INCREMENT,
Emp_FName   VARCHAR(50) NOT NULL,
Emp_LName   VARCHAR(50) NOT NULL,
Emp_Initial CHAR(1) DEFAULT NULL,
Emp_Phone   VARCHAR(50) NOT NULL,
Emp_Type    CHAR(1) DEFAULT NULL,
Sup_ID      INTEGER DEFAULT NULL,

PRIMARY KEY (Emp_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- AIRLINE table to hold information about airline
-- 
CREATE TABLE AIRLINE(
Airline_ID      INTEGER NOT NULL AUTO_INCREMENT,
Airline_Name    VARCHAR(50) NOT NULL,
Airline_Country VARCHAR(50) NOT NULL,
Airline_Phone   VARCHAR(50) NOT NULL,

PRIMARY KEY (Airline_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- PILOT table to hold pilot information
-- 
CREATE TABLE PILOT(
Pilot_ID        INTEGER NOT NULL AUTO_INCREMENT,
Pilot_FName     VARCHAR(50) NOT NULL,
Pilot_LName     VARCHAR(50) NOT NULL,
Pilot_Initial   CHAR(1) DEFAULT NULL,
Airline_ID      INTEGER DEFAULT NULL,
FAA_Num         INTEGER NOT NULL,

PRIMARY KEY (Pilot_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- GROUNDCREW subtype of EMPLOYEE
-- 
CREATE TABLE GROUNDCREW(
Emp_ID      INTEGER NOT NULL,
Grnd_Team   INTEGER DEFAULT NULL,
Term_Letter CHAR(1) NOT NULL,
FAA_Num     INTEGER NOT NULL,
FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE(Emp_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- AIRTRAFFIC subtype of EMPLOYEE
-- 
CREATE TABLE AIRTRAFFIC(
Emp_ID      INTEGER NOT NULL,
Ctrl_Team   INTEGER DEFAULT NULL,
Tower_Num   INTEGER NOT NULL,
FAA_Num     INTEGER NOT NULL,
FOREIGN KEY (Emp_ID) REFERENCES EMPLOYEE(Emp_ID)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- FAALICENSE table to hold information about faa license
-- 
CREATE TABLE FAALICENSE(
FAA_Num     INTEGER NOT NULL AUTO_INCREMENT,
FAA_Class   VARCHAR(30) NOT NULL,
FAA_CertDate DATE NOT NULL,

PRIMARY KEY (FAA_Num)) ENGINE=InnoDB DEFAULT CHARSET=latin1; 

--
-- Creating Table For arriving flights
-- 
CREATE TABLE FLIGHT(
Flight_Num      INTEGER NOT NULL,
Term_Letter     VARCHAR(1) NOT NULL,
Gate_Num        INTEGER NOT NULL,
Flight_Time    TIME NOT NULL,
Airline_ID      INTEGER NOT NULL,
Aircraft_ID     INTEGER NOT NULL,
Pilot_ID        INTEGER NOT NULL,

PRIMARY KEY (Flight_Num),
FOREIGN KEY (Airline_ID) REFERENCES AIRLINE(Airline_ID),
FOREIGN KEY (Aircraft_ID) REFERENCES AIRCRAFT(Aircraft_ID),
FOREIGN KEY (Pilot_ID) REFERENCES PILOT(Pilot_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- PASSENGERS table: holds passenger information
-- 
CREATE TABLE PASSENGER(
Pass_ID         INTEGER NOT NULL AUTO_INCREMENT,
Pass_FName      VARCHAR(50) NOT NULL,
Pass_LName      VARCHAR(50) NOT NULL,
Pass_Initial    CHAR(1) DEFAULT NULL,
Pass_Phone      VARCHAR(50) NOT NULL,
Flight_Num      INTEGER NOT NULL,

PRIMARY KEY (Pass_ID),
FOREIGN KEY (Flight_Num) REFERENCES FLIGHT(Flight_Num)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- LUGGAGE table: hold luggage information
--
CREATE TABLE LUGGAGE(
Pass_ID         INTEGER NOT NULL AUTO_INCREMENT,
Bag_Weight      VARCHAR(5) NOT NULL,
Bag_Color       VARCHAR(10) DEFAULT NULL,
FOREIGN KEY (Pass_ID) REFERENCES PASSENGER(Pass_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Loading data rows

--
-- Inserting data for Terminal
--
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('A', 1);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('A', 2);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('A', 3);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('A', 4);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('A', 5);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('B', 1);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('B', 2);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('B', 3);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('B', 4);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('B', 5);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('C', 1);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('C', 2);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('C', 3);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('C', 4);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('C', 5);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('D', 1);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('D', 2);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('D', 3);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('D', 4);
INSERT INTO TERMINAL (Term_Letter, Gate_Num) VALUES('D', 5);



--
-- Inserting data for FAA License
--
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(1, 'C', '2021-03-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(2, 'C', '2020-03-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(3, 'C', '2020-04-07');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(4, 'C', '2020-03-22');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(5, 'C', '2019-08-15');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(6, 'C', '2021-04-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(7, 'C', '2019-04-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(8, 'C', '2021-04-10');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(9, 'C', '2021-04-01');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(10, 'C','2020-04-26');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(11, 'C','2019-09-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(12, 'C','2020-04-26');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(13, 'C','2022-08-07');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(14, 'C','2021-04-13');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(15, 'C','2020-04-08');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(16, 'C','2020-08-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(17, 'C','2021-04-01');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(18, 'C','2020-08-24');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(19, 'C','2020-04-13');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(20, 'C','2021-08-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(21, 'C','2019-04-19');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(22, 'C','2021-04-04');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(23, 'C','2021-04-05');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(24, 'C','2020-07-12');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(25, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(26, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(27, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(28, 'C','2020-05-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(29, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(30, 'C','2020-05-12');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(31, 'C','2020-04-22');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(32, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(33, 'C','2020-05-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(34, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(35, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(36, 'C','2020-07-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(37, 'C','2020-04-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(38, 'C','2020-05-17');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(39, 'C','2020-04-17');


--
-- Inserting data for Manufacturer
--
INSERT INTO MANUFACTURER (Man_ID, Man_Name, Man_Country, Man_Phone, Man_ContactName) VALUES(1, 'Dassault', 'France', '584-272-6030','Angie');
INSERT INTO MANUFACTURER (Man_ID, Man_Name, Man_Country, Man_Phone, Man_ContactName) VALUES(2, 'BAE Systems','United Kingdom', '607-337-5854', 'Florella');
INSERT INTO MANUFACTURER (Man_ID, Man_Name, Man_Country, Man_Phone, Man_ContactName) VALUES(3, 'Boeing', 'United States', '332-354-2772', 'Mozes');
INSERT INTO MANUFACTURER (Man_ID, Man_Name, Man_Country, Man_Phone, Man_ContactName) VALUES(4, 'Airbus', 'United States', '502-711-0994', 'Genevieve');
INSERT INTO MANUFACTURER (Man_ID, Man_Name, Man_Country, Man_Phone, Man_ContactName) VALUES(5, 'Honda', 'United States', '209-206-4822', 'Max');   




-- 
-- Inserting data for Airline
--
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(1, 'American', 'United States', '404-383-1274');   
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(2, 'Delta', 'United States', '917-122-1345');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(3, 'Qantas', 'Australia', '775-707-3503');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(4, 'Southwest', 'United States', '719-943-9050');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(5, 'Frontier', 'United States', '212-421-5103');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(6, 'Alaska', 'United States', '912-602-2697');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(7, 'JetBlue', 'United States', '239-295-9179');
INSERT INTO AIRLINE (Airline_ID, Airline_Name, Airline_Country, Airline_Phone) VALUES(8, 'Allegian', 'United States', '304-927-6521');

--
-- Inserting data for Employee
--
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(1, 'Husain', 'Coppledike', 'A', '914-891-0767', NULL, NULL);     
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(2, 'Cleon', 'Rothman', 'L', '235-401-5092', NULL, NULL);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(3, 'Janela', 'Auty', 'A', '931-916-8187', NULL, NULL);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(4, 'Sophi', 'Spavins', 'G', '418-844-3022', NULL, NULL);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(5, 'Agathe', 'Melhuish', 'C', '144-899-1736', NULL, NULL);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(6, 'Ann-marie', 'Detheridge', 'E', '310-624-4624', NULL, 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(7, 'Georgianne', 'Carrigan', 'K', '390-780-9540', 'T', 4);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(8, 'Antony', 'Hagart', 'A', '951-999-9982', 'T', 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(9, 'Stearn', 'Borit', 'B', '319-556-9357', 'T', 1);      
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(10, 'Chaunce', 'Crone', 'A', '530-625-7543', NULL, 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(11, 'Virginia', 'Leishman', 'V', '596-329-3246', NULL, 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(12, 'Bonny', 'Ratley', 'L', '936-642-7334', NULL, 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(13, 'Janel', 'Disbrey', 'I', '278-465-5968', 'T', 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(14, 'Lloyd', 'Ambrozewicz', 'O', '685-248-8487', 'T', 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(15, 'Ajay', 'Brittan', 'P', '516-271-3396', 'T', 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(16, 'Hamlen', 'Sigfrid', 'R', '986-280-5858', 'G', 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(17, 'Jennee', 'Ritmeyer', 'R', '325-785-3770', 'G', 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(18, 'Teodoor', 'Pill', 'W', '197-666-6234', 'G', 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(19, 'Joli', 'Minihane', 'Q', '651-768-2798', 'G', 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(20, 'Andrej', 'Kaplin', 'A', '397-262-8038', NULL, 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(21, 'Had', 'Geram', 'D', '981-792-7393', 'G', 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(22, 'Lock', 'Castellan', 'C', '694-210-0374', 'G', 1);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(23, 'Andrei', 'Kellitt', 'S', '912-876-7955', 'G', 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(24, 'Ruperto', 'Allport', 'S', '690-431-9201', 'G', 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(25, 'Cly', 'Kinchin', 'S', '166-955-7975', NULL, 2);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(26, 'Chaim', 'Hempel', 'R', '986-203-3493', NULL, 5);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(27, 'Shawna', 'Fidal', 'T', '164-659-0989', NULL, 1);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(28, 'Carrie', 'Ashburner', 'K', '546-145-7046', NULL, 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(29, 'Micky', 'McCarney', 'P', '599-775-0853', NULL, 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(30, 'Johna', 'Duckworth', 'I', '926-908-4558', NULL, 4);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(31, 'Cheryl', 'Ruby', 'A', '837-164-3757', NULL, 3);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(32, 'Aimee', 'Tallach', 'C', '528-190-9919', NULL, 4);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(33, 'Agnes', 'Santhouse', 'C', '420-863-5339', NULL, 1);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(34, 'Shalne', 'Portwaine', 'N', '995-582-4396', NULL, 4);
INSERT INTO EMPLOYEE (Emp_ID, Emp_FName, Emp_LName, Emp_Initial, Emp_Phone, Emp_Type, Sup_ID) VALUES(35, 'Cammy', 'Tempest', 'T', '447-862-1820', NULL, 5);

--
-- Inserting data for Airtraffic 
-- 
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(7, 1, 1, 26);
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(8, 1, 1, 27);
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(9, 1, 1, 28);
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(13, 2, 2, 29);
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(14, 2, 2, 30);
INSERT INTO AIRTRAFFIC(Emp_ID, Ctrl_Team, Tower_Num, FAA_Num) VALUES(15, 2, 2, 31);

-- 
-- Inserting data for Groundcrew
-- 
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(16, 1, 'A', 32); 
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(17, 1, 'A', 33);
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(18, 2, 'A', 34);
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(19, 2, 'B', 35);
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(21, 3, 'B', 36);
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(22, 3, 'C', 37);
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(23, 4, 'C', 38); 
INSERT INTO GROUNDCREW(Emp_ID, Grnd_Team, Term_Letter, FAA_Num) VALUES(24, 5, 'D', 39); 

--
-- Inserting data for Aircraft
--
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(1, '737','MAX', 190, '067ffa9f94b', 3);   
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(2, '747','-8', 450, '6564f5f6f49', 3);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(3, '777','X', 426, 'ba56eb90d13', 3);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(4, 'A22O',NULL, 160, '402c642648e4', 4);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(5, 'A320',NULL, 170, '54256304e5a8', 4);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(6, 'A380',NULL, 853, '2633d5b6fa74', 4);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(7, 'Hondajet','Elite', 10, '9d44d1d1bb9', 5);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(8, 'BAe','146', 70, 'af553fd562d', 2);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(9, 'BAe','146', 181, 'edfb5dedb07', 2);
INSERT INTO AIRCRAFT (Aircraft_ID, Aircraft_Model, Aircraft_Variant, Aircraft_Capacity, Aircraft_Registration, Man_ID) VALUES(10, 'Falcon2000','LXs', 12, '8e741cd23f', 1);

--
-- Inserting data for Pilot
--
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(1, 'Berne', 'Fancet', 'M', 1, 4);        
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(2, 'Tully', 'Tumioto', 'A', 5, 21);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(3, 'Earlie', 'Jaffrey', 'K', 8, 22);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(4, 'Adelice', 'Langfat', 'L', 5, 7);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(5, 'Meris', 'Peckett', 'L', 3, 4);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(6, 'Zora', 'Georgeou', 'A', 5, 6);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(7, 'Adi', 'Doldon', 'W', 2, 16);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(8, 'Farlie', 'Swatten', 'C', 3, 10);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(9, 'Amitie', 'Scotter', 'J', 6, 20);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(10, 'Olav', 'Badman', 'I', 5, 19);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(11, 'Sam', 'Burger', 'M', 1, 1);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(12, 'Beauregard', 'Peppard', 'M', 2, 18);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(13, 'Lucilia', 'Hawse', 'R', 6, 24);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(14, 'Olivier', 'Hulson', 'E', 1, 25);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(15, 'Caitrin', 'Chasemoore', 'G', 6, 12);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(16, 'Bruno', 'Saltwell', 'T', 3, 2);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(17, 'Brodie', 'Reyner', 'O', 1, 8);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(18, 'Cletus', 'Sinott', 'G', 7, 17);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(19, 'Dominga', 'Haire', 'F', 4, 11);
INSERT INTO PILOT (Pilot_ID, Pilot_FName, Pilot_LName, Pilot_Initial, Airline_ID, FAA_Num) VALUES(20, 'Vincenz', 'Marlor', 'T', 6, 13);    


--
-- Inserting data for arriving flights
--
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1001, 'A', 5, '1:21', 1, 3, 8);    
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1002, 'B', 5, '18:42', 1, 8, 5);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1003, 'A', 2, '23:28', 5, 2, 4);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1004, 'C', 4, '20:06', 3, 10, 9);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1005, 'C', 5, '19:26', 1, 6, 9);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(1006, 'C', 2, '3:25', 8, 1, 1);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2001, 'A', 1, '14:35', 5, 4, 4);  
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2002, 'B', 3, '16:36', 3, 3, 8);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2003, 'A', 3, '1:26', 2, 2, 6);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2004, 'C', 3, '16:16', 8, 9, 3);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2005, 'C', 4, '17:07', 7, 5, 2);
INSERT INTO FLIGHT (Flight_Num, Term_Letter, Gate_Num, Flight_Time, Airline_ID, Aircraft_ID, Pilot_ID) VALUES(2006, 'C', 1, '1:02', 2, 6, 6);

--
-- Inserting data for passengers
--
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(1, 'Hannah', 'Ghelardoni', 'L', '696-601-3566', '1001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(2, 'Michaeline', 'Esler', 'S', '445-173-7441', '1001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(3, 'Amelia', 'Dumphry', 'A', '231-264-4120', '1001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(4, 'Karim', 'Ghelardoni', 'Q', '696-601-3568', '1001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(5, 'Alis', 'Gladhill', 'V', '722-284-9497', '1002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(6, 'Robbie', 'Boagey', 'D', '779-869-5753', '1002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(7, 'Lucius', 'Gong', 'B', '844-581-2762', '1002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(8, 'Margot', 'Cane', 'H', '888-126-2498', '1002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(9, 'Goran', 'Ovize', 'M', '981-168-9949', '1003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(10, 'Gibby', 'Thing', 'R', '449-552-0248', '1003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(11, 'Fae', 'Shore', 'E', '771-684-0587', '1003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(12, 'Felicio', 'Walcot', 'E', '593-852-8654', '1003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(13, 'Mella', 'Keats', 'H', '358-986-0433', '1004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(14, 'Gertrude', 'Frisdick', 'J', '438-284-9114', '1004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(15, 'Yance', 'O''Mara', 'M', '310-791-6842', '1004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(16, 'Mallorie', 'Breslin', 'L', '505-615-9544', '1004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(17, 'Elisha', 'Kelner', 'P', '837-499-9436', '1005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(18, 'Mari', 'Hurlston', 'U', '959-139-9678', '1005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(19, 'Benedicto', 'Tunnow', 'E', '416-324-2905', '1005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(20, 'Dilly', 'Gullan', 'Q', '661-567-8087', '1005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(21, 'Georgianna', 'Swindells', 'V', '169-280-7926', '1006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(22, 'Mikael', 'Trodden', 'B', '372-946-4287', '1006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(23, 'Gates', 'Walklate', 'V', '124-661-1892', '1006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(24, 'Debbie', 'Zorzini', 'J', '586-944-7147', '1006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(25, 'Kelci', 'Ewin', 'J', '580-856-8335', '2001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(26, 'Fannie', 'Mouget', 'F', '235-216-3811', '2001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(27, 'Gerhardt', 'Furlonge', 'S', '254-228-4916', '2001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(28, 'Avram', 'Russi', 'S', '650-521-2894', '2001');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(29, 'Red', 'Janacek', 'A', '920-300-2171', '2002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(30, 'Dewain', 'Catlin', 'A', '722-450-0242', '2002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(31, 'Jephthah', 'Tweddle', 'C', '314-611-4128', '2002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(32, 'Aluin', 'Dumbrall', 'C', '808-486-5471', '2002');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(33, 'Fabian', 'Mathison', 'M', '260-222-4705', '2003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(34, 'Billy', 'Schottli', 'D', '881-983-3608', '2003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(35, 'Thorndike', 'Tubbs', 'A', '283-853-9735', '2003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(36, 'Donnamarie', 'Nicholson', 'F', '306-710-1300', '2003');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(37, 'Cordie', 'Orpen', 'J', '773-160-0255', '2004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(38, 'Ernst', 'Mangion', 'G', '501-674-0612', '2004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(39, 'Kania', 'Ellerey', 'G', '918-134-7192', '2004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(40, 'Camel', 'Thewys', 'E', '158-807-1120', '2004');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(41, 'Cindie', 'Gatecliffe', 'T', '597-246-1210', '2005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(42, 'Hedy', 'Brandt', 'F', '643-529-5111', '2005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(43, 'Beulah', 'Kroch', 'H', '131-534-1591', '2005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(44, 'Noam', 'Toner', 'Y', '360-576-0422', '2005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(45, 'Lizabeth', 'Newarte', 'H', '144-321-1605', '2005');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(46, 'Micky', 'Middas', 'T', '231-705-6896', '2006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(47, 'Ollie', 'Bantham', 'J', '644-767-1512', '2006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(48, 'Joey', 'Kornalik', 'E', '148-662-0744', '2006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(49, 'Lari', 'Runnalls', 'W', '993-253-1329', '2006');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(50, 'Laurent', 'Shaw', 'R', '479-648-3735', '2006');


--
-- Inserting data for luggage
--
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(44, 31.61, 'Fuscia');        
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(13, 19.44, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(34, 40.13, 'Goldenrod');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(27, 7.89, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(5, 41.27, 'Yellow');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(8, 42.77, 'Violet');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(23, 32.88, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(21, 38.51, 'Crimson');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(40, 16.09, 'Green');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(31, 32.45, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(4, 35.17, 'Puce');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(28, 32.3, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(34, 38.9, 'Puce');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(38, 40.09, 'Green');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(32, 22.16, 'Turquoise');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(13, 32.82, 'Maroon');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(30, 21.61, 'Yellow');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(43, 16.15, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(47, 39.33, 'Indigo');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(27, 40.97, 'Blue');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(41, 40.6, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(26, 37.19, 'Violet');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(19, 36.47, 'Purple');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(38, 44.53, 'Crimson');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(41, 6.62, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(39, 24.98, 'Khaki');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(24, 28.78, 'Violet');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(45, 31.78, 'Blue');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(2, 44.18, 'Blue');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(41, 30.57, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(26, 19.4, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(10, 8.85, 'Mauv');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(42, 40.2, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(48, 39.35, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(26, 28.99, 'Khaki');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(23, 19.79, 'Mauv');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(16, 40.38, 'Khaki');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(22, 11.59, 'Khaki');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(38, 39.04, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(30, 23.22, 'Mauv');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(8, 44.48, 'Mauv');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(3, 27.4, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(36, 13.41, 'Violet');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(21, 22.68, 'Red');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(1, 1.32, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(46, 4.26, 'Violet');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(40, 39.34, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(4, 7.34, 'Indigo');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(23, 18.38, 'Aquamarine');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(36, 17.92, 'Red');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(1, 29.66, 'Goldenrod');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(3, 31.9, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(1, 5.81, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(3, 8.98, 'Blue');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(7, 13.82, 'Khaki');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(27, 30.48, 'Crimson');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(2, 37.21, 'Teal');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(16, 43.07, 'Yellow');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(50, 19.1, 'Puce');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(18, 43.94, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(24, 1.52, 'Puce');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(24, 2.97, 'Goldenrod');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(16, 25.54, 'Puce');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(3, 26.78, 'Fuscia');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(43, 21.01, 'Orange');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(14, 6.63, 'Purple');
INSERT INTO LUGGAGE (Pass_ID, Bag_Weight, Bag_Color) VALUES(16, 5.45, 'Puce');

COMMIT;
