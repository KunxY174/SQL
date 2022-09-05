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
? BAD: з/п меньше 10000 и отсутствие комиссионных;
? NORMAL: з/п между 10000 и 15000 или, если присутствуют 
комиссионные;
? GOOD: з/п больше или равна 15000.*/
select first_name, salary, case
when salary<10000 and commission_pct is null then 'BAD'
when salary between 10000 and 15000 or commission_pct is not null then 'NORMAL'
when salary >=15000 then 'GOOD'
end
from employees;