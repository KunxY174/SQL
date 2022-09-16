 --1.  Получите описание таблицы REGIONS, используя её полное имя
DESC hr.regions;

--2. Ïîëó÷èòå îïèñàíèå òàáëèöû COUNTRIES, èñïîëüçóÿ å¸ ïîëíîå èìÿ.
DESC hr.countries;

--3. Ïîëó÷èòå îïèñàíèå òàáëèöû JOBS, èñïîëüçóÿ å¸ êîðîòêîå èìÿ.*/
DESC hr.jobs;

--4. Ïîëó÷èòå îïèñàíèå òàáëèöû LOCATIONS, èñïîëüçóÿ å¸ êîðîòêîå èìÿ.*/
DESC hr.locations;

--5. Âûâåäèòå âñþ èíôîðìàöèþ î ðåãèîíàõ.*/
SELECT * 
FROM regions;

--6. Âûâåäèòå èíôîðìàöèþ î èìåíè, id äåïàðòàìåíòà, çàðïëàòå è ôàìèëèè 
äëÿ âñåõ ðàáîòíèêîâ.*/
SELECT first_name, department_id, salary, last_name 
FROM employees;

--7. Âûâåäèòå èíôîðìàöèþ î id ðàáîòíèêà, ýëåêòðîííîé ïî÷òå è äàòó, 
êîòîðàÿ áûëà çà íåäåëþ äî òðóäîóñòðîéñòâà äëÿ âñåõ ðàáîòíèêîâ. 
Ñòîëáåö, êîòîðûé áóäåò ñîäåðæàòü äàòó íàçîâèòå One week before hire
date.*/
SELECT employee_id, email, hire_date-7 AS "One week before hire date" 
FROM employees;

--8. Âûâåäèòå èíôîðìàöèþ î ðàáîòíèêàõ ñ èõ ïîçèöèÿìè â ôîðìàòå: 
Donald(SH_CLERK) . Íàçîâèòå ñòîëáåö our_employees .*/
SELECT first_name || '(' || job_id || ')' our_employees
FROM employees;

--9.  Âûâåäèòå ñïèñîê óíèêàëüíûõ èì¸í ñðåäè ðàáîòíèêîâ.*/
SELECT DISTINCT first_name
FROM employees;

--10.Âûâåäèòå ñëåäóþùóþ èíôîðìàöèþ èç òàáëèöû jobs: 
--- job_title, 
--- âûðàæåíèå â ôîðìàòå: «min = 20080, max = 40000», 
--ãäå 20080 – ýòî ìèíèìàëüíàÿ ç/ï, à 40000 – ìàêñèìàëüíàÿ.
--Íàçîâèòå ýòîò ñòîëáåö info.
--- ìàêñèìàëüíóþ ç/ï è íàçîâèòå ñòîëáåö max,
--- íîâóþ ç/ï, êîòîðàÿ áóäåò íàçûâàòüñÿ new_salary è âû÷èñëÿòüñÿ ïî 
ôîðìóëå: max_salary*2-2000*/
SELECT job_title,  'min = ' || min_salary || ', max = ' || max_salary AS info, max_salary AS max, max_salary*2-2000 AS new_salary
FROM jobs;

--11. Âûâåäèòå íà ýêðàí ïðåäëîæåíèå «Peter's dog is very clever», èñïîëüçóÿ 
îäíó èç äâóõ òåõíèê ðàáîòû ñ îäèíàðíûìè êàâû÷êàìè.*/
SELECT 'Peter''s dog is very clever'
FROM dual;

--12. Âûâåäèòå íà ýêðàí ïðåäëîæåíèå «Peter's dog is very clever», èñïîëüçóÿ, îòëè÷íóþ îò ïðåäûäóùåãî ïðèìåðà, òåõíèêó ðàáîòû ñ îäèíàðíûìè êàâû÷êàìè.
SELECT q'<Peter's dog is very clever>'
FROM dual;

. Âûâåäèòå íà ýêðàí êîëè÷åñòâî ìèíóò â îäíîì âåêå (1 ãîä = 365.25 
äíåé).
SELECT 100*365.25*24*60 
FROM dual;

/*14.Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ ñ èìåíåì David.*/
SELECT * 
FROM employees
WHERE first_name = 'David';

/*15. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ job_id ðàâåí FI_ACCOUNT.*/
SELECT * 
FROM employees
WHERE job_id = 'FI_ACCOUNT';

/*16.  Âûâåäèòå èíôîðìàöèþ î èìåíè, ôàìèëèè, ç/ï è íîìåðå äåïàðòàìåíòà 
äëÿ ñîòðóäíèêîâ èç 50ãî äåïàðòàìåíòà ñ çàðïëàòîé, áîëüøåé 4000.*/
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 50
AND salary > 4000;

/*17. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, êîòîðûå ðàáîòàþò èëè â 20ì, èëè â 
30ì äåïàðòàìåíòå.*/
SELECT *
FROM employees
where department_id = 20 or department_id = 30;

/*18. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ âòîðàÿ è ïîñëåäíÿÿ áóêâà 
â èìåíè ðàâíà 'a'.*/
SELECT *
FROM employees
WHERE first_name like '_a%a';

/*19. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ èç 50ãî è èç 80ãî äåïàðòàìåíòà, ó 
êîòîðûõ åñòü áîíóñ(êîìèññèîííûå). Îòñîðòèðóéòå ñòðîêè ïî email
(âîçðàñòàþùèé ïîðÿäîê), èñïîëüçóÿ åãî ïîðÿäêîâûé íîìåð.*/
SELECT *
FROM employees
WHERE (department_id = 50 or department_id = 80)
AND commission_pct is not null
order by 4;

/*20. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ â èìåíè ñîäåðæàòñÿ 
ìèíèìóì 2 áóêâû 'n'.*/
SELECT * 
FROM employees
WHERE first_name like '%n%n%';

/*21. Ïîëó÷èòü ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ äëèíà èìåíè áîëüøå 4 
áóêâ. Îòñîðòèðóéòå ñòðîêè ïî íîìåðó äåïàðòàìåíòà (óáûâàþùèé 
ïîðÿäîê) òàê, ÷òîáû çíà÷åíèÿ “null” áûëè â ñàìîì êîíöå.*/
SELECT * 
FROM employees
WHERE first_name like '%_____%'
order by department_id desc nulls last;

/*22. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ çàðïëàòà íàõîäèòñÿ â 
ïðîìåæóòêå îò 3000 äî 7000 (âêëþ÷èòåëüíî), íåò áîíóñà 
(êîìèññèîííûõ) è job_id ñðåäè ñëåäóþùèõ âàðèàíòîâ: PU_CLERK, 
ST_MAN, ST_CLERK.*/
SELECT * 
FROM employees
WHERE salary between 3000 and 7000
AND commission_pct is null
AND job_id in ('PU_CLERK', 'ST_MAN', 'ST_CLERK');

/*23. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ ó êîòîðûõ â èìåíè ñîäåðæèòñÿ 
ñèìâîë '%'.*/
SELECT *
FROM employees
WHERE first_name like '%\%%' escape '\';

/*24. Âûâåäèòå èíôîðìàöèþ î job_id, èìåíå è ç/ï äëÿ ðàáîòíèêîâ, ðàáî÷èé 
id êîòîðûõ áîëüøå èëè ðàâåí 120 è job_id íå ðàâåí IT_PROG. 
Îòñîðòèðóéòå ñòðîêè ïî job_id (âîçðàñòàþùèé ïîðÿäîê) è èìåíàì 
(óáûâàþùèé ïîðÿäîê).*/
SELECT job_id, first_name, salary
FROM employees
WHERE employee_id >= 120
AND job_id != 'IT_PROG';

/*25. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ äëèíà èìåíè áîëüøå 10 áóêâ.*/
select * 
from employees
where length(first_name)>10;

/*26. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, çàðïëàòà êîòîðûõ êðàòíà 1000.*/
select *
from employees
where mod(salary, 1000)=0;

/*27. Âûâåäèòå òåëåôîííûé íîìåð è ïåðâîå 3õ çíà÷íîå ÷èñëî òåëåôîííîãî íîìåðà ñîòðóäíèêà, åñëè åãî íîìåð ïðåäñòàâëåí â ôîðìàòåÕÕÕ.ÕÕÕ.ÕÕÕÕ.
select phone_number, substr (phone_number, 1, 3)*/
from employees
where phone_number like '___.___.____';

/*28.  Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, ó êîòîðûõ ïîñëåäíÿÿ áóêâà â èìåíè ðàâíà 'm' è äëèíà èìåíè áîëüøå 5òè.*/
select *
from employees
where substr (first_name, -1) = 'm'
and length (first_name)>5;

/*29.  Âûâåäèòå äàòó ñëåäóþùåé ïÿòíèöû.*/
select next_day (sysdate , 'FRIDAY') fri 
from dual;

/*30. Ïîëó÷èòå ñïèñîê âñåõ ñîòðóäíèêîâ, êîòîðûå ðàáîòàþò â êîìïàíèè áîëüøå 12 ëåò è 6òè ìåñÿöåâ (150 ìåñÿöåâ).*/
select * from employees
where   months_between (sysdate, hire_date)>150;

/*31. Âûâåäèòå òåëåôîííûé íîìåð, çàìåíèâ â çíà÷åíèè PHONE_NUMBER âñå '.' íà '-'.*/
select replace(phone_number, '.', '-')
from employees;

/*32. Âûâåäèòå èìÿ, email, job_id äëÿ âñåõ ðàáîòíèêîâ â ôîðìàòå: STEVEN sking Ad_Pres */
select upper (first_name), lower (email), initcap (job_id)
from employees;

/*33. Âûâåäèòå èíôîðìàöèþ î èìåíè ðàáîòíèêà è åãî ç/ï, íå èñïîëüçóÿ cèìâîë || , â òàêîì âèäå: Steven24000 */
select concat (first_name, salary)
from employees;

/*34. Âûâåäèòå èíôîðìàöèþ î äàòå ïðè¸ìà ñîòðóäíèêà íà ðàáîòó, îêðóãë¸ííîé äàòå ïðè¸ìà íà ðàáîòó äî ìåñÿöà è ïåðâîì äíå ãîäà ïðè¸ìà íà ðàáîòó. */
select hire_date, round (hire_date, 'MM'), trunc(hire_date, 'YYYY')
from employees;

/*35. Âûâåäèòå èíôîðìàöèþ î èìåíè è ôàìèëèè âñåõ ðàáîòíèêîâ. Èìÿ äîëæíî ñîñòîÿòü èç 10 ñèìâîëîâ è åñëè äëèíà èìåíè ìåíüøå 10, 
òî äîïîëíÿéòå äî 10 ñèìâîëîâ çíàêîì $. Ôàìèëèÿ äîëæíà ñîñòîÿòü èç 15 ñèìâîëîâ è åñëè äëèíà ôàìèëèè ìåíüøå 15,
òî ïåðåä ôàìèëèåé ñòàâüòå ñòîëüêî çíàêîâ ! ñêîëüêî íåîáõîäèìî. */ 
select rpad (first_name, 10, $), lpad (last_name, 15, '!')
from employees;

/*36. Âûâåäèòå èìÿ ñîòðóäíèêà è ïîçèöèþ âòîðîé áóêâû ‘a’ â åãî èìåíè. */
select first_name, instr(first_name, 'a', 1, 2)
from employees;

/*37. Âûâåäèòå íà ýêðàí òåêñò '!!!HELLO!! MY FRIEND!!!!!!!!' è òîò æå òåêñò, íî áåç ñèìâîëà âîñêëèöàòåëüíûé çíàê â íà÷àëå è êîíöå òåêñòà. */
select '!!!HELLO!! MY FRIEND!!!!!!!!', trim ('!' from '!!!HELLO!! MY FRIEND!!!!!!!!')
from dual;

/*38. Âûâåäèòå èíôîðìàöèþ î:
- ç/ï ðàáîòíèêà,
- ç/ï óìíîæåííîé íà êîýôôèöèåíò 3.1415 ,
- îêðóãë¸ííûé äî öåëîãî çíà÷åíèÿ âàðèàíò óâåëè÷åííîé ç/ï-òû, 
- öåëîå êîëè÷åñòâî òûñÿ÷ èç óâåëè÷åííîé ç/ï. */
select salary, salary*3.1415, round (salary*3.1415), trunc (salary*3.1415, -3)/1000
from employees;
/*39. .Âûâåäèòå èíôîðìàöèþ î:
- äàòå ïðè¸ìà ñîòðóäíèêà íà ðàáîòó,
- äàòå, êîòîðàÿ áûëà ÷åðåç ïîë ãîäà, ïîñëå ïðèíÿòèÿ ñîòðóäíèêà íà ðàáîòó,
- äàòå ïîñëåäíåãî äíÿ â ìåñÿöå ïðèíÿòèÿ ñîòðóäíèêà íà ðàáîòó */
select hire_date, add_months (hire_date, 6), last_day (hire_date)
from employees;


 
 
 
