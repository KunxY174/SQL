![Header](https://raw.githubusercontent.com/KunxY174/KunxY174/main/sqlheader2.jpg)

### ⚡Этот репозиторий содержит образцы SQL-запросов к следущим базам данных:
| Название БД       | Описание                          |Тема|
| :-------------:|:------------------------:|:-----:|
| [Air Travels](https://github.com/KunxY174/SQL/tree/main/Air-Travels)|Содержит информацию о пассажирах, путешествиях и компаниях |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Airbnb](https://github.com/KunxY174/SQL/tree/main/Airbnb)|Содержит информацию об онлайн-площадки для размещения и поиска аренды жилья |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Computer Company](https://github.com/KunxY174/SQL/tree/main/Computer-Company)|Содержит информацию о производителях ПК, ноутбуков, принтеров |Selection, single row функции, GROUP BY, JOIN|
| [Family](https://github.com/KunxY174/SQL/tree/main/Family)|Содержит информацию о покупках семьи |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Human Resources](https://github.com/KunxY174/SQL/tree/main/Human-Resources)|Содержит информацию о сотрудниках, департаментах, регионах, истории работ.|Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Recycling Company](https://github.com/KunxY174/SQL/tree/main/Recycling-Company)|Содержит информацию фирме вторсырья и ее пунктах |Selection, single row функции, GROUP BY, JOIN|
| [Schedule](https://github.com/KunxY174/SQL/tree/main/Schedule)|Содержит информацию о студентах, преподавателях, расписании уроков, предметах |Selection, single row функции, GROUP BY, JOIN, DML, DDL команды|
| [Ships](https://github.com/KunxY174/SQL/tree/main/Ships)|Содержит информацию о кораблях, технических характеристиках, сражениях с результатом |Selection, single row функции, GROUP BY, JOIN|


<details><summary>Air Travels</summary>
Схема БД состоит из четырех таблиц:
Product(maker, model, type)
PC(code, model, speed, ram, hd, cd, price)
Laptop(code, model, speed, ram, hd, price, screen)
Printer(code, model, color, type, price)
Таблица Product представляет производителя (maker), номер модели (model) и тип ('PC' - ПК, 'Laptop' - ПК-блокнот или 'Printer' - принтер). Предполагается, что номера моделей в таблице Product уникальны для всех производителей и типов продуктов. В таблице PC для каждого ПК, однозначно определяемого уникальным кодом – code, указаны модель – model (внешний ключ к таблице Product), скорость - speed (процессора в мегагерцах), объем памяти - ram (в мегабайтах), размер диска - hd (в гигабайтах), скорость считывающего устройства - cd (например, '4x') и цена - price (в долларах). Таблица Laptop аналогична таблице РС за исключением того, что вместо скорости CD содержит размер экрана -screen (в дюймах). В таблице Printer для каждой модели принтера указывается, является ли он цветным - color ('y', если цветной), тип принтера - type (лазерный – 'Laser', струйный – 'Jet' или матричный – 'Matrix') и цена - price.


</details>
