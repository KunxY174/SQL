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

/*6.Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, 
найти скорости таких ПК-блокнотов. Вывод: производитель, скорость*/
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

/*9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker*/
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