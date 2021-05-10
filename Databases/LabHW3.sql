--1. Sa se afiseze numele, departamentul, salariul ?i job-ul tuturor angajatilor
--al caror salariu si comision coincid cu salariul si comisionul unui angajat din Oxford.
--(no case-sensitive)

select e.first_name || ' ' || e.last_name as "nume_NMA",
d.department_name as "departament_NMA", e.salary as "salariu_NMA",
j.job_title as "job_NMA"
from (employees e LEFT OUTER JOIN departments d on e.department_id = d.department_id)   
LEFT OUTER JOIN jobs j on e.job_id = j.job_id                      --LO JOIN CA SA FIE INCLUSI ORICE ANGAJATI(FARA DPT SAU JOB)
WHERE
e.salary IN 
(select e.salary from employees e, departments d, locations l       
where e.department_id = d.department_id and d.location_id = l.location_id
and l.city = 'Oxford')                                               --SUBCERERE PT SALARIU EGAL
and e.commission_pct IN 
(select e.commission_pct from employees e, departments d, locations l
where e.department_id = d.department_id and d.location_id = l.location_id
and l.city = 'Oxford');                                               --SUBCERERE PT COMISION EGAL

--35 REZULTATE



--2. Afisati informatii despre salariatii care castiga mai bine decat cea mai mica medie reala a salariilor pe job-uri.

select e.first_name || ' ' || e.last_name as "nume_NMA",
d.department_name as "departament_NMA", e.salary as "salariu_NMA",
j.job_title as "job_NMA"
from (employees e LEFT OUTER JOIN departments d on e.department_id = d.department_id) --LO JOIN SA POATA SA NU AIBA DPT
JOIN jobs j on e.job_id = j.job_id                      --JOIN CA SA AIBA JOB
WHERE e.salary > (SELECT MIN(a) FROM (SELECT AVG(salary) a from employees GROUP BY job_id));

--90 rezultate


--3. Pentru fiecare job, afisati care sunt salariatii platiti mai bine decat media reala a salariilor
--cu care sunt platiti salariatii angajati pe respectivul job.

select j.job_title as "job_NMA", e.first_name || ' ' || e.last_name as "nume_NMA" 
from (jobs j left outer join employees e on j.job_id = e.job_id)    --luam toate joburile
left outer join (select AVG(salary) a, job_id b from employees GROUP BY job_id) s on j.job_id = s.b 
            --luam averageul pentru joburile individuale ale angajatilor
where e.salary > s.a;

--43 rezultate