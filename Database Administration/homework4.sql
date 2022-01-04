-- 1. Crea?i tabelul info_*** cu urm?toarele coloane:
-- utilizator (numele utilizatorului care a ini?iat o comand?) 
-- data (data ?i timpul la care utilizatorul a ini?iat comanda)
-- comanda (comanda care a fost ini?iat? de utilizatorul respectiv)
-- nr_linii (num?rul de linii selectate/modificate de comand?)
-- eroare (un mesaj pentru excep?ii).

CREATE TABLE INFO_NMT (
utilizator VARCHAR2(30),
data date,
comanda VARCHAR2(50),
nr_linii NUMBER(10),
eroare VARCHAR2(100)
);

--2. Modifica?i func?ia definit? la exerci?iul 2, respectiv procedura definit? la exerci?iul 4 astfel încât 
--s? determine inserarea în tabelul info_*** a informa?iile corespunz?toare fiec?rui caz 
--determinat de valoarea dat? pentru parametru:
-- exist? un singur angajat cu numele specificat;
-- exist? mai mul?i angaja?i cu numele specificat;
-- nu exist? angaja?i cu numele specificat. 


CREATE OR REPLACE FUNCTION f2_NMT 
 (v_nume employees.last_name%TYPE DEFAULT 'Bell') 
RETURN NUMBER IS
    salariu employees.salary%type; 
    nr_linii number(3);
    utilizator VARCHAR2(30);
    
 BEGIN
     SELECT USER INTO utilizator FROM dual;
     
     SELECT COUNT(*) INTO nr_linii
     FROM employees WHERE last_name = v_nume;
     
     SELECT salary INTO salariu 
     FROM employees
     WHERE last_name = v_nume;
     
     
     INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'f2_NMT(' || v_nume || ')' , 1, NULL);
     commit;
     RETURN salariu;
     
 EXCEPTION
     WHEN NO_DATA_FOUND THEN
     INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'f2_NMT(' || v_nume || ')' , 0, 'Nu exista angajati cu numele dat');
     commit;
     
     RAISE_APPLICATION_ERROR(-20000,
     'Nu exista angajati cu numele dat');
     
     WHEN TOO_MANY_ROWS THEN
     INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'f2_NMT(' || v_nume || ')' , nr_linii, 'Prea multi angajati');
     commit;
     
     RAISE_APPLICATION_ERROR(-20001,
     'Exista mai multi angajati cu numele dat');
     
     WHEN OTHERS THEN
     INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'f2_NMT(' || v_nume || ')' , nr_linii, 'Undefined error');
     commit;
     
     RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END f2_NMT;
/

SET SERVEROUTPUT ON;
BEGIN
 DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2_NMT('Kimball'));
END;
/


CREATE OR REPLACE PROCEDURE p2_NMT
(v_nume employees.last_name%TYPE) IS 
salariu employees.salary%TYPE;
 nr_linii number(3);
 utilizator VARCHAR2(30);

BEGIN
	SELECT USER INTO utilizator FROM dual;
     
 SELECT COUNT(*) INTO nr_linii
 FROM employees WHERE last_name = v_nume;

SELECT salary INTO salariu 
FROM   employees
WHERE  last_name = v_nume;

INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'p2_NMT(' || v_nume || ')' , 1, NULL);
commit;

DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);

EXCEPTION
WHEN NO_DATA_FOUND THEN 

	 INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'p2_NMT(' || v_nume || ')' , 0, 'Nu exista angajati cu numele dat');
     				commit;
RAISE_APPLICATION_ERROR(-20000,'Nu exista angajati cu numele dat');


WHEN TOO_MANY_ROWS THEN 

	INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'p2_NMT(' || v_nume || ')' , nr_linii, 'Prea multi angajati');
     				commit;
RAISE_APPLICATION_ERROR(-20001,'Exista mai multi angajati cu numele dat');


WHEN OTHERS THEN
	 INSERT INTO INFO_NMT VALUES(utilizator, SYSDATE, 'p2_NMT(' || v_nume || ')' , nr_linii, 'Undefined error');
     				commit;
RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END p2_NMT;
/

BEGIN
p2_NMT('Kimball');
END;
/

-- 3. Defini?i  o  func?ie stocat? care determin? num?rul de angaja?i care  au  avut  cel  pu?in  2  joburi diferite
-- ?i care în prezent lucreaz? într-un ora? dat ca parametru. Trata?i cazul în care ora?ul dat ca
-- parametru nu exist?, respectiv cazul în care în ora?ul dat nu lucreaz? niciun angajat.
-- Insera?i în tabelul info_***informa?iile corespunz?toare fiec?rui caz determinat de valoarea dat? pentru parametru. 

CREATE OR REPLACE FUNCTION f3_NMT
    (v_oras locations.city%TYPE DEFAULT 'Roma') 
RETURN NUMBER IS
    nr_angajati NUMBER; 
    BEGIN
        
        SELECT COUNT(*) INTO nr_angajati FROM locations WHERE city = v_oras;
        IF (nr_angajati = 0) THEN
            INSERT INTO INFO_NMT VALUES(USER, SYSDATE, 'f3_NMT(' || v_oras || ')' , 0, 'Orasul nu exista');
            commit;
            RAISE_APPLICATION_ERROR(-20001,'Orasul nu exista');
        END IF;
        
        
        SELECT COUNT(*) INTO nr_angajati
        FROM employees e, departments d, locations l
        WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.city = v_oras;
        
        IF (nr_angajati = 0) THEN
            INSERT INTO INFO_NMT VALUES(USER, SYSDATE, 'f3_NMT(' || v_oras || ')' , 0, 'Niciun angajat in oras');
            commit;
            RAISE_APPLICATION_ERROR(-20000,'Nu exista angajati in orasul dat');
        END IF;
        
        SELECT COUNT(*) INTO nr_angajati 
        FROM   employees e, departments d, locations l
        WHERE e.department_id = d.department_id AND d.location_id = l.location_id AND l.city = v_oras AND 
            (SELECT COUNT(*) FROM job_history j
            WHERE j.employee_id = e.employee_id) > 1;
        
        INSERT INTO INFO_NMT VALUES(USER, SYSDATE, 'f3_NMT(' || v_oras || ')' , nr_angajati, NULL);
        commit;
        
        RETURN nr_angajati;
END f3_NMT;
/


BEGIN
   --DBMS_OUTPUT.PUT_LINE('Numarul este '|| f3_NMT('Iasi')); -- orasul nu exista
   -- DBMS_OUTPUT.PUT_LINE('Numarul este '|| f3_NMT('Utrecth')); -- niciun angajat in oras
 --DBMS_OUTPUT.PUT_LINE('Numarul este '|| f3_NMT('Southlake')); -- are angajati, dar nu minim 2
 DBMS_OUTPUT.PUT_LINE('Numarul este '|| f3_NMT('Seattle')); -- 2
END;
/



--4. Defini?i o procedur? stocat? care m?re?te cu 10% salariile tuturor angaja?ilor condu?i direct sau 
--indirect de c?tre un manager al c?rui cod este dat ca parametru. Trata?i cazul în care nu exist? 
--niciun manager cu codul dat. Insera?i în tabelul info_*** informa?iile corespunz?toare fiec?rui 
--caz determinat de valoarea dat? pentru parametru

CREATE OR REPLACE TYPE subordonati_NMT AS VARRAY(10) OF NUMBER(4);
/
CREATE OR REPLACE PROCEDURE p4_NMT
    (v_manager employees.manager_id%TYPE)
 IS
    vector_subordonati subordonati_NMT;
    aux subordonati_NMT;
    i NUMBER;
    k NUMBER;
 BEGIN
    SELECT employee_id BULK COLLECT INTO vector_subordonati
    FROM emp_nmt
    WHERE manager_id = v_manager;
    
    IF vector_subordonati.COUNT = 0 THEN
        INSERT INTO INFO_NMT VALUES(USER, SYSDATE, 'p4_NMT(' || v_manager || ')' , 0, 'Niciun manager cu acest cod');
        commit;
        RAISE_APPLICATION_ERROR(-20000,'Niciun manager cu acest cod');
    END IF;
    
    i := vector_subordonati.FIRST;
    WHILE i <= vector_subordonati.LAST LOOP         --vector_subordonati e un queue, la fiecare pas dam pop la un subordonat (direct sau indirect)
        UPDATE emp_nmt                                    --,ii updatam salariul si dam push la toti subordonatii lui directi (pentru cel original, vor fi indirecti)
        SET salary = salary + 10 / 100 * salary
        WHERE employee_id = vector_subordonati(i);
        
        SELECT employee_id BULK COLLECT INTO aux
        FROM emp_nmt
        WHERE manager_id = vector_subordonati(i);

         --k := vector_subordonati.LAST;
         IF aux.COUNT != 0 THEN
             FOR j IN aux.FIRST..aux.LAST LOOP
                vector_subordonati.extend;
                k := k + 1;
                vector_subordonati(vector_subordonati.LAST) := aux(j);
             END LOOP;
        END IF;
         
         i := i + 1;
    END LOOP;
    
    INSERT INTO INFO_NMT VALUES(USER, SYSDATE, 'p4_NMT(' || v_manager || ')' , i - 1, NULL);
    commit;
 END p4_NMT;
/

BEGIN
 --p4_NMT(300);   --nu exista managerul
 --p4_NMT(205);       -- un modificat
 p4_NMT(102);       -- se modifica de la 103 la 107
END;
/



