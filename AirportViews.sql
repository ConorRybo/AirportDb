--
-- Conor Rybacki + Lleyton Seymour
-- Airport Views
-- File name: AirportViews.sql
--

/* Display all employees and their managers */
CREATE VIEW vManagers AS 
SELECT E.Emp_FName "Employee First Name", E.Emp_LName "Employee Last Name", B.Emp_FName "Boss First Name", B.Emp_LName "Boss Last Name"
FROM EMPLOYEE E JOIN EMPLOYEE B ON  E.Sup_ID=B.Emp_ID
ORDER BY B.Emp_FName;

/* Displays all Arriving Flight information and number of passangers on that flight */ 
create view vArrivingFlights AS
select F.Flight_Num 'Flight Number', concat(F.Term_Letter,F.Gate_Num) 'Gate', F.Flight_Time 'Arrival Time', A.Airline_Name 'Airline', count(*) 'Number of Passengers'
from FLIGHT F join PASSENGER P on P.Flight_Num=F.Flight_Num join AIRLINE A on A.Airline_ID=F.Airline_ID 
group by F.Flight_Num
having F.Flight_Num < 2000
order by F.Flight_Time;

/* Displays all Departing Flight information and number of passengers on flights */
create view vDepartingFlights AS
select F.Flight_Num 'Flight Number', concat(F.Term_Letter,F.Gate_Num) 'Gate', F.Flight_Time 'Departure Time', A.Airline_Name 'Airline', count(*) 'Number of Passengers'
from FLIGHT F join PASSENGER P on P.Flight_Num=F.Flight_Num join AIRLINE A on A.Airline_ID=F.Airline_ID 
group by F.Flight_Num
having F.Flight_Num >= 2000
order by F.Flight_Time;

/* Displays total weight of all luggage on flight */
CREATE view vLuggageWeight AS
SELECT CONCAT(FORMAT(SUM(L.Bag_Weight), 2), "lbs") AS "Total Bag Weight" 
FROM LUGGAGE L JOIN PASSENGER P ON L.Pass_ID = P.Pass_ID JOIN FLIGHT F ON P.Flight_Num = F.Flight_Num 
WHERE F.Flight_Num = 2006;

/* Top 3 most popular colors chosen for passenger's luggage */
CREATE view vPopLuggageColor AS
SELECT Bag_Color AS "Color" 
FROM LUGGAGE 
GROUP BY Bag_Color 
ORDER BY COUNT(Bag_Color) DESC 
LIMIT 3;

/* Pilot's with expired FAA Licenses */
CREATE view vExpiredPilot AS
SELECT CONCAT(P.Pilot_FName, " ", P.Pilot_LName) AS "Pilot Full Name" 
FROM PILOT P 
WHERE FAA_Num 
NOT IN (SELECT FAA_Num FROM FAALICENSE WHERE (DATEDIFF(FAA_CertDate, '2020-11-22') > 0))
ORDER BY P.Pilot_FName;