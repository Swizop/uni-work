SET SERVEROUTPUT ON;
CREATE TABLE emp_nmt AS SELECT * FROM employees;
CREATE TABLE dep_nmt AS SELECT * FROM departments;
/
CREATE OR REPLACE PACKAGE pachet_nmt AS

FUNCTION fct_dpt (v_dep dep_nmt.department_name%TYPE) RETURN NUMBER;
FUNCTION fct_job (v_job jobs.job_title%TYPE) RETURN VARCHAR2;
FUNCTION fct_manager(v_nume emp_nmt.last_name%TYPE, v_prenume emp_nmt.last_name%TYPE) RETURN NUMBER;
FUNCTION fct_min_salary(v_dep dep_nmt.department_id%TYPE, v_job jobs.job_id%TYPE) RETURN NUMBER;

PROCEDURE update_emp (v_first_name emp_nmt.first_name%TYPE,
                    v_last_name emp_nmt.last_name%TYPE,
                    v_email emp_nmt.email%TYPE,
                    v_phone_number emp_nmt.phone_number%TYPE);
RETURN NUMBER;

END pachet_nmt;
/

CREATE OR REPLACE PACKAGE BODY pachet_nmt AS
FUNCTION fct_dpt (v_dep dep_nmt.department_name%TYPE) 
    RETURN NUMBER IS 
    ret_cod NUMBER := 0;
BEGIN
        SELECT department_id
        into ret_cod
        FROM dep_nmt
        WHERE UPPER(v_dep)=UPPER(department_name);
        RETURN ret_cod;
END fct_dpt;


FUNCTION fct_job (v_job jobs.job_title%TYPE)
    RETURN VARCHAR2 IS 
    ret_cod VARCHAR2(50) := '0';
BEGIN
    SELECT job_id
    into ret_cod
    FROM jobs
    WHERE UPPER(v_job)=UPPER(job_title);
    RETURN ret_cod;
END fct_job;

FUNCTION fct_manager(v_nume emp_nmt.last_name%TYPE, v_prenume emp_nmt.last_name%TYPE)
    RETURN NUMBER IS
    ret_cod NUMBER:=0;
BEGIN
    SELECT employee_id INTO ret_cod
    FROM emp_nmt
    WHERE last_name = v_nume AND first_name = v_prenume;
    RETURN ret_cod;
END fct_manager;

FUNCTION fct_min_salary(v_dep dep_nmt.department_id%TYPE, v_job jobs.job_id%TYPE)
    RETURN NUMBER IS sal number;
begin
select min(salary)
into sal
from employees
where department_id = v_dep and job_id = v_job;

return sal;
    
    RETURN sal;
END fct_min_salary;


PROCEDURE update_emp (v_first_name emp_nmt.first_name%TYPE,
                    v_last_name emp_nmt.last_name%TYPE,
                    v_email emp_nmt.email%TYPE,
                    v_phone_number emp_nmt.phone_number%TYPE,
                    v_dep_name DEPARTMENTS.DEPARTMENT_NAME%TYPE
                    v_job_title jobs)
AS BEGIN
    INSERT INTO emp_nmt
    VALUES (v_first_name, v_last_name, v_email, v_phone_number, SYSDATE, fct_job(v_job_title), 
                fct_min_salary(, get_dep(v_dep_name));
    END update_emp;
END;

END pachet_nmt;

/
BEGIN   
DBMS_OUTPUT.PUT_LINE(pachet_nmt.fct_dpt(10));
END;
/
select * from dep_nmt;
select pachet_nmt.fct_dpt('Marketing')
from dual;

select pachet_nmt.fct_job('Sales Manager')
from dual;

select pachet_nmt.fct_manager('King', 'Steven')
from dual;

select pachet_nmt.fct_min_salary(100, 'FI_ACCOUNT')
from dual;