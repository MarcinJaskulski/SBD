--zad1
insert  into pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp) 
    VALUES(250, 'KOWALSKI', 'ASYSTENT', NULL, '2015-01-13', 1500, null, 10);
insert  into pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp) 
    VALUES(260, 'ADAMSKI', 'ASYSTENT', NULL, '2014-09-10', 1500, null, 10);
insert  into pracownicy (id_prac, nazwisko, etat, id_szefa, zatrudniony, placa_pod, placa_dod, id_zesp) 
    VALUES(270, 'NOWAK', 'ADIUNKT', NULL, '1990-05-01', 2050, 540, 20);
    
select * from pracownicy where id_prac IN (250, 260, 270);

--zad2
UPDATE pracownicy SET placa_pod = placa_pod * 1.1,
       placa_dod = coalesce(placa_dod * 1.2, 100)
where id_prac IN (250, 260, 270);

--zad3
insert into zespoly VALUES(60, 'BAZY DANYCH', 'PIOTROWO 2');
select * from zespoly where id_zesp = 60;

--zad4
update pracownicy SET id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH')
where id_prac IN (250, 260, 270);

select * from pracownicy where id_prac IN (250, 260, 270);

--zad5
update pracownicy SET id_szefa = (select id_prac from pracownicy where nazwisko = 'MORZY')
where id_zesp = (select id_zesp from zespoly where nazwa = 'BAZY DANYCH');

--zad6
DELETE from zespoly 
where nazwa = 'BAZY DANYCH';
--Nie, bo istanieje powiazanie z tym rekordem

--zad7
DELETE from pracownicy 
where id_prac IN (250, 260, 270); 

DELETE from zespoly 
where nazwa = 'BAZY DANYCH';

--zad8 -- !!!
select nazwisko, placa_pod, (select avg(placa_pod) from pracownicy group by id_zesp having id_zesp = p.id_zesp)*0.1
from pracownicy p order by nazwisko;

--zad9 -- !!!
update pracownicy p set placa_pod = (select p.placa_pod+avg(placa_pod)*0.1 from pracownicy where id_zesp=p.id_zesp);

select nazwisko,placa_pod from pracownicy order by nazwisko;

--zad10
select * from pracownicy where id_prac = (select id_prac from pracownicy where (select MIN(placa_pod) from pracownicy) = placa_pod);

--zad11
update pracownicy set placa_pod = (select avg(placa_pod) from pracownicy )
where id_prac = (select id_prac from pracownicy where (select MIN(placa_pod) from pracownicy) = placa_pod);

select * from pracownicy where nazwisko = 'ZAKRZEWICZ';

--zad12
select nazwisko, placa_dod from pracownicy where id_zesp = 20 order by nazwisko;

update pracownicy 
set placa_dod = (select avg(placa_pod) from pracownicy where id_szefa = (select id_prac from pracownicy where nazwisko='MORZY'))
where id_zesp = 20;

--zad13 -- !!!
select nazwisko, placa_pod from pracownicy where id_zesp = (select id_zesp from zespoly where nazwa= 'SYSTEMY ROZPROSZONE') order by nazwisko;

update (select placa_pod from pracownicy left join zespoly using(id_zesp) where nazwa = 'SYSTEMY ROZPROSZONE')
set placa_pod = placa_pod*1.25;

--zad14 -- !!!
delete from 
(select p.nazwisko, s.nazwisko from pracownicy p JOIN pracownicy s ON p.id_szefa = s.id_prac
where s.nazwisko = 'MORZY');

select p.nazwisko, s.nazwisko 
from pracownicy p JOIN pracownicy s ON p.id_szefa = s.id_prac
where s.nazwisko = 'MORZY';

--zad15
select * from pracownicy order by nazwisko;

--------------SEKWENCJE

--zad16
create sequence PRAC_SEQ START WITH 300 INCREMENT BY 10;
--zad17
insert into pracownicy (id_prac,nazwisko,etat,placa_pod)
values (PRAC_SEQ.NEXTVAL, 'Trabczynski','STAZYSTA',1000);
--zad18
update pracownicy set placa_dod = PRAC_SEQ.currval 
where id_prac = 300;

select * from pracownicy where id_prac = 300;

--zad19
delete from pracownicy 
where id_prac = 300;

--zad20
create sequence MALA_SEQ start with 1 increment by 2 maxvalue 10;
select MALA_SEQ.nextval from dual;
--blad przekroczena wartosci maxvalue

--zad21
DROP SEQUENCE MALA_SEQ;


