/*1. ������� ����� ������, �������� � ������ �������� ����� ��� ���� �� ���������� ����� 500 ���. �������: model, speed � hd*/
select model, speed, hd
from pc
where price<500;

/*2. ������� �������������� ���������. �������: maker*/
select distinct maker
from product
where type = 'printer';

/*3. ������� ����� ������, ����� ������ � ������� ������� ��-���������, ���� ������� ��������� 1000 ���.*/
select model, ram, screen
from laptop
where price >1000;

/*4.  ������� ��� ������ ������� Printer ��� ������� ���������.*/
select *
from printer
where color = 'y';

/*5.  ������� ����� ������, �������� � ������ �������� ����� ��, ������� 12x ��� 24x CD � ���� ����� 600 ���.*/
select model, speed, hd 
from pc 
where (cd = '12x' or cd = '24x') 
and price < 600;

/*6.��� ������� �������������, ������������ ��-�������� c ������� �������� ����� �� ����� 10 �����, 
����� �������� ����� ��-���������. �����: �������������, ��������*/
select distinct  maker, speed
from product p
join laptop l
on (p.model=l.model)
where hd>=10;

/*7. ������� ������ ������� � ���� ���� ��������� � ������� ��������� (������ ����) ������������� B (��������� �����).*/
select pr.model, price
from product pr
join pc p
on (pr.model=p.model)
where maker = 'B'
union
select pr.model, price
from product pr
join laptop l
on (pr.model=l.model)
where maker = 'B'
union
select pr.model, price
from product pr
join printer pri
on (pr.model=pri.model)
where maker = 'B'

/*8. ������� �������������, ������������ ��, �� �� ��-��������.*/
select maker 
from product
where type = 'pc'
except 
select maker 
from product
where type = 'laptop';

/*9. ������� �������������� �� � ����������� �� ����� 450 ���. �������: Maker*/
select distinct maker
from pc p
join product pr
on(p.model=pr.model)
where speed>=450;

/*10. ������� ������ ���������, ������� ����� ������� ����. �������: model, price*/
select model, price
from printer
where price = (select max(price)
                from printer);