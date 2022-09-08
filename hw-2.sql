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
- BAD: �/� ������ 10000 � ���������� ������������;
- NORMAL: �/� ����� 10000 � 15000 ���, ���� ������������ 
������������;
- GOOD: �/� ������ ��� ����� 15000.*/
select first_name, salary, case
when salary<10000 and commission_pct is null then 'BAD'
when salary between 10000 and 15000 or commission_pct is not null then 'NORMAL'
when salary >=15000 then 'GOOD'
end
from employees;

/*22.  �������� ������ �� department_id � ����������� � ������������ 
���������, � ����� ������ � ����� ������� ����� ������� �� ������ � 
� ����������� �����������. ����������� �� ���������� ����������� 
(�� ��������).*/
select min(salary), max(salary), min(hire_date), max(hire_date), count(employee_id)
from employees
group by department_id;

/*23.  �������� ���������� � ������ ����� ����� ���������� � ���������� 
���, ������� ���������� � ���� �����. �������� ������ ��� ����, ��� 
���������� ���, ������������ � �� ������ 1. ����������� �� 
����������.*/
select substr (first_name, 1, 1), count(*)
from employees
group by substr (first_name, 1, 1)
having count(*)>1
order by 2 desc;

/*24.  �������� id ������������, �/� � ���������� �����������, ������� 
�������� � ����� � ��� �� ������������ � �������� ���������� 
��������.*/
select department_id, salary, count(employee_id)
from employees
group by department_id, salary;

/*25.   �������� ���� ������ � ���������� �����������, ������� ������� �� 
������ � ���� ����.*/
select to_char (hire_date, 'day'), count(*)
from employees
group by to_char (hire_date, 'day');

/*26.  �������� id �������������, � ������� �������� ������ 30 
����������� � ����� �� �/�-� ������ 300000.*/
select department_id
from employees
group by department_id
having count(*)>30
and sum(salary)>300000;

/*27.  �� ������� countries ������� ��� region_id, ��� ������� ����� ���� 
���� �� ����� ������ 50��.*/
select region_id
from countries
group by region_id
having sum(length(country_name))>50;

/*28.  �������� ���������� � job_id � ����������� ������� �������� 
���������� ��� ������� job_id.*/
select job_id, round(avg(salary))
from employees
group by job_id;

/*29.  �������� ������ id �������������, � ������� �������� ����������
���������� (>1) job_id.*/
select department_id
from employees
group by department_id
having count(distinct job_id)>1;

/*30.  �������� ���������� � department, job_id, ������������ � 
����������� �/� ��� ���� ��������� department_id - job_id, ��� 
������� �/� ������ 10000.*/
select department_id, job_id, max(salary), min(salary)
from employees
group by department_id, job_id
having avg(salary)>10000;

/*31.  .�������� ������ manager_id, � ������� ������� �������� ���� ��� 
�����������, �� ������� ������������, ��������� � ���������� �� 
6000 �� 9000*/
select manager_id
from employees
where commission_pct is null
group by manager_id
having avg(salary) between 6000 and 9000;

/*32.  �������� ���������� �� ����� (�� ��������) ������������ �������� 
����� ���� ������� ������� �� �������������.*/
select round (avg(max(salary)), -3)
from employees
group by department_id;

/*33.  �������� ���������� � �������� � ���-�� ����������� � ������ �������*/
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

/*34.  �������� ��������� ���������� � ������ ���������� 
(�������, ��� , �������� ������������, ���� ����, �����, ������ � ������).*/
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

/*35.  �������� ���������� � ����� ���������� ������� ����� � ���������� >6 �����������, 
� ��� �� �������� ���-�� ����������� ������� �� �����������.*/
select m.first_name, count (*)
from employees em
join employees m
on(em.manager_id=m.employee_id)
group by m.first_name
having count(*)>6;

/*36.  �������� ���������� � �������� ���� ������������� � � ���-�� ����������, 
���� � ������������ �������� > 30 ����������� ����������� ���������� ����� ��� ����������� �� id ������������.*/
select department_name, count(*)
from employees e
join departments d
using (department_id)
group by department_name
having count(*)>30;
/*37.  �������� �������� ���� ������������� � ������� ��� �� ������ ����������.*/
select department_name
from employees e
right join departments d
on (e.department_id=d.department_id)
where employee_id is null;

/*38.  �������� ��� ���������� � ����������� ��������� ������� ���������� �� ������ � 2005 ����, 
�� ��� ���� ���� ��������� ���������� �� ������ �� 1989 ����.*/
select e.*
from employees e
join employees m
on (e.manager_id=m.employee_id)
where to_char(m.hire_date, 'YYYY')='1989'
and e.hire_date<to_date ('01-01-1989', 'DD-MM-YYYY');

/*39.  �������� �������� ������ � �������� ������� ���� ������, ��������� ������� �����.*/
select country_name, region_name
from countries
natural join regions;

/*40.  �������� ������� , ����� � �� ����������� 
������� �������� ������ ��� ����������� �� �� ������������� + 1000.*/
select last_name, first_name, salary
from employees e
join jobs j
on(e.job_id=j.job_id
and salary<min_salary+1000);

/*41.  �������� ���������� ����� � �������, �������� ����� ����������� � ������� ��� ��������, 
��� �� �������� ���������� � ����������� � ������� ������� ��� ����������,
� ��� �� �������� ��� ������ � ������� ��� ����������� ��������.*/
select distinct first_name, last_name, country_name
from employees e
full outer join departments d
on (e.department_id=d.department_id)
full outer join locations l
on (d.location_id=l.location_id)
full outer join countries c
on (l.country_id=c.country_id);

/*42.  �������� ����� � ������� ���� ����������� , � ��� �� �������� ����� 
������� �� �������� ��� ����������� ���������� �� ����� ��������, ��� ����� ���� ������.*/
select first_name, last_name, country_name
from employees
cross join countries;

/*43.  ������ ������ �1 ��������� ����� ����� ���������.*/
select region_name, count(*)
from employees e, departments d, locations l, countries c, regions r
where (e.department_id=d.department_id and d.location_id=l.location_id 
and l.country_id=c.country_id and c.region_id=r.region_id)
group by region_name;
/*44.  ������ ������ �5 ��������� ����� ����� ���������.*/
select department_name
from employees e, departments d
where e.department_id(+)=d.department_id
and first_name is null;

/*45. �������� ��� ���������� � �����������, � ����� ������� ������.*/
select *
from employees
where length(first_name) in (select max (length(first_name)) from employees);

/*46.  �������� ��� ���������� � �����������, � ��������� ������� 
������� �������� ���� �����������.*/
select *
from employees
where salary > (select avg(salary) from employees);

/*47.  �������� �����/������, ��� ���������� � ����� ������������ ������ �����.*/
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

/*48.  �������� ��� ���������� � �����������, � ������� �������� 
�������� �������� ������ 15000.*/
select *
from employees
where manager_id in (select employee_id from employees
                    where salary>15000);

/*49.  �������� ��� ���������� � �������������, � ������� ��� �� ������ 
����������.*/
select *
from departments
where department_id not in (select distinct department_id from employees 
                             where department_id is not null);

/*50.  �������� ��� ���������� � �����������, ������� �� �������� 
�����������.*/
select * 
from employees e
where employee_id not in (select distinct manager_id
                           from employees
                        where manager_id is not null);

/*51.  �������� ��� ���������� � ����������, ������� ����� � 
���������� ������ 6�� �����������.*/
select * 
from employees 
where (select count(*) from employees
       where manager_id=e.employee_id)>6;

/*52.  �������� ��� ���������� � �����������, ������� �������� � 
������������ � ��������� IT.*/
select *
from employees
where department_id in (select department_id
                         from departments
                        where department_name = 'IT');
                        
/*53.  �������� ��� ���������� � �����������, ��������� ������� 
���������� �� ������ � 2005 �� ����, �� ��� ��� ���� ��������� 
���������� �� ������ �� 2005 ����..*/
select *
from employees
where manager_id in (select employee_id from employees
                     where to_char (hire_date, 'YYYY')= '2005'
                     and hire_date < to_date ('01-01-2005', 'DD-MM-YYYY'));
/*54.  �������� ��� ���������� � �����������, ��������� ������� 
���������� �� ������ � ������ ������ ����, � ����� job_title ���� 
����������� ������ 15�� ��������.*/
select * 
from employees e
where manager_id in (select employee_id
                    from employees
                    where to_char(hire_date, 'MM')='01')
                    and (select length(job_title)
                        from jobs
                        where job_id = e.job_id)>15;