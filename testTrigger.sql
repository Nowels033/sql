CREATE DATABASE testTrigger ;
use testTrigger;

create TABLE alumnos(id int PRIMARY KEY,nombre varchar(30),apellido1 varchar(50),apellido2 varchar(50),edad int ,nota real);


delimiter $$

drop TRIGGER IF EXISTS trigger_check_before_insert $$
CREATE TRIGGER trigger_check_before_insert 
BEFORE INSERT
on alumnos FOR EACH ROW

BEGIN

	if NEW.nota < 0 then
			set NEW.nota=0;
	elseif NEW.nota > 10 then
			set NEW.nota = 10;
	END IF;
END
$$
delimiter ;


delimiter $$
drop TRIGGER IF EXISTS trigger_check_before_update $$
CREATE TRIGGER trigger_check_before_update
BEFORE update
on alumnos FOR EACH ROW

BEGIN

	if NEW.nota < 0 then
			set NEW.nota=0;
	elseif NEW.nota > 10 then
			set NEW.nota = 10;
	END IF;
END
$$
delimiter ;

create table empleados ( dni VARCHAR(9) PRIMARY KEY,nomemp VARCHAR(100),mgr char(4),salario double DEFAULT 1000,usuario INTEGER default 1000,fecha date);
-- drop table  empleados;
-- drop trigger jefes;

delimiter $$
create trigger jefes 
before insert on empleados
for each row
	
    begin 
    
    declare supervisa integer;
    DECLARE error1 VARCHAR(100);
		select count(*) into supervisa from empleados where mgr = NEW.mgr;
        
        if (supervisa > 4) then 
          set error1 = concat(New.mgr,'No se puede supervisar mas de 5');
          ROLLBACK;
         
        end if;
        
        end
        $$
        
        delimiter ;
        select @error1;
        
        -- truncate empleados;
        
