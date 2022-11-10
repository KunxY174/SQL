![Typing SVG](https://readme-typing-svg.herokuapp.com?color=%2356BCF8&lines=This+is+SQL+portfolio)

### ⚡Этот репозиторий содержит образцы SQL-запросов к следущим базам данных:
| Название БД       | Описание                          |Тема|
| :-------------:|:------------------------:|:-----:|
| [Air Travels](https://github.com/KunxY174/SQL/tree/main/Air-Travels)|Содержит информацию о пассажирах, путешествиях и компаниях |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Airbnb](https://github.com/KunxY174/SQL/tree/main/Airbnb)|Содержит информацию об онлайн-площадке для размещения и поиска аренды жилья |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Computer Company](https://github.com/KunxY174/SQL/tree/main/Computer-Company)|Содержит информацию о производителях ПК, ноутбуков, принтеров |Selection, single row функции, GROUP BY, JOIN|
| [Family](https://github.com/KunxY174/SQL/tree/main/Family)|Содержит информацию о покупках семьи |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Human Resources](https://github.com/KunxY174/SQL/tree/main/Human-Resources)|Содержит информацию о сотрудниках, департаментах, регионах, истории работ.|Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Recycling Company](https://github.com/KunxY174/SQL/tree/main/Recycling-Company)|Содержит информацию фирме вторсырья и ее пунктах |Selection, single row функции, GROUP BY, JOIN|
| [Schedule](https://github.com/KunxY174/SQL/tree/main/Schedule)|Содержит информацию о студентах, преподавателях, расписании уроков, предметах |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Ships](https://github.com/KunxY174/SQL/tree/main/Ships)|Содержит информацию о кораблях, технических характеристиках, сражениях с результатом |Selection, single row функции, GROUP BY, JOIN|


<details><summary>✈️Схема БД Air Travels✈️</summary>
Схема БД состоит из четырех отношений:
Company (id, name)
Trip(id, company, plane, town_from, town_to, time_out, time_in)
Passenger(id, name)
Pass_in_trip(id, trip, passenger, place)
Таблица Company содержит идентификатор и название компании, осуществляющей перевозку пассажиров. Таблица Trip содержит информацию о рейсах: номер рейса, идентификатор компании, тип самолета, город отправления, город прибытия, время отправления и время прибытия. Таблица Passenger содержит идентификатор и имя пассажира. Таблица Pass_in_trip содержит информацию о полетах: номер рейса, дата вылета (день), идентификатор пассажира и место, на котором он сидел во время полета. При этом следует иметь в виду, что
- рейсы выполняются ежедневно, а длительность полета любого рейса менее суток; town_from <> town_to;
- время и дата учитывается относительно одного часового пояса;
- время отправления и прибытия указывается с точностью до минуты;
- среди пассажиров могут быть однофамильцы (одинаковые значения поля name, например, Bruce Willis);
- номер места в салоне – это число с буквой; число определяет номер ряда, буква (a – d) – место в ряду слева направо в алфавитном порядке;
- связи и ограничения показаны на схеме данных.
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/air-travels-schema.png)

</details>

<details><summary>🏠Схема БД Airbnb🏠</summary>
Схема БД состоит из четырех таблиц:
Reviews(id, reservation_id, rating)
Reservations(id, user_id, room_id, start_date, end_date, price, total)
Users(id, name, email, email_verified_at, passport, phone_number)
Rooms(id, home_type, address, has_tv, has_internet, has_kitchen, has_air_con, owner_id, latitude, longitude)
Упрощенная схема услуги по сдаче жилья в аренду. Users - Пользователи сервиса, Reservations - История бронирования номеров, Rooms - Доступное жилье в аренду,
Reviews - Отзывы об аренде жилья
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/airbnb-schema.png)

</details>

<details><summary>🖥️Схема БД Computer Company🖥️</summary>
Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/cc-schema.png)
  
</details>
 
<details><summary>👪Схема БД Family👪</summary>
Схема БД состоит из четырех таблиц:
FamilyMembers(member_id, status, member_name, birthday)
Goods(good_id, good_name, type)
GoodTypes(good_type_id, good_type_name)
Payments(payment_id, family_member, good, amount, unit_price, date)
Информация о семейных покупках. FamilyMembers - Члены семьи, Goods - Список существующих продуктов, GoodTypes - Типы продуктов,
Payments - Платежи за покупки
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/family-schema.png)
  
</details>
  
  <details><summary>🚶Схема БД Human Resources🚶</summary>
Схема БД состоит из семи таблиц:
Class(id, name)
Schedule(id, date, class, number_pair, teacher, subject, classroom)
Student(id, first_name, middle_name, last_name, birthday, address)
Student_in_class(id, class, student)
Subject(id, name)
Teacher(id, first_name, middle_name, last_name)
Timepair(id, start_pair, end_pair)
Схема БД состоит из семи таблиц: Countries(country_id, country_name, region_id) Schedule(id, date, class, number_pair, teacher, subject, classroom) Student(id, first_name, middle_name, last_name, birthday, address) Student_in_class(id, class, student) Subject(id, name) Teacher(id, first_name, middle_name, last_name) Timepair(id, start_pair, end_pair) Информация о семейных покупках. Countries: country_id - Первичный ключ таблицы, country_name - Имя страны, region_id - Идентификатор региона для страны. Внешний ключ к столбцу region_id в таблице departments. Departments: department_id - Столбец первичного ключа таблицы, department_name - not null столбец, который показывает название отдела, manager_id - Manager_id отдела. Внешний ключ к столбцу employee_id таблицы сотрудников. Столбец manager_id таблицы сотрудников ссылается на этот столбец, location_id - Идентификатор местоположения, в котором находится отдел. Внешний ключ к столбцу location_id таблицы местоположений. Employees: employee_id - Первичный ключ таблицы, first_name - Имя сотрудника. Not null столбец, last_name - Фамилия сотрудника. Not null столбец, 
email - email сотрудника, phone_number - Телефон сотрудника; включает код страны и код города, hire_date - Дата, когда сотрудник приступил к работе. Not null столбец, job_id - Текущая работа сотрудника; внешний ключ к столбцу job_id таблицы jobs. Not null столбец, salary - Ежемесячная заработная плата работника. Должна быть больше
чем ноль, commission_pct - Комиссионный процент сотрудника; Только сотрудники в отделе продаж, имеют право на комиссионный процент, manager_id - Идентификатор менеджера сотрудника; имеет тот же домен, что и manager_id в таблице отделов. Внешний ключ к столбцу employee_id таблицы сотрудников, department_id - Идентификатор отдела, в котором работает сотрудник; внешний ключ к Department_id столбец таблицы departments. Job_history: employee_id - not null столбец в сложном первичном ключе employee_id+start_date. Внешний ключ к столбцу employee_id таблицы сотрудников, start_date - not null столбец в сложном первичном ключе employee_id+start_date. Должно быть меньше end_date таблицы job_history, end_date - Последний день работы сотрудника на этой должности. Not null столбец. Должен быть больше, чем start_date таблицы job_history, job_id - Должностная роль, в которой сотрудник работал в прошлом; внешний ключ к столбwe job_id в таблице jobs. not null столбец, department_id - id отдела, в котором сотрудник работал в прошлом; внешний ключ к столбцу deparment_id в таблице departments
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/schedule-schema.png)
  
</details>
  
<details><summary>💼Схема БД Recycling Company💼</summary>
Фирма имеет несколько пунктов приема вторсырья. Каждый пункт получает деньги для их выдачи сдатчикам вторсырья. Сведения о получении денег на пунктах приема записываются в таблицу:
Income_o(point, date, inc)
Первичным ключом является (point, date). При этом в столбец date записывается только дата (без времени), т.е. прием денег (inc) на каждом пункте производится не чаще одного раза в день. Сведения о выдаче денег сдатчикам вторсырья записываются в таблицу:
Outcome_o(point, date, out)
В этой таблице также первичный ключ (point, date) гарантирует отчетность каждого пункта о выданных деньгах (out) не чаще одного раза в день.
В случае, когда приход и расход денег может фиксироваться несколько раз в день, используется другая схема с таблицами, имеющими первичный ключ code:
Income(code, point, date, inc)
Outcome(code, point, date, out)
Здесь также значения столбца date не содержат времени.
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/rc-schema.png)
  
</details>
  
<details><summary>🎓Схема БД Schedule🎓</summary>
Схема БД состоит из семи таблиц:
Class(id, name)
Schedule(id, date, class, number_pair, teacher, subject, classroom)
Student(id, first_name, middle_name, last_name, birthday, address)
Student_in_class(id, class, student)
Subject(id, name)
Teacher(id, first_name, middle_name, last_name)
Timepair(id, start_pair, end_pair)
Информация о семейных покупках. Class - Список классов в школе, Schedule - Расписание занятий, Student - Студенты школы,
Student_in_class - Информация о студентах в классе, Subject - Список школьных предметов, Teacher - Список школьных учителей, Timepair - Расписание звонков
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/schedule-schema.png)
  
</details>
  
  <details><summary>🚢Схема БД Ships🚢</summary>
Рассматривается БД кораблей, участвовавших во второй мировой войне. Имеются следующие отношения:
Classes (class, type, country, numGuns, bore, displacement)
Ships (name, class, launched)
Battles (name, date)
Outcomes (ship, battle, result)
Корабли в «классах» построены по одному и тому же проекту, и классу присваивается либо имя первого корабля, построенного по данному проекту, либо названию класса дается имя проекта, которое не совпадает ни с одним из кораблей в БД. Корабль, давший название классу, называется головным.
Отношение Classes содержит имя класса, тип (bb для боевого (линейного) корабля или bc для боевого крейсера), страну, в которой построен корабль, число главных орудий, калибр орудий (диаметр ствола орудия в дюймах) и водоизмещение ( вес в тоннах). В отношении Ships записаны название корабля, имя его класса и год спуска на воду. В отношение Battles включены название и дата битвы, в которой участвовали корабли, а в отношении Outcomes – результат участия данного корабля в битве (потоплен-sunk, поврежден - damaged или невредим - OK).
Замечания. 1) В отношение Outcomes могут входить корабли, отсутствующие в отношении Ships. 2) Потопленный корабль в последующих битвах участия не принимает.
  
![schema](https://raw.githubusercontent.com/KunxY174/SQL/main/Schemas-DB/schedule-schema.png)
  
</details>
