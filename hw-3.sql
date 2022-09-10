/*1. Выведите в одном репорте информацию о суммах з/п групп, 
объединённых по id менеджера, по job_id, по id департамента. Репорт 
должен содержать 4 столбца: id менеджера, job_id, id департамента, 
суммированная з/п.*/
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

/*2. Выведите id тех департаментов, где работает менеджер № 100 и не 
работают менеджеры № 145, 201.*/
select department_id  
from employees
where manager_id=100
minus
select department_id  
from employees
where manager_id in (145, 201);

/*3. Используя SET операторы и не используя логические операторы, 
выведите уникальную информацию о именах, фамилиях и з/п 
сотрудников, второй символ в именах которых буква «а», и фамилия 
содержит букву «s» вне зависимости от регистра. Отсортируйте 
результат по з/п по убыванию.*/
select first_name, last_name, salary 
from employees
where first_name like '_a%'
INTERSECT
select first_name, last_name, salary
from employees
where lower(first_name) like '%s%'
order by salary desc;

/*4.  Используя SET операторы и не используя логические операторы, 
выведите информацию о id локаций, почтовом коде и городе для 
локаций, которые находятся в Италии или Германии. А также для 
локаций, почтовый код которых содержит цифру «9».*/
select location_id, postal_code, city
from locations
where country_id in (select country_id from countries
                    where country_name in ('Italy', 'Germany'))
union all
select location_id, postal_code, city
from locations 
where postal_code like '%9%';

/*5.  Используя SET операторы и не используя логические операторы, 
выведите всю уникальную информацию для стран, длина имён 
которых больше 8 символов. А также для стран, которые находятся не в 
европейском регионе. Столбцы аутпута должны называться id, country, 
region. Аутпут отсортируйте по названию стран по убывающей.*/
select country_id id, country_name country, region_id region
from countries
where length(country_name)>8
union
select country_id, country_name, region_id
from countries
where region_id != (select region_id from regions
                     where region_name = 'Europe')
order by country desc;

/*6. Перепишите и запустите данный statemenet для создания таблицы 
locations2, которая будет содержать такие же столбцы, что и locations:
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);*/
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);

/*7.  Добавьте в таблицу locations2 2 строки с информацией о id локации, 
адресе, городе, id страны. Пусть данные строки относятся к стране 
Италия.*/
insert into locations2 (location_id, street_address, city, country_id)
values (1, 'test_address', 'italy_cities', 'IT');

insert into locations2 (location_id, street_address, city, country_id)
values (2, 'test_address2', 'milan', 'IT');
/*8.  Совершите commit.*/
commit;

/*9.  Добавьте в таблицу locations2 ещё 2 строки, не используя 
перечисления имён столбцов, в которые заносится информация. Пусть 
данные строки относятся к стране Франция. При написании значений, 
где возможно, используйте функции.*/
insert into locations2
values (3, initcap('qpefkg'), '999-888-666', initcap('paris'), 'Test province', upper('fr'));

insert into locations2
values (4, initcap('Parmentsl'), '999-888-666', initcap('mexico'), 'Testing', upper('fr'));
/*10.  Совершите commit.*/
commit;

/*11.  Добавьте в таблицу locations2 строки из таблицы locations, в которых 
длина значения столбца state_province больше 9.*/
insert into locations2 (location_id, street_address, postal_code, city, state_province, country_id)
(select location_id, street_address, postal_code, city, state_province, country_id
from locations
where length(state_province) >9);

/*12.  Совершите commit.*/
commit;

/*13.  Перепишите и запустите данный statemenet для создания таблицы 
locations4europe, которая будет содержать такие же столбцы, что и 
locations:
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);*/
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);

/*14.  Одним statement-ом добавьте в таблицу locations2 всю информацию
для всех строк из таблицы locations, а в таблицу locations4europe
добавьте информацию о id локации, адресе, городе, id страны только
для тех строк из таблицы locations, где города находятся в Европе.*/
insert ALL
when 1=1 then
into locations2
values (location_id, street_address, postal_code, city, state_province, country_id)
when country_id in (select country_id from countries where region_id=1) then
into locations4europe (location_id, street_address, city, country_id)
values (location_id, street_address, city, country_id)
select * from locations;

/*15.  Совершите commit.*/
commit;

/*16.  В таблице locations2 измените почтовый код на любое значение в тех 
строках, где сейчас нет информации о почтовом коде.*/
update locations2
set postal_code= 'test_code'
where postal_code is null;

/*17.  Совершите rollback.*/
rollback;

/*18.  .В таблице locations2 измените почтовый код в тех строках, где сейчас 
нет информации о почтовом коде. Новое значение должно быть кодом
из таблицы locations для строки с id 2600.*/
update locations2
set postal_code= (select postal_code from locations where location_id=2600)
where postal_code is null;

/*19.  Совершите commit.*/
commit;

/*20.  Удалите строки из таблицы locations2, где id страны «IT».*/
delete from locations2
where country_id = 'IT';

/*21.  Создайте первый savepoint.*/
savepoint  ggg1;

/*22.  В таблице locations2 измените адрес в тех строках, где id локации 
больше 2500. Новое значение должно быть «Sezam st. 18»*/
update locations2 set street_address = 'Sezam st. 18'
where location_id>2500;

/*23.  Создайте второй savepoint.*/
savepoint ggg2;

/*24.  .Удалите строки из таблицы locations2, где адрес равен «Sezam st. 18».*/
delete from locations2 where street_address = 'Sezam st. 18';

/*25.  Откатите изменения до первого savepoint.*/
rollback to savepoint ggg1;

/*26.  цуеруфк commit.*/
commit;

