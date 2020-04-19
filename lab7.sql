--zad1 A
select nazwisko, placa_pod from pracownicy 
order by placa_pod desc fetch first 3 rows only;
--zad1 B
select naz, placa from (select nazwisko as naz, placa_pod as placa from pracownicy order by placa_pod desc)
where rownum <=3 ;
--zad2 A
select nazwisko, placa_pod from pracownicy 
order by placa_pod desc offset 5 rows fetch first 5 rows only;
--zad2 B
select naz, placa 
        from (select naz, placa from 
                (select nazwisko as naz, placa_pod as placa 
                 from pracownicy 
                 order by placa_pod desc) 
        where rownum <= 10 order by placa)
where rownum <=5 order by placa desc;
--zad3
WITH
    avg_zesp AS ( select id_zesp, avg(placa_pod) as srednia from pracownicy group by id_zesp)
select nazwisko, placa_pod, placa_pod - srednia from pracownicy left join avg_zesp using(id_zesp) 
where (placa_pod - srednia) > 0 
order by nazwisko;
--zad4
WITH 
    Lata AS (select extract(year from zatrudniony), count(*) as ile from pracownicy group by extract(year from zatrudniony) )
select * from Lata order by ile desc;
--zad5
WITH 
    Lata AS (select extract(year from zatrudniony) as rok, count(*) as ile from pracownicy group by extract(year from zatrudniony) )
select rok, ile from Lata where ile = (select max(ile) from Lata);
--zad6 --!!!
WITH
    Asystenci AS (select * from pracownicy where etat='ASYSTENT'),
    Piotrowo AS (select * from zespoly where adres like 'PIOTROWO%')
select nazwisko, etat, nazwa, adres from Asystenci JOIN Piotrowo USING(id_zesp);
--zad7
WITH 
    suma_plac AS (select id_zesp, sum(placa_pod) as suma_p from pracownicy group by id_zesp)
select nazwa, suma_p 
from zespoly LEFT JOIN suma_plac USING(id_zesp) 
where suma_p IS NOT NULL
order by suma_p desc FETCH FIRST 1 ROWS ONLY;




--zad8 A
--XDDDDDDDDDDDDDDDDDDDDDDDDDDDDD 
WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
        -- definicja korzenia hierarchii
        (SELECT id_prac, id_szefa, nazwisko, 1
        FROM pracownicy
        WHERE nazwisko = 'BRZEZINSKI'
        UNION ALL 
        -- rekurencyjna definicja ni¿szych poziomów
        SELECT p.id_prac, p.id_szefa, p.nazwisko, poziom+1
        FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa) 
        -- wskazanie sposobu przeszukiwania hierarchii i sortowania rekordów-dzieci 
--SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT id_prac, id_szefa, nazwisko, poziom
FROM podwladni;
--ORDER BY porzadek_potomkow;

--zad 8 B
--XDDDD v2

SELECT id_prac, id_szefa, nazwisko, LEVEL AS poziom
FROM pracownicy
CONNECT BY id_szefa = PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI' ORDER SIBLINGS BY nazwisko;

--zad9 A
--XDDDD v3

WITH
    podwladni (id_prac, id_szefa, nazwisko, poziom) AS
        -- definicja korzenia hierarchii
        (SELECT id_prac, id_szefa, nazwisko, 1
        FROM pracownicy
        WHERE nazwisko = 'BRZEZINSKI'
        UNION ALL 
        -- rekurencyjna definicja ni¿szych poziomów
        SELECT p.id_prac, p.id_szefa,  '  ' || p.nazwisko, poziom+1
        FROM podwladni s JOIN pracownicy p ON s.id_prac = p.id_szefa) 
        -- wskazanie sposobu przeszukiwania hierarchii i sortowania rekordów-dzieci 
--SEARCH DEPTH FIRST BY nazwisko SET porzadek_potomkow
SELECT id_prac, id_szefa, nazwisko, poziom
FROM podwladni;
--ORDER BY porzadek_potomkow;

--zad9 B
--...

SELECT id_prac, id_szefa, nazwisko, LEVEL AS poziom
FROM pracownicy
CONNECT BY id_szefa = PRIOR id_prac
START WITH nazwisko = 'BRZEZINSKI' ORDER SIBLINGS BY nazwisko;
