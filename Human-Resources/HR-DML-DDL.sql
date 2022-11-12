--1. Перепишите и запустите данный statemenet для создания таблицы locations2, которая будет содержать такие же столбцы, что и locations:
CREATE TABLE locations2 AS (SELECT * FROM locations WHERE 1=2);

--2.  Добавьте в таблицу locations2 2 строки с информацией о id локации, адресе, городе, id страны. Пусть данные строки относятся к стране Италия.
insert into locations2 (location_id, street_address, city, country_id)
values (1, 'test_address', 'italy_cities', 'IT');

insert into locations2 (location_id, street_address, city, country_id)
values (2, 'test_address2', 'milan', 'IT');
--3. Совершите commit
commit;

--4.  Добавьте в таблицу locations2 ещё 2 строки, не используя перечисления имён столбцов, в которые заносится информация. Пусть данные строки относятся к стране Франция. При написании значений, где возможно, используйте функции.
insert into locations2
values (3, initcap('qpefkg'), '999-888-666', initcap('paris'), 'Test province', upper('fr'));

insert into locations2
values (4, initcap('Parmentsl'), '999-888-666', initcap('mexico'), 'Testing', upper('fr'));
--5. Совершите commit
commit;

--6.  Добавьте в таблицу locations2 строки из таблицы locations, в которых длина значения столбца state_province больше 9
insert into locations2 (location_id, street_address, postal_code, city, state_province, country_id)
(select location_id, street_address, postal_code, city, state_province, country_id
from locations
where length(state_province) >9);

--7. Совершите commit
commit;

--8.  Перепишите и запустите данный statemenet для создания таблицы locations4europe, которая будет содержать такие же столбцы, что и locations:
CREATE TABLE locations4europe AS (SELECT * FROM locations WHERE 1=2);

--9.  Одним statement-ом добавьте в таблицу locations2 всю информациюдля всех строк из таблицы locations, а в таблицу locations4europeдобавьте информацию о id локации, адресе, городе, id страны только для тех строк из таблицы locations, где города находятся в Европе. 
insert ALL
when 1=1 then
into locations2
values (location_id, street_address, postal_code, city, state_province, country_id)
when country_id in (select country_id from countries where region_id=1) then
into locations4europe (location_id, street_address, city, country_id)
values (location_id, street_address, city, country_id)
select * from locations;

--10. Совершите commit
commit;

--11.  В таблице locations2 измените почтовый код на любое значение в тех строках, где сейчас нет информации о почтовом коде.
update locations2
set postal_code= 'test_code'
where postal_code is null;

--12. Совершите rollback.--
rollback;

--13.  В таблице locations2 измените почтовый код в тех строках, где сейчас нет информации о почтовом коде. Новое значение должно быть кодом из таблицы locations для строки с id 2600.

update locations2
set postal_code= (select postal_code from locations where location_id=2600)
where postal_code is null;

--14. Совершите commit
commit;

--15.  Удалите строки из таблицы locations2, где id страны «IT».
delete from locations2
where country_id = 'IT';

--16.  Создайте первый savepoint.
savepoint  ggg1;

--17.  В таблице locations2 измените адрес в тех строках, где id локации больше 2500. Новое значение должно быть «Sezam st. 18»
update locations2 set street_address = 'Sezam st. 18'
where location_id>2500;

--18.  Создайте второй savepoint.
savepoint ggg2;

--19.  Удалите строки из таблицы locations2, где адрес равен «Sezam st. 18».
delete from locations2 where street_address = 'Sezam st. 18';

--20.  Откатите изменения до первого savepoint.
rollback to savepoint ggg1;

--21 Совершите commit
commit;

--22.  Создать таблицу friends с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы employees: employee_id, first_name, last_name для тех строк, где имеются комиссионные. Столбцы в таблице friends должны называться id, name, surname .
create table friends as 
select employee_id, first_name name, last_name surname
from employees
where commission_pct is not null;

--23. Добавить в таблицу friends новый столбец email .
alter table friends
add (email varchar (25));

--24. Изменить столбец email так, чтобы его значение по умолчанию было  «no email».
alter table friends
modify (email varchar (25) default 'no email');

--25. Изменить название столбца с id на friends_id .
alter table friends
rename column employee_id to friend_id;

--26. Удалить таблицу friends
drop table friends;

--27. Создать таблицу friends со следующими столбцами: id, name, surname, email, salary, city, birthday. У столбцов salary и birthday должны быть значения по умолчанию.
create table frineds (
id int, 
name varchar(25),
surname varchar(25),
email varchar(25),
salary number  (9,3) default 10000,
city varchar(25),
birthday date default to_date ('15-JUN-1999', 'DD-MON-YYYY'));

--28. Добавить 1 строку в таблицу friends со всеми значениями.
insert into frineds 
values (1, 'kekeke', 'kekekelov', 'kekekek@ehflad.com', 1000, 'moscow', to_date('19-JUN-1999', 'DD-MON-YYYY'));

--29. Добавить 1 строку в таблицу friends со всеми значениями кроме salary и birthday.
insert into frineds (id, name, surname, email, city) 
values (2, 'memmem', 'mememelov', 'asddghg@asdazzd.com', 'moscow');

--30. Совершите commit
commit;

--31. Удалить столбец salary.
alter table friends 
drop column salary;

--32. Сделать столбец email неиспользуемым (unused).
alter table friends 
set unused column email;

--33. Сделать столбец birthday неиспользуемым (unused).
alter table friends 
set unused column birthday;

--34. Удалить из таблицы friends неиспользуемые столбцы
alter table friends 
drop unused columns;

--35. Сделать таблицу friends пригодной только для чтения.
alter table friends read only;

--36. Проверить предыдущее действие любой DML командой.
insert into friends
values (3, 'dsfdsv', 'asdasd', 'asdsadas');

--37. Опустошить таблицу friends.
truncate table friends;

--38. Удалить таблицу friends
drop table friends;

--39. Создать таблицу address со следующими столбцами: id, country, city. При создании таблицы создайте на inline уровне unique constraint с именем ad_id_un на столбец id.
create table address (
id integer constraint id_un unique,
country varchar(25),
email varchar (25));

--40. Создать таблицу friends со следующими столбцами: id, name, email, address_id, birthday. При создании таблицы создайте на inline уровнеforeign key constraint на столбец address_id, который ссылается на столбец id из таблицы address, используйте опцию «on delete set null». Также при создании таблицы создайте на table уровне check constraint для проверки того, что длина имени должна быть больше 3-х.
create table friends (
id integer,
name varchar(25),
city varchar (25),
email varchar (25),
address_id integer references address(id) on delete set null,
birthday date,
check (length(name)>3)
);

--41.  Создайте уникальный индекс на столбец id из таблицы friends.
create unique index f_id_un on friends (id);

--42. С помощью функционала «add» команды «alter table» создайтеconstraint primary key с названием fr_id_pk на столбец id из таблицы friends.
alter table friends
add constraint fr_pk primary key (id);

--43. Создайте индекс с названием fr_email_in на столбец email из таблицы friends.
create unique index fr_em_in on friends (email);

--44. С помощью функционала «modify» команды «alter table» создайтеconstraint not null с названием fr_email_nn на столбец email из таблицы friends.
alter table friends
modify  (email constraint fr_email_nn not null);

--45. Удалите таблицу friends.
drop table friends;

--46. Удалите таблицу address.
drop table address;

--47. Создать таблицу emp1000 с помощью subquery так, чтобы она после создания содержала значения следующих столбцов из таблицы employees: first_name, last_name, salary, department_id. 
create table emp1000 as 
select first_name, last_name, salary, department_id from employees;

--48.  Создать view v1000 на основе select-а, который объединяет таблицы emp1000 и departments по столбцу department_id. View долженсодержать следующие столбцы: first_name, last_name, salary, department_name, city .
create force view  v1000 as 
select first_name, last_name, salary, department_name, e.city from emp1000 e
join departments d on (e.department_id=d.department_id);

--49.  Добавьте в таблицу emp1000 столбец city .
alter table emp1000
add (city varchar(25));

--50. Откомпилируйте view v1000
alter view v1000 compile;

--51.  Создайте синоним syn1000 для v1000
create synonym syn1000 for v1000;
 
--52.  Удалите v1000.
drop view v1000;

--53.  Удалите syn1000.
drop synonym syn1000;

--54.  Удалите emp1000.
drop table emp1000;

--55.  Создайте последовательность seq1000, которая начинается с 12, увеличивается на 4, имеет максимальное значение 200 и цикличность. 
create sequence seq1000
increment by 4 
start with 12 
maxvalue 200
cycle;

--56. Измените эту последовательность. Удалите максимальное значение и цикличность.
alter sequence seq1000
nomaxvalue
nocycle;

--57. Добавьте 2 строки в таблицу employees, используя минимально возможное количество столбцов. Воспользуйтесь последовательностью seq1000 при добавлении значений в столбец employee_id.
insert into employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'norris', 'ASBCDE', sysdate, 'IT_PROG');

insert into employees (employee_id, last_name, email, hire_date, job_id)
values (seq1000.nextval, 'TESTTEST', 'ASBCDEFGG', sysdate, 'IT_PROG');

--58. Совершите commit
commit;