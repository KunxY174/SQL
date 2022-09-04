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
- выражение в формате: «min = 20080, max = 40000»
, где 20080 – это минимальная з/п, а 40000 – максимальная.
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
