----Men?ine?i într-o colec?ie codurile celor mai prost pl?ti?i 5 angaja?i care nu câ?tig? comision. Folosind aceast? colec?ie
----m?ri?i cu 5% salariul acestor angaja?i. Afi?a?i valoarea veche a salariului, respectiv valoarea nou? a salariului. 
--
--create table emp_oas as select * from employees;
--
--
--
--set serveroutput on;
--DECLARE
--TYPE tablou_indexat IS TABLE OF employees%ROWTYPE;
--colectiePP tablou_indexat;
--BEGIN
--select * bulk collect into colectiePP
--from (select * from employees where commission_pct is null order by salary)
--where rownum <= 5;
--for i in 1..5 loop
--dbms_output.put_line('salariu vechi ' || colectiePP(i).salary || ' salariu nou ' || colectiePP(i).salary * 1.05);
--colectiePP(i).salary := colectiePP(i).salary * 1.05;
--end loop;
--
--for i in 1..5 loop
--update emp_oas
--set row = colectiePP(i)
--where employee_id = colectiePP(i).employee_id;
--end loop;
--END;
--/
--
--
--
--
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


--tema : e), 3.

--3. nested tables;   e) selectam minimul si apoi setam status la cancelled