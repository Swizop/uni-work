--1.  S? se afi?eze titlul job-ului, limitele salariale (min_salary, max_salary), numele complet al salaria?ilor,
--id-ul ?i denumirea departamentelor în care lucreaz?.
--Se vor afi?a ?i job-urile pe care nu lucreaz? niciun salariat, dar ?i salaria?ii care nu au asociat un departament.

SELECT j.job_title as "Job_NMA", j.min_salary as "MIN_NMA", j.max_salary as "MAX_NMA", 
CONCAT(e.last_name,CONCAT(' ', e.first_name)) as "numeAngajat_NMA",
d.department_id as "deptID_NMA", d.department_name as "deptName_NMA"
FROM (employees e RIGHT OUTER JOIN jobs j ON e.job_id = j.job_id)   --RO join ca sa fie incluse si joburile care nu au angajati
LEFT OUTER JOIN departments d       --LO join ca sa fie inclusi si angajatii fara departamente, dar nu si dep. fara angajati
ON e.department_id = d.department_id;


--108 rezultate


--2.  S? se afi?eze informa?ii despre departamente în formatul urm?tor:
--„Departamentul <department_name>  este  condus  de  {<manager_id> |nimeni}
--?i {are salaria?i|  nu are salariati}“.

--folosim select distinct pentru ca ne intereseaza sa avem cel putin un rezultat cu un employee not null si un departament
--restul rezultatelor nu ne intereseaza, fara select distinct s ar repeta

SELECT DISTINCT 'Departamentul ' || d.department_name || ' este condus de ' || 
DECODE(d.manager_id, NULL, 'nimeni', d.manager_id) || ' si ' ||    --departamentul nu are manager <=> d.manager_id e null
DECODE(e.employee_id, NULL, 'nu are salariati', 'are salariati')    --nu exista niciun employee <=> exista un 
                                                                                --match cu employee_id null
AS "Cerere_NMA"
FROM employees e RIGHT OUTER JOIN departments d          --se alatura toate departamentele, indiferent daca au angajati sau nu
ON e.department_id = d.department_id;


--27 rezultate


--3.  S? se afi?eze numele, prenumele angaja?ilor, lungimea numelui ?i ora?ul în care lucreaz?
--pentru înregistr?rile în care lungimea numelui este diferit? de lungimea prenumelui.


SELECT DISTINCT e.last_name as "Nume_NMA", e.first_name as "Prenume_NMA", length(e.last_name) AS "lungime_NMA",
l.city as "City_NMA"
FROM employees e, departments d, locations l 
WHERE e.department_id = d.department_id AND d.location_id = l.location_id
AND length(e.last_name) != length(e.first_name);

--86 rezultate


--4. S? se afi?eze numele, data angaj?rii, titlul job-ului, salariul
--?i o coloan? reprezentând salariul dup? ce se aplic? o m?rire, astfel:
--pentru salaria?ii angaja?i în 1989 cre?terea este de 20%, pentru cei angaja?i în 1990 cre?terea este de 15%,
--iar salariul celor angaja?i în anul 1991 cre?te cu 10%. Pentru salaria?ii angaja?i în al?i ani valoarea nu
--se modific?.(2 rezolv?ri? DECODE si CASE).

--VARIANTA 1

SELECT e.last_name as "Nume_NMA", e.hire_date as "Date_NMA", j.job_title as "Job_NMA", e.salary as "salariu_NMA",
DECODE(TO_CHAR(e.hire_date, 'YYYY'), '1989', e.salary + 0.2 * e.salary, '1990', 
e.salary + 0.15 * e.salary, '1991', e.salary + 0.1 * e.salary, 
e.salary) as "newSalary_NMA"
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

--107 rezultate

--VARIANTA 2


SELECT e.last_name as "Nume_NMA", e.hire_date as "Date_NMA", j.job_title as "Job_NMA", e.salary as "salariu_NMA",
CASE TO_CHAR(e.hire_date, 'YYYY')
WHEN '1989' THEN e.salary + 0.2 * e.salary
WHEN '1990' THEN e.salary + 0.15 * e.salary
WHEN '1991' THEN e.salary + 0.1 * e.salary
ELSE e.salary
END AS "newSalary_NMA" 
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

--107 rezultate