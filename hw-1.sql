 /*1. �������� �������� ������� REGIONS, ��������� � ������ ���.*/
DESC hr.regions;

 /*2. �������� �������� ������� COUNTRIES, ��������� � ������ ���.*/
DESC hr.countries;

/*3. �������� �������� ������� JOBS, ��������� � �������� ���.*/
DESC hr.jobs;

/*4. �������� �������� ������� LOCATIONS, ��������� � �������� ���.*/
DESC hr.locations;

/*5. �������� ��� ���������� � ��������.*/
SELECT * 
FROM regions;

/*6. �������� ���������� � �����, id ������������, �������� � ������� 
��� ���� ����������.*/
SELECT first_name, department_id, salary, last_name 
FROM employees;

/*7. �������� ���������� � id ���������, ����������� ����� � ����, 
������� ���� �� ������ �� ��������������� ��� ���� ����������. 
�������, ������� ����� ��������� ���� �������� One week before hire
date.*/
SELECT employee_id, email, hire_date-7 AS "One week before hire date" 
FROM employees;

/*8. �������� ���������� � ���������� � �� ��������� � �������: 
Donald(SH_CLERK) . �������� ������� our_employees .*/
SELECT first_name || '(' || job_id || ')' our_employees
FROM employees;

/*9.  �������� ������ ���������� ��� ����� ����������.*/
SELECT DISTINCT first_name
FROM employees;

/*10.�������� ��������� ���������� �� ������� jobs: 
- job_title, 
- ��������� � �������: �min = 20080, max = 40000�, 
��� 20080 � ��� ����������� �/�, � 40000 � ������������.
�������� ���� ������� info.
- ������������ �/� � �������� ������� max,
- ����� �/�, ������� ����� ���������� new_salary � ����������� �� 
�������: max_salary*2-2000*/
SELECT job_title,  'min = ' || min_salary || ', max = ' || max_salary AS info, max_salary AS max, max_salary*2-2000 AS new_salary
FROM jobs;

/*11. �������� �� ����� ����������� �Peter's dog is very clever�, ��������� 
���� �� ���� ������ ������ � ���������� ���������.*/
SELECT 'Peter''s dog is very clever'
FROM dual;

/*12. �������� �� ����� ����������� �Peter's dog is very clever�, ���������, 
�������� �� ����������� �������, ������� ������ � ���������� 
���������.*/
SELECT q'<Peter's dog is very clever>'
FROM dual;

/*13. �������� �� ����� ���������� ����� � ����� ���� (1 ��� = 365.25 
����).*/
SELECT 100*365.25*24*60 
FROM dual;

/*14.�������� ������ ���� ����������� � ������ David.*/
SELECT * 
FROM employees
WHERE first_name = 'David';

/*15. �������� ������ ���� �����������, � ������� job_id ����� FI_ACCOUNT.*/
SELECT * 
FROM employees
WHERE job_id = 'FI_ACCOUNT';

/*16.  �������� ���������� � �����, �������, �/� � ������ ������������ 
��� ����������� �� 50�� ������������ � ���������, ������� 4000.*/
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 50
AND salary > 4000;

/*17. �������� ������ ���� �����������, ������� �������� ��� � 20�, ��� � 
30� ������������.*/
SELECT *
FROM employees
where department_id = 20 or department_id = 30;

/*18. �������� ������ ���� �����������, � ������� ������ � ��������� ����� 
� ����� ����� 'a'.*/
SELECT *
FROM employees
WHERE first_name like '_a%a';

/*19. �������� ������ ���� ����������� �� 50�� � �� 80�� ������������, � 
������� ���� �����(������������). ������������ ������ �� email
(������������ �������), ��������� ��� ���������� �����.*/
SELECT *
FROM employees
WHERE (department_id = 50 or department_id = 80)
AND commission_pct is not null
order by 4;

/*20. �������� ������ ���� �����������, � ������� � ����� ���������� 
������� 2 ����� 'n'.*/
SELECT * 
FROM employees
WHERE first_name like '%n%n%';

/*21. �������� ������ ���� �����������, � ������� ����� ����� ������ 4 
����. ������������ ������ �� ������ ������������ (��������� 
�������) ���, ����� �������� �null� ���� � ����� �����.*/
SELECT * 
FROM employees
WHERE first_name like '%_____%'
order by department_id desc nulls last;

/*22. �������� ������ ���� �����������, � ������� �������� ��������� � 
���������� �� 3000 �� 7000 (������������), ��� ������ 
(������������) � job_id ����� ��������� ���������: PU_CLERK, 
ST_MAN, ST_CLERK.*/
SELECT * 
FROM employees
WHERE salary between 3000 and 7000
AND commission_pct is null
AND job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

/*23. �������� ������ ���� ����������� � ������� � ����� ���������� 
������ '%'.*/
SELECT *
FROM employees
WHERE first_name like '%\%%' escape '\';

/*24. �������� ���������� � job_id, ����� � �/� ��� ����������, ������� 
id ������� ������ ��� ����� 120 � job_id �� ����� IT_PROG. 
������������ ������ �� job_id (������������ �������) � ������ 
(��������� �������).*/
SELECT job_id, first_name, salary
FROM employees
WHERE employee_id >= 120
AND job_id != 'IT_PROG';

/*25. �������� ������ ���� �����������, � ������� ����� ����� ������ 10 ����.*/
select * 
from employees
where length(first_name)>10;

/*26. �������� ������ ���� �����������, �������� ������� ������ 1000.*/
select *
from employees
where mod(salary, 1000)=0;

/*27. �������� ���������� ����� � ������ 3� ������� ����� ����������� ������ ����������, ���� ��� ����� ����������� � ����������.���.����.
select phone_number, substr (phone_number, 1, 3)*/
from employees
where phone_number like '___.___.____';

/*28.  �������� ������ ���� �����������, � ������� ��������� ����� � ����� ����� 'm' � ����� ����� ������ 5��.*/
select *
from employees
where substr (first_name, -1) = 'm'
and length (first_name)>5;

/*29.  �������� ���� ��������� �������.*/
select next_day (sysdate , 'FRIDAY') fri 
from dual;

/*30. �������� ������ ���� �����������, ������� �������� � �������� ������ 12 ��� � 6�� ������� (150 �������).*/
select * from employees
where   months_between (sysdate, hire_date)>150;

/*31. �������� ���������� �����, ������� � �������� PHONE_NUMBER ��� '.' �� '-'.*/
select replace(phone_number, '.', '-')
from employees;

/*32. �������� ���, email, job_id ��� ���� ���������� � �������: STEVEN sking Ad_Pres */
select upper (first_name), lower (email), initcap (job_id)
from employees;

/*33. �������� ���������� � ����� ��������� � ��� �/�, �� ��������� c����� || , � ����� ����: Steven24000 */
select concat (first_name, salary)
from employees;

/*34. �������� ���������� � ���� ����� ���������� �� ������, ���������� ���� ����� �� ������ �� ������ � ������ ��� ���� ����� �� ������. */
select hire_date, round (hire_date, 'MM'), trunc(hire_date, 'YYYY')
from employees;

/*35. �������� ���������� � ����� � ������� ���� ����������. ��� ������ �������� �� 10 �������� � ���� ����� ����� ������ 10, 
�� ���������� �� 10 �������� ������ $. ������� ������ �������� �� 15 �������� � ���� ����� ������� ������ 15,
�� ����� �������� ������� ������� ������ ! ������� ����������. */ 
select rpad (first_name, 10, $), lpad (last_name, 15, '!')
from employees;

/*36. �������� ��� ���������� � ������� ������ ����� �a� � ��� �����. */
select first_name, instr(first_name, 'a', 1, 2)
from employees;

/*37. �������� �� ����� ����� '!!!HELLO!! MY FRIEND!!!!!!!!' � ��� �� �����, �� ��� ������� ��������������� ���� � ������ � ����� ������. */
select '!!!HELLO!! MY FRIEND!!!!!!!!', trim ('!' from '!!!HELLO!! MY FRIEND!!!!!!!!')
from dual;

/*38. �������� ���������� �:
- �/� ���������,
- �/� ���������� �� ����������� 3.1415 ,
- ���������� �� ������ �������� ������� ����������� �/�-��, 
- ����� ���������� ����� �� ����������� �/�. */
select salary, salary*3.1415, round (salary*3.1415), trunc (salary*3.1415, -3)/1000
from employees;
/*39. .�������� ���������� �:
- ���� ����� ���������� �� ������,
- ����, ������� ���� ����� ��� ����, ����� �������� ���������� �� ������,
- ���� ���������� ��� � ������ �������� ���������� �� ������ */
select hire_date, add_months (hire_date, 6), last_day (hire_date)
from employees;


 
 
 
