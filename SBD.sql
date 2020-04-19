SELECT nazwisko,
CASE etat
WHEN 'DYREKTOR' THEN '***'
WHEN 'PROFESOR' THEN '***'
ELSE CAST(placa_pod AS VARCHAR(10))
END AS placa_psod FROM pracownicy;

SELECT id_zesp, AVG(placa_pod)
FROM pracownicy
GROUP BY id_zesp
HAVING SUM(placa_pod) > 3000
ORDER BY id_zesp DESC;

select * from  etaty;

SELECT ROWNUM, nazwisko, etat, placa_pod FROM pracownicy ORDER BY placa_pod DESC;

SELECT ROWNUM AS pozycja, T.nazwisko, T.etat, T.pensja
FROM (SELECT nazwisko, etat, placa_pod AS pensja FROM pracownicy ORDER BY pensja DESC) T
WHERE ROWNUM <= 10;

SELECT ROWID, id_zesp FROM pracownicy WHERE nazwisko = 'HAPKE';




create table x(
    a number(4,0) default null,
    b number(4,0) default null
);

insert into x 
select 1, 1 from dual union all
select 2, null from dual union all
select 5, 2 from dual union all
select null, 7 from dual union all
select 3, null from dual;


select distinct count(distinct sum(nvl(a, 0)+b))
from x
where b<>1
group by a ;

select  a
from x 
where b=null or b>1;



select z.id_zesp, 
(select listagg (placa_pod,', ') from pracownicy p where rownum<=3 and (p.id_zesp=z.id_zesp) 
order by placa_pod
desc) from pracownicy z;
