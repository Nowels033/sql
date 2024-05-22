/* 1) Crear un Trigger que borre en cascada sobre la tabla relacionada cuando borremos una sala.
Mostrar el registro borrado al ejecutar el Trigger.
*/
CREATE TABLE Registro_Borrado (
ID INT AUTO_INCREMENT PRIMARY KEY,
Descripcion VARCHAR(255)
);
DELIMITER $$
CREATE TRIGGER delete_cascade_sala AFTER DELETE ON Sala
FOR EACH ROW
BEGIN
	DECLARE emp_no INT;
	DECLARE done INT DEFAULT FALSE;
	-- Cursor para recorrer los empleados que serán borrados
	DECLARE cur_emp CURSOR FOR
	SELECT Empleado_No FROM Plantilla WHERE Sala_Cod = old.Sala_Cod;
	-- Variables para manejar el fin del cursor
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cur_emp;
		-- Inicio del bucle
		empleado_loop: LOOP
		FETCH cur_emp INTO emp_no;
		IF done THEN
			LEAVE empleado_loop;
		END IF;
		-- Insertar en la tabla Registro_Borrado
		INSERT INTO Registro_Borrado (Descripcion)
		VALUES (CONCAT('Se ha eliminado la sala con código ', old.sala_cod, '.
		Número de empleado afectado: ', emp_no));
		END LOOP empleado_loop;
	CLOSE cur_emp;
	-- Borrar los registros de la tabla Plantilla
	DELETE FROM Plantilla WHERE Sala_Cod = old.sala_cod;
END $$
DELIMITER ;
DELETE FROM SALA WHERE SALA_COD = 2;
SELECT * FROM Registro_Borrado;

/* 2) Crear un Trigger que se active cuando Actualicemos alguna sala del hospital, modificando sus
tablas relacionadas. Mostrar el registro Actualizado.	
*/
CREATE TABLE Registro_Actualizado (
ID INT AUTO_INCREMENT PRIMARY KEY,
Descripcion VARCHAR(255));
Drop TRIGGER update_related_tables_sala;
DELIMITER $$
CREATE TRIGGER update_related_tables_sala
AFTER UPDATE ON Sala
FOR EACH ROW
BEGIN
	DECLARE emp_no INT;
	DECLARE done INT DEFAULT FALSE;
	-- Cursor para recorrer los empleados que serán borrados
	DECLARE cur_emp CURSOR FOR
	SELECT Empleado_No FROM Plantilla WHERE Sala_Cod = old.Sala_Cod;
	-- Variables para manejar el fin del cursor
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cur_emp;
		-- Inicio del bucle
		empleado_loop: LOOP
		FETCH cur_emp INTO emp_no;
		IF done THEN
			LEAVE empleado_loop;
		END IF;
		-- Insertar en la tabla Registro_Borrado
		INSERT INTO Registro_actualizado (Descripcion)
		VALUES (CONCAT('Se ha actualizado la sala con código ', old.sala_cod, '.
		Número de empleado afectado: ', emp_no));
		END LOOP empleado_loop;
	CLOSE cur_emp;
	-- Actualizar otras tablas relacionadas con Sala si es necesario
	UPDATE Plantilla SET Sala_Cod = NEW.Sala_Cod WHERE Sala_Cod = OLD.Sala_Cod;
END $$
DELIMITER ;
UPDATE SALA SET SALA_COD = 2 WHERE SALA_COD = 4;
SELECT * FROM Registro_Actualizado;

/*	3) Crear un Trigger que se active al eliminar un registro en la tabla hospital 
y modifique las tablas correspondientes. OK	
*/
DROP TRIGGER BORRARHOSPITAL;
DELIMITER $$
CREATE TRIGGER BORRARHOSPITAL AFTER DELETE ON HOSPITAL
FOR EACH ROW
BEGIN
	DELETE FROM PLANTILLA WHERE HOSPITAL_COD = OLD.HOSPITAL_COD;
	DELETE FROM SALA WHERE HOSPITAL_COD = OLD.HOSPITAL_COD;
	DELETE FROM DOCTOR WHERE HOSPITAL_COD = OLD.HOSPITAL_COD;
END$$
DELIMITER ;
DELETE FROM HOSPITAL WHERE HOSPITAL_COD = 45;

/*	4) Crear un Trigger para controlar la inserción de empleados, cuando insertemos un empleado se
copiarán datos sobre la inserción en una tabla llamada Control_BD. Los datos que se copiarán son el
Número de empleado, El usuario que está realizando la operación, la fecha y el tipo de operación.
*/
CREATE TABLE Control_BD (
EMP_NO INT, USUARIO VARCHAR(20),
FECHA DATETIME,
OPERACION VARCHAR(15));
DELIMITER $$
CREATE TRIGGER DAR_ALTA AFTER INSERT ON EMP
FOR EACH ROW
BEGIN
	INSERT INTO Control_BD (EMP_NO, USUARIO, FECHA, OPERACION)
	VALUES (NEW.EMP_NO, USER(), NOW(), 'INSERCION');
END $$
DELIMITER ;
INSERT INTO EMP (EMP_NO, APELLIDO, OFICIO, DIR, FECHA_ALT, SALARIO, COMISION, DEPT_NO)VALUES 
(7455, 'GANOZA', 'EMPLEADO', 7902,'2015-05-29', 15520, 0, 20);

/	*5) Crear un Trigger que actúe cuando se modifique la tabla hospital y sobre todas las tablas con las
que esté relacionadas.
*/
DELIMITER $$
CREATE TRIGGER MODIFHOSPITAL AFTER UPDATE ON HOSPITAL
FOR EACH ROW
BEGIN
	UPDATE PLANTILLA SET PLANTILLA.HOSPITAL_COD = NEW.HOSPITAL_COD WHERE PLANTILLA.HOSPITAL_COD = OLD.HOSPITAL_COD;
	UPDATE SALA SET SALA.HOSPITAL_COD = NEW.HOSPITAL_COD WHERE SALA.HOSPITAL_COD = OLD.HOSPITAL_COD;
	UPDATE DOCTOR SET DOCTOR.HOSPITAL_COD = NEW.HOSPITAL_COD WHERE DOCTOR.HOSPITAL_COD = OLD.HOSPITAL_COD;
END$$
UPDATE HOSPITAL SET HOSPITAL_COD = 90 WHERE HOSPITAL_COD = 18;

/*	6) Crear un Trigger en la tabla plantilla. Cuando actualicemos la tabla plantilla, debemos comprobar
que el hospital que actualizamos existe, si intentamos actualizar el código de hospital, no podremos
hacerlo si no existe relación con algún código de hospital. Realizar el mismo Trigger para las tablas
relacionadas con Hospital.
*/
DELIMITER $$
CREATE TRIGGER ACTUALIZARPLANTILLA BEFORE UPDATE ON PLANTILLA
FOR EACH ROW
BEGIN
	DECLARE HOSPITAL INT;
	SELECT I.HOSPITAL_COD INTO HOSPITAL FROM HOSPITAL AS H INNER JOIN (SELECT NEW.HOSPITAL_COD AS HOSPITAL_COD) AS I
	ON H.HOSPITAL_COD = I.HOSPITAL_COD;
	IF (HOSPITAL IS NULL) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'NO EXISTE EL CÓDIGO DE HOSPITAL';
	END IF;
END$$
UPDATE PLANTILLA SET HOSPITAL_COD = 140 WHERE EMPLEADO_NO = 1009;
UPDATE PLANTILLA SET HOSPITAL_COD = 90 WHERE EMPLEADO_NO = 1009;

/*	7) Modificar el Trigger del ejercicio 4, utilizando transacciones y control de errores, si la operación
es correcta, mostrará un mensaje positivo, si la operación no es correcta mostrará el error y un
mensaje que indique que no se ha llevado a cabo la operación.
*/
DELIMITER $$	/*NO FUNCIONA, HAY VARIOS begin Y end*/
CREATE TRIGGER DAR_ALTA AFTER INSERT ON EMP
FOR EACH ROW
BEGIN
	DECLARE exit handler for sqlexception
BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error al insertar empleado. Operación abortada.';
END;
	DECLARE exit handler for sqlwarning
BEGIN
	ROLLBACK;
	SIGNAL SQLSTATE '01000' SET MESSAGE_TEXT = 'Advertencia: Ha ocurrido una advertencia al insertar el empleado.';
END;
	START TRANSACTION;
	INSERT INTO Control_BD (EMP_NO, USUARIO, FECHA, OPERACION) VALUES (NEW.EMP_NO, USER(), NOW(), 'INSERCION');
COMMIT;
END $$
DELIMITER ;
INSERT INTO EMP(EMP_NO, APELLIDO, OFICIO, DIR, FECHA_ALT, SALARIO, COMISION, DEPT_NO)
VALUES(8741,'ZEGARRA','EMPLEADO',7902,'30/05/2015',15520,0,20);

/*	8) Crear un Trigger que guarde los datos en la tabla controlTrigger cuando se realice 
la baja de un empleado.
*/
DELIMITER $$
CREATE TRIGGER DAR_BAJA BEFORE DELETE ON EMP
FOR EACH ROW
BEGIN
	INSERT INTO Control_BD (EMP_NO, USUARIO, FECHA, OPERACION) VALUES (OLD.EMP_No, USER(), NOW(), 'BAJA');
END$$
DELIMITER ;
DELETE FROM EMP WHERE EMP_NO = 8741;

/*	9) Crear un Trigger que guarde los datos en la tabla ControlTrigger cuando se realice una
modificación en un empleado. Guardar la hora de la actualización en un campo aparte en la tabla
ControlTrigger. (Añadir un campo)
*/
ALTER TABLE Control_BD ADD COLUMN HORA VARCHAR(10);
DELIMITER $$
CREATE TRIGGER MODIFICAREMP AFTER UPDATE ON EMP
FOR EACH ROW
BEGIN
	DECLARE HORA VARCHAR(10);
	-- Calcular la hora actual
	SET HORA = CONCAT(HOUR(NOW()), ':', MINUTE(NOW()), ':', SECOND(NOW()));
	-- Insertar en la tabla Control_BD
	INSERT INTO Control_BD (EMP_NO, USUARIO, FECHA, OPERACION, HORA)
	-- SELECT OLD.EMP_NO, USER(), NOW(), 'MODIFICACION', HORA;
    VALUES (OLD.EMP_NO, USER(), NOW(), 'MODIFICACION', HORA);
END$$
DELIMITER ;
UPDATE EMP SET APELLIDO = 'ARROYO' WHERE EMP_NO = 7499;




