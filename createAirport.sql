--
-- Conor Rybacki + Llayton Seymour
-- Database: Airport
-- File name: Airport.sql
--

--
-- Creating Table For arriving flights
-- 

CREATE TABLE IF NOT EXISTS ARRIVING(
    Flight_Num int NOT NULL,
    Term_Letter varchar(1) NOT NULL,
    Gate_Num int NOT NULL,
    Arrival_Time DATETIME NOT NULL,
    Airline_ID int NOT NULL,
    Aircraft_ID int NOT NULL,
    Pilot_ID int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- DEPARTING flighs table
--

CREATE TABLE IF NOT EXISTS DEPARTING(
    Flight_Num int NOT NULL,
    Term_Letter varchar(1) NOT NULL,
    Gate_Num int NOT NULL,
    Arrival_Time DATETIME NOT NULL,
    Airline_ID int NOT NULL,
    Aircraft_ID int NOT NULL,
    Pilot_ID int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- PASSENGERS table: holds passenger information
-- 

CREATE TABLE IF NOT EXISTS PASSENGERS(
    Pass_ID int NOT NULL,
    Pass_FName varchar(50) NOT NULL,
    Pass_LName varchar(50) NOT NULL,
    Pass_Initial char(1) DEFAULT NULL,
    Pass_Phone varchar(50) NOT NULL,
    Flight_Num int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- LUGGAGE table: hold luggage information
--

CREATE TABLE IF NOT EXISTS LUGGAGE(
    Pass_ID int NOT NULL,
    Weight varchar(5) NOT NULL,
    Color varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- TERMINAL table: hold terminal information
-- 

CREATE TABLE IF NOT EXISTS TERMINAL(
    Term_Letter char(1) NOT NULL,
    Gate_Num int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- AIRCRAFT table to hold info about aircraft
-- 

CREATE TABLE IF NOT EXISTS AIRCRAFT(
    Aircraft_ID int NOT NULL,
    Aircraft_Model varchar(50) NOT NULL,
    Aircraft_Variant varchar(50) NOT NULL,
    Aircraft_Capacity varchar(5) NOT NULL,
    Aircraft_Registration varchar(25) NOT NULL,
    Man_ID int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- MANUFACTURER table to hold airplan manufacturer information
-- 

CREATE TABLE IF NOT EXISTS MANUFACTURER(
    Man_ID int NOT NULL,
    Man_Name varchar(50) NOT NULL,
    Man_Country varchar(50) NOT NULL,
    Man_Phone varchar(50) NOT NULL,
    Man_ContactName varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- EMPLOYEE table holding emoloyee information
-- 

CREATE TABLE IF NOT EXISTS EMPLOYEE(
    Emp_ID int NOT NULL,
    Emp_FName varchar(50) NOT NULL,
    Emp_LName varchar(50) NOT NULL,
    Emp_Initial char(1) DEFAULT NULL,
    Emp_Phone varchar(50) NOT NULL,
    Emp_Type char(1) DEFAULT NULL,
    Sup_ID int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- AIRLINE table to hold information about airline
-- 

CREATE TABLE IF NOT EXISTS AIRLINE(
    Airline_ID int NOT NULL,
    Airline_Name varchar(50) NOT NULL,
    Airline_Country varchar(50) NOT NULL,
    Airline_Phone varchar(50) NOT NULL 
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- PILOT table to hold pilot information
-- 

CREATE TABLE IF NOT EXISTS PILOT(
    Pilot_ID int NOT NULL,
    Pilot_FName varchar(50) NOT NULL,
    Pilot_LName varchar(50) NOT NULL,
    Pilot_Initial char(1) DEFAULT NULL,
    Airline_ID int DEFAULT NULL,
    FAA_Num int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- GROUNDCREW subtype of EMPLOYEE
-- 

CREATE TABLE IF NOT EXISTS GROUNDCREW(
    Emp_ID int NOT NULL,
    Grnd_Team int DEFAULT NULL,
    Term_Letter char(1) NOT NULL,
    FAA_Num int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- 
-- AIRTRAFFIC subtype of EMPLOYEE
-- 

CREATE TABLE IF NOT EXISTS AIRTRAFFIC(
    Emp_ID int NOT NULL,
    Ctrl_Team int DEFAULT NULL,
    Tower_Num int NOT NULL,
    FAA_Num int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- FAALICENSE table to hold information about faa license
-- 

CREATE TABLE IF NOT EXISTS FAALICENSE(
    FAA_Num int NOT NULL,
    FAA_Class varchar(30) NOT NULL,
    FAA_CertDate DATE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1; 
