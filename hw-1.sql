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
- ��������� � �������: �min = 20080, max = 40000�
, ��� 20080 � ��� ����������� �/�, � 40000 � ������������.
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
