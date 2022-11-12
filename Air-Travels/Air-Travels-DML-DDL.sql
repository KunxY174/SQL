--1.Удалить компании, совершившие наименьшее количество рейсов.
DELETE from Company
where name in (
    WITH t1 as (
      select name,
        count (t.id) qrt
      from Company c
        join trip t on (c.id = t.company)
      group by name
    )
    select name
    from t1
    where qrt = (
        select min (qrt)
        from t1
      )
  );

--2.Удалить все перелеты, совершенные из Москвы (Moscow).
DELETE from Trip
where town_from = 'Moscow';