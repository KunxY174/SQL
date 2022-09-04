 /*1. Получите описание таблицы REGIONS, используя её полное имя.*/
DESC hr.regions;

 /*2. Получите описание таблицы COUNTRIES, используя её полное имя.*/
DESC hr.countries;

/*3. Получите описание таблицы JOBS, используя её короткое имя.*/
DESC hr.jobs;

/*4. Получите описание таблицы LOCATIONS, используя её короткое имя.*/
DESC hr.locations;

/*5. Выведите всю информацию о регионах.*/
SELECT * 
FROM regions;

/*6. Выведите информацию о имени, id департамента, зарплате и фамилии 
для всех работников.*/
SELECT first_name, department_id, salary, last_name 
FROM employees;

/*7. Выведите информацию о id работника, электронной почте и дату, 
которая была за неделю до трудоустройства для всех работников. 
Столбец, который будет содержать дату назовите One week before hire
date.*/
SELECT employee_id, email, hire_date-7 AS "One week before hire date" 
FROM employees;

/*8. Выведите информацию о работниках с их позициями в формате: 
Donald(SH_CLERK) . Назовите столбец our_employees .*/
SELECT first_name || '(' || job_id || ')' our_employees
FROM employees;

/*9.  Выведите список уникальных имён среди работников.*/
SELECT DISTINCT first_name
FROM employees;

/*10.Выведите следующую информацию из таблицы jobs: 
- job_title, 
- выражение в формате: «min = 20080, max = 40000», 
где 20080 – это минимальная з/п, а 40000 – максимальная.
Назовите этот столбец info.
- максимальную з/п и назовите столбец max,
- новую з/п, которая будет называться new_salary и вычисляться по 
формуле: max_salary*2-2000*/
SELECT job_title,  'min = ' || min_salary || ', max = ' || max_salary AS info, max_salary AS max, max_salary*2-2000 AS new_salary
FROM jobs;

/*11. Выведите на экран предложение «Peter's dog is very clever», используя 
одну из двух техник работы с одинарными кавычками.*/
SELECT 'Peter''s dog is very clever'
FROM dual;

/*12. Выведите на экран предложение «Peter's dog is very clever», используя, 
отличную от предыдущего примера, технику работы с одинарными 
кавычками.*/
SELECT q'<Peter's dog is very clever>'
FROM dual;

/*13. Выведите на экран количество минут в одном веке (1 год = 365.25 
дней).*/
SELECT 100*365.25*24*60 
FROM dual;

/*14.Получите список всех сотрудников с именем David.*/
SELECT * 
FROM employees
WHERE first_name = 'David';

/*15. Получите список всех сотрудников, у которых job_id равен FI_ACCOUNT.*/
SELECT * 
FROM employees
WHERE job_id = 'FI_ACCOUNT';

/*16.  Выведите информацию о имени, фамилии, з/п и номере департамента 
для сотрудников из 50го департамента с зарплатой, большей 4000.*/
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 50
AND salary > 4000;

/*17. Получите список всех сотрудников, которые работают или в 20м, или в 
30м департаменте.*/
SELECT *
FROM employees
where department_id = 20 or department_id = 30;

/*18. Получите список всех сотрудников, у которых вторая и последняя буква 
в имени равна 'a'.*/
SELECT *
FROM employees
WHERE first_name like '_a%a';

/*19. Получите список всех сотрудников из 50го и из 80го департамента, у 
которых есть бонус(комиссионные). Отсортируйте строки по email
(возрастающий порядок), используя его порядковый номер.*/
SELECT *
FROM employees
WHERE (department_id = 50 or department_id = 80)
AND commission_pct is not null
order by 4;

/*20. Получите список всех сотрудников, у которых в имени содержатся 
минимум 2 буквы 'n'.*/
SELECT * 
FROM employees
WHERE first_name like '%n%n%';

/*21. Получить список всех сотрудников, у которых длина имени больше 4 
букв. Отсортируйте строки по номеру департамента (убывающий 
порядок) так, чтобы значения “null” были в самом конце.*/
SELECT * 
FROM employees
WHERE first_name like '%_____%'
order by department_id desc nulls last;

/*22. Получите список всех сотрудников, у которых зарплата находится в 
промежутке от 3000 до 7000 (включительно), нет бонуса 
(комиссионных) и job_id среди следующих вариантов: PU_CLERK, 
ST_MAN, ST_CLERK.*/
SELECT * 
FROM employees
WHERE salary between 3000 and 7000
AND commission_pct is null
AND job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

/*23. Получите список всех сотрудников у которых в имени содержится 
символ '%'.*/
SELECT *
FROM employees
WHERE first_name like '%\%%' escape '\';

/*24. Выведите информацию о job_id, имене и з/п для работников, рабочий 
id которых больше или равен 120 и job_id не равен IT_PROG. 
Отсортируйте строки по job_id (возрастающий порядок) и именам 
(убывающий порядок).*/
SELECT job_id, first_name, salary
FROM employees
WHERE employee_id >= 120
AND job_id != 'IT_PROG';

/*25. Получите список всех сотрудников, у которых длина имени больше 10 букв.*/
select * 
from employees
where length(first_name)>10;

/*26. Получите список всех сотрудников, зарплата которых кратна 1000.*/
select *
from employees
where mod(salary, 1000)=0;

/*27. Выведите телефонный номер и первое 3х значное число телефонного номера сотрудника, если его номер представлен в форматеХХХ.ХХХ.ХХХХ.
select phone_number, substr (phone_number, 1, 3)*/
from employees
where phone_number like '___.___.____';

/*28.  Получите список всех сотрудников, у которых последняя буква в имени равна 'm' и длина имени больше 5ти.*/
select *
from employees
where substr (first_name, -1) = 'm'
and length (first_name)>5;

/*29.  Выведите дату следующей пятницы.*/
select next_day (sysdate , 'FRIDAY') fri 
from dual;

/*30. Получите список всех сотрудников, которые работают в компании больше 12 лет и 6ти месяцев (150 месяцев).*/
select * from employees
where   months_between (sysdate, hire_date)>150;

/*31. Выведите телефонный номер, заменив в значении PHONE_NUMBER все '.' на '-'.*/
select replace(phone_number, '.', '-')
from employees;

/*32. Выведите имя, email, job_id для всех работников в формате: STEVEN sking Ad_Pres */
select upper (first_name), lower (email), initcap (job_id)
from employees;

/*33. Выведите информацию о имени работника и его з/п, не используя cимвол || , в таком виде: Steven24000 */
select concat (first_name, salary)
from employees;

/*34. Выведите информацию о дате приёма сотрудника на работу, округлённой дате приёма на работу до месяца и первом дне года приёма на работу. */
select hire_date, round (hire_date, 'MM'), trunc(hire_date, 'YYYY')
from employees;

/*35. Выведите информацию о имени и фамилии всех работников. Имя должно состоять из 10 символов и если длина имени меньше 10, 
то дополняйте до 10 символов знаком $. Фамилия должна состоять из 15 символов и если длина фамилии меньше 15,
то перед фамилией ставьте столько знаков ! сколько необходимо. */ 
select rpad (first_name, 10, $), lpad (last_name, 15, '!')
from employees;

/*36. Выведите имя сотрудника и позицию второй буквы ‘a’ в его имени. */
select first_name, instr(first_name, 'a', 1, 2)
from employees;

/*37. Выведите на экран текст '!!!HELLO!! MY FRIEND!!!!!!!!' и тот же текст, но без символа восклицательный знак в начале и конце текста. */
select '!!!HELLO!! MY FRIEND!!!!!!!!', trim ('!' from '!!!HELLO!! MY FRIEND!!!!!!!!')
from dual;

/*38. Выведите информацию о:
- з/п работника,
- з/п умноженной на коэффициент 3.1415 ,
- округлённый до целого значения вариант увеличенной з/п-ты, 
- целое количество тысяч из увеличенной з/п. */
select salary, salary*3.1415, round (salary*3.1415), trunc (salary*3.1415, -3)/1000
from employees;
/*39. .Выведите информацию о:
- дате приёма сотрудника на работу,
- дате, которая была через пол года, после принятия сотрудника на работу,
- дате последнего дня в месяце принятия сотрудника на работу */
select hire_date, add_months (hire_date, 6), last_day (hire_date)
from employees;


 
 
 
