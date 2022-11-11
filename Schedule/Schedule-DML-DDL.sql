--57.Перенести расписание всех занятий на 30 мин. вперед.
update Timepair
SET 
start_pair=start_pair + interval +30 MINUTE,
end_pair =end_pair + interval +30 MINUTE;

--60.Выведите идентификаторы преподавателей, которые хотя бы один раз за всё время преподавали в каждом из одиннадцатых классов.
select teacher
from Schedule s
JOIN class c
on (s.class=c.id)
where name like '11%'
group by teacher
HAVING count (DISTINCT name)>=2;

--63.Выведите отсортированный список (по возрастанию) имен студентов в виде Фамилия.И.О.
select concat (last_name, '.',
SUBSTRING(first_name, 1, 1), '.', 
SUBSTRING(middle_name, 1, 1), '.') as name
from Student
order by last_name, first_name;