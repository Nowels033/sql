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

select @aux_manager,@aux_salariomax,@aux_salariomanager;
insert into empleados values('1234','manager','1',300,1000,'2024-04-09');

lock tables nombreDeTabla write;
unlock tables ;
CREATE TEMPORARY TABLE temporal ;


drop trigger salario20porciento;
delimiter $$
create trigger salario20porciento after update on empleados
FOR EACH ROW
begin
declare porcentaje DOUBLE default old.salario*20/100 ;
declare salariomax double DEFAULT old.salario+porcentaje;


if NEW.salario > salariomax then 
	update empleados set salario= salariomax where dni = new.dni;
END IF;
end$$

        delimiter ;
   
   
delimiter $$
DROP PROCEDURE IF EXISTS modificar_salario $$
CREATE PROCEDURE modificar_salario(in dni_empleado varchar(9),in sueldo_nuevo double)
BEGIN
	declare salarioempleado double default ( select salario from empleados where dni = dni_empleado);
	declare porcentaje DOUBLE default salarioempleado*20/100 ;
	declare salariomax double DEFAULT salarioempleado+porcentaje;


if sueldo_nuevo > salariomax then 
	update empleados set salario= salariomax where dni = dni_empleado;
END IF;
END;

CALL modificar_salario('12345678T',11500);   
   
update empleados set salario = 11500  where dni ='12345678T';

drop table if exists socios;
create table socios (
id int auto_increment,
nombre varchar(100) not null,
email varchar(225),
anonacimiento date,
primary key(id));

create table recordatorios (
id int auto_increment,
idsocio int,
mensaje varchar(225) not null,
primary key (id,idsocio));

drop trigger borrar_recordatorio;
delimiter $$
create trigger borrar_recordatorio before delete on socios
FOR EACH ROW
begin


delete from  recordatorios where idsocio = old.id;

end$$

        delimiter ;
   
   
delete from socios where id=1;
drop trigger menoresdeedad;
delimiter $$
create trigger menoresdeedad before INSERT on socios
FOR EACH ROW
begin
-- declare edad date default new.anonacimiento ;
declare edadsocio INT; -- DEFAULT (DATEDIFF(CURRENT_DATE(),edad)/365,25);
set edadsocio = YEAR(curdate()) - year(new.anonacimiento);

if edadsocio < 18 then 
set @msg = concat('EL SOCIO NO ES MAYOR DE EDAD');
          signal SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
END IF;
end$$

        delimiter ;
        
INSERT INTO socios VALUES (3, 'pedro', 'pedro@gmail.com', '2020-04-03');
INSERT INTO socios (nombre, email,anonacimiento) VALUES ('pedro', 'pedro@gmail.com', '2020-04-03');
select current_date();

drop table registro_socios;
create table registro_socios (id int auto_increment,
idsocio int,
nombre_antiguo VARCHAR(100),
nombre_nuevo VARCHAR(100),
email_antiguo varchar(225),
email_nuevo VARCHAR(225),
edad_antigua date,
edad_nueva date,
fecha_actualizacion date,
primary key (id));

drop trigger actualizacion;
delimiter $$
create trigger actualizacion before update on socios
FOR EACH ROW
begin

if old.nombre != new.nombre or old.email != new.email or old.anonacimiento != new.anonacimiento then 

insert into registro_socios (idsocio,nombre_antiguo,nombre_nuevo,email_antiguo,email_nuevo,edad_antigua ,edad_nueva ,fecha_actualizacion) values
(old.id,old.nombre,new.nombre,old.email,new.email,old.anonacimiento,new.anonacimiento,current_date());

end if;
end$$
delimiter ;
        
update socios set nombre = "pepteo" where id =1;

drop trigger cambionombre;
delimiter $$
create trigger cambionombre before update on socios
FOR EACH ROW
begin

if old.nombre != new.nombre then 

insert into recordatorios (idsocio,mensaje) values
(old.id,concat("Se cambio el nombre de ",old.nombre," por ",new.nombre));

end if;
end$$
delimiter ;

update socios set nombre = "dorot1eo44115" where id =1;


CREATE table recordatorios_backup(
id int auto_increment,
idsocio int,
mensaje varchar(225) not null,
primary key (id,idsocio));



drop trigger borrarsocio;
delimiter $$
create trigger borrarsocio before DELETE on socios
FOR EACH ROW
begin

insert into recordatorios_backup (idsocio,mensaje)  select idsocio,mensaje from recordatorios where idsocio=old.id;


end$$
delimiter ;

delete from socios where id = 1;

delimiter $$
    drop trigger if exists recordatorios$$
    create trigger arecordatorios before delete on socios
    for each row
    begin
    
    INSERT INTO recordatorios_backup (idsocio, mensaje) 
    
    SELECT idsocio, mensaje
    FROM recordatorios
    WHERE idsocio = OLD.id;
    

    end
    $$
    
   delimiter ;
   

delete from socios where id = 1;
drop TRIGGER borrar_recordatorio;


CREATE TABLE historico_recordarios(
id int AUTO_INCREMENT PRIMARY KEY,
fecha_traspaso DATE,
idsocio int,
mensaje VARCHAR(255),
fecha_creacion date);


drop trigger  arecordatorios_lleno;
delimiter $$
    
    create trigger arecordatorios_lleno before insert on recordatorios
    for each row
    begin
    
    declare conteo int default ( select count(*) from recordatorios);
    
    if conteo > 5 then
    
    INSERT INTO historico_recordarios (fecha_traspaso, idsocio, mensaje, fecha_creacion)
	SELECT  , idsocio, mensaje, fecha_recordatorio FROM recordatorios;
    
	END IF;
    end
    $$
    
   delimiter ;
   
   update socios set nombre = "uiooyp" where id =1;
   
   insert into recordatorios(idsocio,mensaje,fecha_recordatorio) values (7,'jjejsadljfhkjsdhfsdfsdfsdfsdfsdfsdejejej',curdate());





