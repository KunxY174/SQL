--58.Добавить отзыв с рейтингом 5 на жилье, находящиеся по адресу "11218, Friel Place, New York", от имени "George Clooney"
INSERT into reviews 
SEt id = (select count(*)+1 
          from reviews as a),
rating=5,
reservation_id = (select r.id 
                  from reservations  r
                  join rooms ro
                  on (r.room_id=ro.id)
                  join users u
                  on (r.user_id=u.id)
                  where address= '11218, Friel Place, New York'
                  and name = 'George Clooney');