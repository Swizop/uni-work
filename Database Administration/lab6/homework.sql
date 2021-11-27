-- 1. 
---- Defini?i  un  tip  colec?ie  denumit  tip_orase_***.  Crea?i  tabelul excursie_*** cu  urm?toarea  structur?: cod_excursieNUMBER(4),
---- denumireVARCHAR2(20), orase tip_orase_***  (ce  va  con?ine lista ora?elor care se viziteaz?într-o excursie, într-o ordine stabilit?;
---- de exemplu, primul ora? din list? va fi primul ora? vizitat), status(disponibil?sau anulat?). a.Insera?i 5 înregistr?ri în tabel.

CREATE OR REPLACE TYPE tip_orase_NMT IS VARRAY(15) OF VARCHAR2(50);
/
CREATE TABLE excursie_NMT (
        cod_excursie NUMBER(4) PRIMARY KEY,
        denumire VARCHAR2(20) NOT NULL,
        orase tip_orase_NMT NOT NULL,
        status VARCHAR2(20));

    INSERT INTO excursie_NMT VALUES(1, 'cercetasi', tip_orase_NMT('bucuresti','viena','berlin'), 'available');
    INSERT INTO excursie_NMT VALUES(2, 'aventurierii', tip_orase_NMT('zurich','londra','dublin'), 'available');
    INSERT INTO excursie_NMT VALUES(3, 'informaticienii', tip_orase_NMT('bucuresti','viena','berlin'), 'available');
    INSERT INTO excursie_NMT VALUES(4, 'tabara mare', tip_orase_NMT('bucuresti','viena','berlin'), 'available');
    INSERT INTO excursie_NMT VALUES(5, 'tabara mica', tip_orase_NMT('bucuresti','viena','berlin'), 'available');
/    
    
-- b. Actualiza?i coloana orase pentru o excursie specificat?:
-- ad?uga?i un ora? nou în list?, ce va fi ultimul vizitat în excursia respectiv?

--DECLARE 
--    id_excursie excursie_NMT.cod_excursie%TYPE:=&id_cautat;
--    oras_de_ad VARCHAR2(50):=&baga_oras;
--    arr_orase excursie_NMT.orase%TYPE;
--    i NUMBER(10);
--BEGIN
--    SELECT orase
--    INTO arr_orase
--    FROM excursie_NMT
--    WHERE cod_excursie = id_excursie;
--    
--    i := arr_orase.last;
--    arr_orase.extend;
--    arr_orase(i + 1) := oras_de_ad;
--    
--    UPDATE excursie_NMT 
--    SET orase = arr_orase
--    WHERE cod_excursie = id_excursie;
--END;
    
    
    
/
-- ad?uga?i un ora? nou în list?, ce va fi al doilea ora? vizitat în excursia respectiv?;

DECLARE 
    id_excursie excursie_NMT.cod_excursie%TYPE:=&id_cautat;
    oras_de_ad VARCHAR2(50):=&baga_oras;
    arr_orase excursie_NMT.orase%TYPE;
    i NUMBER(10);
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT
    WHERE cod_excursie = id_excursie;

    arr_orase.extend();
    
    FOR j in REVERSE 3..arr_orase.last LOOP
        arr_orase(j) := arr_orase(j - 1);
    END LOOP;
    arr_orase(2) := oras_de_ad;
    
    UPDATE excursie_NMT 
    SET orase = arr_orase
    WHERE cod_excursie = id_excursie;
END;
/
SELECT * from excursie_NMT;

commit;

-- inversa?i ordinea de vizitare a dou? dintre ora?e al c?ror nume este specificat;

/
SET SERVEROUTPUT ON;
/
DECLARE 
    id_excursie excursie_NMT.cod_excursie%TYPE:='&id_cautat';
    oras1 VARCHAR2(50):='&baga_oras';
    oras2 VARCHAR2(50):='&baga_oras2';
    aux VARCHAR2(50);
    arr_orase excursie_NMT.orase%TYPE;
    poz1 NUMBER(3) := -1;
    poz2 NUMBER(3) := -1; 
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT
    WHERE cod_excursie = id_excursie;
    
    FOR j in arr_orase.first..arr_orase.last LOOP
        IF arr_orase(j) = LOWER(oras1) OR arr_orase(j) = LOWER(oras2) THEN
            IF poz1 = -1 THEN
                poz1 := j;
            ELSE
                poz2 := j;
            END IF;
        END IF;
    END LOOP;
    
    IF poz1 = -1 OR poz2 = -1 THEN
        DBMS_OUTPUT.PUT_LINE('nu exista unul dintre ele');
    ELSE
        aux := arr_orase(poz1);
        arr_orase(poz1) := arr_orase(poz2);
        arr_orase(poz2) := aux;
    
        UPDATE excursie_NMT 
        SET orase = arr_orase
        WHERE cod_excursie = id_excursie;
    END IF;
END;
/
SELECT * from excursie_NMT;





-- elimina?i din list? un ora? al c?rui nume este specificat

/

DECLARE 
    id_excursie excursie_NMT.cod_excursie%TYPE:='&id_cautat';
    oras_de_ad VARCHAR2(50):='&baga_oras';
    arr_orase excursie_NMT.orase%TYPE;
    i NUMBER(10);
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT
    WHERE cod_excursie = id_excursie;
    
    FOR j in REVERSE arr_orase.first..arr_orase.last LOOP
        IF arr_orase(j) = oras_de_ad THEN 
            i = j;
        END IF;
    END LOOP;
    
    -- v[i] = v[i+ 1] si apoi trim
    
    UPDATE excursie_NMT 
    SET orase = arr_orase
    WHERE cod_excursie = id_excursie;
END;
/
SELECT * from excursie_NMT;


-- c. Pentru o excursie al c?rui cod este dat, afi?a?i num?rul de ora?e vizitate, respectiv numele ora?elor
/
DECLARE 
    id_excursie excursie_NMT.cod_excursie%TYPE:='&id_cautat';
    arr_orase excursie_NMT.orase%TYPE;
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT
    WHERE cod_excursie = id_excursie;
    
    DBMS_OUTPUT.PUT_LINE('Nr. orase: ' || arr_orase.COUNT);
    DBMS_OUTPUT.PUT('Orase:');
    FOR j in arr_orase.first..arr_orase.last LOOP
        DBMS_OUTPUT.PUT(' ' || arr_orase(j));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

DECLARE 
    id_excursie excursie_NMT.cod_excursie%TYPE:='&id_cautat';
    arr_orase excursie_NMT.orase%TYPE;
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT
    WHERE cod_excursie = id_excursie;
    
    DBMS_OUTPUT.PUT_LINE('Nr. orase: ' || arr_orase.COUNT);
    DBMS_OUTPUT.PUT('Orase:');
    FOR j in arr_orase.first..arr_orase.last LOOP
        DBMS_OUTPUT.PUT(' ' || arr_orase(j));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.

CREATE OR REPLACE TYPE lista_orase_NMT IS VARRAY(20) OF tip_orase_NMT;
/
DECLARE 
    l lista_orase_NMT;
BEGIN
    SELECT orase
    BULK COLLECT INTO l
    FROM excursie_NMT;
    
    FOR i in l.first..l.last LOOP
        FOR j in l(i).first..l(i).last LOOP
            DBMS_OUTPUT.PUT(l(i)(j) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
SELECT * FROM excursie_NMT;


-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.
-- Etape:
-- - preluam toate excursiile intr-o lista
-- - parcurgem lista de excursii si pentru fiecare excursie selectam orasele, apoi facem un count
-- - retinem count-ul minim, intr-o instructiune conditionala
-- - reiteram si actualizam doar pentru excursiile care au numarul de orase minim

/
DECLARE
    TYPE vector_excursii IS VARRAY(100) OF excursie_nmt%ROWTYPE;
    l vector_excursii;
    mini NUMBER(10) := -1;
BEGIN
    SELECT * BULK COLLECT INTO l
    FROM excursie_nmt;
    
    FOR i IN l.first..l.last LOOP
        IF mini = -1 OR l(i).orase.COUNT < mini THEN
            mini := l(i).orase.COUNT;
        END IF;
    END LOOP;
    
    FOR i IN l.first..l.last LOOP
        IF mini = l(i).orase.COUNT THEN
            UPDATE excursie_NMT SET status = 'unavailable'
            WHERE cod_excursie = l(i).cod_excursie;
        END IF;
    END LOOP;
END;
/

rollback;
select * from excursie_nmt;




--3. nested tables;

-- 1. 
---- Defini?i  un  tip  colec?ie  denumit  tip_orase_***.  Crea?i  tabelul excursie_*** cu  urm?toarea  structur?: cod_excursieNUMBER(4),
---- denumireVARCHAR2(20), orase tip_orase_***  (ce  va  con?ine lista ora?elor care se viziteaz?într-o excursie, într-o ordine stabilit?;
---- de exemplu, primul ora? din list? va fi primul ora? vizitat), status(disponibil?sau anulat?). a.Insera?i 5 înregistr?ri în tabel.
/
CREATE OR REPLACE TYPE tip_orase_NMT3 IS TABLE OF VARCHAR2(50);
/
CREATE TABLE excursie_NMT3 (
        cod_excursie NUMBER(4) PRIMARY KEY,
        denumire VARCHAR2(20) NOT NULL,
        status VARCHAR2(20));
        
ALTER TABLE excursie_NMT3
ADD (orase tip_orase_NMT3)
NESTED TABLE orase STORE AS tabel_orase_NMT3;


select * from excursie_NMT3;

    INSERT INTO excursie_NMT3 VALUES(1, 'cercetasi', 'available', tip_orase_NMT3('bucuresti','viena','berlin'));
    INSERT INTO excursie_NMT3 VALUES(2, 'aventurierii', 'available', tip_orase_NMT3('zurich','londra','dublin'));
    INSERT INTO excursie_NMT3 VALUES(3, 'informaticienii', 'available', tip_orase_NMT3('bucuresti','viena','berlin'));
    INSERT INTO excursie_NMT3 VALUES(4, 'tabara mare', 'available', tip_orase_NMT3('bucuresti','viena','berlin'));
    INSERT INTO excursie_NMT3 VALUES(5, 'tabara mica', 'available', tip_orase_NMT3('bucuresti','viena','berlin'));
    commit;
/    
    
-- b. Actualiza?i coloana orase pentru o excursie specificat?:
-- ad?uga?i un ora? nou în list?, ce va fi ultimul vizitat în excursia respectiv?

DECLARE 
    id_excursie excursie_NMT3.cod_excursie%TYPE:=&id_cautat;
    oras_de_ad VARCHAR2(50):=&baga_oras;
    arr_orase excursie_NMT3.orase%TYPE;
    i NUMBER(10);
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT3
    WHERE cod_excursie = id_excursie;
    
    i := arr_orase.last;
    arr_orase.extend;
    arr_orase(i + 1) := oras_de_ad;
    
    UPDATE excursie_NMT3 
    SET orase = arr_orase
    WHERE cod_excursie = id_excursie;
END;
    
    
    
/
-- ad?uga?i un ora? nou în list?, ce va fi al doilea ora? vizitat în excursia respectiv?;

DECLARE 
    id_excursie excursie_NMT3.cod_excursie%TYPE:=&id_cautat;
    oras_de_ad VARCHAR2(50):=&baga_oras;
    arr_orase excursie_NMT3.orase%TYPE;
    i NUMBER(10);
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT3
    WHERE cod_excursie = id_excursie;

    arr_orase.extend;
    
    FOR j in REVERSE 3..arr_orase.last LOOP
        arr_orase(j) := arr_orase(j - 1);
    END LOOP;
    arr_orase(2) := oras_de_ad;
    
    UPDATE excursie_NMT3 
    SET orase = arr_orase
    WHERE cod_excursie = id_excursie;
END;
/
SELECT * from excursie_NMT3;

commit;

-- inversa?i ordinea de vizitare a dou? dintre ora?e al c?ror nume este specificat;

/
SET SERVEROUTPUT ON;
/
DECLARE 
    id_excursie excursie_NMT3.cod_excursie%TYPE:='&id_cautat';
    oras1 VARCHAR2(50):='&baga_oras';
    oras2 VARCHAR2(50):='&baga_oras2';
    aux VARCHAR2(50);
    arr_orase excursie_NMT3.orase%TYPE;
    poz1 NUMBER(3) := -1;
    poz2 NUMBER(3) := -1; 
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT3
    WHERE cod_excursie = id_excursie;
    
    FOR j in arr_orase.first..arr_orase.last LOOP
        IF arr_orase(j) = LOWER(oras1) OR arr_orase(j) = LOWER(oras2) THEN
            IF poz1 = -1 THEN
                poz1 := j;
            ELSE
                poz2 := j;
            END IF;
        END IF;
    END LOOP;
    
    IF poz1 = -1 OR poz2 = -1 THEN
        DBMS_OUTPUT.PUT_LINE('nu exista unul dintre ele');
    ELSE
        aux := arr_orase(poz1);
        arr_orase(poz1) := arr_orase(poz2);
        arr_orase(poz2) := aux;
    
        UPDATE excursie_NMT3 
        SET orase = arr_orase
        WHERE cod_excursie = id_excursie;
    END IF;
END;
/
SELECT * from excursie_NMT3;





-- elimina?i din list? un ora? al c?rui nume este specificat

/

DECLARE 
    id_excursie excursie_NMT3.cod_excursie%TYPE:='&id_cautat';
    oras_de_ad VARCHAR2(50):='&baga_oras';
    arr_orase excursie_NMT3.orase%TYPE;
    i NUMBER(10);
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT3
    WHERE cod_excursie = id_excursie;
    
    FOR j in REVERSE arr_orase.first..arr_orase.last LOOP
        IF arr_orase(j) = oras_de_ad THEN 
            i := j;
        END IF;
    END LOOP;
    
    FOR j in i..arr_orase.last - 1 LOOP
        arr_orase(j) := arr_orase(j + 1);
    END LOOP;
    arr_orase.trim;
    
    UPDATE excursie_NMT3 
    SET orase = arr_orase
    WHERE cod_excursie = id_excursie;
END;
/
SELECT * from excursie_NMT3;


-- c. Pentru o excursie al c?rui cod este dat, afi?a?i num?rul de ora?e vizitate, respectiv numele ora?elor
set serveroutput on;
/
DECLARE 
    id_excursie excursie_NMT3.cod_excursie%TYPE:='&id_cautat';
    arr_orase excursie_NMT3.orase%TYPE;
BEGIN
    SELECT orase
    INTO arr_orase
    FROM excursie_NMT3
    WHERE cod_excursie = id_excursie;
    
    DBMS_OUTPUT.PUT_LINE('Nr. orase: ' || arr_orase.COUNT);
    DBMS_OUTPUT.PUT('Orase:');
    FOR j in arr_orase.first..arr_orase.last LOOP
        DBMS_OUTPUT.PUT(' ' || arr_orase(j));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');
END;
/

-- d. Pentru fiecare excursie afi?a?i lista ora?elor vizitate.

CREATE OR REPLACE TYPE lista_orase_NMT3 IS VARRAY(20) OF tip_orase_NMT3;
/
DECLARE 
    l lista_orase_NMT3;
BEGIN
    SELECT orase
    BULK COLLECT INTO l
    FROM excursie_NMT3;
    
    FOR i in l.first..l.last LOOP
        FOR j in l(i).first..l(i).last LOOP
            DBMS_OUTPUT.PUT(l(i)(j) || ' ');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('');
    END LOOP;
END;
/
SELECT * FROM excursie_NMT3;
commit;


-- e. Anula?i excursiile cu cele mai pu?ine ora?e vizitate.

/
DECLARE
    TYPE vector_excursii IS VARRAY(100) OF excursie_nmt3%ROWTYPE;
    l vector_excursii;
    mini NUMBER(10) := -1;
BEGIN
    SELECT * BULK COLLECT INTO l
    FROM excursie_nmt3;
    
    FOR i IN l.first..l.last LOOP
        IF mini = -1 OR l(i).orase.COUNT < mini THEN
            mini := l(i).orase.COUNT;
        END IF;
    END LOOP;
    
    FOR i IN l.first..l.last LOOP
        IF mini = l(i).orase.COUNT THEN
            UPDATE excursie_NMT3 SET status = 'unavailable'
            WHERE cod_excursie = l(i).cod_excursie;
        END IF;
    END LOOP;
END;
/

rollback;
select * from excursie_nmt3;
