--zad1
create view ASYSTENCI (ID, NAZWISKO, PLACA, STAZ_PRACY) as
SELECT ID_PRAC, NAZWISKO, PLACA_POD, EXTRACT(YEAR FROM current_date)  - EXTRACT(YEAR FROM zatrudniony) || 
'miesiace:' || mod(trunc(months_between(current_date,zatrudniony), 0), 12)
from PRACOWNICY 
WHERE etat='ASYSTENT';

select * from asystenci;

select nazwisko, etat from pracownicy;

--zad2
create or replace view PLACE as
select id_zesp, avg(placa_pod) as "sred", min(nvl(placa_pod,0)) as "min", sum(placa_pod) as "fundusz", count(placa_pod) as "l_pensji", count(placa_dod) as "l_dodatkow" 
from pracownicy
group by id_zesp
order by id_zesp;

select * from place;

--zad3
--cos nie smiga
select p.nazwisko, p.placa_pod
from pracownicy p
where (select p2.sred from place p2 where p.id_zesp = p2.id_zesp) < p.placa_pod;


select p.nazwisko, p.placa_pod
from pracownicy p
join place p2 on p.id_zesp = p2.id_zesp
where p2."sred" < p.placa_pod;

--zad4
create or replace view PLACE_MINIMALNE as
select id_prac, nazwisko, etat, placa_pod
from pracownicy
where placa_pod < 700
WITH CHECK OPTION CONSTRAINT kije_wije;

select * from place_minimalne;

--zad5
update place_minimalne
set placa_pod = 800 where nazwisko = 'KOSZLAJDA';

--zad6
create or replace view PRAC_SZEF as
select ;









