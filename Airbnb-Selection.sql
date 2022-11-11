
--59.Вывести пользователей,указавших Белорусский номер телефона ? Телефонный код Белоруссии +375.
select *
from Users
WHERE phone_number like '+375%';

--61.Выведите список комнат, которые были зарезервированы в течение 12 недели 2020 года.
SELECT Rooms.*
FROM Rooms
  JOIN Reservations re 
  ON (Rooms.id = re.room_id)
WHERE WEEK(start_date, 1) = 12
  OR WEEK(end_date, 1) = 12;

--62.Вывести в порядке убывания популярности доменные имена 2-го уровня, используемые пользователями для электронной почты. Полученный результат необходимо дополнительно отсортировать по возрастанию названий доменных имён.
SELECT SUBSTRING(email, LOCATE('@', email)) as domain,
count (*) as count
from Users
group by domain
order by count DESC, domain asc;

--64.Вывести количество бронирований по каждому месяцу каждого года, в которых было хотя бы 1 бронирование. Результат отсортируйте в порядке возрастания даты бронирования.
select YEAR(start_date) as year, MONTH(start_date) as month,
COUNT(*) as amount
from Reservations
GROUP by 1, 2
having count (*)>=1
ORDER by 1, 2;

--65.Необходимо вывести рейтинг для комнат, которые хоть раз арендовали, как среднее значение рейтинга отзывов округленное до целого вниз.
SELECT room_id, FLOOR(AVG(rating)) as rating
from Reviews re
join Reservations r
on (re.reservation_id=r.id)
GROUP by room_id 

--66.Вывести список комнат со всеми удобствами (наличие ТВ, интернета, кухни и кондиционера), а также общее количество дней и сумму за все дни аренды каждой из таких комнат.
SELECT home_type, address, 
ifnull (sum(DATEDIFF (end_date, start_date)), 0) as days,
ifnull (sum(total), 0) as total_fee
from Rooms r
LEFT JOIN Reservations re
on(r.id=re.room_id)
where has_tv = 1
and has_internet = 1
and has_kitchen = 1
and has_air_con = 1
GROUP by r.id;

--68.Для каждой комнаты, которую снимали как минимум 1 раз, найдите имя человека, снимавшего ее последний раз, и дату, когда он выехал
with get_data as (
select room_id,
max(end_date) as end_date
from Reservations
group by room_id
having count(*) >= 1
)
select rs.room_id,
u.name,
rs.end_date
from Reservations as rs
join get_data as gd on gd.room_id = rs.room_id
and gd.end_date = rs.end_date
join users as u on u.id = rs.user_id

--69.Вывести идентификаторы всех владельцев комнат, что размещены на сервисе бронирования жилья и сумму, которую они заработали
SELECT owner_id, ifnull (sum(re.total), 0) as total_earn
from Rooms r
left join Reservations re
on (r.id=re.room_id )
group by owner_id;

--70.Необходимо категоризовать жилье на economy, comfort, premium по цене соответственно <= 100, 100 < цена < 200, >= 200. В качестве результата вывести таблицу с названием категории и количеством жилья, попадающего в данную категорию
select (case
when price <=100 then 'economy'
when price >100
and price <200 then 'comfort'
when price >=200 then 'premium'
end ) as category, COUNT(id) as count
from Rooms
group by category;

--71.Найдите какой процент пользователей, зарегистрированных на сервисе бронирования, хоть раз арендовали или сдавали в аренду жилье. Результат округлите до сотых.
WITH  t1 AS (
SELECT DISTINCT user_id
FROM Reservations
UNION
SELECT DISTINCT owner_id
FROM Rooms r
JOIN Reservations re
ON (r.id = re.room_id) 
)

SELECT ROUND(
    (
        (SELECT COUNT(*) FROM active) / COUNT(*) * 100), 2
    ) AS percent
FROM Users;