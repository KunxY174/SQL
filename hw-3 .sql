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

/*4.  ПИспользуя SET операторы и не используя логические операторы, 
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
