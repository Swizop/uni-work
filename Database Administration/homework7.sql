-- 3. S? se creeze un bloc PL/SQL care trateaz? eroarea ap?rut? în cazul în care se modific?
-- codul unui departament în care lucreaz? angaja?i.

SET SERVEROUTPUT ON;

DECLARE
    nume dep_nmt.department_name%TYPE := '&nume';
    x NUMBER;
    exceptie EXCEPTION;
BEGIN
    SELECT COUNT(employee_id) INTO x FROM emp_nmt WHERE department_id IN
    (SELECT department_id FROM dep_nmt WHERE LOWER(department_name) = LOWER(nume));
    
    IF x > 0 THEN
        RAISE exceptie;
    ELSE
        UPDATE dep_NMT SET department_id = department_id + 100;
    END IF;
    
EXCEPTION
    WHEN exceptie THEN
        DBMS_OUTPUT.PUT_LINE('Angajati lucreaza in departamentul dorit');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END;
/



-- 4. S? se creeze un bloc PL/SQLprin care se afi?eaz? numele departamentului 10 dac? num?rul s?u de angaja?i este într-un interval dat de la tastatur?.
-- S? se trateze cazul în care departamentul nu îndepline?te aceast? condi?ie.


DECLARE
    a NUMBER(1) := &primul_nr;
    b NUMBER(1) := &al_doilea;
    x NUMBER;
    exceptie EXCEPTION;
    nume departments.department_name%TYPE;
BEGIN
    SELECT COUNT(employee_id) INTO x FROM employees WHERE department_id = 10;
    
    IF x < a OR x > b THEN
        RAISE exceptie;
    ELSE
        SELECT department_name INTO nume FROM departments WHERE department_id = 10;
        DBMS_OUTPUT.PUT_LINE('Departamentul 10 are numele: ' || nume);
    END IF;
    
EXCEPTION
    WHEN exceptie THEN
        DBMS_OUTPUT.PUT_LINE('Dep. 10 nu are numarul de angajati in intervalul dat.');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END;
/

SELECT COUNT(employee_id) FROM emp_nmt WHERE department_id = 10;
SELECT department_name FROM departments WHERE department_id = 10;



-- 5. S? se modifice numele unui departament al c?rui cod este dat de la tastatur?. 
-- S? se trateze cazul în care nu exist? acel departament. Tratarea excep?ie se va face în sec?iunea executabil?.


DECLARE
    cod dep_nmt.department_id%TYPE := &cod;
BEGIN
    UPDATE dep_nmt SET department_name = 'modificat' WHERE department_id = cod;
    IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20055, 'nu exista departamentul');
    END IF;
END;
/



-- 6. S? se creeze un bloc PL/SQL care afi?eaz? numele departamentului ce se afl? într-o anumit? loca?ie ?i numele
-- departamentului ce are un anumit cod(se vor folosi dou? comenzi SELECT). 
-- S? se trateze excep?ia NO_DATA_FOUND ?i s? se afi?eze care dintre comenzi a determinat eroarea.  S? se rezolve problema în dou? moduri.

-- varianta 1

DECLARE
    cod departments.department_id%TYPE := &cod;
    locatie departments.location_id%TYPE := &cod_locatie;
    v_nume departments.department_name%TYPE;
    comanda VARCHAR2(100);
BEGIN
    comanda := 'Comanda pentru un anumit cod de departament';
    SELECT department_name INTO v_nume FROM departments WHERE department_id = cod;
    DBMS_OUTPUT.PUT_LINE('Nume dept cu id-ul ' || cod || ': ' || v_nume);
    
    comanda := 'Comanda pt o anumita locatie';
    SELECT department_name INTO v_nume FROM departments WHERE location_id = locatie;
    DBMS_OUTPUT.PUT_LINE('Nume dept din locatia ' || locatie || ': ' || v_nume);
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE(comanda || ' nu gaseste nimic!');
     WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('If I had to guess, too many rows!');
END;
/


-- varianta 2

DECLARE
    cod departments.department_id%TYPE := &cod;
    locatie departments.location_id%TYPE := &cod_locatie;
    v_nume departments.department_name%TYPE;
BEGIN

    BEGIN
        SELECT department_name INTO v_nume FROM departments WHERE department_id = cod;
        DBMS_OUTPUT.PUT_LINE('Nume dept cu id-ul ' || cod || ': ' || v_nume);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Comanda pt id departament nu gaseste nimic');
    END;
    
    BEGIN
        SELECT department_name INTO v_nume FROM departments WHERE location_id = locatie;
        DBMS_OUTPUT.PUT_LINE('Nume dept din locatia ' || locatie || ': ' || v_nume);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Comanda pt id locatie nu gaseste nimic');
    END;

END;
/