/*1. Используя функции, получите список всех сотрудников у которых в 
имени есть буква 'b' (без учета регистра).*/
select * 
from employees
where instr (lower(first_name), 'b')>0;

/*2. Используя функции, получите список всех сотрудников у которых в 
имени содержатся минимум 2 буквы 'a'.*/
select * 
from employees
where instr(lower (first_name), 'a', 1, 2)>0;

/*3. Получите первое слово из имени департамента, для тех
департаментов, у которых название состоит больше, чем из одного 
слова.*/
select substr(department_name, 1, instr(department_name, ' ') -1)
from departments
where instr (department_name, ' ')>0;

/*4.  Получите имена сотрудников без первой и последней буквы в имени.*/
select first_name, substr (first_name, 2, length(first_name)-2)
from employees;

/*5.  Получите список всех сотрудников, у которых в значении job_id после 
знака '_' как минимум 3 символа, но при этом это значение после '_' не 
равно 'CLERK'.*/
select *
from employees
where length (substr (job_id, instr(job_id, '_')+1))>3
and substr(job_id, instr(job_id, '_')+1)!= 'CLERK';

/*6.Получите список всех сотрудников, которые пришли на работу в 
первый день любого месяца.*/
select *
from employees
where to_char(hire_date, 'DD') = '01';

/*7. Получите список всех сотрудников, которые пришли на работу в 
1998ом году.*/
select * 
from employees
where to_char (hire_date, 'YYYY')='1998';

/*8. Покажите завтрашнюю дату в формате:
Tomorrow is Second day of January*/
select to_char (sysdate, 'fm"Tomorrow is "Ddspth "day of" Month')
from dual;

/*9. Выведите имя сотрудника и дату его прихода на работу в формате: 
21st of June, 2007*/
select first_name, to_char (hire_date, 'fmddth "of "Month, YYYY')
from employees;

/*10. Получите список работников с увеличенными зарплатами на 20%. 
Зарплату показать в формате: $28,800.00*/
select first_name, to_char (salary+salary*0.2, '$999,999.99')
from employees;

/*11. .Выведите актуальную дату (нынешнюю), + секунда, + минута, + час, + 
день, + месяц, + год. (Всё это по отдельности прибавляется к 
актуальной дате).*/
select sysdate, sysdate+1/(24*60*60) plus_sec, sysdate +1/(24*60) plus_min, sysdate+1/24 plus_hour, sysdate+1 plus_day,
add_months(sysdate, 1) plus_day, add_months(sysdate, 12) plus_year
from dual;

/*12. Выведите имя сотрудника, его з/п и новую з/п, которая равна старой 
плюс это значение текста «$12,345.55».*/
select first_name, salary, salary  + to_number ('$12,345.55', '$99,999.99')
from employees;

/*13. Выведите имя сотрудника, день его трудоустройства, а также 
количество месяцев между днём его трудоустройства и датой, которую 
необходимо получить из текста «SEP, 18:45:00 18 2009».*/
select months_between(to_date('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), hire_date)
from employees;

/*14. Выведите имя сотрудника, его з/п, а также полную з/п (salary + 
commission_pct(%)) в формате: $24,000.00 .*/
select first_name, salary, to_char (salary+salary*nvl(commission_pct,0), '$99,999.99')
from employees;

/*15. Выведите имя сотрудника, его фамилию, а также выражение «different 
length», если длина имени не равна длине фамилии или выражение 
«same length», если длина имени равна длине фамилии. Не 
используйте conditional functions.*/
select first_name, last_name, 
nvl2 (nullif (length(first_name), length(last_name)), 'different length', 'same length') 
from employees;

/*16. Выведите имя сотрудника, его комиссионные, а также информацию о 
наличии бонусов к зарплате – есть ли у него комиссионные (Yes/No).*/
select first_name, commission_pct, nvl2(commission_pct, 'Yes', 'No')
from employees;

/*17. Выведите имя сотрудника и значение которое его будет 
характеризовать: значение комиссионных, если присутствует, если нет, 
то id его менеджера, если и оно отсутствует, то его з/п.*/
select first_name, coalesce (commission_pct, manager_id, salary)
from employees;

/*18. Выведите имя сотрудника, его з/п, а также уровень зарплаты каждого 
сотрудника: Меньше 5000 считается Low level, Больше или равно 5000 
и меньше 10000 считается Normal level, Больше или равно 10000 
считается High level.*/
select first_name, salary, case
when salary<5000 then 'Low'
when salary>=5000 and salary <10000 then 'Normal level'
when salary>=10000 then 'High level'
END
from employees;

/*19. Для каждой страны показать регион, в котором она находится: 1-
Europe, 2-America, 3-Asia, 4-Africa . Выполнить данное задание, не 
используя функционал JOIN. Используйте DECODE.*/
select country_name, decode (region_id,
1, 'Europe',
2, 'America',
3, 'Asia',
4, 'Africa',
'unknown') region
from countries;

/*20. Задачу №19 решите используя CASE.*/
select country_name, case region_id
when 1 then 'Europe'
when 2 then 'America'
when 3 then 'Asia'
when 4 then 'Africa'
else 'unknown'
end
from countries;

/*21. Выведите имя сотрудника, его з/п, а также уровень того, насколько у 
сотрудника хорошие условия : 
- BAD: з/п меньше 10000 и отсутствие комиссионных;
- NORMAL: з/п между 10000 и 15000 или, если присутствуют 
комиссионные;
- GOOD: з/п больше или равна 15000.*/
select first_name, salary, case
when salary<10000 and commission_pct is null then 'BAD'
when salary between 10000 and 15000 or commission_pct is not null then 'NORMAL'
when salary >=15000 then 'GOOD'
end
from employees;

/*22.  Получить репорт по department_id с минимальной и максимальной 
зарплатой, с самой ранней и самой поздней датой прихода на работу и 
с количеством сотрудников. Сортировать по количеству сотрудников 
(по убыванию).*/
select min(salary), max(salary), min(hire_date), max(hire_date), count(employee_id)
from employees
group by department_id;

/*23.  Выведите информацию о первой букве имени сотрудника и количество 
имён, которые начинаются с этой буквы. Выводить строки для букв, где 
количество имён, начинающихся с неё больше 1. Сортировать по 
количеству.*/
select substr (first_name, 1, 1), count(*)
from employees
group by substr (first_name, 1, 1)
having count(*)>1
order by 2 desc;

/*24.  Выведите id департамента, з/п и количество сотрудников, которые 
работают в одном и том же департаменте и получают одинаковую 
зарплату.*/
select department_id, salary, count(employee_id)
from employees
group by department_id, salary;

/*25.   Выведите день недели и количество сотрудников, которых приняли на 
работу в этот день.*/
select to_char (hire_date, 'day'), count(*)
from employees
group by to_char (hire_date, 'day');

/*26.  Выведите id департаментов, в которых работает больше 30 
сотрудников и сумма их з/п-т больше 300000.*/
select department_id
from employees
group by department_id
having count(*)>30
and sum(salary)>300000;

/*27.  Из таблицы countries вывести все region_id, для которых сумма всех 
букв их стран больше 50ти.*/
select region_id
from countries
group by region_id
having sum(length(country_name))>50;

/*28.  Выведите информацию о job_id и округленную среднюю зарплату 
работников для каждого job_id.*/
select job_id, round(avg(salary))
from employees
group by job_id;

/*29.  Получить список id департаментов, в которых работают сотрудники
нескольких (>1) job_id.*/
select department_id
from employees
group by department_id
having count(distinct job_id)>1;

/*30.  Выведите информацию о department, job_id, максимальную и 
минимальную з/п для всех сочетаний department_id - job_id, где 
средняя з/п больше 10000.*/
select department_id, job_id, max(salary), min(salary)
from employees
group by department_id, job_id
having avg(salary)>10000;

/*31.  .Получить список manager_id, у которых средняя зарплата всех его 
подчиненных, не имеющих комиссионные, находится в промежутке от 
6000 до 9000*/
select manager_id
from employees
where commission_pct is null
group by manager_id
having avg(salary) between 6000 and 9000;

/*32.  Выведите округлённую до тысяч (не тысячных) максимальную зарплату 
среди всех средних зарплат по департаментам.*/
select round (avg(max(salary)), -3)
from employees
group by department_id;
