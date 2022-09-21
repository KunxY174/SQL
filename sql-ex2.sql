--11.Найдите среднюю скорость ПК.
select avg (speed)
from pc;

--12.Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
select avg(speed)
from laptop
where price >1000;

--13.Найдите среднюю скорость ПК, выпущенных производителем A.
select avg (speed)
from pc p
join product pr
on (p.model=pr.model)
where maker = 'A';

--14.Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
select s.class, name, country
from ships s
join classes c
on (s.class=c.class)
where numGuns>=10;

--15.Найдите размеры жестких дисков, совпадающих у двух и более PC.
select hd
from pc
group by hd
having count(hd)>=2;

--16.Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
select distinct p.model, p2.model, p.speed, p.ram
from pc p, pc p2
where p.speed=p2.speed
and p.ram=p2.ram
and p.model>p2.model;

--17.Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
select distinct  type, l.model, speed
from  laptop l
join  product pr
on (l.model=pr.model)
where speed <all (select speed from pc);

--18.Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
select distinct  maker, price
from printer p
join product pr
on (p.model=pr.model)
where price in (select min (price) from printer where color = 'y')
and color = 'y';

--19.Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.Вывести: maker, средний размер экрана.
select maker, avg(screen)
from laptop l
join product pr
on (l.model=pr.model)
group by maker;

--20.Найдите производителей, выпускающих по меньшей мере три различных
select maker, count (pr.model)
from product pr
where type = 'pc'
group by maker
having count (pr.model)>=3;

--21.Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
select distinct maker, max(price)
from product pr
join pc p
on (pr.model=p.model)
where type = 'PC'
group by maker;

--22.Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
select speed, avg (price)
from pc
where speed>600
group by speed;


--23.Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
select maker
from product pr
join pc p
on (pr.model=p.model)
where type = 'PC'
and speed >=750
intersect 
select maker
from product pr
join laptop l
on (pr.model=l.model)
where type = 'laptop'
and speed >=750;

--24.Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
with t1 as (select model, price 
from pc
union
select model, price
from laptop
union
select model, price
from printer)

select model 
from t1
where price in (select max(price) from t1);


--25.Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
with model_pc as (select model 
from pc 
where ram in (select min(ram) from pc)
and speed in (select max(speed) from pc where ram in (select min(ram) from pc)))

select distinct maker
from product pr
where model in (select * from model_pc)
and maker in (select maker from product where type = 'printer');

--26.Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.
with prices as (select price
from pc
join product pr
on (pc.model=pr.model)
where maker = 'A'
union all
select price
from laptop l
join product pr
on (l.model=pr.model)
where maker = 'A')

select avg(price)
from prices

--27.Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
with  makers as (select maker
from product
where type = 'pc'
intersect
select maker
from product
where type = 'printer'
)
select maker, avg (hd)
from pc
join product pr
on (pc.model=pr.model)
where maker in (select maker from makers)
group by maker

--28.Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
with t1 as  (select maker
from product
group by maker
having count (model)=1
)
select count(maker)
from t1

--29.В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.
select o.point, o.date, inc, out
from Outcome_o o
left join  Income_o  i
on(o.point=i.point)
and (o.date=i.date)
union
select i.point, i.date, inc, out
from Income_o i
left join Outcome_o o
on(i.point=o.point)
and (i.date=o.date)


--30.В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
--Вывод: point, date, суммарный расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).
with dohod as(select point, date, sum(out) out , null inc
from Outcome
group by point, date 
union 
select point, date, null out, sum(inc) inc
from Income
group by point, date)

select point, date, sum(out) out, sum(inc) inc
from dohod
group by point, date

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

--35.В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра). Вывод: номер модели, тип модели. В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра). Вывод: номер модели, тип модели.
select model, type
from product
where upper (model) not  like '%[^0-9]%'
or upper (model) not  like '%[^A-Z]%';

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

--40.Найти производителей, которые выпускают более одной модели, при этом все выпускаемые производителем модели являются продуктами одного типа. Вывести: maker, type
select maker, max(type) type
from product
group by maker
having count(model)>1
and count(distinct type)=1;

