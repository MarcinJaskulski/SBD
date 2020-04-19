
--zad5
select nazwa, COUNT(id_prac), SUM(placa_pod)
from zespoly left join pracownicy using(id_zesp)
group by nazwa
when COUNT(id_prac) = '0';


--zad1
select nazwisko, id_zesp, nazwa
from pracownicy LEFT JOIN zespoly USING(id_zesp)
order by nazwisko;
--zad2
select nazwa, id_zesp, COALESCE(nazwisko, 'Brak pracownika')
from zespoly left join pracownicy using(id_zesp)
order by nazwa, nazwisko;
--zad3
select COALESCE(nazwa, 'Brak zespolu'), COALESCE(nazwisko, 'Brak pracownika')
from zespoly full join pracownicy using(id_zesp)
order by nazwa, nazwisko;
--zad4
select nazwa, count(id_prac), sum(placa_pod)
from zespoly LEFT JOIN pracownicy using(id_zesp)
group by nazwa;
--zad5
select nazwa 
from zespoly LEFT JOIN pracownicy using(id_zesp)
group by nazwa
having count(id_prac) = 0;
--zad6
select p.nazwisko, p.id_prac, s.nazwisko, s.id_prac
from pracownicy p LEFT JOIN pracownicy s ON p.id_szefa = s.id_prac
order by p.nazwisko;
--zad7
select s.nazwisko, count(p.id_prac)
from pracownicy s LEFT JOIN pracownicy p ON s.id_prac = p.id_szefa
group by s.nazwisko
order by s.nazwisko;
--zad8
select p.nazwisko, p.etat, p.placa_pod, s.nazwisko
from (pracownicy p NATURAL LEFT JOIN zespoly z) LEFT JOIN pracownicy s ON p.id_szefa = s.id_prac
order by p.nazwisko;
--zad9
select p.nazwisko, z.nazwa
from pracownicy p CROSS JOIN zespoly z
order by p.nazwisko;
--zad10
select count(*)
from pracownicy  CROSS JOIN zespoly  CROSS JOIN etaty;
---------OPERATORY ZBIOROWE
--zad11
select etat from pracownicy where extract(YEAR FROM zatrudniony) =  '1992'
UNION
select etat from pracownicy where extract(YEAR FROM zatrudniony) =  '1993';
--zad12 -- !!!
select id_zesp from zespoly
MINUS
select id_zesp from pracownicy;
--zad13 -- !!!
select id_zesp, nazwa from zespoly
MINUS
select id_zesp, nazwa
from pracownicy LEFT JOIN zespoly USING(id_zesp);
--zad14
select nazwisko, placa_pod, 'Poni¿ej 480 zotych' from pracownicy where placa_pod < 480
UNION 
select nazwisko, placa_pod, 'Dokadnie 480 zotych' from pracownicy where placa_pod = 480
UNION
select nazwisko, placa_pod, 'Powy¿ej 480 zotych' from pracownicy where placa_pod > 480
order by placa_pod;



