--13
select department_id
from departments
where lower (department_name) like '%re%'
and department_id = ANY (select department_id from employees where job_id = 'HR_REP');

--14
select employee_id, job_id, last_name
from employees
where salary >= 3000
union select e.employee_id, j.job_id, e.last_name
from employees e
inner join jobs j
on e.job_id = j.job_id
WHERE e.salary = (j.min_salary + j.max_salary) / 2;

--17

select first_name, last_name, salary
from employees
where manager_id = (select employee_id from employees where manager_id is null);


--18
select first_name, last_name, department_id, salary
from employees
where department_id in (select department_id from employees where commission_pct is not null)
intersect
select first_name, last_name, department_id, salary
from employees
where salary in (select salary from employees where commission_pct is not null);

--20

select first_name , last_name, job_id ,salary
from employees 
where salary >all( select salary from employees where lower(job_id) like '%clerk%' );



--21

select e.last_name, d.department_name, e.salary
from employees e
inner join departments d
on e.department_id = d.department_id
where e.manager_id = ANY (select employee_id from employees where commission_pct is not null );


--23

select last_name , department_id , job_id
from employees
join departments using (department_id)
where department_name in ( select department_name from departments join locations using (location_id)
                      where lower(city) = 'toronto');
                      