use airline;

select year , format(sum(load_factor),2) as load_factor
from maindata
group by year;

select  Quarter, format(sum(load_factor),2) as load_factor
from maindata
group by Quarter;

select Month_Name , format(sum(load_factor),2) as load_factor
from maindata
group by Month_Name;

select year,concat(format(sum(load_factor)/100,2),'%') as load_factorPercentage
from maindata
group by year;

select unique_carrier,concat(format(sum(load_factor)/100,2),'%') as load_factorPercentage
from maindata
group by unique_carrier;

select carrier_Name ,concat(format(sum(load_factor)/100,2),'%') as load_factorPercentage
from maindata
group by carrier_Name;

select carrier_Name,count(Airline_ID)
from maindata
group by carrier_Name
order by count(Airline_ID) desc limit 10;

select From_To_City,count(Airline_ID)
from maindata
group by From_To_City;

select Weekday_name,format(sum(load_factor),2)
from maindata
group by Weekday_name;

select case 
when Weekdayno in (1,7) then 'Weekend'
else
'Weekday'
end as daytype,
concat(format(sum(load_factor)/1000,2),'%') as loadFactor
from maindata
group by case
when Weekdayno in (1,7) then 'Weekend'
else 'Weekday'
end;

select Airline,Origin_Country,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Airline;

select Airline,Origin_State,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Origin_State;

select Airline,Origin_City,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Origin_City;

select Airline,Destination_Country,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Airline;

select Airline,Destination_State,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Airline;


select Airline,Destination_City,count(m.Airline_ID)
from maindata m inner join airlines a on m.Airline_ID=a.Airline_ID
group by Airline;

select Distance_Interval,count(Airline_ID)
from maindata m inner join distance_groups d on m.Distance_Group_ID=d.Distance_Group_ID
group by Distance_Interval;


create view Statewise as 
select Destination_State,Air_Time,count(Airline_ID) 
from maindata
group by Destination_State;

create view citywise as 
select Destination_City,Air_Time,count(Airline_ID) 
from maindata
group by Destination_City;

create view yearwise as
select Year,concat(format(sum(Transported_Passengers)/1000000,1),"M") as TransportedPassengers,format(sum(load_Factor),2) as load_factor
from maindata
group by year;

create view weekday_end as
select case 
when Weekdayno in (1,7) then 'Weekend'
else
'Weekday'
end as daytype,
concat(format(sum(Transported_Passengers)/1000000,1),"M") as TransportedPassengers,sum(Air_Time),concat(format(sum(load_factor)/1000,2),'%') as loadFactor
from maindata
group by case
when Weekdayno in (1,7) then 'Weekend'
else 'Weekday'
end;

create view transportedPassengers as
select Distance_Interval,concat(format(sum(Transported_Passengers)/1000000,1),"M") as TransportedPassengers,count(Airline_ID)
from maindata m inner join distance_groups d on m.Distance_Group_ID=d.Distance_Group_ID
group by Distance_Interval;

create view top10carrier as
select unique_carrier,concat(format(sum(load_factor)/100,2),'%') as load_factorPercentage
from maindata
group by unique_carrier 
order by sum(load_factor) desc limit 10;