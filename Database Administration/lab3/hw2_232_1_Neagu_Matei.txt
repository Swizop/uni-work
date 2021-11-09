--6. Modificați  exercițiul anterior astfel încât să obțineți și numărul de angajați  din  departamentul respectiv. 
SET SERVEROUTPUT ON;
VARIABLE rezultat VARCHAR2(35)
VARIABLE numar NUMBER(5)

BEGIN
    SELECT MAX(COUNT(*))
    INTO :numar
    FROM   employees
    GROUP BY department_id;
    
    SELECT department_name
    INTO :rezultat
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = :numar;
    
    DBMS_OUTPUT.PUT_LINE('Departamentul '|| :rezultat);
    DBMS_OUTPUT.PUT_LINE('Nr angajati: ' || :numar);
END;
/
PRINT rezultat


-- 1.

a) 2
b) text 2
c) text 3 adaugat in sub-bloc
d) 101
e) text 1 adaugat un blocul principal
f) text 2 adaugat in blocul principal



-- 4. Modificați problema anterioară astfel încât să afișați și următorul text:
-- -Categoria 1 (a împrumutat mai mult de 75% din titlurile existente) -Categoria 2 (a împrumutat mai mult de 50% din titlurile existente)
-- -Categoria 3 (a împrumutat mai mult de 25% din titlurile existente) -Categoria 4 (altfel)

DECLARE
    id_membru_cautat NUMBER;
    numar_filme_inchiriate NUMBER;
    numar_filme_existente NUMBER;
BEGIN
    SELECT member_id 
    INTO id_membru_cautat
    FROM member
    WHERE LOWER(first_name) = LOWER('&nume');

    -- acelasi titlu poate fi inchiriat de mai multe ori. pentru a nu numara copii redundante, 
        -- asociem inchirerile cu titlul efectiv si apoi putem numara titlurile distincte
    SELECT COUNT(COUNT(*)) 
    INTO numar_filme_inchiriate
    FROM rental
    WHERE member_id = id_membru_cautat
    GROUP BY title_id;

    SELECT COUNT(*)
    INTO numar_filme_existente
    FROM title;
    
    IF numar_filme_inchiriate = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu a inchiriat filme!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Numar filme inchiriate: ' || numar_filme_inchiriate);
        CASE WHEN numar_filme_inchiriate > 75 / 100 * numar_filme_existente THEN 
            DBMS_OUTPUT.PUT_LINE('Categoria 1');
        WHEN numar_filme_inchiriate > 50 / 100 * numar_filme_existente THEN
            DBMS_OUTPUT.PUT_LINE('Categoria 2');
        WHEN numar_filme_inchiriate > 25 / 100 * numar_filme_existente THEN
            DBMS_OUTPUT.PUT_LINE('Categoria 3');
        ELSE DBMS_OUTPUT.PUT_LINE('Categoria 4');
        END CASE;
    END IF;


EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu a fost gasit un membru avand id-ul introdus!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Au fost descoperite mai multe persoane cu acelasi nume in baza de date!');
END;
/

-- helpers
SELECT COUNT(COUNT(*)) 
FROM rental
WHERE member_id = 101
GROUP BY title_id;

SELECT COUNT(*)
FROM title;




-- 5
--Creați  tabelul member_***  (o  copie  a  tabelului member).  Adăugați  în  acest  tabel  coloana discount,  care  va  reprezenta
--procentul  de  reducere  aplicat  pentru  membrii,  în  funcție  de  categoria din care fac parte aceștia:-10% pentru membrii din Categoria 1
---5% pentru membrii din Categoria 2 -3% pentru membrii din Categoria 3
---nimic. Actualizați  coloana discountpentru un membru al cărui cod este dat de la tastatură.
--Afișați  un mesaj din care să reiasă dacă actualizarea s-a produs sau nu.

CREATE TABLE MEMBER_NMT AS
(SELECT * FROM MEMBER);
commit;


ALTER TABLE MEMBER_NMT
ADD discount NUMBER(3);

SELECT * FROM MEMBER_NMT;

commit;

DECLARE
    id_membru_cautat member_nmt.member_id%TYPE:=&id_cautat;
    numar_filme_inchiriate NUMBER;
    numar_filme_existente NUMBER;
    okay BOOLEAN:=TRUE;
BEGIN
     -- acelasi titlu poate fi inchiriat de mai multe ori. pentru a nu numara copii redundante, 
        -- asociem inchirerile cu titlul efectiv si apoi putem numara titlurile distincte
    SELECT COUNT(COUNT(*)) 
    INTO numar_filme_inchiriate
    FROM rental
    WHERE member_id = id_membru_cautat
    GROUP BY title_id;

    SELECT COUNT(*)
    INTO numar_filme_existente
    FROM title;
    
   CASE WHEN numar_filme_inchiriate > 75 / 100 * numar_filme_existente THEN 
            UPDATE member_nmt SET discount = 10 WHERE member_id = id_membru_cautat;
    WHEN numar_filme_inchiriate > 50 / 100 * numar_filme_existente THEN
            UPDATE member_nmt SET discount = 5 WHERE member_id = id_membru_cautat;
    WHEN numar_filme_inchiriate > 25 / 100 * numar_filme_existente THEN
            UPDATE member_nmt SET discount = 3 WHERE member_id = id_membru_cautat;
    ELSE okay := FALSE;
    END CASE;
    
    IF okay = FALSE THEN
        DBMS_OUTPUT.PUT_LINE('Nu s-a facut update-ul!');
    ELSE DBMS_OUTPUT.PUT_LINE('Update reusit!');
    END IF;
END;
/

ROLLBACK;
commit;

SELECT * FROM MEMBER_NMT;