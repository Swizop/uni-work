DECLARE 
    CURSOR c IS
        SELECT j.job_title nume, COUNT(e.employee_id) nr, j.job_id jobid
        FROM jobs j, employees e
        WHERE j.job_id = e.job_id(+)
        GROUP BY j.job_id, j.job_title;
        
    CURSOR d (parametru VARCHAR2) IS 
        SELECT last_name nume, salary
        FROM employees 
        WHERE job_id = parametru;
    
    BEGIN
        FOR i IN c LOOP
            DBMS_OUTPUT.PUT_LINE('Jobul ' || i.jobid || ': ');
            IF i.nr = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Niciun angajat pe job');
            ELSE
                FOR j IN d(i.jobid) LOOP
                    DBMS_OUTPUT.PUT_LINE(j.nume || ' ' || j.salary);
                END LOOP;
            END IF;
        END LOOP;
    END;
/
                
            