-- 9. De câte ori a împrumutat unmembru(nume ?i prenume)fiecare film(titlu)?

SELECT m.last_name || ' ' || m.first_name AS "nume", t.title AS "titlu", COUNT(*) as "de cate ori"      --selectam filmele inchiriate de membri si le numaram
FROM member m, title t, rental r
WHERE m.member_id = r.member_id AND
r.title_id = t.title_id
GROUP BY m.last_name || ' ' || m.first_name, t.title
UNION
SELECT m.last_name || ' ' || m.first_name AS "nume", t.title AS "titlu", 0 as "de cate ori"         --asociem toti membri cu toate filmele si presupunem ca nimeni nu a inchiriat nimic niciodata
FROM member m, title t
MINUS
SELECT m.last_name || ' ' || m.first_name AS "nume", t.title AS "titlu", 0                  --scadem din aceasta asociere grupele gasite in primul select, ca sa nu avem redundanta cand unim
FROM member m, title t, rental r
WHERE m.member_id = r.member_id AND
r.title_id = t.title_id;




-- 10. De câte ori a împrumutat un membru(nume ?i prenume)fiecare exemplar(cod)alunui film(titlu)?


SELECT m.last_name || ' ' || m.first_name AS "nume", r.copy_id AS "exemplar", t.title AS "titlu", COUNT(*) as "de cate ori"      --aceeasi logica ca mai sus, doar ca includem si exemplarele
FROM member m, title t, rental r
WHERE m.member_id = r.member_id AND
r.title_id = t.title_id
GROUP BY m.last_name || ' ' || m.first_name, r.copy_id, t.title

UNION
SELECT m.last_name || ' ' || m.first_name AS "nume", tc.copy_id AS "exemplar", t.title AS "titlu", 0 as "de cate ori"        
FROM member m, title_copy tc, title t
WHERE tc.title_id = t.title_id

MINUS
SELECT m.last_name || ' ' || m.first_name AS "nume", r.copy_id AS "exemplar", t.title AS "titlu", 0     
FROM member m, title t, rental r
WHERE m.member_id = r.member_id AND
r.title_id = t.title_id;


-- 11. Ob?ine?i statusul celuimai des împrumutat exemplar al fiec?rui film(titlu)


--SELECT COUNT(*), copy_id, title_id FROM RENTAL GROUP BY copy_id, title_id;

WITH tempTable AS (SELECT COUNT(*) AS amount, copy_id as cod_copie, title_id as cod_titlu FROM RENTAL GROUP BY copy_id, title_id)      --contine numarul de exemplare inchiriate pt fiecare copie a filmelor
SELECT tc.status as "status", tc.copy_id as "id exemplar", t.title as "film"
FROM title_copy tc, title t
WHERE tc.title_id = t.title_id AND tc.copy_id IN
(   SELECT x.cod_copie FROM tempTable x WHERE x.amount in
        (SELECT MAX(amount) from tempTable WHERE t.title_id = cod_titlu GROUP BY cod_titlu)     --grupam fiecare film cu copia inchiriata maxim, si sincronizam subcererea cu cea principala
    AND x.cod_titlu = t.title_id);      --fara asta, ar putea fi selectate copii ale altor filme care au fost inchiriate de la fel de multe ori ca copia cautata de noi   
                                                                                                        
                                                                                                        
--WITH tempTable AS (SELECT COUNT(*) AS amount, copy_id as cod_copie, title_id as cod_titlu FROM RENTAL GROUP BY copy_id, title_id)                                                                                                       
--SELECT x.cod_copie, x.amount FROM tempTable x WHERE x.amount in
--(SELECT MAX(amount) from tempTable WHERE 95 = cod_titlu GROUP BY cod_titlu)
--AND x.cod_titlu = 95;          


-- 12. Pentru anumite zile specificate din luna curent?,ob?ine?i num?rul de împrumuturi efectuate
-- a) Se iau în considerare doar primele 2 zile din lun?.


SELECT COUNT(*) AS "nr imprumuturi", to_char(r.book_date, 'DD/MM/YYYY') AS "data inchirierii"
FROM rental r
WHERE to_char(r.book_date, 'MM') = to_char(SYSDATE, 'MM') AND (to_char(r.book_date, 'DD') = '01' OR to_char(r.book_date, 'DD') = '02')
GROUP BY to_char(r.book_date, 'DD/MM/YYYY')
UNION
SELECT 0 AS "nr imprumuturi", '01/' || to_char(SYSDATE, 'MM/YYYY')  AS "data inchirierii"
FROM dual
UNION
SELECT 0 AS "nr imprumuturi", '02/' || to_char(SYSDATE, 'MM/YYYY')  AS "data inchirierii"
FROM dual;


-- b) Se iau în considerare doar zilele din lun? în care au fost efectuate împrumuturi.

-- din cerinta, inteleg ca se iau zilele din octombrie cu imprumuturi (daca suntem in octombrie)

SELECT COUNT(*) AS "nr imprumuturi", to_char(r.book_date, 'DD/MM/YYYY') AS "data inchirierii"
FROM rental r
WHERE to_char(r.book_date, 'MM') = to_char(SYSDATE, 'MM')
GROUP BY to_char(r.book_date, 'DD/MM/YYYY');                --daca nu fac conversia in char, pot fi luate imprumuturi din acceasi zi
                                                    --separat, pentru ca data din sistem e salvata si cu ora, nu doar cu ziua si luna


--verificare
--SELECT COUNT(*) AS "nr imprumuturi", to_char(r.book_date, 'DD/MM/YYYY') AS "data inchirierii"
--FROM rental r
--WHERE to_char(r.book_date, 'MM') = '09'
--GROUP BY to_char(r.book_date, 'DD/MM/YYYY');



-- c) Se iau în considerare toate zilele din lun?, incluzând în rezultat ?i zilele în carenu au fost efectuate împrumuturi.


-- aici as face un for cu union-uri ca cel de la punctul a), dar nu stiu exact cum se fac inca