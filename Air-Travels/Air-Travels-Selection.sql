--1.Вывести имена всех когда-либо обслуживаемых пассажиров авиакомпаний
SELECT name
from Passenger;

--2.Вывести названия всеx авиакомпаний
SELECT name
from company;

--3.Вывести все рейсы, совершенные из Москвы
SELECT *
from trip
where town_from = 'Moscow';

--4.Вывести имена людей, которые заканчиваются на "man"
SELECT name
from Passenger
where name like '%man';

--5.Вывести количество рейсов, совершенных на TU-134
SELECT count (*) as count
from trip
where plane = 'TU-134';

--6.Какие компании совершали перелеты на Boeing
SELECT distinct name
FROM company
  join trip on (company.id = Trip.company)
where plane = 'Boeing';

--7.Вывести все названия самолётов, на которых можно улететь в Москву (Moscow)
select DISTINCT plane
from Trip
where town_to = 'Moscow';

--8.В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?
SELECT town_to,
  TIMEDIFF(time_in, time_out) as flight_time
from Trip
WHERE town_from = 'Paris';

--9.Какие компании организуют перелеты с Владивостока (Vladivostok)?
SELECT name
FROM Company c
  JOIN Trip t on (c.id = t.company)
where town_from = 'Vladivostok';

--10.Вывести вылеты, совершенные с 10 ч. по 14 ч. 1 января 1900 г.
SELECT *
from Trip
where time_out BETWEEN '1900-01-01T10:00:00.000Z' and '1900-01-01T14:00:00.000Z';

--11.Вывести пассажиров с самым длинным именем
SELECT name
from Passenger
where LENGTH(name) in (
    SELECT max(LENGTH(name))
    FROM Passenger);

--12.Вывести id и количество пассажиров для всех прошедших полётов
SELECT trip,
  count(*) as count
from Pass_in_trip
GROUP BY trip;


--13.Вывести имена людей, у которых есть полный тёзка среди пассажиров
SELECT name
FROM Passenger
GROUP by name
having count(name) > 1;

--14.В какие города летал Bruce Willis
SELECT town_to
from Passenger p
  join Pass_in_trip pr on (p.id = pr.Passenger)
  join Trip t ON (pr.trip = t.id)
where name = 'Bruce Willis';


--15.Во сколько Стив Мартин (Steve Martin) прилетел в Лондон (London)
SELECT time_in
from Trip
where id in (
    SELECT trip
    from Passenger p
      join Pass_in_trip pr on (p.id = pr.Passenger)
    WHERE name = 'Steve Martin'
  )
  and town_to = 'london';

--16.Вывести отсортированный по количеству перелетов (по убыванию) и имени (по возрастанию) список пассажиров, совершивших хотя бы 1 полет.
SELECT name,
  count(trip) as count
from Pass_in_trip pr
  join Passenger p on (pr.passenger = p.id)
group by name
having count(Trip) >= 1
ORDER BY COUNT(trip) DESC, name

--17.Сколько рейсов совершили авиакомпании с Ростова (Rostov) в Москву (Moscow) ?
SELECT count(id) as count
from trip
WHERE town_from = 'Rostov'
  and town_to = 'Moscow';

--18.Выведите имена пассажиров улетевших в Москву (Moscow) на самолете TU-134
SELECT distinct name
from passenger p
  join Pass_in_trip pt on (p.id = pt.passenger)
where trip in (
    select id
    from trip
    where plane = 'TU-134'
      and town_to = 'Moscow');

--19.Выведите нагруженность (число пассажиров) каждого рейса (trip). Результат вывести в отсортированном виде по убыванию нагруженности.
select trip, count (name) as count
from passenger p
  join Pass_in_trip pt on (p.id = pt.passenger)
GROUP by trip
ORDER by 2 desc;

--20.Вывести время отлета и время прилета для каждого перелета в формате "ЧЧ:ММ, ДД.ММ - ЧЧ:ММ, ДД.ММ", где часы и минуты с ведущим нулем, а день и месяц без.
SELECT concat(DATE_FORMAT(time_out, '%H:%i, %e.%c' ), ' - ', 
DATE_FORMAT(time_in, '%H:%i, %e.%c')) as flight_time
from Trip;

--21. Выбрать три наименьших и три наибольших номера рейса. Вывести их в шести столбцах одной строки, расположив в порядке от наименьшего к наибольшему.
--Замечание: считать, что таблица Trip содержит не менее шести строк.
select min (t.trip_no), min (tt. trip_no), min (ttt.trip_no), max (t.trip_no), max (tt.trip_no), max (ttt.trip_no)
from Trip t, trip tt, trip ttt
where t.trip_no<tt. trip_no
and tt. trip_no<ttt.trip_no;