 --1.  Получите описание таблицы REGIONS, используя её полное имя
DESC hr.regions;

--2.  Получите описание таблицы COUNTRIES, используя её полное имя.
DESC hr.countries;

--3. Получите описание таблицы JOBS, используя её короткое имя.
DESC hr.jobs;

--4. Получите описание таблицы LOCATIONS, используя её короткое имя
DESC hr.locations;

--5. Выведите всю информацию о регионах.
SELECT * 
FROM regions;

--6. Выведите информацию о имени, id департамента, зарплате и фамилии для всех работников.
SELECT first_name, department_id, salary, last_name 
FROM employees;

--7. Выведите информацию о id работника, электронной почте и дату, которая была за неделю до трудоустройства для всех работников. Столбец, который будет содержать дату назовите One week before hire date.
SELECT employee_id, email, hire_date-7 AS "One week before hire date" 
FROM employees;

--8. Выведите информацию о работниках с их позициями в формате: Donald(SH_CLERK) . Назовите столбец our_employees .
SELECT first_name || '(' || job_id || ')' our_employees
FROM employees;

--9.  Выведите список уникальных имён среди работников.
SELECT DISTINCT first_name
FROM employees;

--10.Выведите следующую информацию из таблицы jobs: 
-- job_title, 
-- выражение в формате: «min = 20080, max = 40000», где 20080 – это минимальная з/п, а 40000 – максимальная.
--Назовите этот столбец info.
-- максимальную з/п и назовите столбец max,
-- новую з/п, которая будет называться new_salary и вычисляться по формуле: max_salary*2-2000.
SELECT job_title,  'min = ' || min_salary || ', max = ' || max_salary AS info, max_salary AS max, max_salary*2-2000 AS new_salary
FROM jobs;

--11. Выведите на экран предложение «Peter's dog is very clever», используя одну из двух техник работы с одинарными кавычками.
SELECT 'Peter''s dog is very clever'
FROM dual;

--12. Выведите на экран количество минут в одном веке (1 год = 365.25 дней).
SELECT 100*365.25*24*60 
FROM dual;

--13.Получите список всех сотрудников с именем David
SELECT * 
FROM employees
WHERE first_name = 'David';

--14. Получите список всех сотрудников, у которых job_id равен FI_ACCOUNT.
SELECT * 
FROM employees
WHERE job_id = 'FI_ACCOUNT';

--15.  Выведите информацию о имени, фамилии, з/п и номере департамента для сотрудников из 50го департамента с зарплатой, большей 4000.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 50
AND salary > 4000;

--16. Получите список всех сотрудников, которые работают или в 20м, или в 30м департаменте.
SELECT *
FROM employees
where department_id = 20 or department_id = 30;

--17. Получите список всех сотрудников, у которых вторая и последняя буква в имени равна 'a'.
SELECT *
FROM employees
WHERE first_name like '_a%a';

--18. Получите список всех сотрудников из 50го и из 80го департамента, у которых есть бонус(комиссионные). Отсортируйте строки по email (возрастающий порядок), используя его порядковый номер.
SELECT *
FROM employees
WHERE (department_id = 50 or department_id = 80)
AND commission_pct is not null
order by 4;

--19. Получите список всех сотрудников, у которых в имени содержатся минимум 2 буквы 'n'.
SELECT * 
FROM employees
WHERE first_name like '%n%n%';

--20. Получить список всех сотрудников, у которых длина имени больше 4 букв. Отсортируйте строки по номеру департамента (убывающий порядок) так, чтобы значения “null” были в самом конце.
SELECT * 
FROM employees
WHERE first_name like '%_____%'
order by department_id desc nulls last;

--21. Получите список всех сотрудников, у которых зарплата находится в промежутке от 3000 до 7000 (включительно), нет бонуса (комиссионных) и job_id среди следующих вариантов: PU_CLERK, ST_MAN, ST_CLERK.
SELECT * 
FROM employees
WHERE salary between 3000 and 7000
AND commission_pct is null
AND job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

--22. Получите список всех сотрудников у которых в имени содержится символ '%'.
SELECT *
FROM employees
WHERE first_name like '%\%%' escape '\';

--23. Выведите информацию о job_id, имене и з/п для работников, рабочий id которых больше или равен 120 и job_id не равен IT_PROG. Отсортируйте строки по job_id (возрастающий порядок) и именам (убывающий порядок)
SELECT job_id, first_name, salary
FROM employees
WHERE employee_id >= 120
AND job_id != 'IT_PROG';

--24. Получите список всех сотрудников, у которых длина имени больше 10 букв.
select * 
from employees
where length(first_name)>10;

--25.  Получите список всех сотрудников, зарплата которых кратна 1000.
select *
from employees
where mod(salary, 1000)=0;

--26. Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника, если его номер представлен в формате ХХХ.ХХХ.ХХХХ .
select phone_number, substr (phone_number, 1, 3)*/
from employees
where phone_number like '___.___.____';

--27.  Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.
select *
from employees
where substr (first_name, -1) = 'm'
and length (first_name)>5;

--28.   Выведите дату следующей пятницы.
select next_day (sysdate , 'FRIDAY') fri 
from dual;

--29. Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).
select * from employees
where   months_between (sysdate, hire_date)>150;

--30. Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.
select replace(phone_number, '.', '-')
from employees;

--31. Выведите имя, email, job_id для всех работников в формате:  STEVEN sking Ad_Pres
select upper (first_name), lower (email), initcap (job_id)
from employees;

--32. Выведите информацию о имени работника и его з/п, не используя символ || , в таком виде: Steven24000
select concat (first_name, salary)
from employees;

--33. .Выведите информацию о дате приёма сотрудника на работу, округлённой дате приёма на работу до месяца и первом дне года приёма на работу.
select hire_date, round (hire_date, 'MM'), trunc(hire_date, 'YYYY')
from employees;

--34. .Выведите информацию о имени и фамилии всех работников. Имя должно состоять из 10 символов и если длина имени меньше 10, то дополняйте до 10 символов знаком $. Фамилия должна состоять из 15 символов и если длина фамилии меньше 15, то перед фамилией ставьте столько знаков ! сколько необходимо.
select rpad (first_name, 10, $), lpad (last_name, 15, '!')
from employees;

--35. Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени.
select first_name, instr(first_name, 'a', 1, 2)
from employees;

--36. Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст, но без символа восклицательный знак в начале и конце текста.
select '!!!HELLO!! MY FRIEND!!!!!!!!', trim ('!' from '!!!HELLO!! MY FRIEND!!!!!!!!')
from dual;

--37. Выведите информацию о:
-- з/п работника,
-- з/п умноженной на коэффициент 3.1415 ,
-- округлённый до целого значения вариант увеличенной з/п-ты, 
-- целое количество тысяч из увеличенной з/п.
select salary, salary*3.1415, round (salary*3.1415), trunc (salary*3.1415, -3)/1000
from employees;
--38. .Выведите информацию о:
-- дате приёма сотрудника на работу,
-- дате, которая была через пол года, после принятия сотрудника на работу,
-- дате последнего дня в месяце принятия сотрудника на работу
select hire_date, add_months (hire_date, 6), last_day (hire_date)
from employees;
--39. Используя функции, получите список всех сотрудников у которых в имени есть буква 'b' (без учета регистра).*/
select * 
from employees
where instr (lower(first_name), 'b')>0;

--40. Используя функции, получите список всех сотрудников у которых в имени содержатся минимум 2 буквы 'a'.
select * 
from employees
where instr(lower (first_name), 'a', 1, 2)>0;

--41. Получите первое слово из имени департамента, для тех департаментов, у которых название состоит больше, чем из одного слова.
select substr(department_name, 1, instr(department_name, ' ') -1)
from departments
where instr (department_name, ' ')>0;

--42.  Получите имена сотрудников без первой и последней буквы в имени.
select first_name, substr (first_name, 2, length(first_name)-2)
from employees;

--43.  Получите список всех сотрудников, у которых в значении job_id после знака '_' как минимум 3 символа, но при этом это значение после '_' не равно 'CLERK'.
select *
from employees
where length (substr (job_id, instr(job_id, '_')+1))>3
and substr(job_id, instr(job_id, '_')+1)!= 'CLERK';

--44.Получите список всех сотрудников, которые пришли на работу в первый день любого месяца.
select *
from employees
where to_char(hire_date, 'DD') = '01';

--45. Получите список всех сотрудников, которые пришли на работу в 1998ом году.
select * 
from employees
where to_char (hire_date, 'YYYY')='1998';

--46. Покажите завтрашнюю дату в формате: Tomorrow is Second day of January
select to_char (sysdate, 'fm"Tomorrow is "Ddspth "day of" Month')
from dual;

--47. Выведите имя сотрудника и дату его прихода на работу в формате: 21st of June, 2007
select first_name, to_char (hire_date, 'fmddth "of "Month, YYYY')
from employees;

--48. Получите список работников с увеличенными зарплатами на 20%. Зарплату показать в формате: $28,800.00
select first_name, to_char (salary+salary*0.2, '$999,999.99')
from employees;

--49. .Выведите актуальную дату (нынешнюю), + секунда, + минута, + час, + день, + месяц, + год. (Всё это по отдельности прибавляется к актуальной дате).
select sysdate, sysdate+1/(24*60*60) plus_sec, sysdate +1/(24*60) plus_min, sysdate+1/24 plus_hour, sysdate+1 plus_day,
add_months(sysdate, 1) plus_day, add_months(sysdate, 12) plus_year
from dual;

--50. Выведите имя сотрудника, его з/п и новую з/п, которая равна старой плюс это значение текста «$12,345.55».
select first_name, salary, salary  + to_number ('$12,345.55', '$99,999.99')
from employees;

--51. Выведите имя сотрудника, день его трудоустройства, а также количество месяцев между днём его трудоустройства и датой, которую необходимо получить из текста «SEP, 18:45:00 18 2009».
select months_between(to_date('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), hire_date)
from employees;

--52. Выведите имя сотрудника, его з/п, а также полную з/п (salary + commission_pct(%)) в формате: $24,000.00 .
select first_name, salary, to_char (salary+salary*nvl(commission_pct,0), '$99,999.99')
from employees;

--53. Выведите имя сотрудника, его фамилию, а также выражение «different length», если длина имени не равна длине фамилии или выражение 
--«same length», если длина имени равна длине фамилии. Не используйте conditional functions.
select first_name, last_name, 
nvl2 (nullif (length(first_name), length(last_name)), 'different length', 'same length') 
from employees;

--53. Выведите имя сотрудника, его комиссионные, а также информацию о наличии бонусов к зарплате – есть ли у него комиссионные (Yes/No).
select first_name, commission_pct, nvl2(commission_pct, 'Yes', 'No')
from employees;

--54. Выведите имя сотрудника и значение которое его будет характеризовать: значение комиссионных, если присутствует, если нет, то id его менеджера, если и оно отсутствует, то его з/п.
select first_name, coalesce (commission_pct, manager_id, salary)
from employees;

--55. Выведите имя сотрудника, его з/п, а также уровень зарплаты каждого сотрудника: Меньше 5000 считается Low level, Больше или равно 5000 
--и меньше 10000 считается Normal level, Больше или равно 10000 
--считается High level.
select first_name, salary, case
when salary<5000 then 'Low'
when salary>=5000 and salary <10000 then 'Normal level'
when salary>=10000 then 'High level'
END
from employees;

--56. Для каждой страны показать регион, в котором она находится: 1-Europe, 2-America, 3-Asia, 4-Africa . Выполнить данное задание, не используя функционал JOIN. Используйте DECODE.
select country_name, decode (region_id,
1, 'Europe',
2, 'America',
3, 'Asia',
4, 'Africa',
'unknown') region
from countries;

--57. Задачу №56 решите используя CASE.
select country_name, case region_id
when 1 then 'Europe'
when 2 then 'America'
when 3 then 'Asia'
when 4 then 'Africa'
else 'unknown'
end
from countries;
--58. Выведите имя сотрудника, его з/п, а также уровень того, насколько у 
--сотрудника хорошие условия : 
--- BAD: з/п меньше 10000 и отсутствие комиссионных;
--- NORMAL: з/п между 10000 и 15000 или, если присутствуют комиссионные;
--- GOOD: з/п больше или равна 15000.
select first_name, salary, case
when salary<10000 and commission_pct is null then 'BAD'
when salary between 10000 and 15000 or commission_pct is not null then 'NORMAL'
when salary >=15000 then 'GOOD'
end
from employees;

--59.  Получить репорт по department_id с минимальной и максимальной зарплатой, с самой ранней и самой поздней датой прихода на работу и с количеством сотрудников. Сортировать по количеству сотрудников (по убыванию).
select min(salary), max(salary), min(hire_date), max(hire_date), count(employee_id)
from employees
group by department_id;

--60.  Выведите информацию о первой букве имени сотрудника и количество имён, которые начинаются с этой буквы. Выводить строки для букв, где 
--количество имён, начинающихся с неё больше 1. Сортировать по количеству.
select substr (first_name, 1, 1), count(*)
from employees
group by substr (first_name, 1, 1)
having count(*)>1
order by 2 desc;

--61.  Выведите id департамента, з/п и количество сотрудников, которые работают в одном и том же департаменте и получают одинаковую зарплату.
select department_id, salary, count(employee_id)
from employees
group by department_id, salary;

--62.   Выведите день недели и количество сотрудников, которых приняли на работу в этот день.
select to_char (hire_date, 'day'), count(*)
from employees
group by to_char (hire_date, 'day');

--63.  Выведите id департаментов, в которых работает больше 30 сотрудников и сумма их з/п-т больше 300000.*/
select department_id
from employees
group by department_id
having count(*)>30
and sum(salary)>300000;

--64.  Из таблицы countries вывести все region_id, для которых сумма всех букв их стран больше 50ти.
select region_id
from countries
group by region_id
having sum(length(country_name))>50;

--65.  Выведите информацию о job_id и округленную среднюю зарплату работников для каждого job_id.
select job_id, round(avg(salary))
from employees
group by job_id;

--66.  Получить список id департаментов, в которых работают сотрудники нескольких (>1) job_id.
select department_id
from employees
group by department_id
having count(distinct job_id)>1;

--67.  Выведите информацию о department, job_id, максимальную и минимальную з/п для всех сочетаний department_id - job_id, где средняя з/п больше 10000.
select department_id, job_id, max(salary), min(salary)
from employees
group by department_id, job_id
having avg(salary)>10000;

--67.  .Получить список manager_id, у которых средняя зарплата всех его подчиненных, не имеющих комиссионные, находится в промежутке от 6000 до 9000
select manager_id
from employees
where commission_pct is null
group by manager_id
having avg(salary) between 6000 and 9000;

--68.  Выведите округлённую до тысяч (не тысячных) максимальную зарплату среди всех средних зарплат по департаментам.
select round (avg(max(salary)), -3)
from employees
group by department_id;

--69.  Выведите информацию о регионах и кол-ве сотрудников в каждом регионе
select region_name, count(employee_id)
from employees e
join departments d
on (e.department_id=d.department_id)
join locations l
on (d.location_id=l.location_id)
join countries c
on (l.country_id=c.country_id)
join regions r
on (c.region_id=r.region_id)
group by region_name;

--70.  Выведите детальную информацию о каждом сотруднике (фамилия, имя , название департамента, джоб айди, адрес, страна и регион).*/
select first_name, last_name, department_name, job_id, street_address, country_name, region_name
from employees e
join departments d
on (e.department_id=d.department_id)
join locations l
on (d.location_id=l.location_id)
join countries c
on (l.country_id=c.country_id)
join regions r
on (c.region_id=r.region_id);

--71.  Выведите информацию о имени менеджеров которые имеют в подчинении >6 сотрудников, а так же выведете кол-во сотрудников которые им подчиняются.
select m.first_name, count (*)
from employees em
join employees m
on(em.manager_id=m.employee_id)
group by m.first_name
having count(*)>6;

--72.  Выведите информацию о названии всех департаментов и о кол-ве работников, если в департаменте работают > 30 сотрудников используйте технологию Юзинг для объединения по id департамента.
select department_name, count(*)
from employees e
join departments d
using (department_id)
group by department_name
having count(*)>30;
--72.  Выведите название всех департаментов в которых нет ни одного сотрудника.
select department_name
from employees e
right join departments d
on (e.department_id=d.department_id)
where employee_id is null;

--73.  Выведите всю информацию о сотрудниках менеджеры которых устроились на работу в 2005 году, но при этом сами работники устроились на работу до 1989 года.
select e.*
from employees e
join employees m
on (e.manager_id=m.employee_id)
where to_char(m.hire_date, 'YYYY')='1989'
and e.hire_date<to_date ('01-01-1989', 'DD-MM-YYYY');

--74.  Выведете название страны и название региона этой страны, используя Натурал джоин.
select country_name, region_name
from countries
natural join regions;

--75.  Выведете фамилии , имена и зп сотрудников которые получают меньше чем минимальная зп по специальности + 1000.
select last_name, first_name, salary
from employees e
join jobs j
on(e.job_id=j.job_id
and salary<min_salary+1000);

--76.  Выведите уникальные имена и фамилии, названия стран сотрудников в которых они работают, так же выведете информацию о сотрудниках о странах которых нет информации,
--а так же выведите все страны в которых нет сотрудников компании.
select distinct first_name, last_name, country_name
from employees e
full outer join departments d
on (e.department_id=d.department_id)
full outer join locations l
on (d.location_id=l.location_id)
full outer join countries c
on (l.country_id=c.country_id);

--77.  Выведите имена и фамилии всех сотрудников , а так же названия стран 
которые мы получаем при объединении работников со всеми странами, без какой либо логики.*/
select first_name, last_name, country_name
from employees
cross join countries;

--78.  Решите задачу №69 используя оракл джоин синтаксис.
select region_name, count(*)
from employees e, departments d, locations l, countries c, regions r
where (e.department_id=d.department_id and d.location_id=l.location_id 
and l.country_id=c.country_id and c.region_id=r.region_id)
group by region_name;
/*44.  Решите задачу №5 используя оракл джоин синтаксис.*/
select department_name
from employees e, departments d
where e.department_id(+)=d.department_id
and first_name is null;

--79. Выведите всю информацию о сотрудниках, с самым длинным именем.
select *
from employees
where length(first_name) in (select max (length(first_name)) from employees);

--80.  Выведите всю информацию о сотрудниках, с зарплатой большей средней зарплаты всех сотрудников.
select *
from employees
where salary > (select avg(salary) from employees);

--81.  Получить город/города, где сотрудники в сумме зарабатывают меньше всего.
select city
from employees e
join departments d
 on (e.department_id=d.department_id)
join locations l
on (l.location_id=d.location_id)
group by city
having  sum(salary) in (select min(sum(salary))
                        from employees e
                        join departments d
                         on (e.department_id=d.department_id)
                         join locations l
                         on (l.location_id=d.location_id)
                          group by city);

--82.  Выведите всю информацию о сотрудниках, у которых менеджер получает зарплату больше 15000.
select *
from employees
where manager_id in (select employee_id from employees
                    where salary>15000);

--83.  Выведите всю информацию о департаментах, в которых нет ни одного сотрудника.
select *
from departments
where department_id not in (select distinct department_id from employees 
                             where department_id is not null);

--84.  Выведите всю информацию о сотрудниках, которые не являются менеджерами.
select * 
from employees e
where employee_id not in (select distinct manager_id
                           from employees
                        where manager_id is not null);

--85.  Выведите всю информацию о менеджерах, которые имеют в подчинении больше 6ти сотрудников.
select * 
from employees 
where (select count(*) from employees
       where manager_id=e.employee_id)>6;

--86.  Выведите всю информацию о сотрудниках, которые работают в департаменте с названием IT.
select *
from employees
where department_id in (select department_id
                         from departments
                        where department_name = 'IT');
                        
--87.  Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в 2005 ом году, но при это сами работники устроились на работу до 2005 года..
select *
from employees
where manager_id in (select employee_id from employees
                     where to_char (hire_date, 'YYYY')= '2005'
                     and hire_date < to_date ('01-01-2005', 'DD-MM-YYYY'));
--88.  Выведите всю информацию о сотрудниках, менеджеры которых устроились на работу в январе любого года, и длина job_title этих сотрудников больше 15ти символов.
select * 
from employees e
where manager_id in (select employee_id
                    from employees
                    where to_char(hire_date, 'MM')='01')
                    and (select length(job_title)
                        from jobs
                        where job_id = e.job_id)>15;
--89.  Выведите в одном репорте информацию о суммах з/п групп, объединённых по id менеджера, по job_id, по id департамента. Репорт должен содержать 4 столбца: id менеджера, job_id, id департамента, суммированная з/п.
select manager_id, to_char(null) job_id, to_number(null) department_id, sum(salary)
from employees
group by manager_id
union
select to_number(null), job_id, to_number(null) , sum(salary)
from employees
group by job_id
union
select to_number(null), to_char(null), department_id, sum(salary)
from employees
group by department_id;

--90. Выведите id тех департаментов, где работает менеджер № 100 и не работают менеджеры № 145, 201
select department_id  
from employees
where manager_id=100
minus
select department_id  
from employees
where manager_id in (145, 201);

--91. Используя SET операторы и не используя логические операторы, выведите уникальную информацию о именах, фамилиях и з/п сотрудников, второй символ в именах которых буква «а», и фамилия содержит букву «s» вне зависимости от регистра. Отсортируйте результат по з/п по убыванию.
select first_name, last_name, salary 
from employees
where first_name like '_a%'
INTERSECT
select first_name, last_name, salary
from employees
where lower(first_name) like '%s%'
order by salary desc;

--92.  Используя SET операторы и не используя логические операторы, выведите информацию о id локаций, почтовом коде и городе для локаций, которые находятся в Италии или Германии. А также для локаций, почтовый код которых содержит цифру «9».
select location_id, postal_code, city
from locations
where country_id in (select country_id from countries
                    where country_name in ('Italy', 'Germany'))
union all
select location_id, postal_code, city
from locations 
where postal_code like '%9%';

--93.  Используя SET операторы и не используя логические операторы, выведите всю уникальную информацию для стран, длина имён которых больше 8 символов. А также для стран, которые находятся не в европейском регионе. Столбцы аутпута должны называться id, country, region. Аутпут отсортируйте по названию стран по убывающей
select country_id id, country_name country, region_id region
from countries
where length(country_name)>8
union
select country_id, country_name, region_id
from countries
where region_id != (select region_id from regions
                     where region_name = 'Europe')
order by country desc;