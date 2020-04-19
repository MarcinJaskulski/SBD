--zad1
select pracownicy.nazwisko, pracownicy.etat, pracownicy.id_zesp, zespoly.nazwa
from pracownicy inner join zespoly ON pracownicy.id_zesp = zespoly.id_zesp
order by pracownicy.nazwisko;

select nazwisko, etat, id_zesp, nazwa
from pracownicy INNER JOIN zespoly USING (id_zesp);

--zad2
select pracownicy.nazwisko, pracownicy.etat, pracownicy.id_zesp, zespoly.nazwa
from pracownicy inner join zespoly ON pracownicy.id_zesp = zespoly.id_zesp
where zespoly.adres = 'PIOTROWO 3A'
order by pracownicy.nazwisko;

--zad3
select nazwisko, etat, placa_pod, etaty.placa_min, etaty.placa_max
from pracownicy inner join etaty ON etaty.nazwa = pracownicy.etat;

--zad4 -- !!!
select nazwisko, etat, placa_pod, placa_min, placa_max, 
case 
    when placa_pod between placa_min AND placa_max then 'OK'
    else 'NIE'
end
from pracownicy inner join etaty ON etaty.nazwa = pracownicy.etat;

--zad5
select nazwisko, etat, placa_pod, placa_min, placa_max, 
case 
   when placa_pod between placa_min AND placa_max then 'OK'
    else 'NIE'
end
from pracownicy inner join etaty ON etaty.nazwa = pracownicy.etat
where placa_pod not between placa_min AND placa_max;

--zad6
select p.nazwisko, p.placa_pod, p.etat, e.nazwa, e.placa_min, e.placa_max
from pracownicy p INNER JOIN etaty e ON p.placa_pod BETWEEN e.placa_min AND e.placa_max order by p.nazwisko;

--zad7
select p.nazwisko, p.placa_pod, p.etat, e.nazwa, e.placa_min, e.placa_max
from pracownicy p INNER JOIN etaty e ON p.placa_pod BETWEEN e.placa_min AND e.placa_max 
where e.nazwa = 'SEKRETARKA'
order by p.nazwisko;

--zad8
select p.nazwisko, p.id_prac, s.nazwisko, s.id_prac
from pracownicy p INNER JOIN pracownicy s ON p.id_szefa = s.id_prac order by p.nazwisko;

--zad9 --!!!
select p.nazwisko, p.id_prac, s.nazwisko, p.zatrudniony, (extract(YEAR FROM p.zatrudniony) - extract(YEAR FROM s.zatrudniony)) AS ZATRUDNIONY 
from pracownicy p INNER JOIN pracownicy s ON p.id_szefa = s.id_prac 
where (extract(YEAR FROM p.zatrudniony) - extract(YEAR FROM s.zatrudniony)) < 10
order by p.zatrudniony;

--zad10
select z.nazwa, COUNT(*),  AVG(p.placa_pod)
from pracownicy p INNER JOIN zespoly z USING(id_zesp)
group by z.nazwa
order by z.nazwa;

--zad11
select z.nazwa,
    case
        WHEN count(*) <= 2 THEN 'MALY'
        WHEN count(*) between 3 and 6 THEN 'SREDNI'
        WHEN count(*) >= 7 THEN 'DUZY'
        END AS "ETYKIETA"
from pracownicy p INNER JOIN zespoly z USING(id_zesp)
group by z.nazwa
order by z.nazwa;
