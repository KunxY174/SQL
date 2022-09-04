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
