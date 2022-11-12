
--14.Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
select s.class, name, country
from ships s
join classes c
on (s.class=c.class)
where numGuns>=10;

--31.Для классов кораблей, калибр орудий которых не менее 16 дюймов, укажите класс и страну.
Select class, country
From classes c
Where bore>=16;

--32.Одной из характеристик корабля является половина куба калибра его главных орудий (mw). С точностью до 2 десятичных знаков определите среднее значение mw для кораблей каждой страны, у которой есть корабли в базе данных.
with t1 as (select country, name, bore
from classes c
join ships s
on (c.class=s.class)
union
select country, ship, bore
from classes c
join outcomes o
on (c.class=o.ship))

select distinct country, CAST(avg((bore*bore*bore)/2) AS numeric(6,2)) weight 
from t1
group by country;

--33.Укажите корабли, потопленные в сражениях в Северной Атлантике (North Atlantic). Вывод: ship.
select ship
from outcomes
where result = 'sunk'
and battle in ('North Atlantic');

--34.По Вашингтонскому международному договору от начала 1922 г. запрещалось строить линейные корабли водоизмещением более 35 тыс.тонн. Укажите корабли, нарушившие этот договор (учитывать только корабли c известным годом спуска на воду). Вывести названия кораблей.
select distinct name
from ships s
join classes c
on (s.class=c.class)
where launched >=1922
and displacement>35000
and type = 'bb';

--36.Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes).
select name
from ships s
join classes c
on (s.name=c.class)
union
select ship
from outcomes o
join classes c
on (o.ship=c.class);

--37.Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes).
with shipes as (select c.class, name
from ships s
join classes c
on (c.class=s.class)
union
select c.class, ship
from Outcomes o
join classes c
on (c.class=o.ship)
)

select class
from shipes
group by class
having count (name)=1;

--38.Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc').
select country
from classes
where type = 'bb'
INTERSECT
select country
from classes
where type = 'bc';

--39.Найдите корабли, `сохранившиеся для будущих сражений`; т.е. выведенные из строя в одной битве (damaged), они участвовали в другой, произошедшей позже.
select distinct ship
from outcomes o
join battles b
on (o.battle=b.name)
where ship in (select ship 
from outcomes o
join battles ba
on (o.battle=ba.name)
where b.date <ba.date)
and result = 'damaged'

--42. Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены.
select ship, battle
from outcomes
where result = 'sunk';

--43.Укажите сражения, которые произошли в годы, не совпадающие ни с одним из годов спуска кораблей на воду.
select name
from battles
where DATEPART(YEAR, date) not in (select DATEPART(yy, date)
from battles join ships on DATEPART(yy, date)=launched);

--44. Найдите названия всех кораблей в базе данных, начинающихся с буквы R.
select name
from ships
where name like 'R%'
union
select ship
from outcomes
where ship like 'R%';

--45. Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V). Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов.
select name
from ships
where name like '% % %'
union
select ship
from outcomes
where ship like '% % %';

--46. Для каждого корабля, участвовавшего в сражении при Гвадалканале (Guadalcanal), вывести название, водоизмещение и число орудий.
select o.ship, displacement, numGuns
from (
select name as class, displacement, numGuns
from Classes c
join ships s
on (c.class=s.class)
union
select ship, displacement, numGuns
from Classes c
join outcomes o
on (c.class=o.ship)
) t1
right join outcomes o
on (t1.class=o.ship)
where battle = 'Guadalcanal';


--48. Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении.
select class
from classes c
join outcomes o
on (c.class=o.ship)
where result = 'sunk'
union
select class
from ships s
join outcomes o
on (s.name=o.ship)
where result = 'sunk';

--49. Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes).
select name
from classes c
join ships s
on (c.class=s.class)
where bore = 16
union
select ship
from classes c
join outcomes o
on (c.class=o.ship)
where bore = 16;

--50. Найдите сражения, в которых участвовали корабли класса Kongo из таблицы Ships.
select distinct battle
from  outcomes b
join ships s
on (b.ship=s.name)
where class = 'Kongo';

--52. Определить названия всех кораблей из таблицы Ships, которые могут быть линейным японским кораблем, имеющим число главных орудий не менее девяти, калибр орудий менее 19 дюймов и водоизмещение не более 65 тыс.тонн
select name
from ships s
join classes c on (s.class=c.class)
WHERE country = 'JAPAN' 
AND (numguns>=9 or numguns is NULL) 
AND (bore < 19 OR bore IS NULL) 
AND (displacement <= 65000 OR displacement IS NULL) 
AND type = 'bb';

--53. Определите среднее число орудий для классов линейных кораблей. Получить результат с точностью до 2-х десятичных знаков.
select cast (avg (numguns*1.0) as numeric (6,2))
from classes c
where type = 'bb';

--54. С точностью до 2-х десятичных знаков определите среднее число орудий всех линейных кораблей (учесть корабли из таблицы Outcomes).
select cast(avg(numguns*1.0)  as numeric (6,2))
from (
select name, class
from ships
union
select ship, ship
from outcomes ) t1
join classes c 
on (t1.class=c.class)
where type = 'bb';

--55. Для каждого класса определите год, когда был спущен на воду первый корабль этого класса. Если год спуска на воду головного корабля неизвестен, определите минимальный год спуска на воду кораблей этого класса. Вывести: класс, год.
select c.class, min (launched) yer
from ships s
full join classes c
on (c.class=s.class)
group by c.class;

--83.Определить названия всех кораблей из таблицы Ships, которые удовлетворяют, по крайней мере, комбинации любых четырёх критериев из следующего списка:
--numGuns = 8
--bore = 15
--displacement = 32000
--type = bb
--launched = 1915
--class=Kongo
--country=USA
select name 
from ships s 
join Classes c
on (s.class=c.class)
WHERE 
CASE WHEN numGuns = 8 THEN 1 ELSE 0 END +
CASE WHEN bore = 15 THEN 1 ELSE 0 END +
CASE WHEN displacement = 32000 THEN 1 ELSE 0 END +
CASE WHEN type = 'bb' THEN 1 ELSE 0 END +
CASE WHEN launched = 1915 THEN 1 ELSE 0 END +
CASE WHEN c.class='Kongo' THEN 1 ELSE 0 END +
CASE WHEN country='USA' THEN 1 ELSE 0 END >=4;

