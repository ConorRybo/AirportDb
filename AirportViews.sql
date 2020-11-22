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
