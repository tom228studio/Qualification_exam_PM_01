CREATE TABLE Students
(
	st_id serial PRIMARY KEY,
	st_firstname CHARACTER VARYING(20),
	st_midname character VARYING(29),
	st_lastname character VARYING(20),
	st_score real
)

DROP TABLE students

select * from students

create or replace FUNCTION st_insert(_firstname character VARYING, _midname CHARACTER varying, _lastname CHARACTER varying, _score real)
RETURNs int as
$$
BEGIN
	insert into students(st_firstname,st_midname,st_lastname,st_score)
	VALUES(_firstname, _midname, _lastname, _score);
	if found then
		return 1;
	else return 0;
	end if;
END
$$
LANGUAGE plpgsql

select * from st_insert('tom','valerevich','ponomarev',4.4);
select * from st_insert('evgeni','vladimirovich','shaigu',2.7);

create or replace FUNCTION st_update(_id int, _firstname character VARYING, _midname CHARACTER varying, _lastname CHARACTER varying, _score real)
RETURNs int as
$$
BEGIN
	update students
	set
		st_firstname = _firstname,
		st_midname = _midname,
		st_lastname = _lastname,
		st_score = _score
	where st_id = _id;
	if found then
		return 1;
	else return 0;
	end if; 
END
$$
LANGUAGE plpgsql

select * from st_update(2,'evgeni','vladimirovich','shaigu',3.7);

create or replace FUNCTION st_select()
RETURNs table
(
	_id int,
	_firstname character VARYING, 
	_midname CHARACTER varying, 
	_lastname CHARACTER varying, 
	_score real
)AS
$$
BEGIN
	return query
	SELECT st_id, st_firstname, st_midname, st_lastname, st_score from students order by st_id;
end
$$
language plpgsql

select * from st_select();

CREATE or REPLACE FUNCTION st_delete(_id int)
returns int as
$$
begin
	delete from students
	where st_id = _id;
	if found then
		return 1;
	else return 0;
	end if; 
END
$$
LANGUAGE plpgsql

