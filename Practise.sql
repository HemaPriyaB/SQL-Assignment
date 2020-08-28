DDL COMMANDS

1. Creation of table :

create table init(
id int,
first_name varchar,
last_name varchar,
gender varchar,
date_of_birth date,
p_id int);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'hema','priya','female','1998-07-24',10);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'hema','priyabalaji','female','1998-07-10',20);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'h','priya','female','1998-07-05',30);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'puja','priya','female','2003-08-30',40);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'suja','puja','female','1998-07-04',50);
insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (1,'suja','balaji','female','1978-02-10',60);
select * from init;


2. Altering a table:

alter table init
add column c_id int;

3. Dropping a table:

drop table init;

DML COMMANDS:

1. INSERT INTO:

insert into init(id,first_name,last_name,gender,date_of_birth,p_id) values (5,'keerthana','velu','female','1997-01-01',60);

2.SELECT 

select id,first_name,p_id from init;
select  id,first_name,p_id  from init where id=1;

3.SELECT *

select * from init;
select * from init where id=1;

4.SELECT DISTINCT

select distinct date_of_birth init;

5.WHERE

select * from init where id=1;

6.USING LIKE

select id,first_name,last_name,gender,date_of_birth from init where first_name like 'h%';

7.ORDER BY

select id,first_name,last_name,gender,date_of_birth from init where id=1 order by first_name;

8.UPDATE

update init set id =1 where first_name='hema';

Group functions:

create table student(
roll_number int,
first_name varchar,
last_name varchar,
marks int);

insert into student(roll_number,first_name,last_name,marks) values(1,'abhi','prasad',95);
insert into student(roll_number,first_name,last_name,marks) values(1,'puja','balaji',90);
insert into student(roll_number,first_name,last_name,marks) values(1,'keerthana','velu',95);
insert into student(roll_number,first_name,last_name,marks) values(1,'vignesh','kumar',93);
insert into student(roll_number,first_name,last_name,marks) values(1,'pugal','selvan',92);
insert into student(roll_number,first_name,last_name,marks) values(1,'satya','a',100);

1.Average function:
 select avg(marks) from student;

2.Max function:
select max(marks) from student;

3.Min function:
select min(marks) from student;

4.Sum function:
select sum(marks) from student;

5.Count function:
select count(first_name) from student;

6.Group by:
select max(marks) from student group by roll_number;

7.Having clause:
select max(marks) from student group by first_name having first_name like 'p%';



Creation of a fuction query:

CREATE OR REPLACE FUNCTION total_person()
RETURNS integer as $total$
DECLARE
total integer;
BEGIN 
SELECT COUNT(*) INTO total FROM person;
RETURN total;
end;
$total$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION process_emp_audit() RETURNS TRIGGER AS $emp_audit$
    BEGIN
        --
        -- Create rows in emp_audit to reflect the operations performed on emp,
        -- making use of the special variable TG_OP to work out the operation.
        --
        IF (TG_OP = 'DELETE') THEN
            INSERT INTO emp_audit
                SELECT 'D', now(), user, o.* FROM old_table o;
        ELSIF (TG_OP = 'UPDATE') THEN
            INSERT INTO emp_audit
                SELECT 'U', now(), user, n.* FROM new_table n;
        ELSIF (TG_OP = 'INSERT') THEN
            INSERT INTO emp_audit
                SELECT 'I', now(), user, n.* FROM new_table n;
        END IF;
        RETURN NULL; -- result is ignored since this is an AFTER trigger
    END;
$emp_audit$ LANGUAGE plpgsql;


Nested function:

CREATE OR REPLACE FUNCTION outerfunc(a int) RETURN int IS
  FUNCTION innerfunc1(b1 int) RETURN int IS
  BEGIN
    return innerfunc2(5);
  END;

  FUNCTION innerfunc2(b2 int) RETURN int IS
  BEGIN
    return 10;
  END;
BEGIN
  return innerfunc1(a);
END;

SELECT outerfunc(1);




Creating triggers:

CREATE TABLE emp (
    empname           text NOT NULL,
    salary            integer
);

CREATE TABLE emp_audit(
    operation         char(1)   NOT NULL,
    stamp             timestamp NOT NULL,
    userid            text      NOT NULL,
    empname           text      NOT NULL,
    salary integer
);



CREATE TRIGGER emp_audit_ins
    AFTER INSERT ON emp
    REFERENCING NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE PROCEDURE process_emp_audit();
CREATE TRIGGER emp_audit_upd
    AFTER UPDATE ON emp
    REFERENCING OLD TABLE AS old_table NEW TABLE AS new_table
    FOR EACH STATEMENT EXECUTE PROCEDURE process_emp_audit();
CREATE TRIGGER emp_audit_del
    AFTER DELETE ON emp
    REFERENCING OLD TABLE AS old_table
    FOR EACH STATEMENT EXECUTE PROCEDURE process_emp_audit();



CREATION OF STORED PROCEDURES:

1.Inserting data into the stored procedure


create procedure eg (int,varchar,varchar,varchar,date,int)
language 'plpsql'
as $$
begin
insert into init(id,first_nam,last_name,gender,date_of_birth,p_id) values($1,$2,$3,$4,$5,$6);
commit;
end;
$$;

call eg(12,'suja','balaji','female','1978-02-10',18);

2.Displaying a message on the screen


create or replace procedure display_message(inout msg text)
as $$
begin
raise notice 'Procedure Parameter: %,msg;
end;
$$
language plpgsql;
 
call display_message("Welcome to Kloudone");

3.Using transaction control:


create or replace procedure control()
language plpgsql
as $$
declare
begin
create table test1 (id int);
insert into test1 values (1);
commit;
create table test2 (id int);
insert into test2 values(1);
rollback;
end $$

select relname from pg_class where relname like '%test%';

4.Using column data types:

create or replace procedure generated_max() language plpgsql as $$
declare
marks "student"."marks"%type;
begin
select max("marks") into marks from student;
raise notice 'Maximum marks of the student is :%', marks;
end;
$$;

call generated_max();









