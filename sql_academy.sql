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

--17.Определить, сколько потратил в 2005 году каждый из членов семьи
SELECT member_name,
  status,
  sum(unit_price * amount) as costs
from FamilyMembers f
  join Payments p on (f.member_id = p.family_member)
where payment_id in (
    SELECT payment_id
    from Payments
    where YEAR(date) = 2005
  )
group by member_name, status

--18.Узнать, кто старше всех в семьe
SELECT member_name
from FamilyMembers
where birthday in (
    SELECT min(birthday)
    FROM FamilyMembers);

--19.Определить, кто из членов семьи покупал картошку (potato)
SELECT distinct status
from FamilyMembers f
  join Payments p on (f.member_id = p.family_member)
  join Goods g on (p.good = g.good_id)
where good_name = 'potato';

--20.Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму
SELECT status,
  member_name,
  sum(amount * unit_price) as costs
from FamilyMembers f
  join Payments p on (f.member_id = p.family_member)
  join goods g on (p.good = g.good_id)
  join GoodTypes gt on (g.type = gt.good_type_id)
where good_type_name = 'entertainment'
GROUP by status, member_name;

--21.Определить товары, которые покупали более 1 раза
select distinct good_name
from Goods g
  join Payments p on (g.good_id = p.good)
GROUP by good_name
HAVING count (amount) > 1;

--22.Найти имена всех матерей (mother)
select member_name
from FamilyMembers
where status = 'mother';

--23.Найдите самый дорогой деликатес (delicacies) и выведите его стоимость
SELECT good_name,
  unit_price
from Goods g
  join GoodTypes gt on (g.type = gt.good_type_id)
  join Payments p on (p.good = g.good_id)
where good_type_name = 'delicacies'
  and unit_price = (
    SELECT max(unit_price)
    from Payments p
      join Goods g on(p.good = g.good_id)
      join GoodTypes gt on (g.type = gt.good_type_id)
    where good_type_name = 'delicacies');

--24.Определить кто и сколько потратил в июне 2005
SELECT member_name,
  sum(unit_price * amount) as costs
from Payments p
  join FamilyMembers f on (p.family_member = f.member_id)
WHERE payment_id in (
    SELECT payment_id
    from Payments
    where DATE_FORMAT(date, '%b-%Y') = 'Jun-2005')
GROUP by member_name;

--25.Определить, какие товары не покупались в 2005 году
select good_name
from Goods
where good_id not in (
    select good
    from Payments
    where YEAR(date) = 2005);

--26.Определить группы товаров, которые не приобретались в 2005 году
SELECT distinct good_type_name
from GoodTypes gt
WHERE good_type_id not in (
    select type
    from goods g
      join Payments p on (g.good_id = p.good)
    where YEAR(date) = 2005);

--27.Узнать, сколько потрачено на каждую из групп товаров в 2005 году. Вывести название группы и сумму
SELECT good_type_name,
  sum(unit_price * amount) as costs
from Payments p
  JOIN goods g on(p.good = g.good_id)
  join GoodTypes gt on (g.type = gt.good_type_id)
WHERE YEAR(date) = 2005
group by good_type_name;