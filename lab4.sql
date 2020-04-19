--zad1
select MIN(placa_pod), MAX(placa_pod), MAX(placa_pod) - MIN(placa_pod) AS RONICA from pracownicy;
--zad2
select etat, AVG(placa_pod) from pracownicy
group by etat
order by AVG(placa_pod) desc;
--zad3
select count(*) AS "PROFRSOROWIE" from pracownicy where etat='PROFESOR';
--zad4
select id_zesp, SUM(placa_pod) + SUM(NVL(placa_dod,0)) from pracownicy group by id_zesp;
--zad5
select MAX(SUM(placa_pod) + SUM(NVL(placa_dod,0))) from pracownicy group by id_zesp;
--zad5 Dodatkowo
select id_zesp, SUM(placa_pod) + SUM(NVL(placa_dod,0)) AS MAKS_SUM from pracownicy 
group by id_zesp
having(select MAX(SUM(placa_pod) + SUM(NVL(placa_dod,0))) from pracownicy group by id_zesp) = SUM(placa_pod) + SUM(NVL(placa_dod,0));
--zad6
select id_szefa, MIN(placa_pod) AS MINIMALNA from pracownicy 
group by id_szefa
having id_szefa IS NOT NULL
order by MINIMALNA desc;
--zad7
select id_zesp, count(*) AS Ile_Pracuje from pracownicy group by id_zesp;
--zad8
select id_zesp, count(*) AS Ile_Pracuje from pracownicy group by id_zesp having count(*) > 3;
--zad9
select count(*), id_prac from pracownicy group by id_prac having count(*) > 1;
--zad10 --!!!
select etat, AVG(placa_pod), count(*) from pracownicy where zatrudniony < '1990-01-01' group by etat ; 
--zad11
select id_zesp, etat, ROUND(AVG(placa_pod + NVL(placa_dod,0)),0), ROUND(MAX(placa_pod + NVL(placa_dod,0)),0) from pracownicy 
where etat IN('ASYSTENT', 'PROFESOR') group by id_zesp, etat order by id_zesp, etat;
--zad12 --!!!
select extract( YEAR FROM zatrudniony) as ROK, count(*) from pracownicy 
group by extract( YEAR FROM zatrudniony) 
order by extract( YEAR FROM zatrudniony); 
--zad13 --!!!!
select length(nazwisko), count(*) from pracownicy group by length(nazwisko) order by length(nazwisko); 
--zad14 --!!!
select count(case  
                when nazwisko like '%A%' then 1
                end) as ILE from pracownicy;
--zad15
select count(case when nazwisko like '%A%' then  'A' end) as "Ile nazwisk z A", 
       count(case when nazwisko like '%E%' then  'E' end) as "Ile nazwisk z E" from pracownicy;
--zad16
select id_zesp, SUM(placa_pod), listagg(nazwisko || ':' || placa_pod , ',') WITHIN GROUP (ORDER BY nazwisko) as lol from pracownicy group by id_zesp order by id_zesp;

