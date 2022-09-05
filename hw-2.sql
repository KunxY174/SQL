/*1. ��������� �������, �������� ������ ���� ����������� � ������� � 
����� ���� ����� 'b' (��� ����� ��������).*/
select * 
from employees
where instr (lower(first_name), 'b')>0;

/*2. ��������� �������, �������� ������ ���� ����������� � ������� � 
����� ���������� ������� 2 ����� 'a'.*/
select * 
from employees
where instr(lower (first_name), 'a', 1, 2)>0;

/*3. �������� ������ ����� �� ����� ������������, ��� ���
�������������, � ������� �������� ������� ������, ��� �� ������ 
�����.*/
select substr(department_name, 1, instr(department_name, ' ') -1)
from departments
where instr (department_name, ' ')>0;

/*4.  �������� ����� ����������� ��� ������ � ��������� ����� � �����.*/
select first_name, substr (first_name, 2, length(first_name)-2)
from employees;

/*5.  �������� ������ ���� �����������, � ������� � �������� job_id ����� 
����� '_' ��� ������� 3 �������, �� ��� ���� ��� �������� ����� '_' �� 
����� 'CLERK'.*/
select *
from employees
where length (substr (job_id, instr(job_id, '_')+1))>3
and substr(job_id, instr(job_id, '_')+1)!= 'CLERK';

/*6.�������� ������ ���� �����������, ������� ������ �� ������ � 
������ ���� ������ ������.*/
select *
from employees
where to_char(hire_date, 'DD') = '01';

/*7. �������� ������ ���� �����������, ������� ������ �� ������ � 
1998�� ����.*/
select * 
from employees
where to_char (hire_date, 'YYYY')='1998';

/*8. �������� ���������� ���� � �������:
Tomorrow is Second day of January*/
select to_char (sysdate, 'fm"Tomorrow is "Ddspth "day of" Month')
from dual;

/*9. �������� ��� ���������� � ���� ��� ������� �� ������ � �������: 
21st of June, 2007*/
select first_name, to_char (hire_date, 'fmddth "of "Month, YYYY')
from employees;

/*10. �������� ������ ���������� � ������������ ���������� �� 20%. 
�������� �������� � �������: $28,800.00*/
select first_name, to_char (salary+salary*0.2, '$999,999.99')
from employees;

/*11. .�������� ���������� ���� (��������), + �������, + ������, + ���, + 
����, + �����, + ���. (�� ��� �� ����������� ������������ � 
���������� ����).*/
select sysdate, sysdate+1/(24*60*60) plus_sec, sysdate +1/(24*60) plus_min, sysdate+1/24 plus_hour, sysdate+1 plus_day,
add_months(sysdate, 1) plus_day, add_months(sysdate, 12) plus_year
from dual;

/*12. �������� ��� ����������, ��� �/� � ����� �/�, ������� ����� ������ 
���� ��� �������� ������ �$12,345.55�.*/
select first_name, salary, salary  + to_number ('$12,345.55', '$99,999.99')
from employees;

/*13. �������� ��� ����������, ���� ��� ���������������, � ����� 
���������� ������� ����� ��� ��� ��������������� � �����, ������� 
���������� �������� �� ������ �SEP, 18:45:00 18 2009�.*/
select months_between(to_date('SEP, 18:45:00 18 2009', 'MON, HH24:MI:SS DD YYYY'), hire_date)
from employees;

/*14. �������� ��� ����������, ��� �/�, � ����� ������ �/� (salary + 
commission_pct(%)) � �������: $24,000.00 .*/
select first_name, salary, to_char (salary+salary*nvl(commission_pct,0), '$99,999.99')
from employees;

/*15. �������� ��� ����������, ��� �������, � ����� ��������� �different 
length�, ���� ����� ����� �� ����� ����� ������� ��� ��������� 
�same length�, ���� ����� ����� ����� ����� �������. �� 
����������� conditional functions.*/
select first_name, last_name, 
nvl2 (nullif (length(first_name), length(last_name)), 'different length', 'same length') 
from employees;

/*16. �������� ��� ����������, ��� ������������, � ����� ���������� � 
������� ������� � �������� � ���� �� � ���� ������������ (Yes/No).*/
select first_name, commission_pct, nvl2(commission_pct, 'Yes', 'No')
from employees;

/*17. �������� ��� ���������� � �������� ������� ��� ����� 
���������������: �������� ������������, ���� ������������, ���� ���, 
�� id ��� ���������, ���� � ��� �����������, �� ��� �/�.*/
select first_name, coalesce (commission_pct, manager_id, salary)
from employees;

/*18. �������� ��� ����������, ��� �/�, � ����� ������� �������� ������� 
����������: ������ 5000 ��������� Low level, ������ ��� ����� 5000 
� ������ 10000 ��������� Normal level, ������ ��� ����� 10000 
��������� High level.*/
select first_name, salary, case
when salary<5000 then 'Low'
when salary>=5000 and salary <10000 then 'Normal level'
when salary>=10000 then 'High level'
END
from employees;

/*19. ��� ������ ������ �������� ������, � ������� ��� ���������: 1-
Europe, 2-America, 3-Asia, 4-Africa . ��������� ������ �������, �� 
��������� ���������� JOIN. ����������� DECODE.*/
select country_name, decode (region_id,
1, 'Europe',
2, 'America',
3, 'Asia',
4, 'Africa',
'unknown') region
from countries;

/*20. ������ �19 ������ ��������� CASE.*/
select country_name, case region_id
when 1 then 'Europe'
when 2 then 'America'
when 3 then 'Asia'
when 4 then 'Africa'
else 'unknown'
end
from countries;

/*21. �������� ��� ����������, ��� �/�, � ����� ������� ����, ��������� � 
���������� ������� ������� : 
? BAD: �/� ������ 10000 � ���������� ������������;
? NORMAL: �/� ����� 10000 � 15000 ���, ���� ������������ 
������������;
? GOOD: �/� ������ ��� ����� 15000.*/
select first_name, salary, case
when salary<10000 and commission_pct is null then 'BAD'
when salary between 10000 and 15000 or commission_pct is not null then 'NORMAL'
when salary >=15000 then 'GOOD'
end
from employees;