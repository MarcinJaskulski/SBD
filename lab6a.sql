--zad1
select nazwisko, etat, id_zesp
from pracownicy
where id_zesp = (select id_zesp from pracownicy where nazwisko = 'BRZEZINSKI');
--zad2
select nazwisko, etat, nazwa
from pracownicy left join zespoly USING(id_zesp)
where id_zesp = (select id_zesp from pracownicy where nazwisko = 'BRZEZINSKI');
--zad3
select nazwisko, etat, zatrudniony from pracownicy
where zatrudniony = (select MIN(zatrudniony) from pracownicy where etat = 'PROFESOR');
--zad4
select nazwisko, zatrudniony, id_zesp
from pracownicy
where zatrudniony IN (select MAX(zatrudniony) from pracownicy group by id_zesp ) 
order by zatrudniony;
--zad5
select id_zesp, nazwa, adres
from zespoly
where id_zesp IN (select id_zesp 
                  from pracownicy RIGHT JOIN zespoly USING(id_zesp)
                  group by id_zesp having COUNT(id_prac) = 0);

select id_zesp,nazwa,adres from zespoly 
where id_zesp in (select z.id_zesp from pracownicy p right outer join zespoly z on p.ID_ZESP=z.ID_ZESP where p.ID_ZESP is null);
--zad6
select nazwisko, id_prac from pracownicy
where id_prac NOT IN (select distinct id_szefa from pracownicy where id_szefa IS NOT NULL AND etat='STAZYSTA') AND etat='PROFESOR';
--zad7
select id_zesp, SUM(placa_pod)
from pracownicy
group by id_zesp
having SUM(placa_pod) = (select MAX(SUM(placa_pod)) from pracownicy group by id_zesp);
--zad8
select nazwa, SUM(placa_pod)
from pracownicy RIGHT JOIN zespoly USING(id_zesp)
group by nazwa
having SUM(placa_pod) = (select MAX(SUM(placa_pod)) from pracownicy group by id_zesp);
--zad9
select nazwa, count(id_prac)
from zespoly left join pracownicy using(id_zesp)
group by nazwa
having count(id_prac) > (select count(id_prac) from pracownicy right join zespoly using(id_zesp) group by nazwa having nazwa='ADMINISTRACJA');
--zad10
select etat
from pracownicy
group by etat
having COUNT(id_prac) = (select MAX(COUNT(id_prac)) from pracownicy group by etat);
--zad11
select etat, listagg(nazwisko, ',')
from pracownicy
group by etat
having COUNT(id_prac) = (select MAX(COUNT(id_prac)) from pracownicy group by etat);
--zad12 --!!!
select p.nazwisko, s.nazwisko
from pracownicy p JOIN pracownicy s ON p.id_szefa = s.id_prac
where abs(s.placa_pod - p.placa_pod) = (select MIN(s2.placa_pod - p2.placa_pod) 
                                       from pracownicy p2 JOIN pracownicy s2 ON p2.id_szefa = s2.id_prac);

