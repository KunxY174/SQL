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

--29.Выведите имена пассажиров улетевших в Москву (Moscow) на самолете TU-134
SELECT distinct name
from passenger p
  join Pass_in_trip pt on (p.id = pt.passenger)
where trip in (
    select id
    from trip
    where plane = 'TU-134'
      and town_to = 'Moscow');

--31.Вывести всех членов семьи с фамилией Quincey.
select *
from FamilyMembers
where member_name like '% Quincey';

--32.Вывести средний возраст людей (в годах), хранящихся в базе данных. Результат округлите до целого в меньшую сторону.
SELECT FLOOR (avg(TIMESTAMPDIFF(YEAR, birthday, now()))) as age
from FamilyMembers;

--33.Найдите среднюю стоимость икры. В базе данных хранятся данные о покупках красной (red caviar) и черной икры (black caviar).
SELECT avg(unit_price) as cost
from Payments p
  join Goods g on (p.good = g.good_id)
where good_name in ('red caviar', 'black caviar');