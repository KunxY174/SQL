--34.Сколько всего 10-ых классов
select count(name) as count
from class
where name like '10 %';

--35.Сколько различных кабинетов школы использовались 2.09.2019 в образовательных целях ?
SELECT count(classroom) as count
from Schedule
where date = '2019-09-02';

--36.Выведите информацию об обучающихся живущих на улице Пушкина (ul. Pushkina)?
select *
from student
WHERE address like 'ul. Pushkina%';

--37.Сколько лет самому молодому обучающемуся ?
SELECT TIMESTAMPDIFF (YEAR, max(birthday), now()) as year
from student;

--38.Сколько Анн (Anna) учится в школе ?
SELECT count(id) as count
FROM Student
where first_name = 'Anna';

--39.Сколько обучающихся в 10 B классе ?
select count(student) as count
from Student_in_class s
  join class c on (s.class = c.id)
where name like '10 B';

--40.Выведите название предметов, которые преподает Ромашкин П.П. (Romashkin P.P.) ?
select name as subjects
from subject s  
join Schedule sc
on (s.id=sc.subject)
join Teacher t
on (sc.teacher=t.id)
where last_name = 'Romashkin';

--41.Во сколько начинается 4-ый учебный предмет по расписанию ?
select start_pair
from Timepair
where id = 4;

--42.Сколько времени обучающийся будет находиться в школе, учась со 2-го по 4-ый уч. предмет ?
SELECT distinct TIMEDIFF ('11:50:00', '09:20:00') as time
from Timepair;

--43.Выведите фамилии преподавателей, которые ведут физическую культуру (Physical Culture). Отcортируйте преподавателей по фамилии.
SELECT last_name
from Teacher t
  join Schedule s ON (t.id = s.teacher)
where subject in (
    select id
    from subject
    where name = 'Physical Culture')
ORDER BY last_name;

--44.Найдите максимальный возраст (колич. лет) среди обучающихся 10 классов ?
select max(YEAR(now()) - YEAR(birthday)) as max_year
from student s
  join Student_in_class st on (s.id = st.student)
where st.class in (
    select id
    from class
    where name like '10 %');

--45.Какой(ие) кабинет(ы) пользуются самым большим спросом?
SELECT classroom
FROM Schedule
GROUP by classroom
having count (classroom) = (
    SELECT count (classroom)
    from Schedule
    group by classroom
    ORDER by 1 desc
    limit 1);

--46.В каких классах введет занятия преподаватель "Krauze" ?
SELECT DISTINCT name
from teacher t
  join Schedule s on (t.id = s.teacher)
  join class c on (c.id = s.class)
where last_name = 'Krauze';

--47.Сколько занятий провел Krauze 30 августа 2019 г.?
select count (subject) as count
from Schedule s
  join Teacher t on (s.teacher = t.id)
where date = '2019-08-30'
  and last_name = 'Krauze';

--48.Выведите заполненность классов в порядке убывания
select name,
  count (student) as count
from Class c
  join Student_in_class st on (c.id = st.class)
GROUP BY name
order by count desc;

--49.Какой процент обучающихся учится в 10 A классе ?
SELECT (count(student) * 100 / (select count(student)
                                from Student_in_class)) as percent
from Class c
  join Student_in_class st on (c.id = st.class)
where name = '10 A';

--50.Какой процент обучающихся родился в 2000 году? Результат округлить до целого в меньшую сторону.
SELECT FLOOR((COUNT(id) * 100 /(SELECT COUNT(id)
                                from Student))) as percent
FROM Student
WHERE YEAR(birthday) = '2000';

--63.Выведите отсортированный список (по возрастанию) имен студентов в виде Фамилия.И.О.
select concat (last_name, '.',
SUBSTRING(first_name, 1, 1), '.', 
SUBSTRING(middle_name, 1, 1), '.') as name
from Student
order by last_name, first_name;