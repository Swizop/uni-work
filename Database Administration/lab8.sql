DECLARE
    CURSOR c IS
        SELECT j.job_title nume, j.job_id jobid, COUNT(e.employee_id) nr
        FROM jobs j, employees e
        WHERE j.job_id = e.job_id(+)
        GROUP BY j.job_id, j.job_title;
    
    CURSOR d (parametru VARCHAR2) IS
        SELECT last_name nume, salary, commission_pct c
        FROM employees
        WHERE job_id = parametru;
    s number(10) := 0;
    aux number(10,2);
    BEGIN
    FOR i IN c LOOP
        IF i.nr != 0 THEN
            FOR j IN d(i.jobid) LOOP
                s := s + j.salary + NVL(j.c, 0) * j.salary;
            END LOOP;
        END IF;
    END LOOP;
    
    FOR i IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Jobul ' || i.jobid || ': ');
        IF i.nr = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Niciun angajat pe job');
            ELSE
            FOR j IN d(i.jobid) LOOP
                DBMS_OUTPUT.PUT_LINE(j.nume || ' ' || j.salary);
                aux := (j.salary + NVL(j.c, 0) * j.salary);
            END LOOP;
        END IF;
    END LOOP;
END;
/

set serveroutput on;
DECLARE
    CURSOR c IS
        SELECT j.job_title nume, j.job_id jobid, COUNT(e.employee_id) nr
        FROM jobs j, employees e
        WHERE j.job_id = e.job_id(+)
        GROUP BY j.job_id, j.job_title;
    
    CURSOR d (parametru VARCHAR2) IS
        SELECT last_name nume, salary, commission_pct c
        FROM employees
        WHERE job_id = parametru;
    s number(10) := 0;
    TYPE vector_salarii IS VARRAY(10) of employees.salary%TYPE; 
    
    aux vector_salarii;
    
    BEGIN
    FOR i IN c LOOP
        IF i.nr != 0 THEN
            FOR j IN d(i.jobid) LOOP
                --s := s + j.salary + NVL(j.c, 0) * j.salary;
            END LOOP;
        END IF;
    END LOOP;
    
    FOR i IN c LOOP
        DBMS_OUTPUT.PUT_LINE('Jobul ' || i.jobid || ': ');
        IF i.nr = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Niciun angajat pe job');
            ELSE
            FOR j IN d(i.jobid) LOOP
                DBMS_OUTPUT.PUT_LINE(j.nume || ' ' || j.salary);
                aux := (j.salary + NVL(j.c, 0) * j.salary);
            END LOOP;
        END IF;
    END LOOP;
END;
/

CREATE TABLE INFO_NMT (
    utilizator VARCHAR2(30),
    data date,
    comanda VARCHAR2(50),
    nr_linii NUMBER(10),
    eroare VARCHAR2(100)
);
SELECT * FROM INFO_NMT;
