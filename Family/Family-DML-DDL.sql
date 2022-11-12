--1.Добавьте товар с именем "Cheese" и типом "food" в список товаров (Goods).
INSERT INTO Goods (good_id, good_name, type)
VALUES (17, 'Cheese', 2);

--2.Добавьте в список типов товаров (GoodTypes) новый тип "auto".
INSERT into GoodTypes (good_type_id, good_type_name)
values (9, 'auto');

--3.Измените имя "Andie Quincey" на новое "Andie Anthony".
update FamilyMembers
set member_name = 'Andie Anthony'
where member_name = 'Andie Quincey';

--4.Удалить всех членов семьи с фамилией "Quincey".
DELETE from FamilyMembers
where member_name like '% Quincey';