--zad1
create view asystenci(id, nazwisko, placa, staz) 
    AS select id_prac, nazwisko, placa_pod + nvl(placa_dod,0), 
    extract(year from current_date)- extract(year from zatrudniony) || ' miesciace: ' || mod(trunc(months_between(current_date,zatrudniony) ,0),12)
    from pracownicy where etat='ASYSTENT';
    
select * from asystenci order by nazwisko;

--zad2
create view place(id_zesp, srednia, minimum, maximum, fundusz, l_pensja, l_dodatkow)
    AS select id_zesp, avg(placa_pod+nvl(placa_dod,0)), min(placa_pod+nvl(placa_dod,0)), 
        max(placa_pod+nvl(placa_dod,0)), sum(placa_pod+nvl(placa_dod,0)), count(placa_pod), count(placa_dod)
    from pracownicy group by id_zesp;

select * from place order by id_zesp;

--zad3
select nazwisko, placa_pod from pracownicy p left join place p2 using(id_zesp) where p.placa_pod < p2.srednia;

--zad4
create view place_minimalne(id_prac, nazwisko, etat, placa_pod) 
as select id_prac, nazwisko, etat, placa_pod from pracownicy where placa_pod <700
with check option CONSTRAINT za_duzo;

select * from place_minimalne;

--zad5
update place_minimalne set placa_pod = 800 where nazwisko = 'HAPKE';

--zad6
create view prac_szef(id_prac, id_szefa, pracownik, etat, szef) 
AS select p.id_prac, p.id_szefa, p.nazwisko, p.etat, s.nazwisko from pracownicy p left join pracownicy s ON p.id_szefa = s.id_prac;

select * from prac_szef order by pracownik;

INSERT INTO prac_szef (ID_PRAC, ID_SZEFA, PRACOWNIK, ETAT) VALUES (280,150, 'MORZY','ASYSTENT');
UPDATE prac_szef SET ID_SZEFA = 130 WHERE ID_PRAC = 280;
DELETE FROM prac_szef WHERE ID_PRAC = 280;

--zad7
create view zarobki(id_prac, nazwisko, etat, placa_pod)
as select p.id_prac, p.nazwisko, p.etat, p.placa_pod from pracownicy p left join pracownicy s ON p.id_szefa = s.id_prac
where p.placa_pod < s.placa_pod 
with check option constraint za_wysoka_placa_2;

select * from zarobki;

UPDATE zarobki SET placa_pod = 2000
WHERE NAZWISKO = 'BIALY';

--zad8
SELECT COLUMN_NAME, UPDATABLE, INSERTABLE, DELETABLE, TABLE_NAME FROM
USER_UPDATABLE_COLUMNS WHERE TABLE_NAME = 'prac_szef';

drop view prac_szef;

