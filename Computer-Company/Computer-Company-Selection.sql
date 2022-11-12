/*1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd*/
select model, speed, hd
from pc
where price<500;

/*2. Найдите производителей принтеров. Вывести: maker*/
select distinct maker
from product
where type = 'printer';

/*3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.*/
select model, ram, screen
from laptop
where price >1000;

/*4.  Найдите все записи таблицы Printer для цветных принтеров.*/
select *
from printer
where color = 'y';

/*5.  Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.*/
select model, speed, hd 
from pc 
where (cd = '12x' or cd = '24x') 
and price < 600;

/*6.Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.*/
select distinct  maker, speed
from product p
join laptop l
on (p.model=l.model)
where hd>=10;

/*7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).*/
select pr.model, price
from product pr
join pc p
on (pr.model=p.model)
where maker = 'B'
union
select pr.model, price
from product pr
join laptop l
on (pr.model=l.model)
where maker = 'B'
union
select pr.model, price
from product pr
join printer pri
on (pr.model=pri.model)
where maker = 'B'

/*8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.*/
select maker 
from product
where type = 'pc'
except 
select maker 
from product
where type = 'laptop';

/*9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
*/
select distinct maker
from pc p
join product pr
on(p.model=pr.model)
where speed>=450;

/*10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price*/
select model, price
from printer
where price = (select max(price)
                from printer);
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
--15.Найдите размеры жестких дисков, совпадающих у двух и более PC.
select hd
from pc
group by hd
having count(hd)>=2;

--14.Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
select distinct p.model, p2.model, p.speed, p.ram
from pc p, pc p2
where p.speed=p2.speed
and p.ram=p2.ram
and p.model>p2.model;

--15.Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК.
select distinct  type, l.model, speed
from  laptop l
join  product pr
on (l.model=pr.model)
where speed <all (select speed from pc);

--16.Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
select distinct  maker, price
from printer p
join product pr
on (p.model=pr.model)
where price in (select min (price) from printer where color = 'y')
and color = 'y';

--17.Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.Вывести: maker, средний размер экрана.
select maker, avg(screen)
from laptop l
join product pr
on (l.model=pr.model)
group by maker;

--18.Найдите производителей, выпускающих по меньшей мере три различных
select maker, count (pr.model)
from product pr
where type = 'pc'
group by maker
having count (pr.model)>=3;

--19.Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
select distinct maker, max(price)
from product pr
join pc p
on (pr.model=p.model)
where type = 'PC'
group by maker;

--20.Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же скоростью. Вывести: speed, средняя цена.
select speed, avg (price)
from pc
where speed>600
group by speed;


--21.Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и ПК-блокноты со скоростью не менее 750 МГц.
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

--22.Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции.
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


--23.Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
with model_pc as (select model 
from pc 
where ram in (select min(ram) from pc)
and speed in (select max(speed) from pc where ram in (select min(ram) from pc)))

select distinct maker
from product pr
where model in (select * from model_pc)
and maker in (select maker from product where type = 'printer');

--24.Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена.
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
from prices;

--25.Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. Вывести: maker, средний размер HD.
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
group by maker;

--26.Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
with t1 as  (select maker
from product
group by maker
having count (model)=1
)
select count(maker)
from t1;

--27.В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра). Вывод: номер модели, тип модели. В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра). Вывод: номер модели, тип модели.
select model, type
from product
where upper (model) not  like '%[^0-9]%'
or upper (model) not  like '%[^A-Z]%';

--28.Найти производителей, которые выпускают более одной модели, при этом все выпускаемые производителем модели являются продуктами одного типа. Вывести: maker, type
select maker, max(type) type
from product
group by maker
having count(model)>1
and count(distinct type)=1;

--29. Для каждого производителя, у которого присутствуют модели хотя бы в одной из таблиц PC, Laptop или Printer, определить максимальную цену на его продукцию.
--Вывод: имя производителя, если среди цен на продукцию данного производителя присутствует NULL, то выводить для этого производителя NULL, иначе максимальную цену.
with t1 as (select model, price
           from pc  union
select model, price from laptop
union
select model, price from printer)

select distinct p.maker,
case
when max(case when t1.price is null then 1 else 0 end)=0 then max(t1.price)
end
from product p
right join t1
on (p.model=t1.model)
group by maker;

--30. Найти производителей, у которых больше всего моделей в таблице Product, а также тех, у которых меньше всего моделей. Вывод: maker, число моделей
select maker, count(model) qty
from product
group by maker 
having count (model)>=all (select count(model) qty
                           from product
                           group by maker)
union
select maker, count(model) qty
from product
group by maker 
having count (model)<=all (select count(model) qty
                          from product
                          group by maker);
