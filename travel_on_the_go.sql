/*Additional Comments : There is no primary key here also, a bus with the same distance can have two 
different prices, for example, festive season and on normal days.
 Also, display/consider both the price values for different prices, while writing queries.*/
 
show databases;
create database travel_on_the_go;
use travel_on_the_go;

/*(1) You are required to create two tables PASSENGER and PRICE with the following
attributes and properties */

	create table PASSENGER (
	Passenger_name varchar(30),
	 Category varchar(10),
	 Gender varchar(1),
	 Boarding_City varchar(20),
	 Destination_City varchar(20),
	 Distance int,
	 Bus_Type varchar(15)
	 );
	 create table PRICE(
	 Bus_Type varchar(15),
	 Distance int,
	 Price int
	 );

/* (2) Insert the following data in the tables */

	insert into PASSENGER values('Sejal','AC','F','Bengaluru','Chennai',350,'Sleeper');
	insert into PASSENGER values('Anmol','Non-AC','M','Mumbai','Hyderabad',700,'Sitting');
	insert into PASSENGER values('Pallavi','AC','F','Panaji','Bengaluru',600,'Sleeper');
	insert into PASSENGER values('Khusboo','AC','F','Chennai','Mumbai',1500,'Sleeper');
	insert into PASSENGER values('Udit','Non-AC','M','Trivandrum','panaji',1000,'Sleeper');
	insert into PASSENGER values('Ankur','AC','M','Nagpur','Hyderabad',500,'Sitting');
	insert into PASSENGER values('Hemant','Non-AC','M','panaji','Mumbai',700,'Sleeper');
	insert into PASSENGER values('Manish','Non-AC','M','Hyderabad','Bengaluru',500,'Sitting');
	insert into PASSENGER values('Piyush','AC','M','Pune','Nagpur',700,'Sitting');

	insert into PRICE values('Sleeper', 350 ,770);
	insert into PRICE values('Sleeper', 500, 1100);
	insert into PRICE values('Sleeper', 600 ,1320);
	insert into PRICE values('Sleeper' ,700 ,1540);
	insert into PRICE values('Sleeper', 1000, 2200);
	insert into PRICE values('Sleeper', 1200 ,2640);
	insert into PRICE values('Sleeper' ,1500, 2700);
	insert into PRICE values('Sitting', 500, 620);
	insert into PRICE values('Sitting', 600, 744);
	insert into PRICE values('Sitting', 700 ,868);
	insert into PRICE values('Sitting', 1000 ,1240);
	insert into PRICE values('Sitting', 1200 ,1488);
	insert into PRICE values('Sitting', 1500, 1860);

/*(3)How many females and how many male passengers travelled for a minimum distance of
600 KM s?*/

	select count(gender) as count,gender from PASSENGER where distance>=600 group by gender;

		/* output 
			4	M
			2	F
		*/
		
/* 4) Find the minimum ticket price for Sleeper Bus. */
	select min(Price) from PRICE where Bus_Type='Sleeper';
    
		/* output 
			770
		*/
		
/* 5) Select passenger names whose names start with character 'S' */
	select * from PASSENGER where Passenger_name like 'S%';
	
		/* output
		Sejal	AC	F	Bengaluru	Chennai	350	Sleeper
		*/

/* 6) Calculate price charged for each passenger displaying Passenger name,
 Boarding City,Destination City, Bus_Type, Price in the output */
	
	select Passenger_name,Boarding_City,Destination_City, pr.Bus_Type , pr.Price   from PASSENGER , Price as pr
	where PASSENGER.Bus_Type=pr.Bus_Type and PASSENGER.Distance=pr.Distance;
		/* output 
			Sejal	Bengaluru	Chennai	Sleeper	770
			Pallavi	Panaji	Bengaluru	Sleeper	1320
			Hemant	panaji	Mumbai	Sleeper	1540
			Udit	Trivandrum	panaji	Sleeper	2200
			Khusboo	Chennai	Mumbai	Sleeper	2700
			Manish	Hyderabad	Bengaluru	Sitting	620
			Ankur	Nagpur	Hyderabad	Sitting	620
			Piyush	Pune	Nagpur	Sitting	868
			Anmol	Mumbai	Hyderabad	Sitting	868
		*/


/*7) What are the passenger name/s and his/her ticket price who travelled in the Sitting bus
for a distance of 1000 KM s*/

	select Passenger_name,pr.Price from Passenger,Price as pr where Passenger.Bus_Type='Sitting' and Passenger.Distance='1000' and 
	PASSENGER.Bus_Type=pr.Bus_Type and PASSENGER.Distance=pr.Distance;
	
	/* output
	 no rows 
	 */

/*8) What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to
Panaji?*/
	select Bus_Type,Price from Price where distance=(select distance from  PASSENGER where Passenger_name='Pallavi');
	
	/* output 
		Sleeper	1320
		Sitting	744
	*/

/* 9) List the distances from the "Passenger" table which are unique (non-repeated
distances) in descending order.
*/
	select distance from Passenger group by distance 
	having COUNT(*)=1 order by distance desc;
	
	/* output 
		1500
		1000
		600
		350
	*/


/* 10) Display the passenger name and percentage of distance travelled by that passenger
from the total distance travelled by all passengers without using user variables*/

	select Passenger_name, concat (((Distance)* 100 / (Select SUM(Distance) From passenger)),'%') as 'percentage_of_distance_travelled%' from passenger;
	
	/* output 
		Sejal	5.3435%
		Anmol	10.6870%
		Pallavi	9.1603%
		Khusboo	22.9008%
		Udit	15.2672%
		Ankur	7.6336%
		Hemant	10.6870%
		Manish	7.6336%
		Piyush	10.6870%
	*/

/* 11) Display the distance, price in three categories in table Price
a) Expensive if the cost is more than 1000
b) Average Cost if the cost is less than 1000 and greater than 500
c) Cheap otherwise
	Sample output for 11th question
	350 770 Average
	Cost
	500 1100 Expensive
	600 1320 Expensive
	700 1540 Expensive*/
	
	select distance, price, CASE WHEN  price > '1000' THEN 'Expensive'
             WHEN price <= '1000' and price > '500' THEN 'Average Cost'
			 ELSE 'Cheap'
       END AS Rating FROM PRICE
	
		/* output 
		350		770		Average Cost
		500		1100	Expensive
		600		1320	Expensive
		700		1540	Expensive
		1000	2200	Expensive
		1200	2640	Expensive
		1500	2700	Expensive
		500		620		Average Cost
		600		744		Average Cost
		700		868		Average Cost
		1000	1240	Expensive
		1200	1488	Expensive
		1500	1860	Expensive
		
		*/
