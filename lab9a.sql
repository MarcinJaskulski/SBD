--zad1
CREATE TABLE projekty ( id_projektu NUMBER(4,0) GENERATED ALWAYS AS IDENTITY,
                        opis_projektu VARCHAR2(20 CHAR),
                        data_rozpoczecia DATE DEFAULT CURRENT_DATE,
                        data_zakoczenia DATE,
                        fundusz NUMBER(7,2));
--zad2
insert into projekty (opis_projektu, data_rozpoczecia, data_zakoczenia, fundusz) VALUES('indeksy bitmapowe', '1999-04-02', '2001-08-31', 25000);
insert into projekty (opis_projektu, fundusz) VALUES('Sieci krêgos³upowe', 19000);

--zad3
select * from projekty;

--zad4
insert into projekty (opis_projektu, data_rozpoczecia, data_zakoczenia, fundusz) 
VALUES('Indeksy drzewiaste', '2013-12-24', '2014-01-01', 1200);

--zad5
update projekty SET id_projektu = 10
where opis_projektu = 'Indeksy drzewiaste';

--zad6
create table projekty_kopia 
    as select * from projekty;
    
select * from projekty_kopia;

--zad7 -- !!!
insert into projekty_kopia (id_projektu, opis_projektu, data_zakoczenia, fundusz) VALUES(10, 'Sieci lokalne', CURRENT_DATE + 1, 24500);

--zad8
delete from projekty where opis_projektu = 'Indeksy drzewiaste';

select * from projekty_kopia;
--NIE!

--zad9
select TABLE_NAME from USER_TABLES;

