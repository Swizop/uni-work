-- CEA MAI inchiriata categorie


--where instead of join
select t.category, count(*) as total, count(distinct t.title) as total_titluri_distincte
from title t, rental rl
where rl.title_id = t.title_id 
group by t.category
having count(*) = (
select max(count(*))
from title t, rental rl
where rl.title_id = t.title_id
group by t.category);


--cate exemplare din fiecare wsunt disponibile in prezent

select count(title_id)
FROM title
GROUP BY title;

select * from title;


--titlul filmului, nr exemplarului, statusul setat si cel corect

select t.title, tc.copy_id, tc.status as "status setat"
FROM title t, title_copy tc;


select t.title, tc.copy_id, status as status_actual,
case
        when (t.title_id, tc.copy_id) not in (
                            select title_id, copy_id
                            from rental
                            where act_ret_date is null)
        then 'AVAILABLE'
        else 'RENTED'
        end "STATUS CORECT"
from title t, title_copy tc 
where t.title_id = tc.title_id;


--Câte exemplareau statusul eronat? 

select count(*)
from (select t.title, tc.copy_id, status,
case
when (t.title_id, tc.copy_id) not in (select title_id, copy_id from rental where act_ret_date is null) then 'AVAILABLE'
else 'RENTED'
end "STATUS CORECT"
from title t, title_copy tc
where t.title_id = tc.title_id)
where status != "STATUS CORECT";





create table title_copy_NMT

as select * from title_copy;

UPDATE title_copy
SET status = 'RENTED'
WHERE title_id IN (select t.title_id
from (select t.title, tc.copy_id, status,
case
when (t.title_id, tc.copy_id) not in (select title_id, copy_id from rental where act_ret_date is null) then 'AVAILABLE'
else 'RENTED'
end "STATUS CORECT"
from title t, title_copy tc
where t.title_id = tc.title_id)
where status != "STATUS CORECT");




SELECT CASE 
WHEN(rl.res_date in (select
FROM RESERVATION r RENTAL rl;