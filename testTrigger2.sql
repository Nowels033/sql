delimiter $$

CREATE TRIGGER acctulizar_usuario before INSERT on empleados
FOR EACH ROW
begin
	set NEW.usuario = 99999;
    
END
$$
delimiter ;

delimiter $$

CREATE TRIGGER acctulizar_fecha before INSERT on empleados
FOR EACH ROW
begin
	set NEW.fecha =current_date();
    
END
$$
delimiter ;

insert into empleados values('12345678T','pepe','1234',1300,1000,'2024-04-09');
insert into empleados values('12345679T','paco','1234',1300,1000,'2025-04-09');

select * from information_schema.tables where table_schema = database() and table_name='registroEmpleados';

create TABLE registroEmpleados (id INT AUTO_INCREMENT PRIMARY KEY,dni varchar(9),salario_anterior double,salario_nuevo double,fecha_modificacion DATE);

delimiter $$

CREATE TRIGGER cambiosDeSalario after update on empleados
FOR EACH ROW
begin
if old.salario != NEW.salario then 

-- if not EXISTS(select * from information_schema.tables where table_schema = database() and table_name='registroEmpleados') then
-- create TABLE registroEmpleados (id INT AUTO_INCREMENT PRIMARY KEY,dni varchar(9),salario_anterior double,salario_nuevo double,fecha_modificacion DATE);
-- end if;

insert into registroEmpleados (dni,salario_anterior,salario_nuevo,fecha_modificacion) values (OLD.dni,OLD.salario,NEW.salario,now());

END IF;

	-- set NEW.fecha =current_date();
    
END
$$
delimiter ;

drop TRIGGER cambiosDeSalario;
update empleados set salario = 0 where dni ='12345678T';
update empleados set salario = 2000;



delimiter $$
create trigger jefes 
before insert on empleados
for each row
	
    begin 
    
    declare supervisa int;
   
		select count(*) into supervisa from empleados where mgr = NEW.mgr;
        
        if (supervisa > 4) then 
			
          set @msg = concat(New.mgr,' No se puede supervisar mas de 4 empleados');
          signal SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
         
         
        end if;
        
        end
        $$
        
        delimiter ;

insert into empleados values('22345678T','juan','1234',1300,1000,'2024-04-09');
insert into empleados values('32345678T','rodolfo','1234',1300,1000,'2024-04-09');
insert into empleados values('42345678T','pablo','1234',1300,1000,'2024-04-09');
insert into empleados values('52345678T','perico','1234',1300,1000,'2024-04-09');
insert into empleados values('62345678T','palotes','1234',1300,1000,'2024-04-09');

-- set @@autocommit = 1;

delimiter $$
create trigger salario20porciento before update on empleados
FOR EACH ROW
begin
declare porcentaje DOUBLE default old.salario*20/100 ;
declare salarionuevo double DEFAULT old.salario+porcentaje;


if NEW.salario > salarionuevo then 
set @msg = concat('No se puede poner un salario mayor al 20% del empleado');
          signal SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
END IF;
end$$

        delimiter ;

update empleados set salario = 1000000000000000000 where dni ='12345678T';        

--  drop trigger salario20porciento ;    
-- las sentencias de dll de estructura de tabla solo se pueden ejecutar en procedimiento, ni el trigger ni la funcion lo permite en mysql 

drop trigger sueldoManager;
delimiter $$

create trigger sueldoManager after update on empleados
FOR EACH ROW
begin
declare manager varchar(9) default (select mgr from empleados where dni = old.dni);

declare salariomax double default (select max(salario) from empleados where mgr = manager);

declare salariomanager double default (select salario from empleados where dni= manager);
-- set manager = ;

set @aux_manager = manager;
set @aux_salariomax = salariomax;
set @aux_salariomanager = salariomanager;

if  salariomax > salariomanager then 

update empleados set empleados.salario= salariomax where empleados.dni = manager;

END IF;

end$$

        delimiter ;

update empleados set salario = 1150  where dni ='12345678T';

drop trigger sueldoManager;
DELIMITER $$

CREATE TRIGGER sueldoManager AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
    DECLARE manager VARCHAR(9);
    DECLARE salariomax DOUBLE;
    DECLARE salariomanager DOUBLE;
    


    SELECT mgr INTO manager FROM empleados WHERE dni = OLD.dni;
    SELECT MAX(salario) INTO salariomax FROM empleados WHERE mgr = manager;
    SELECT salario INTO salariomanager FROM empleados WHERE dni = manager;
set @aux_manager = manager;
set @aux_salariomax = salariomax;
set @aux_salariomanager = salariomanager;
    IF salariomax > salariomanager THEN
        UPDATE empleados SET salario = salariomax WHERE dni = manager;
    END IF;
END$$

DELIMITER ;

select @aux_manager,@aux_salariomax,@aux_salariomanager;
insert into empleados values('1234','manager','1',300,1000,'2024-04-09');