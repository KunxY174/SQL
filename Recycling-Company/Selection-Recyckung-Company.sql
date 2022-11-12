--1.В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, расход). Использовать таблицы Income_o и Outcome_o.
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


--2.В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому пункту за каждую дату выполнения операций будет соответствовать одна строка.
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

--3. Посчитать остаток денежных средств на всех пунктах приема для базы данных с отчетностью не чаще одного раза в день.
select sum(coalesce(inc, 0))-sum(coalesce(out, 0)) qty
from income_o i
full join outcome_o o
on (i.point=o.point)
and (i.date=o.date);