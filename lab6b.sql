--zad1
select z.id_zesp, z.nazwa, z.adres from zespoly z
where (select count(id_prac) from pracownicy where id_zesp = z.id_zesp) = 0;

select id_zesp, nazwa, adres from zespoly where id_zesp = (select id_zesp from pracownicy right join zespoly using(id_zesp) group by id_zesp having count(id_prac) =0);

--zad2
select nazwisko, placa_pod, etat 
from pracownicy p where placa_pod > (select avg(placa_pod)  from pracownicy where p.etat = etat) 
order by placa_pod desc;

--zad3
select nazwisko, placa_pod 
from pracownicy p 
where placa_pod > 0.75*(select placa_pod from pracownicy where p.id_szefa = id_prac);

--zad4 ---!!!
select p.nazwisko from pracownicy p 
where NOT EXISTS (select * from pracownicy where etat = 'STAZYSTA' AND id_szefa=p.id_prac ) AND etat='PROFESOR';

--zad5 ---???
select suma from (select max(sum(placa_pod)) as suma from pracownicy right join zespoly using(id_zesp)
group by nazwa);

SELECT z.nazwa, sum(placa_pod) AS suma_plac 
FROM zespoly z JOIN pracownicy p ON p.id_zesp = z.id_zesp 
GROUP BY z.nazwa HAVING sum(placa_pod) >= (SELECT max(sum(placa_pod)) FROM Pracownicy 
GROUP BY id_zesp);  

--zad6 --- !!! -- liczê ile osób zarabia wiêcej ni¿ ja
select nazwisko, placa_pod from pracownicy p where (select count(*) from pracownicy  WHERE p.placa_pod < placa_pod) < 3
order by placa_pod desc;

--zad7
select extract( YEAR FROM zatrudniony), count(*) from pracownicy group by extract( YEAR FROM zatrudniony) order by count(*) desc;

select ROK,LICZBA from (select extract(year from zatrudniony) as ROK, count(*) as LICZBA from pracownicy group by extract(year from zatrudniony)) order by LICZBA desc;

--zad8
select extract( YEAR FROM zatrudniony), count(*) 
from pracownicy 
group by extract( YEAR FROM zatrudniony) 
having count(*) = (select MAX(count(*)) 
                   from pracownicy 
                   group by extract( YEAR FROM zatrudniony));
--zad9
select nazwisko, placa_pod, placa_pod - (select avg(placa_pod) from pracownicy group by id_zesp having p.id_zesp = id_zesp) AS ROZNICA
from pracownicy p
order by nazwisko;

---!!!
select nazwisko, placa_pod, placa_pod-roznica as "ROZNICA" 
from (select id_zesp, avg(placa_pod) as roznica from pracownicy group by id_zesp) z inner join pracownicy p on z.id_zesp=p.id_zesp 
order by nazwisko;

--zad10
select nazwisko, placa_pod, placa_pod - (select avg(placa_pod) from pracownicy group by id_zesp having p.id_zesp = id_zesp) AS ROZNICA
from pracownicy p
where placa_pod - (select avg(placa_pod) from pracownicy group by id_zesp having p.id_zesp = id_zesp) > 0
order by nazwisko;

select nazwisko, placa_pod, placa_pod-roznica as "ROZNICA" 
from (select id_zesp, avg(placa_pod) as roznica from pracownicy group by id_zesp) z inner join pracownicy p on z.id_zesp=p.id_zesp 
where (placa_pod - roznica) > 0
order by nazwisko;

--zad11
select nazwisko, (select count(id_prac) from pracownicy where id_szefa = s.id_prac) as podwladni
from pracownicy s JOIN zespoly z using(id_zesp)
where etat = 'PROFESOR' AND adres like 'PIOTROWO%';

--zad12
select naz, sr_zesp, srednia, 
    CASE
        WHEN srednia <= sr_zesp THEN ':)'
        WHEN srednia > sr_zesp THEN ':('
        WHEN sr_zesp IS NULL THEN '???'
        END as nastruj
from (select nazwa as naz, AVG(placa_pod) as sr_zesp 
      from zespoly z LEFT JOIN pracownicy p using(id_zesp) 
      group by nazwa) CROSS JOIN (select ROUND(avg(placa_pod),2) as srednia from pracownicy);
      
--zad13 ---!!!
select * from etaty e
order by (select count(id_prac) from pracownicy where e.nazwa = etat ) desc, nazwa;

