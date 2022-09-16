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

--Найдите производителей, выпускающих по меньшей мере три различных
select maker, count (pr.model)
from product pr
where type = 'pc'
group by maker
having count (pr.model)>=3;