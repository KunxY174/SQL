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
