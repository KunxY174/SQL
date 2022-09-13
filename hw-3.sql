/*1. �������� � ����� ������� ���������� � ������ �/� �����, 
����������� �� id ���������, �� job_id, �� id ������������. ������ 
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

/*27.  ������� ������� friends � ������� subquery ���, ����� ��� ����� 
�������� ��������� �������� ��������� �������� �� ������� 
employees: employee_id, first_name, last_name ��� ��� �����, ��� 
������� ������������. ������� � ������� friends ������ ���������� 
id, name, surname.*/
create table friends as 
select employee_id, first_name name, last_name surname
from employees
where commission_pct is not null;

/*28. �������� � ������� friends ����� ������� email.*/
alter table friends
add (email varchar (25));

/*29. �������� ������� email ���, ����� ��� �������� �� ��������� ���� 
�no email�.*/
alter table friends
modify (email varchar (25) default 'no email');

/*30. �������� �������� ������� � id �� friends_id.*/
alter table friends
rename column employee_id to friend_id;


/*31. ������� ������� friends.*/
drop table friends;

/*32. ������� ������� friends �� ���������� ���������: id, name, surname, 
email, salary, city, birthday. � �������� salary � birthday ������ ���� 
�������� �� ���������.*/
create table frineds (
id int, 
name varchar(25),
surname varchar(25),
email varchar(25),
salary number  (9,3) default 10000,
city varchar(25),
birthday date default to_date ('15-JUN-1999', 'DD-MON-YYYY'));

/*33. �������� 1 ������ � ������� friends �� ����� ����������.*/
insert into frineds 
values (1, 'kekeke', 'kekekelov', 'kekekek@ehflad.com', 1000, 'moscow', to_date('19-JUN-1999', 'DD-MON-YYYY'));

/*34. �������� 1 ������ � ������� friends �� ����� ���������� ����� salary
� birthday.*/
insert into frineds (id, name, surname, email, city) 
values (2, 'memmem', 'mememelov', 'asddghg@asdazzd.com', 'moscow');

/*35. ��������� commit.*/
commit;

/*36. ������� ������� salary.*/
alter table friends 
drop column salary;

/*37. ������� ������� email �������������� (unused).*/
alter table friends 
set unused column email;

/*38. ������� ������� birthday �������������� (unused).*/
alter table friends 
set unused column birthday;


/*39. ������� �� ������� friends �������������� �������.*/
alter table friends 
drop unused columns;

/*40. ������� ������� friends ��������� ������ ��� ������.*/
alter table friends read only;

/*41. ��������� ���������� �������� ����� DML ��������.*/
insert into friends
values (3, 'dsfdsv', 'asdasd', 'asdsadas');

/*42. ���������� ������� friends.*/
truncate table friends;

/*43. ������� ������� friends.*/
drop table friends;

/*44. ������� ������� address �� ���������� ���������: id, country, city. 
��� �������� ������� �������� �� inline ������ unique constraint � 
������ ad_id_un �� ������� id.*/
create table address (
id integer constraint id_un unique,
country varchar(25),
email varchar (25));

/*45. ������� ������� friends �� ���������� ���������: id, name, email, 
address_id, birthday. ��� �������� ������� �������� �� inline ������
foreign key constraint �� ������� address_id, ������� ��������� �� 
������� id �� ������� address, ����������� ����� �on delete set null�.
����� ��� �������� ������� �������� �� table ������ check constraint
��� �������� ����, ��� ����� ����� ������ ���� ������ 3-�.*/
create table friends (
id integer,
name varchar(25),
city varchar (25),
email varchar (25),
address_id integer references address(id) on delete set null,
birthday date,
check (length(name)>3)
);

/*46.  �������� ���������� ������ �� ������� id �� ������� friends.*/
create unique index f_id_un on friends (id);

/*47. � ������� ����������� �add� ������� �alter table� ��������
constraint primary key � ��������� fr_id_pk �� ������� id �� ������� 
friends.*/
alter table friends
add constraint fr_pk primary key (id);

/*48. �������� ������ � ��������� fr_email_in �� ������� email �� ������� 
friends.*/
create unique inder fr_em_in on friends (email);

/*49. � ������� ����������� �modify� ������� �alter table� ��������
constraint not null � ��������� fr_email_nn �� ������� email �� ������� 
friends.*/
alter table friends
modify  (email constraint fr_email_nn not null);

/*50. ������� ������� friends.*/
drop table friends;

/*51. ������� ������� address.*/
drop table address;

/*52. ������� ������� emp1000 � ������� subquery ���, ����� ��� ����� 
�������� ��������� �������� ��������� �������� �� ������� 
employees: first_name, last_name, salary, department_id.*/
create table emp1000 as 
select first_name, last_name, salary, department_id from employees;


/*53.  ������� view v1000 �� ������ select-�, ������� ���������� ������� 
emp1000 � departments �� ������� department_id. View ������
��������� ��������� �������: first_name, last_name, salary, 
department_name, city .*/
create force view  v1000 as 
select first_name, last_name, salary, department_name, e.city from emp1000 e
join departments d on (e.department_id=d.department_id);

/*54.  �������� � ������� emp1000 ������� city .*/
alter table emp1000
add (city varchar(25));

/*55. �������������� view v1000.*/
alter view v1000 compile;

/*56.  �������� ������� syn1000 ��� v1000.*/
create synonym syn1000 for v1000;
 
/*57.  ������� v1000.*/
drop view v1000;

/*58.  ������� syn1000.*/
drop synonym syn1000;

/*59.  ������� emp1000.*/
drop table emp1000;

/*60.  �������� ������������������ seq1000, ������� ���������� � 12,
������������� �� 4, ����� ������������ �������� 200 � �����������.*/
create sequence seq1000
increment by 4 
start with 12 
maxvalue 200
cycle;

/*61. �������� ��� ������������������. ������� ������������ �������� � 
�����������.*/
alter sequence seq1000
nomaxvalue
nocycle;

/*62. �������� 2 ������ � ������� employees, ��������� ���������� 
��������� ���������� ��������. �������������� 
������������������� seq1000 ��� ���������� �������� � ������� 
employee_id.*/
insert into employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'norris', 'ASBCDE', sysdate, 'IT_PROG');

insert into employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'TESTTEST', 'ASBCDEFGG', sysdate, 'IT_PROG');

/*63. ��������� commit.*/
commit;






