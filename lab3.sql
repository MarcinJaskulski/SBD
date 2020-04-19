--zad1
select nazwisko, substr(etat, 1, 2) || id_prac AS KOD from pracownicy;
--zad2
select nazwisko, translate(nazwisko,'KLM', 'XXX') AS wojna from pracownicy;
--zad3
select nazwisko from pracownicy where substr(nazwisko, 1, FLOOR(length(nazwisko)/2)) like '%L%';
--zad4
select nazwisko, round(placa_pod*115/100,0) from pracownicy; 
--zad5
select nazwisko, placa_pod, placa_pod*0.2 AS inwestycja,  placa_pod*0.2 *(power(1.1,10)) AS "KAPITAL",placa_pod*0.2 *(power(1.1,10))-placa_pod*0.2  AS "ZYSK" from pracownicy;
--zad6
select nazwisko, zatrudniony, 2000 - EXTRACT(YEAR FROM zatrudniony) AS "STAZ" from pracownicy;
--zad7
select nazwisko, TO_CHAR(zatrudniony, 'MONTH') || ' , ' || extract(DAY FROM zatrudniony) || extract(YEAR FROM zatrudniony) as DATA_ZATRUDNIENIA from pracownicy where id_zesp = '20';
select nazwisko, TO_CHAR(zatrudniony, 'fmMONTH, DD, YYYY ') from pracownicy where id_zesp=20;
--zad8
select TO_CHAR(CURRENT_DATE, 'DAY') from dual;
--zad9
select nazwa, adres, 
CASE 
    WHEN adres like '%MIELZYNSKIEGO%' OR adres like '%STRZELECKA%' THEN 'STARE MIASTO'
    WHEN adres like '%PIOTROWO%' THEN 'NOWE MIASTO' 
    WHEN adres like '%WLODKOWICA%' THEN 'GRUNWALD'
END AS "DZIELNICA" 
from zespoly;
--zad10
select nazwisko, placa_pod, 
CASE 
    WHEN placa_pod > 480 THEN 'POWYZEJ 480'
    WHEN placa_pod = 480 THEN 'DOKLADNIE 480'
    ELSE 'PONIZEJ 480'
END AS "PROG"
from pracownicy;
--zad11
select nazwisko, placa_pod,
    decode(sign(480-placa_pod),
    -1,'Powy¿ej 480',
    -0,'Dokladnie 480',
     1,'Poni¿ej 480')
as "PRÓG" from pracownicy order by placa_pod desc;




