/*1. �������� � ����� ������� ���������� � ������ �/� �����, 
������������ �� id ���������, �� job_id, �� id ������������. ������ 
������ ��������� 4 �������: id ���������, job_id, id ������������, 
������������� �/�.*/
select manager_id, to_char(null) job_id, to_number(null) department_id, sum(salary)
from employees
group by manager_id
union
select to_number(null), job_id, to_number(null) , sum(salary)
from employees
group by job_id
union
select to_number(null), to_char(null), department_id, sum(salary)
from employees
group by department_id;

/*2. �������� id ��� �������������, ��� �������� �������� � 100 � �� 
�������� ��������� � 145, 201.*/
select department_id  
from employees
where manager_id=100
minus
select department_id  
from employees
where manager_id in (145, 201);

/*3. ��������� SET ��������� � �� ��������� ���������� ���������, 
�������� ���������� ���������� � ������, �������� � �/� 
�����������, ������ ������ � ������ ������� ����� ��, � ������� 
�������� ����� �s� ��� ����������� �� ��������. ������������ 
��������� �� �/� �� ��������.*/
select first_name, last_name, salary 
from employees
where first_name like '_a%'
INTERSECT
select first_name, last_name, salary
from employees
where lower(first_name) like '%s%'
order by salary desc;

/*4.  ��������� SET ��������� � �� ��������� ���������� ���������, 
�������� ���������� � id �������, �������� ���� � ������ ��� 
�������, ������� ��������� � ������ ��� ��������. � ����� ��� 
�������, �������� ��� ������� �������� ����� �9�.*/
select location_id, postal_code, city
from locations
where country_id in (select country_id from countries
                    where country_name in ('Italy', 'Germany'))
union all
select location_id, postal_code, city
from locations 
where postal_code like '%9%';

/*5.  ��������� SET ��������� � �� ��������� ���������� ���������, 
�������� ��� ���������� ���������� ��� �����, ����� ��� 
������� ������ 8 ��������. � ����� ��� �����, ������� ��������� �� � 
����������� �������. ������� ������� ������ ���������� id, country, 
region. ������ ������������ �� �������� ����� �� ���������.*/
select country_id id, country_name country, region_id region
from countries
where length(country_name)>8
union
select country_id, country_name, region_id
from countries
where region_id != (select region_id from regions
                     where region_name = 'Europe')
order by country desc;

/*6. ���������� � ��������� ������ statemenet ��� �������� ������� 
locations2, ������� ����� ��������� ����� �� �������, ��� � locations:
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);*/
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);

/*7.  �������� � ������� locations2 2 ������ � ����������� � id �������, 
������, ������, id ������. ����� ������ ������ ��������� � ������ 
������.*/
insert into locations2 (location_id, street_address, city, country_id)
values (1, 'test_address', 'italy_cities', 'IT');

insert into locations2 (location_id, street_address, city, country_id)
values (2, 'test_address2', 'milan', 'IT');
/*8.  ��������� commit.*/
commit;

/*9.  �������� � ������� locations2 ��� 2 ������, �� ��������� 
������������ ��� ��������, � ������� ��������� ����������. ����� 
������ ������ ��������� � ������ �������. ��� ��������� ��������, 
��� ��������, ����������� �������.*/
insert into locations2
values (3, initcap('qpefkg'), '999-888-666', initcap('paris'), 'Test province', upper('fr'));

insert into locations2
values (4, initcap('Parmentsl'), '999-888-666', initcap('mexico'), 'Testing', upper('fr'));
/*10.  ��������� commit.*/
commit;

/*11.  �������� � ������� locations2 ������ �� ������� locations, � ������� 
����� �������� ������� state_province ������ 9.*/
insert into locations2 (location_id, street_address, postal_code, city, state_province, country_id)
(select location_id, street_address, postal_code, city, state_province, country_id
from locations
where length(state_province) >9);

/*12.  ��������� commit.*/
commit;

/*13.  ���������� � ��������� ������ statemenet ��� �������� ������� 
locations4europe, ������� ����� ��������� ����� �� �������, ��� � 
locations:
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);*/
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);

/*14.  ����� statement-�� �������� � ������� locations2 ��� ����������
��� ���� ����� �� ������� locations, � � ������� locations4europe
�������� ���������� � id �������, ������, ������, id ������ ������
��� ��� ����� �� ������� locations, ��� ������ ��������� � ������.*/
insert ALL
when 1=1 then
into locations2
values (location_id, street_address, postal_code, city, state_province, country_id)
when country_id in (select country_id from countries where region_id=1) then
into locations4europe (location_id, street_address, city, country_id)
values (location_id, street_address, city, country_id)
select * from locations;

/*15.  ��������� commit.*/
commit;

/*16.  � ������� locations2 �������� �������� ��� �� ����� �������� � ��� 
�������, ��� ������ ��� ���������� � �������� ����.*/
update locations2
set postal_code= 'test_code'
where postal_code is null;

/*17.  ��������� rollback.*/
rollback;

/*18.  .� ������� locations2 �������� �������� ��� � ��� �������, ��� ������ 
��� ���������� � �������� ����. ����� �������� ������ ���� �����
�� ������� locations ��� ������ � id 2600.*/
update locations2
set postal_code= (select postal_code from locations where location_id=2600)
where postal_code is null;

/*19.  ��������� commit.*/
commit;

/*20.  ������� ������ �� ������� locations2, ��� id ������ �IT�.*/
delete from locations2
where country_id = 'IT';

/*21.  �������� ������ savepoint.*/
savepoint  ggg1;

/*22.  � ������� locations2 �������� ����� � ��� �������, ��� id ������� 
������ 2500. ����� �������� ������ ���� �Sezam st. 18�*/
update locations2 set street_address = 'Sezam st. 18'
where location_id>2500;

/*23.  �������� ������ savepoint.*/
savepoint ggg2;

/*24.  .������� ������ �� ������� locations2, ��� ����� ����� �Sezam st. 18�.*/
delete from locations2 where street_address = 'Sezam st. 18';

/*25.  �������� ��������� �� ������� savepoint.*/
rollback to savepoint ggg1;

/*26. ��������� commit.*/
commit;
