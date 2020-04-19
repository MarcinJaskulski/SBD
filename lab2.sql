--zad1
select * from ZESPOLY;
--zad2
select * from PRACOWNICY;
--zad3
select nazwisko, placa_pod*12 from pracownicy;
--zad4
select etat, placa_pod + NVL(placa_dod,0) AS MIESIECZNE_ZAROBKI  from pracownicy;
--zad5
select * from zespoly ORDER BY NAZWA;
--zad6
select DISTINCT ETAT from pracownicy ORDER BY ETAT;
--zad7
select * from pracownicy where ETAT='ASYSTENT';
--zad8
select id_prac, nazwisko, etat, placa_pod, id_zesp from pracownicy where id_zesp in ('30', '40') ORDER BY placa_pod DESC;
--zad9
select nazwisko, id_zesp, placa_pod from pracownicy where placa_pod BETWEEN 300 AND 800;
--zad10
select nazwisko, etat, id_zesp from pracownicy where nazwisko like '%SKI';
--zad11
select id_prac, id_szefa, nazwisko, placa_pod from pracownicy where placa_pod > 1000 AND id_szefa IS NOT NULL;
--zad12
select nazwisko, id_zesp from pracownicy where id_zesp = 20 AND (nazwisko LIKE 'M%' OR nazwisko LIKE '%SKI');
--zad13
select nazwisko, etat, placa_pod/(160) AS STAWKA from pracownicy where (etat NOT IN ('ASYSTENT', 'ASYSTENT', 'STAZYSTA')) AND (placa_pod NOT BETWEEN 400 AND 800) ORDER BY STAWKA;
--zad14
select nazwisko, etat, placa_pod, placa_dod from pracownicy where (placa_pod + NVL(placa_dod,0) ) > 1000 order by etat, nazwisko;
--zad15
select nazwisko || ' PRACUJE OD ' || zatrudniony || 'I ZARABIA ' || placa_pod from pracownicy where etat='PROFESOR' order by placa_pod DESC;





