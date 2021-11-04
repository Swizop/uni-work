
--
----pt fiecare zi a lui sept, obtineti nr de imprumuturi efectuate
--
----a) fara structuri
--
--SELECT COUNT(*) AS "nr imprumuturi", to_char(r.book_date, 'DD/MM/YYYY') AS "data inchirierii"
--FROM rental r
--WHERE to_char(r.book_date, 'MM') = '09' 
--GROUP BY to_char(r.book_date, 'DD/MM/YYYY')
--UNION
--SELECT 0 AS "nr imprumuturi", '01/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '02/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '03/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '04/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '05/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '06/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '07/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '08/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '09/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '10/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '11/09/2021'  AS "data inchirierii"
--FROM dual
--UNION
--SELECT 0 AS "nr imprumuturi", '12/09/2021'  AS "data inchirierii"
--FROM dual;
---- etc :)
--
--
--
--
--set serveroutput on;
--DECLARE
--data DATE;
--res NUMBER(2);
--startDate DATE := trunc(to_date('01/09/2021', 'dd/mm/yyyy'));
--BEGIN
--FOR contor IN 0..30 LOOP
--data := startDate + contor;
--select count(*) into res
--from rental
--where trunc(TO_DATE(book_date, 'DD-MM-YYYY')) = trunc(data);
--dbms_output.put_line(data || ' ' || res);
--END LOOP;
--END;








-- EX3 
-- s? se determine num?rul de filme  (titluri)  împrumutate  de  un membru al c?rui numeeste introdus de la tastatur?. 
--Trata?iurm?toarele dou? situa?ii: nu exist? nici un membru cu numedat; exist? mai mul?i membrii cu acela?i nume.

DECLARE
lst_name employees.last_name%TYPE := '&lst';
fst_name employees.first_name%TYPE := '&fst';
res NUMBER(3);
BEGIN
select count(*) into res
from member m, rental r
where m.member_id = r.member_id
and lower(m.first_name) = lower(fst_name);
--and m.last_name = lst_name;
dbms_output.put_line(fst_name || ' ' || lst_name || ':' || res);
END;
    
        
    