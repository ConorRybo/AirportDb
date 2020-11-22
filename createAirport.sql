--
-- Conor Rybacki + Lleyton Seymour
-- Database: Airport
-- File name: Airport.sql
--

BEGIN;

DROP TABLE IF EXISTS ARRIVING;
DROP TABLE IF EXISTS DEPARTING;
DROP TABLE IF EXISTS PASSENGER;
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
Aircraft_Variant VARCHAR(50) NOT NULL,
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
CREATE TABLE ARRIVING(
Flight_Num      INTEGER NOT NULL,
Term_Letter     VARCHAR(1) NOT NULL,
Gate_Num        INTEGER NOT NULL,
Arrival_Time    DATETIME NOT NULL,
Airline_ID      INTEGER NOT NULL,
Aircraft_ID     INTEGER NOT NULL,
Pilot_ID        INTEGER NOT NULL,

PRIMARY KEY (Flight_Num),
FOREIGN KEY (Airline_ID) REFERENCES AIRLINE(Airline_ID),
FOREIGN KEY (Aircraft_ID) REFERENCES AIRCRAFT(Aircraft_ID),
FOREIGN KEY (Pilot_ID) REFERENCES PILOT(Pilot_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- DEPARTING table: holds arriving flights infomation
--
CREATE TABLE DEPARTING(
Flight_Num      INTEGER NOT NULL,
Term_Letter     VARCHAR(1) NOT NULL,
Gate_Num        INTEGER NOT NULL,
Arrival_Time    DATETIME NOT NULL,
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
FOREIGN KEY (Flight_Num) REFERENCES ARRIVING(Pilot_ID),
FOREIGN KEY (Flight_Num) REFERENCES DEPARTING(Pilot_ID)) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- LUGGAGE table: hold luggage information
--
CREATE TABLE LUGGAGE(
Pass_ID         INTEGER NOT NULL AUTO_INCREMENT,
Bag_Weight      VARCHAR(5) NOT NULL,
Bag_Color       VARCHAR(10) DEFAULT NULL,

PRIMARY KEY(Pass_ID),
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
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(4, 'C', '2020-04-22');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(5, 'C', '2019-04-15');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(6, 'C', '2021-04-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(7, 'C', '2019-04-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(8, 'C', '2021-04-10');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(9, 'C', '2021-04-01');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(10, 'C','2020-04-26');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(11, 'C','2019-04-06');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(12, 'C','2020-04-26');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(13, 'C','2022-04-07');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(14, 'C','2021-04-13');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(15, 'C','2020-04-08');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(16, 'C','2020-04-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(17, 'C','2021-04-01');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(18, 'C','2020-04-24');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(19, 'C','2020-04-13');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(20, 'C','2021-04-21');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(21, 'C','2019-04-19');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(22, 'C','2021-04-04');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(23, 'C','2021-04-05');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(24, 'C','2020-04-12');
INSERT INTO FAALICENSE (FAA_Num, FAA_Class, FAA_CertDate) VALUES(25, 'C','2020-04-17');

--
-- Inserting data for passengers
--
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(1, 'Hannah', 'Ghelardoni', 'L', '696-601-3566');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(2, 'Michaeline', 'Esler', 'S', '445-173-7441');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(3, 'Amelia', 'Dumphry', 'A', '231-264-4120');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(4, 'Karim', 'Ghelardoni', 'Q', '696-601-3568');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(5, 'Alis', 'Gladhill', 'V', '722-284-9497');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(6, 'Robbie', 'Boagey', 'D', '779-869-5753');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(7, 'Lucius', 'Gong', 'B', '844-581-2762');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(8, 'Margot', 'Cane', 'H', '888-126-2498');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(9, 'Goran', 'Ovize', 'M', '981-168-9949');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(10, 'Gibby', 'Thing', 'R', '449-552-0248');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(11, 'Fae', 'Shore', 'E', '771-684-0587');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(12, 'Felicio', 'Walcot', 'E', '593-852-8654');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(13, 'Mella', 'Keats', 'H', '358-986-0433');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(14, 'Gertrude', 'Frisdick', 'J', '438-284-9114');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(15, 'Yance', 'O''Mara', 'M', '310-791-6842');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(16, 'Mallorie', 'Breslin', 'L', '505-615-9544');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(17, 'Elisha', 'Kelner', 'P', '837-499-9436');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(18, 'Mari', 'Hurlston', 'U', '959-139-9678');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(19, 'Benedicto', 'Tunnow', 'E', '416-324-2905');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(20, 'Dilly', 'Gullan', 'Q', '661-567-8087');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(21, 'Georgianna', 'Swindells', 'V', '169-280-7926');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(22, 'Mikael', 'Trodden', 'B', '372-946-4287');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(23, 'Gates', 'Walklate', 'V', '124-661-1892');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(24, 'Debbie', 'Zorzini', 'J', '586-944-7147');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(25, 'Kelci', 'Ewin', 'J', '580-856-8335');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(26, 'Fannie', 'Mouget', 'F', '235-216-3811');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(27, 'Gerhardt', 'Furlonge', 'S', '254-228-4916');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(28, 'Avram', 'Russi', 'S', '650-521-2894');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(29, 'Red', 'Janacek', 'A', '920-300-2171');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(30, 'Dewain', 'Catlin', 'A', '722-450-0242');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(31, 'Jephthah', 'Tweddle', 'C', '314-611-4128');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(32, 'Aluin', 'Dumbrall', 'C', '808-486-5471');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(33, 'Fabian', 'Mathison', 'M', '260-222-4705');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(34, 'Billy', 'Schottli', 'D', '881-983-3608');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(35, 'Thorndike', 'Tubbs', 'A', '283-853-9735');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(36, 'Donnamarie', 'Nicholson', 'F', '306-710-1300');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(37, 'Cordie', 'Orpen', 'J', '773-160-0255');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(38, 'Ernst', 'Mangion', 'G', '501-674-0612');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(39, 'Kania', 'Ellerey', 'G', '918-134-7192');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(40, 'Camel', 'Thewys', 'E', '158-807-1120');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(41, 'Cindie', 'Gatecliffe', 'T', '597-246-1210');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(42, 'Hedy', 'Brandt', 'F', '643-529-5111');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(43, 'Beulah', 'Kroch', 'H', '131-534-1591');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(44, 'Noam', 'Toner', 'Y', '360-576-0422');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(45, 'Lizabeth', 'Newarte', 'H', '144-321-1605');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(46, 'Micky', 'Middas', 'T', '231-705-6896');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(47, 'Ollie', 'Bantham', 'J', '644-767-1512');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(48, 'Joey', 'Kornalik', 'E', '148-662-0744');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(49, 'Lari', 'Runnalls', 'W', '993-253-1329');
INSERT INTO PASSENGER (Pass_ID, Pass_FName, Pass_LName, Pass_Initial, Pass_Phone, Flight_Num) VALUES(50, 'Laurent', 'Shaw', 'R', '479-648-3735')

--
-- Inserting data for Manufacturer
--
INSERT INTO MANUFACTURER VALUES(1, 'Dassault', 'France', '584-272-6030','Angie');
INSERT INTO MANUFACTURER VALUES(2, 'BAE Systems','United Kingdom', '607-337-5854', 'Florella');
INSERT INTO MANUFACTURER VALUES(3, 'Boeing', 'United States', '332-354-2772', 'Mozes');
INSERT INTO MANUFACTURER VALUES(4, 'Airbus', 'United States', '502-711-0994', 'Genevieve');
INSERT INTO MANUFACTURER VALUES(5, 'Honda', 'United States', '209-206-4822', 'Max');   



--
-- Inserting data for luggage
--
INSERT INTO LUGGAGE VALUES (44, 31.61, 'Fuscia');        
INSERT INTO LUGGAGE VALUES(13, 19.44, 'Orange');
INSERT INTO LUGGAGE VALUES(34, 40.13, 'Goldenrod');
INSERT INTO LUGGAGE VALUES(27, 7.89, 'Fuscia');
INSERT INTO LUGGAGE VALUES(5, 41.27, 'Yellow');
INSERT INTO LUGGAGE VALUES(8, 42.77, 'Violet');
INSERT INTO LUGGAGE VALUES(23, 32.88, 'Fuscia');
INSERT INTO LUGGAGE VALUES(21, 38.51, 'Crimson');
INSERT INTO LUGGAGE VALUES(40, 16.09, 'Green');
INSERT INTO LUGGAGE VALUES(31, 32.45, 'Teal');
INSERT INTO LUGGAGE VALUES(4, 35.17, 'Puce');
INSERT INTO LUGGAGE VALUES(28, 32.3, 'Teal');
INSERT INTO LUGGAGE VALUES(34, 38.9, 'Puce');
INSERT INTO LUGGAGE VALUES(38, 40.09, 'Green');
INSERT INTO LUGGAGE VALUES(32, 22.16, 'Turquoise');
INSERT INTO LUGGAGE VALUES(13, 32.82, 'Maroon');
INSERT INTO LUGGAGE VALUES(30, 21.61, 'Yellow');
INSERT INTO LUGGAGE VALUES(43, 16.15, 'Orange');
INSERT INTO LUGGAGE VALUES(47, 39.33, 'Indigo');
INSERT INTO LUGGAGE VALUES(27, 40.97, 'Blue');
INSERT INTO LUGGAGE VALUES(41, 40.6, 'Fuscia');
INSERT INTO LUGGAGE VALUES(26, 37.19, 'Violet');
INSERT INTO LUGGAGE VALUES(19, 36.47, 'Purple');
INSERT INTO LUGGAGE VALUES(38, 44.53, 'Crimson');
INSERT INTO LUGGAGE VALUES(41, 6.62, 'Fuscia');
INSERT INTO LUGGAGE VALUES(39, 24.98, 'Khaki');
INSERT INTO LUGGAGE VALUES(24, 28.78, 'Violet');
INSERT INTO LUGGAGE VALUES(45, 31.78, 'Blue');
INSERT INTO LUGGAGE VALUES(2, 44.18, 'Blue');
INSERT INTO LUGGAGE VALUES(41, 30.57, 'Orange');
INSERT INTO LUGGAGE VALUES(26, 19.4, 'Teal');
INSERT INTO LUGGAGE VALUES(10, 8.85, 'Mauv');
INSERT INTO LUGGAGE VALUES(42, 40.2, 'Orange');
INSERT INTO LUGGAGE VALUES(48, 39.35, 'Orange');
INSERT INTO LUGGAGE VALUES(26, 28.99, 'Khaki');
INSERT INTO LUGGAGE VALUES(23, 19.79, 'Mauv');
INSERT INTO LUGGAGE VALUES(16, 40.38, 'Khaki');
INSERT INTO LUGGAGE VALUES(22, 11.59, 'Khaki');
INSERT INTO LUGGAGE VALUES(38, 39.04, 'Orange');
INSERT INTO LUGGAGE VALUES(30, 23.22, 'Mauv');
INSERT INTO LUGGAGE VALUES(8, 44.48, 'Mauv');
INSERT INTO LUGGAGE VALUES(3, 27.4, 'Teal');
INSERT INTO LUGGAGE VALUES(36, 13.41, 'Violet');
INSERT INTO LUGGAGE VALUES(21, 22.68, 'Red');
INSERT INTO LUGGAGE VALUES(1, 1.32, 'Fuscia');
INSERT INTO LUGGAGE VALUES(46, 4.26, 'Violet');
INSERT INTO LUGGAGE VALUES(40, 39.34, 'Teal');
INSERT INTO LUGGAGE VALUES(4, 7.34, 'Indigo');
INSERT INTO LUGGAGE VALUES(23, 18.38, 'Aquamarine');
INSERT INTO LUGGAGE VALUES(36, 17.92, 'Red');
INSERT INTO LUGGAGE VALUES(1, 29.66, 'Goldenrod');
INSERT INTO LUGGAGE VALUES(3, 31.9, 'Fuscia');
INSERT INTO LUGGAGE VALUES(1, 5.81, 'Fuscia');
INSERT INTO LUGGAGE VALUES(3, 8.98, 'Blue');
INSERT INTO LUGGAGE VALUES(7, 13.82, 'Khaki');
INSERT INTO LUGGAGE VALUES(27, 30.48, 'Crimson');
INSERT INTO LUGGAGE VALUES(2, 37.21, 'Teal');
INSERT INTO LUGGAGE VALUES(16, 43.07, 'Yellow');
INSERT INTO LUGGAGE VALUES(50, 19.1, 'Puce');
INSERT INTO LUGGAGE VALUES(18, 43.94, 'Fuscia');
INSERT INTO LUGGAGE VALUES(24, 1.52, 'Puce');
INSERT INTO LUGGAGE VALUES(24, 2.97, 'Goldenrod');
INSERT INTO LUGGAGE VALUES(16, 25.54, 'Puce');
INSERT INTO LUGGAGE VALUES(3, 26.78, 'Fuscia');
INSERT INTO LUGGAGE VALUES(43, 21.01, 'Orange');
INSERT INTO LUGGAGE VALUES(14, 6.63, 'Purple');
INSERT INTO LUGGAGE VALUES(16, 5.45, 'Puce');

--
-- Inserting data for Airline
--
INSERT INTO AIRLINE VALUES(1, 'American', 'United States', '404-383-1274');   
INSERT INTO AIRLINE VALUES(2, 'Delta', 'United States', '917-122-1345');
INSERT INTO AIRLINE VALUES(3, 'Qantas', 'Australia', '775-707-3503');
INSERT INTO AIRLINE VALUES(4, 'Southwest', 'United States', '719-943-9050');
INSERT INTO AIRLINE VALUES(5, 'Frontier', 'United States', '212-421-5103');
INSERT INTO AIRLINE VALUES(6, 'Alaska', 'United States', '912-602-2697');
INSERT INTO AIRLINE VALUES(7, 'JetBlue', 'United States', '239-295-9179');
INSERT INTO AIRLINE VALUES(8, 'Allegian', 'United States', '304-927-6521');

--
-- Inserting data for Employee
--
INSERT INTO EMPLOYEE VALUES(1, 'Husain', 'Coppledike', 'A', '914-891-0767', NULL, NULL);     
INSERT INTO EMPLOYEE VALUES(2, 'Cleon', 'Rothman', 'L', '235-401-5092', NULL, NULL);
INSERT INTO EMPLOYEE VALUES(3, 'Janela', 'Auty', 'A', '931-916-8187', NULL, NULL);
INSERT INTO EMPLOYEE VALUES(4, 'Sophi', 'Spavins', 'G', '418-844-3022', NULL, NULL);
INSERT INTO EMPLOYEE VALUES(5, 'Agathe', 'Melhuish', 'C', '144-899-1736', NULL, NULL);
INSERT INTO EMPLOYEE VALUES(6, 'Ann-marie', 'Detheridge', 'E', '310-624-4624', NULL, 3);
INSERT INTO EMPLOYEE VALUES(7, 'Georgianne', 'Carrigan', 'K', '390-780-9540', 'T', 4);
INSERT INTO EMPLOYEE VALUES(8, 'Antony', 'Hagart', 'A', '951-999-9982', 'T', 3);
INSERT INTO EMPLOYEE VALUES(9, 'Stearn', 'Borit', 'B', '319-556-9357', 'T', 1);      
INSERT INTO EMPLOYEE VALUES(10, 'Chaunce', 'Crone', 'A', '530-625-7543', NULL, 3);
INSERT INTO EMPLOYEE VALUES(11, 'Virginia', 'Leishman', 'V', '596-329-3246', NULL, 5);
INSERT INTO EMPLOYEE VALUES(12, 'Bonny', 'Ratley', 'L', '936-642-7334', NULL, 2);
INSERT INTO EMPLOYEE VALUES(13, 'Janel', 'Disbrey', 'I', '278-465-5968', 'T', 5);
INSERT INTO EMPLOYEE VALUES(14, 'Lloyd', 'Ambrozewicz', 'O', '685-248-8487', 'T', 5);
INSERT INTO EMPLOYEE VALUES(15, 'Ajay', 'Brittan', 'P', '516-271-3396', 'T', 2);
INSERT INTO EMPLOYEE VALUES(16, 'Hamlen', 'Sigfrid', 'R', '986-280-5858', 'G', 5);
INSERT INTO EMPLOYEE VALUES(17, 'Jennee', 'Ritmeyer', 'R', '325-785-3770', 'G', 3);
INSERT INTO EMPLOYEE VALUES(18, 'Teodoor', 'Pill', 'W', '197-666-6234', 'G', 3);
INSERT INTO EMPLOYEE VALUES(19, 'Joli', 'Minihane', 'Q', '651-768-2798', 'G', 2);
INSERT INTO EMPLOYEE VALUES(20, 'Andrej', 'Kaplin', 'A', '397-262-8038', NULL, 2);
INSERT INTO EMPLOYEE VALUES(21, 'Had', 'Geram', 'D', '981-792-7393', 'G', 2);
INSERT INTO EMPLOYEE VALUES(22, 'Lock', 'Castellan', 'C', '694-210-0374', 'G', 1);
INSERT INTO EMPLOYEE VALUES(23, 'Andrei', 'Kellitt', 'S', '912-876-7955', 'G', 5);
INSERT INTO EMPLOYEE VALUES(24, 'Ruperto', 'Allport', 'S', '690-431-9201', 'G', 2);
INSERT INTO EMPLOYEE VALUES(25, 'Cly', 'Kinchin', 'S', '166-955-7975', NULL, 2);
INSERT INTO EMPLOYEE VALUES(26, 'Chaim', 'Hempel', 'R', '986-203-3493', NULL, 5);
INSERT INTO EMPLOYEE VALUES(27, 'Shawna', 'Fidal', 'T', '164-659-0989', NULL, 1);
INSERT INTO EMPLOYEE VALUES(28, 'Carrie', 'Ashburner', 'K', '546-145-7046', NULL, 3);
INSERT INTO EMPLOYEE VALUES(29, 'Micky', 'McCarney', 'P', '599-775-0853', NULL, 3);
INSERT INTO EMPLOYEE VALUES(30, 'Johna', 'Duckworth', 'I', '926-908-4558', NULL, 4);
INSERT INTO EMPLOYEE VALUES(31, 'Cheryl', 'Ruby', 'A', '837-164-3757', NULL, 3);
INSERT INTO EMPLOYEE VALUES(32, 'Aimee', 'Tallach', 'C', '528-190-9919', NULL, 4);
INSERT INTO EMPLOYEE VALUES(33, 'Agnes', 'Santhouse', 'C', '420-863-5339', NULL, 1);
INSERT INTO EMPLOYEE VALUES(34, 'Shalne', 'Portwaine', 'N', '995-582-4396', NULL, 4);
INSERT INTO EMPLOYEE VALUES(35, 'Cammy', 'Tempest', 'T', '447-862-1820', NULL, 5);

--
-- Inserting data for Aircraft
--
INSERT INTO AIRCRAFT VALUES(1, 'B', '747', 205, '067ffa9f94b', 5);   
INSERT INTO AIRCRAFT VALUES(2, 'B', '747', 198, '6564f5f6f49', 2);
INSERT INTO AIRCRAFT VALUES(3, 'B', '747', 112, 'ba56eb90d13', 1);
INSERT INTO AIRCRAFT VALUES(4, 'B', '747', 50, '402c642648e4', 2);
INSERT INTO AIRCRAFT VALUES(5, 'B', '747', 70, '54256304e5a8', 4);
INSERT INTO AIRCRAFT VALUES(6, 'B', '747', 52, '2633d5b6fa74', 3);
INSERT INTO AIRCRAFT VALUES(7, 'B', '747', 139, '9d44d1d1bb9', 5);
INSERT INTO AIRCRAFT VALUES(8, 'B', '747', 125, 'af553fd562d', 1);
INSERT INTO AIRCRAFT VALUES(9, 'B', '747', 181, 'edfb5dedb07', 4);
INSERT INTO AIRCRAFT VALUES(10, 'B', '747', 138, '8e741cd23f', 2);

--
-- Inserting data for Pilot
--
INSERT INTO PILOT VALUES(1, 'Berne', 'Fancet', 'M', 1, 4);        
INSERT INTO PILOT VALUES(2, 'Tully', 'Tumioto', 'M', 5, 21);
INSERT INTO PILOT VALUES(3, 'Earlie', 'Jaffrey', 'M', 8, 22);
INSERT INTO PILOT VALUES(4, 'Adelice', 'Langfat', 'F', 5, 7);
INSERT INTO PILOT VALUES(5, 'Meris', 'Peckett', 'F', 3, 4);
INSERT INTO PILOT VALUES(6, 'Zora', 'Georgeou', 'F', 5, 6);
INSERT INTO PILOT VALUES(7, 'Adi', 'Doldon', 'F', 2, 16);
INSERT INTO PILOT VALUES(8, 'Farlie', 'Swatten', 'M', 3, 10);
INSERT INTO PILOT VALUES(9, 'Amitie', 'Scotter', 'F', 6, 20);
INSERT INTO PILOT VALUES(10, 'Olav', 'Badman', 'M', 5, 19);
INSERT INTO PILOT VALUES(11, 'Sam', 'Burger', 'M', 1, 1);
INSERT INTO PILOT VALUES(12, 'Beauregard', 'Peppard', 'M', 2, 18);
INSERT INTO PILOT VALUES(13, 'Lucilia', 'Hawse', 'F', 6, 24);
INSERT INTO PILOT VALUES(14, 'Olivier', 'Hulson', 'M', 1, 25);
INSERT INTO PILOT VALUES(15, 'Caitrin', 'Chasemoore', 'F', 6, 12);
INSERT INTO PILOT VALUES(16, 'Bruno', 'Saltwell', 'M', 3, 2);
INSERT INTO PILOT VALUES(17, 'Brodie', 'Reyner', 'M', 1, 8);
INSERT INTO PILOT VALUES(18, 'Cletus', 'Sinott', 'M', 7, 17);
INSERT INTO PILOT VALUES(19, 'Dominga', 'Haire', 'F', 4, 11);
INSERT INTO PILOT VALUES(20, 'Vincenz', 'Marlor', 'M', 6, 13);    


--
-- Inserting data for arriving flights
--
INSERT INTO ARRIVING VALUES(1001, 'A', 5, '1:21', 1, 3, 8);    
INSERT INTO ARRIVING VALUES(1002, 'B', 5, '18:42', 1, 10, 5);
INSERT INTO ARRIVING VALUES(1003, 'A', 2, '23:28', 5, 2, 4);
INSERT INTO ARRIVING VALUES(1004, 'C', 4, '20:06', 3, 2, 9);
INSERT INTO ARRIVING VALUES(1005, 'C', 5, '19:26', 1, 6, 9);
INSERT INTO ARRIVING VALUES(1006, 'C', 2, '3:25', 8, 1, 1);
INSERT INTO ARRIVING VALUES(1007, 'D', 1, '10:10', 1, 2, 9);
INSERT INTO ARRIVING VALUES(1008, 'D', 4, '6:54', 8, 7, 2);
INSERT INTO ARRIVING VALUES(1009, 'B', 2, '19:10', 1, 2, 1);
INSERT INTO ARRIVING VALUES(1010, 'D', 2, '17:25', 1, 3, 6);

--
-- Inserting data for departing flights
--
INSERT INTO DEPARTING VALUES(2001, 'A', 5, '14:35', 5, 4, 4);  
INSERT INTO DEPARTING VALUES(2002, 'B', 2, '16:36', 3, 3, 8);
INSERT INTO DEPARTING VALUES(2003, 'A', 5, '1:26', 2, 2, 6);
INSERT INTO DEPARTING VALUES(2004, 'C', 2, '16:16', 8, 9, 3);
INSERT INTO DEPARTING VALUES(2005, 'C', 4, '17:07', 7, 5, 2);
INSERT INTO DEPARTING VALUES(2006, 'C', 1, '1:02', 2, 6, 6);
INSERT INTO DEPARTING VALUES(2007, 'D', 4, '15:11', 3, 6, 7);
INSERT INTO DEPARTING VALUES(2008, 'D', 1, '6:21', 7, 8, 2);
INSERT INTO DEPARTING VALUES(2009, 'B', 4, '10:02', 4, 2, 8);
INSERT INTO DEPARTING VALUES(2010, 'D', 4, '12:35', 4, 3, 1);

COMMIT;