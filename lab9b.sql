--zad1 --!!!
alter table projekty add constraint pk_projekty PRIMARY KEY(id_projektu);
alter table projekty add constraint uk_projekty UNIQUE(opis_projektu);
alter table projekty modify opis_projektu NOT NULL;
alter table projekty add check(data_zakonczenia > data_rozpoczecia);
alter table projekty add check(fundusz > 0 OR fundusz IS NULL);

--alter table projekty rename column data_zakoczenia to data_zakonczenia;

SELECT *
FROM user_constraints
WHERE table_name = 'PROJEKTY';

select * from projekty;

--zad2
insert into projekty (opis_projektu, data_rozpoczecia, data_zakonczenia, fundusz) VALUES('Indeksy bitmapowe', '2015-04-12', '2016-09-30', 40000);

--zad3 --!!!
create table przydzialy (constraint PK_PRZYDZIALY primary key(id_projektu, nr_pracownika),
                         constraint CHK_PRZYDZIALY_DATY check (od < do),
                         id_projektu NUMBER(4,0) constraint FK_PRZYDZIALY_01 not null references projekty(id_projektu),
                         nr_pracownika NUMBER(6,0) constraint FK_PRZYDZIALY_02 not null references pracownicy(id_prac),
                         od DATE DEFAULT CURRENT_DATE,
                         do DATE,
                         stawka NUMBER(7,2) constraint CHK_PRZYDZIALY_STAWKA check (stawka > 0 ),
                         rola VARCHAR2(20) constraint CHK_PRZYDZIALY_ROLA check(rola IN( 'KIERUJ¥CY', 'ANALITYK', 'PROGRAMISTA') )
                         );
--zad4
insert into przydzialy (id_projektu, nr_pracownika, od, do, stawka, rola) 
    VALUES( (select id_projektu from projekty where opis_projektu = 'Indeksy bitmapowe'), 
    170, '1999-04-10', '1999-05-10', 1000, 'KIERUJ¥CY');
    
insert into przydzialy (id_projektu, nr_pracownika, od, stawka, rola) 
    VALUES ( (SELECT ID_PROJEKTU FROM PROJEKTY WHERE OPIS_PROJEKTU = 'Indeksy bitmapowe'), 
    140, '1999/04/10', 1500, 'ANALITYK');
    
insert into przydzialy (id_projektu, nr_pracownika, od, stawka, rola) 
    VALUES ( (SELECT ID_PROJEKTU FROM PROJEKTY WHERE OPIS_PROJEKTU = 'Sieci krêgos³upowe'), 
    140, '2015/09/14', 2500, 'KIERUJ¥CY');
    
select * from przydzialy;

--zad5
alter table przydzialy add godziny NUMBER(4,0) NOT NULL;
--nie mo¿na dodawaæ wymaganych kolumn do istniejacej tabeli

--zad6
alter table przydzialy drop column godziny;
update przydzialy set godziny = 1000;
alter table przydzialy modify godziny not null;

--zad7 -- !!!
alter table projekty disable unique(opis_projektu);

SELECT CONSTRAINT_NAME, STATUS FROM USER_CONSTRAINTS;

--zad8
INSERT INTO projekty (opis_projektu, DATA_ROZPOCZECIA, DATA_ZAKONCZENIA, FUNDUSZ) 
    VALUES ( 'Indeksy bitmapowe', '2015/05/12','2016/09/30', 40000);

select * from projekty;

--zad9
alter table projekty enable unique(opis_projektu);
--nie da siê ustawiæ, bo dwie wartoœci sa takie same

--zad10
update projekty set opis_projektu = 'Inne indeksy' where id_projektu = 6;
alter table projekty enable unique(opis_projektu);
--teraz juz mozna ustawic

--zad11
alter table projekty modify opis_projektu VARCHAR2(10);
--nie udalo siê poniwea¿ obecnie znajduja sie tam dluzsze teksty 

--zad12
delete from projekty where opis_projektu = 'Sieci krêgos³upowe';
--sieci kregosupowe maja podrzêdny rekord w przydzialach

select * from projekty;

--zad13 --!!! -- nie dziala (?)
alter table przydzialy drop constraint FK_PRZYDZIALY_01;
alter table przydzialy add constraint FK_PRZYDZIALY_01 references projekty(id_projektu) ON DELETE CASCADE;

ALTER TABLE przydzialy ADD CONSTRAINT FK_PRZYDZIALY_01 FOREIGN KEY(id_projektu)
REFERENCES projekty(id_projektu) ON DELETE CASCADE;

select * from USER_CONSTRAINTS where CONSTRAINT_NAME = 'FK_PRZYDZIALY_01';

SELECT CONSTRAINT_NAME, STATUS FROM USER_CONSTRAINTS;

--zad14
DROP TABLE projekty CASCADE CONSTRAINTS;

--zad15
DROP TABLE przydzialy;
DROP TABLE projekty_kopia;

select * from user_tables;

select * from etaty;
select * from pracownicy;
select * from zespoly;
