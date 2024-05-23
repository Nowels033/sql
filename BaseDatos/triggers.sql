create DATABASE testTriguers;
use testTriguers;
CREATE TABLE Alumnos(
id INT PRIMARY KEY,
nombre VARCHAR(20),
apellido1 VARCHAR(20),
apellido2 VARCHAR(20),
nota REAL);

DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert$$
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON Alumnos FOR EACH ROW
BEGIN
	IF NEW.nota<0 THEN
		SET NEW.nota=0;
	ELSEIF NEW.nota>10 THEN
		SET NEW.nota=10;
	END IF;
END $$
DELIMITER ;

create TABLE empleados(
dni CHAR(4) PRIMARY KEY,
nomemp VARCHAR(100),
mgr CHAR(4),
salario INT DEFAULT 1000,
usuario INT DEFAULT 1000,
fecha DATE);

-- empleado no sea jefe de mas de 5 empleados
DELIMITER $$
CREATE TRIGGER jefes
	BEFORE INSERT ON empleados
    FOR EACH ROW
BEGIN
DECLARE	supervisa INTEGER;
DECLARE	ERROR1 VARCHAR(100);
	SELECT count(*) INTO supervisa
    FROM empleados WHERE mgr= NEW.mgr;
    if(supervisa>4) then  
		SET ERROR1 = CONCAT(NEW.mgr, ' no se puede supervisar a más de 5 empleados');
        ROLLBACK;
    end if;
    COMMIT;
END $$

DROP TRIGGER jefes;


DELIMITER $$
create trigger actualizar_usuario BEFORE insert on empleados
for each row
BEGIN
	SET NEW.usuario = 9999; -- valor predeterminado para el campo usuario
END$$
DELIMITER ;

INSERT INTO empleados VALUES('123T','Pepe','1234',1300,1000,'2024-04-29');


-- trigger que actualice "fecha" con la fecha actual al insertar o actualizar un empleado
DELIMITER $$
CREATE TRIGGER actualizar_fecha BEFORE INSERT ON empleados 
FOR EACH ROW
BEGIN
	SET NEW.fecha = curdate(); -- establece la fecha actual
END$$

DELIMITER ;


DELIMITER $$
CREATE TRIGGER registro_salario AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
	IF OLD.salario != NEW.salario THEN
	
		/*IF NOT EXISTS (SELECT*FROM information_schema.tables WHERE table_schema=DATABASE() AND table_name='registro_salarios') THEN
		CREATE TABLE registro_salarios(
		id INT AUTO_INCREMENT PRIMARY KEY,
		dni CHAR(4),
		salario_anterior INT,
		salario_nuevo INT,
		fecha_modificacion DATE);
		END IF;*/
	INSERT INTO registro_salarios(dni,salario_anterior,salario_nuevo,fecha_modificacion)
    VALUES (NEW.dni, OLD.salario,NEW.salario,NOW());
    END IF;
END$$
DELIMITER ;

UPDATE empleados SET salario = 1234 where dni='1';


DELIMITER $$
CREATE TRIGGER jefes1 BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
	DECLARE supervisa INT;
    SELECT COUNT(*) INTO supervisa FROM empleados WHERE mgr = NEW.mgr;
    IF(supervisa>=4) THEN
		SET @msg=concat(NEW.mgr, 'no puede supervisar más de 4 empleados');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
	END IF;
END$$
DELIMITER ;

INSERT INTO empleados VALUES('124p','lola','1234',1300,1000,'2024-04-29');
INSERT INTO empleados VALUES('125L','Felix','1234',1300,1000,'2024-04-29');


-- trigger para impedir aumentos de salario de mas de un 20% 	-- corregir
DELIMITER $$
CREATE TRIGGER salario_menosde20porciento BEFORE INSERT ON empleados
FOR EACH ROW
BEGIN
	DECLARE salario_anterior DECIMAL(10,2);
    DECLARE aumento_maximo DECIMAL(10,2);
    IF NEW.salario > 1.2*OLD.salario THEN
		SET salario_anterior = OLD.salaraio;
        SET aumento_maximo = salaraio_anterior*1.20; 
		SET @msg=concat(NEW.salario, 'no puede aumentar el salario en más de un 20%');
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = @msg;
	END IF;
    
END$$
DELIMITER ;



-- actualizar el salario del manager si el salario de un empleado supera el salario del manager
DELIMITER $$
CREATE TRIGGER actualizar_salario_empleado_y_manager AFTER UPDATE ON empleados
FOR EACH ROW
BEGIN
	DECLARE salario_empleado DECIMAL(10,2);
    DECLARE salario_mng DECIMAL(10,2);
    SET salario_mng = (SELECT salaraio from empleados where dni = mgr);
    IF salario_empleado > salario_mng THEN
		SET salario_mng = salario_empleado;
	END IF;
    
END$$
DELIMITER ;


-- LOS TRIGERS NO PERMITEN ACTUALIZAR LA PROPIA TABLA
-- 
-- deberes 
/*
DELIMITER $$
CREATE PROCEDURE actualizar_salario_empleado(IN enpleado_id INT, nuevo_salario DECIMAL(10,2))
BEGIN
	DECLARE 
    DECLARE 
    
    
END $$
*/

-- si el salario aumenta mas de un 20% no permitir ese aumento y aumentar un dentro del rango permitido (20%)
DELIMITER $$
CREATE PROCEDURE actualizar_salario_20_sinError (IN dni_intro VARCHAR(9), IN salario_intro DECIMAL(10,2))
BEGIN
	DECLARE salario_anterior DECIMAL(10,2);
    DECLARE aumento_maximo DECIMAL(10,2);
    DECLARE salario_empleado INT;
    
    SET aumento_maximo = salario_empleado * 0.2;
    SET salario_empleado = (SELECT salario from empleados WHERE dni = dni_intro);
    IF salario_intro > (salario_empleado + aumento_maximo) THEN
		
		
	END IF;
    
END$$
DELIMITER ;

CALL actualizar_salario_20_sinError(1, 2500);


-- crear dos tablas 
CREATE TABLE socios (
id INT AUTO_INCREMENT,
nombre VARCHAR(100) NOT NULL,
email VARCHAR(255),
Anonacimiento DATE,
PRIMARY KEY (id)
);
DROP TABLE recordatorios;
CREATE TABLE recordatorios (
id INT AUTO_INCREMENT,
idsocio INT,
mensaje VARCHAR(255) NOT NULL,
fecha_creacion DATE,
PRIMARY KEY (id, idsocio)
);

-- insert socios
INSERT INTO socios VALUES (1,'Pablo','pablo@correo.es','1996-10-10');
INSERT INTO socios VALUES (2,'Noel','noel@correo.es','1993-01-01');
INSERT INTO socios VALUES (3,'Brayan','brayan@correo.es','2000-01-01');
INSERT INTO socios VALUES (4,'Joel','joeln@correo.es','2010-05-01');

-- insert recordatorios
INSERT INTO recordatorios VALUES (1,1,'sacar fotos dni',now());
INSERT INTO recordatorios VALUES (2,1,'comprar gambas a peluso','2025-10-10');


-- trigger que elimine los recordatorios de dicho socio
DELIMITER $$
CREATE TRIGGER eliminar_recordatorios AFTER DELETE ON socios
FOR EACH ROW
BEGIN
	DELETE FROM recordatorios WHERE idsocios = OLD.id;
END$$
DELIMITER ;


-- trigger que verifique que tienes más de 18 años
DELIMITER $$
CREATE TRIGGER crear_socio_mayor18 BEFORE INSERT ON socios
FOR EACH ROW
BEGIN
	DECLARE edad INT;
    
    SET edad = year(curdate()) - YEAR(NEW.Anonacimiento);
    
    IF edad < 18 THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El socio es debe tener
        al menos 18 años';
    END IF;
    
END $$
DELIMITER ;

/* trigger activa despues de actualizar la fecha de actualizacion de un socio
en la tabla de socios*/
drop TABLE resgistro_socios;

CREATE TABLE resgistro_socios (
id INT AUTO_INCREMENT,
idSocio INT NOT NULL,
nombre_antiguo VARCHAR(100),
nombre VARCHAR(100) NOT NULL,
email_antiguo VARCHAR(255),
email VARCHAR(255),
Anonacimiento_antiguo DATE,
Anonacimiento DATE,
fecha_actualizacion DATE,
PRIMARY KEY (id)
);

drop TRIGGER actualizar_datos;
DELIMITER $$
CREATE TRIGGER actualizar_datos AFTER UPDATE ON socios
FOR EACH ROW
BEGIN
	IF OLD.nombre != NEW.nombre OR OLD.email != NEW.email OR OLD.Anonacimiento != NEW.Anonacimiento THEN  
		insert into resgistro_socios (idSocio, nombre_antiguo, nombre, email_antiguo,
        email, Anonacimiento_antiguo, Anonacimiento, fecha_actualizacion) VALUES (old.id,old.nombre,
        new.nombre,old.email,new.email,old.Anonacimiento,new.Anonacimiento,now());
    END IF;
END$$
DELIMITER ;

UPDATE socios SET nombre = 'pepe';


/*trigger despues de actualizar nombre de socio en la tabla de socios y actualizar el mensaje de 
los recordatorios asociados al socio para reflejar el cambio de nombre*/
DELIMITER $$
CREATE TRIGGER actualizar_nombre_y_recordatorios AFTER UPDATE ON socios
FOR EACH ROW
BEGIN
	IF OLD.nombre != NEW.nombre THEN  
		insert into recordatorios (idsocio,mensaje) values
		(old.id,concat("Se cambio el nombre de ",old.nombre," por ",new.nombre));
    END IF;
END$$
DELIMITER ;

drop TRIGGER cambionombre;
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

UPDATE socios SET nombre = 'adolf' WHERE nombre = 'noel';


/*trigger antes de eliminar un socio de la tabla socios. debe copiar los recordatorios asociados 
al socio  a eliminar en de respaldo "recordatorios_backup" antes de que se elimine definitivamente*/
-- poner dentro del mismo recordatorio los dos trigger de borrar recordatorios dentro
-- del mismo triguer
drop TABLE recordatorios_backup;

CREATE TABLE recordatorios_backup (
id INT,
idsocio INT,
mensaje VARCHAR(255) NOT NULL,
PRIMARY KEY (id, idsocio)
);

DELIMITER $$
CREATE TRIGGER eliminar_socios_manteniendo_recordatorios BEFORE DELETE ON socios
FOR EACH ROW
BEGIN
	INSERT INTO recordatorios_backup (id, idsocios, mensaje) select idsocio from
    recordatorios WHERE idsocio = OLD.id;
END$$
DELIMITER ;

DELETE FROM socios where id = 1;

/*triger */







/*trigger al insertar un recordatorio se verifique el numero total de registros. Si este número supera 
un umbral de registros (ejemplo1000) se traspasan los registros activos en la tabla recordatorios a una 
tabla historial, una vez copiados se borran los registros de recordatorios para permitir la insercion de 
un nuevo recordatorio en t.recordatorio
*/

CREATE TABLE historico_recordatorios (
id INT AUTO_INCREMENT PRIMARY KEY,
fecha_traspaso DATE,
idsocio INT,
mensaje VARCHAR(255),
fecha_creacion DATE
);

drop trigger historial_recordatorios_rellenar;
DELIMITER $$
CREATE TRIGGER historial_recordatorios_rellenar BEFORE INSERT ON recordatorios
FOR EACH ROW
BEGIN
	-- declaramos una variable para saber cuantos reistros hay en la tabla
    DECLARE contador INT DEFAULT 0;
    
    set contador = (SELECT count(*) FROM recordatorios);
	
    IF contador > 3 THEN
    
		INSERT INTO historico_recordatorios (fecha_traspaso, idsocios, mensaje, fecha_creacion)
        select curdate(),recordatorios.idsocio,recordatorios.mensaje,recordatorios.fecha_creacion from
		recordatorios;
		
    END IF;
END $$
DELIMITER ;

INSERT INTO recordatorios VALUES (9,1,'preguntar seguro coste moto',curdate());

DROP EVENT JOB_Diario;
CREATE EVENT JOB_Diario ON SCHEDULE EVERY 1 DAY
STARTS '2024-05-09 18:55:00'
DO
DELETE FROM recordatorios LIMIT 2;


