1) Crear un Trigger que borre en cascada sobre la tabla relacionada cuando borremos una sala y mostrar el registro borrado al ejecutar el Trigger.

CREATE TABLE registrosBorrados (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(255),
    PRIMARY KEY (id)
);

DELIMITER $$
DROP TRIGGER IF EXISTS borradoSala$$
CREATE TRIGGER borradoSala AFTER DELETE ON Sala
FOR EACH ROW
BEGIN
    DECLARE emp_no INT;
    DECLARE done INT DEFAULT FALSE;

    DECLARE cursor1 CURSOR FOR 
        SELECT Empleado_No FROM Plantilla WHERE Sala_Cod = OLD.Sala_Cod;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor1;

    loop_empleado: LOOP
        FETCH cursor1 INTO emp_no;
        IF done THEN
            LEAVE loop_empleado;
        END IF;

        INSERT INTO registrosborrados(descripcion)
        VALUES (CONCAT('Se ha eliminado la sala con codigo: ', OLD.Sala_Cod, '. Numero de empleado afectado: ', emp_no));
    END LOOP loop_empleado;
    CLOSE cursor1;

    DELETE FROM Plantilla WHERE Sala_Cod = OLD.Sala_Cod;
END$$
DELIMITER ;

DELETE FROM Sala WHERE Sala_Cod = 1;
2) Crear un Trigger que se active cuando actualicemos alguna sala del hospital, modificando sus tablas relacionadas. Mostrar el registro actualizado.


CREATE TABLE registrosActualizados (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(255),
    PRIMARY KEY (id)
);

DELIMITER $$
CREATE TRIGGER actualizarSala AFTER UPDATE ON Sala
FOR EACH ROW
BEGIN

    IF OLD.Sala_Cod != NEW.Sala_Cod  THEN
        INSERT INTO registrosactualizados(descripcion)
        VALUES (CONCAT('Se ha modificado la sala con codigo: ', OLD.Sala_Cod, ' por numero de sala: ', NEW.Sala_Cod));

        UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
    END IF;
    
    IF  OLD.Hospital_Cod != NEW.Hospital_Cod THEN
        INSERT INTO registrosactualizados(descripcion)
        VALUES (CONCAT( ' Se cambio el codigo de hospital : ', OLD.Hospital_Cod, ' por ', NEW.Hospital_Cod));

        UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
    END IF;
    
    IF OLD.Nombre != NEW.Nombre THEN
        INSERT INTO registrosactualizados(descripcion)
        VALUES (CONCAT( ' el nombre de la sala : ', OLD.Nombre, ' por : ', NEW.Nombre));

        UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
    END IF;
    
    IF  OLD.Num_Cam != NEW.Num_Cam THEN
        INSERT INTO registrosactualizados(descripcion)
        VALUES (CONCAT('el numero de camas se cambio por : ',NEW.num_cam));

        UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
    END IF;

    IF OLD.Sala_Cod != NEW.Sala_Cod OR OLD.Hospital_Cod != NEW.Hospital_Cod OR OLD.Nombre != NEW.Nombre OR OLD.Num_Cam != NEW.Num_Cam THEN
        INSERT INTO registrosactualizados(descripcion)
        VALUES (CONCAT('Se ha modificado la sala con codigo: ', OLD.Sala_Cod, ' por numero de sala: ', NEW.Sala_Cod,
			', se cambio el codigo de hospital : ', OLD.Hospital_Cod, ' por ', NEW.Hospital_Cod, ', el nombre de la sala : '
			, OLD.Nombre, ' por : ', NEW.Nombre,'el numero de camas que tiene de : ',old.num_cam,' se cambio por : ',NEW.num_cam));

        UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
    END IF;
    

    
END$$
DELIMITER ;

UPDATE Sala SET Sala_Cod = 10 WHERE Sala_Cod = 1;

SELECT * FROM registrosactualizados;
3) Crear un Trigger que se active al eliminar un registro en la tabla hospital y modifique las tablas correspondientes.

select plantilla.empleado_no,doctor.doctor_no,sala.sala_cod 
	from sala join doctor on sala.hospital_cod = doctor.hospital_cod join plantilla on plantilla.hospital_cod = doctor.hospital_cod 
    join hospital on hospital.hospital_cod = plantilla.hospital_cod where hospital.hospital_cod =19;
DELIMITER $$
CREATE TRIGGER eliminarRegisHospital AFTER DELETE ON Hospital
FOR EACH ROW
BEGIN

 DECLARE emp_no INT;
 DECLARE auxdoctor INT;
 DECLARE auxsala INT;
 
    DECLARE done INT DEFAULT FALSE;

    DECLARE cursor1 CURSOR FOR 
        select plantilla.empleado_no,doctor.doctor_no,sala.sala_cod 
			from sala join doctor on sala.hospital_cod = doctor.hospital_cod join plantilla on plantilla.hospital_cod = doctor.hospital_cod 
			join hospital on hospital.hospital_cod = plantilla.hospital_cod where hospital.hospital_cod =OLD.Hospital_Cod;


    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cursor1;

    loop_empleado: LOOP
        FETCH cursor1 INTO emp_no,auxdoctor,auxsala;
        IF done THEN
            LEAVE loop_empleado;
        END IF;

        INSERT INTO registrosborrados(descripcion)
        VALUES (CONCAT('Se ha eliminado el hospital con codigo: ', OLD.hospital_cod, '. Numero de empleado afectado: ', emp_no,
				' .Numero de doctor afectado: ',auxdoctor,' .Numero de sala afectada : ',auxsala ));
    END LOOP loop_empleado;
    CLOSE cursor1;


    DELETE FROM Plantilla WHERE Hospital_Cod = OLD.Hospital_Cod;
    DELETE FROM Doctor WHERE Hospital_Cod = OLD.Hospital_Cod;
    DELETE FROM Sala WHERE Hospital_Cod = OLD.Hospital_Cod;
    
END$$
DELIMITER ;


4) Crear un Trigger para controlar la inserción de empleados, copiando datos sobre la inserción en una tabla llamada Control_BD.

CREATE TABLE Control_BD (
    id INT AUTO_INCREMENT,
    emp_no INT,
    usuario VARCHAR(50),
    fecha date,
    tipo_operacion VARCHAR(50),
    PRIMARY KEY (id)
);
drop trigger insercionEmpleados;
DELIMITER $$
CREATE TRIGGER insercionEmpleados AFTER INSERT ON Emp
FOR EACH ROW
BEGIN
    INSERT INTO Control_BD (emp_no, usuario, fecha, tipo_operacion)
    VALUES (NEW.Emp_No, USER(), curdate(), 'INSERT');
END$$
DELIMITER ;

insert into emp values(1,'dominguez','empleado',7902,curdate(),30.000,0,20);

5) Crear un Trigger que actúe cuando se modifique la tabla hospital y sobre todas las tablas con las que esté relacionadas.

DELIMITER $$
CREATE TRIGGER modificarHospital AFTER UPDATE ON Hospital
FOR EACH ROW
BEGIN
    UPDATE Plantilla SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
    UPDATE Doctor SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
    UPDATE Sala SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
END$$
DELIMITER ;

update hospital set hospital_cod=20 where hospital_cod=19;


6) Crear un Trigger en la tabla Plantilla para verificar que el hospital existe antes de actualizar el código del hospital.

drop trigger actualizarPlantilla;
DELIMITER $$
CREATE TRIGGER actualizarPlantilla BEFORE UPDATE ON Plantilla
FOR EACH ROW
BEGIN
    DECLARE hospital_exists INT;

    set hospital_exists = (SELECT COUNT(*) 
    FROM Hospital
    WHERE Hospital_Cod = new.Hospital_Cod);

    IF hospital_exists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El código del hospital no existe.';
    END IF;
END$$
DELIMITER ;

update plantilla set hospital_cod = 1 where hospital_cod =  500;
SELECT COUNT(*) 
    FROM Hospital
    WHERE Hospital_Cod =1;

7) Modificar el Trigger del ejercicio 4, utilizando transacciones y control de errores.

DELIMITER $$
CREATE TRIGGER insercionEmpleadosTrans AFTER INSERT ON Emp
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la inserción de empleado. Operación no realizada.';
    END;

    START TRANSACTION;

    INSERT INTO Control_BD (emp_no, usuario, fecha, tipo_operacion)
    VALUES (NEW.Emp_No, USER(), curdate(), 'INSERT');

    COMMIT;
END$$
DELIMITER ;


8) Crear un Trigger que guarde los datos en la tabla controlTrigger cuando se realice la baja de un empleado.

CREATE TABLE ControlTrigger (
    id INT AUTO_INCREMENT,
    emp_no INT,
    usuario VARCHAR(50),
    fecha date,
    tipo_operacion VARCHAR(50),
    PRIMARY KEY (id)
);

DELIMITER $$
CREATE TRIGGER bajaEmpleados AFTER DELETE ON Emp
FOR EACH ROW
BEGIN
    INSERT INTO ControlTrigger (emp_no, usuario, fecha, tipo_operacion)
    VALUES (OLD.Emp_No, USER(), NOW(), 'DELETE');
END$$
DELIMITER ;

delete from emp where emp_no = 1;

9) Crear un Trigger que guarde los datos en la tabla ControlTrigger cuando se realice una modificación en un empleado.



DELIMITER $$
CREATE TRIGGER modificarEmpleados AFTER UPDATE ON Emp
FOR EACH ROW
BEGIN
    INSERT INTO ControlTrigger (emp_no, usuario, fecha, tipo_operacion, hora_actualizacion)
    VALUES (NEW.Emp_No, USER(), NOW(), concat('update','se cambio ',old.emp_no, 'por : ',new.emp_no), CURTIME());
END$$
DELIMITER ;