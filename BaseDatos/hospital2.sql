CREATE DATABASE hospital2;
use hospital2;

-- CREATE TABLE
CREATE TABLE Dept
(Dept_No INT NOT NULL,
DNombre VARCHAR(50) NULL,
Loc VARCHAR(50) NULL);

CREATE TABLE Emp
(Emp_No INT NOT NULL,
Apellido VARCHAR(50) NULL,
Oficio VARCHAR(50) NULL,
Dir INT NULL,
Fecha_Alt DATE NULL,
Salario NUMERIC(9,2) NULL,
Comision NUMERIC(9,2) NULL,
Dept_No INT NULL);

CREATE TABLE Hospital(
Hospital_Cod INT NOT NULL,
Nombre VARCHAR(50) NULL,
Direccion VARCHAR(50) NULL,
Telefono VARCHAR(50) NULL,
Num_Cama INT NULL);

CREATE TABLE Doctor(
Doctor_No INT NOT NULL,
Hospital_Cod INT NOT NULL,
Apellido VARCHAR(50) NULL,
Especialidad VARCHAR(50) NULL
);

CREATE TABLE Sala
(Sala_Cod INT NOT NULL,
Hospital_Cod INT NOT NULL,
Nombre VARCHAR(50) NULL,
Num_Cam INT NULL
);

CREATE TABLE Plantilla
(Empleado_No INT NOT NULL,
Sala_Cod INT NOT NULL,
Hospital_Cod INT NOT NULL,
Apellido VARCHAR(50) NULL,
Funcion VARCHAR(50) NULL,
T VARCHAR(15) NULL,
Salario NUMERIC(9,2) NULL
);

CREATE TABLE Enfermo(
Inscripcion INT NOT NULL,
Apellido VARCHAR(50) NULL,
Direccion VARCHAR(50) NULL,
Fecha_Nac VARCHAR(50) NULL,
S VARCHAR(2) NULL,
NSS INT NULL
);

-- INSERT
-- Insertar datos en la table Dept
INSERT INTO Dept(Dept_No,DNombre,Loc) VALUES(10,'CONTABILIDAD','ELCHE');
INSERT INTO Dept(Dept_No,DNombre,Loc) VALUES(20,'INVESTIGACIÓN','MADRID');
INSERT INTO Dept(Dept_No,DNombre,Loc) VALUES(30,'VENTAS','BARCELONA');
INSERT INTO Dept(Dept_No,DNombre,Loc) VALUES(40,'PRODUCCIÓN','SALAMANCA');

-- Insertar datos en la tabla Emp
INSERT INTO Emp( Emp_No, Apellido, Oficio, Dir, Fecha_Alt, Salario, Comision, Dept_No) VALUES
(7369,'SANCHEZ','EMPLEADO',7902,'1980-12-17',10400,0,20),
(7499,'ARROYO','VENDEDOR',7698,'1981-02-22',208000,39000,30),
(7521,'SALA','VENDEDOR',689,'1981-02-22',162500,65000,30),
(7566,'JIMENEZ','DIRECTOR',7839,'1981-04-02',386750,0,20),
(7654,'MARTIN','VENDEDOR',7698,'1981-09-28',182000,182000,30),
(7698,'NEGRO','DIRECTOR',7839,'1981-05-01',370500,0,30),
(7782,'CEREZO','DIRECTOR',7839,'1981-06-09',318500,0,10),
(7788,'NINO','ANALISTA',7566,'1987-03-30',390000,0,20),
(7839,'REY','PRESIDENTE',0,'1981-11-17',650000,0,10),
(7844,'TOVAR','VENDEDOR',7698,'1981-09-08',195000,0,30),
(7876,'ALONSO','EMPLEADO',7788,'1987-05-03',143000,0,20),
(7900,'JIMENO','EMPLEADO',7698,'1981-12-03',123500,0,30),
(7902,'FERNANDEZ','ANALISTA',7566,'1981-12-03',390000,0,20),
(7934,'MUÑOZ','EMPLEADO',7782,'1982-06-23',169000,0,10),
(7119,'SERRA','DIRECTOR',7839,'1983-11-19',225000,39000,20),
(7322,'GARCIA','EMPLEADO',7119,'1982-10-12',129000,0,20);

-- Insertar datos en la tabla Hospital
INSERT INTO Hospital(Hospital_Cod,Nombre,Direccion,Telefono, Num_Cama)
VALUES(19,'Provincial','O Donell 50','964-4256',502);
INSERT INTO Hospital(Hospital_Cod,Nombre,Direccion,Telefono, Num_Cama)
VALUES(18,'General','Atocha s/n','595-3111',987);
INSERT INTO Hospital(Hospital_Cod,Nombre,Direccion,Telefono, Num_Cama) VALUES(22,'La
Paz','Castellana 1000','923-5411',412);
INSERT INTO Hospital(Hospital_Cod,Nombre,Direccion,Telefono, Num_Cama) VALUES(45,'San
Carlos','Ciudad Universitaria','597-1500',845);

-- Insertar datos en la tabla Doctor
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(22,386,'Cabeza D.','Psiquiatría');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(22,398,'Best D.','Urología');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(19,435,'López A.','Cardiología');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(22,453,'Galo D.','Pediatría');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(45,522,'Adams C.','Neurología');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(18,585,'Miller G.','Ginecología');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(45,607,'Chuki P.','Pediatría');
INSERT INTO Doctor(Hospital_Cod,Doctor_No,Apellido,Especialidad) VALUES(18,982,'Cajal R.','Cardiología');

-- Insertar datos en la tabla Sala
INSERT INTO SALA VALUES(1,22,'Recuperación',10);
INSERT INTO SALA VALUES(1,45,'Recuperación',15);
INSERT INTO SALA VALUES(2,22,'Maternidad',34);
INSERT INTO SALA VALUES(2,45,'Maternidad',24);
INSERT INTO SALA VALUES(3,19,'Cuidados Intensivos',21);
INSERT INTO SALA VALUES(3,18,'Cuidados Intensivos',10);
INSERT INTO SALA VALUES(4,18,'Cardiología',53);
INSERT INTO SALA VALUES(4,45,'Cardiología',55);
INSERT INTO SALA VALUES(6,19,'Psiquiátricos',67);
INSERT INTO SALA VALUES(6,22,'Psiquiátricos',118);
TRUNCATE sala;

-- Insertar datos en la tabla Plantilla
INSERT INTO Plantilla(Hospital_Cod,Sala_Cod,Empleado_No,Apellido, Funcion, T, Salario) VALUES
(22,6,1009,'Higueras D.','Enfermera','T',200500),
(45,4,1280,'Amigo R.','Interino','N',221000),
(19,6,3106,'Hernández','Enfermero','T',275000),
(19,6,3754,'Díaz B.','Enfermera','T',226200),
(22,1,6065,'Rivera G.','Enfermera','N',162600),
(18,4,6357,'Karplus W.','Interino','T',337900),
(22,1,7379,'Carlos R.','Enfermera','T',211900),
(22,6,8422,'Bocina G.','Enfermero','M',183800),
(45,1,8526,'Frank H.','Enfermera','T',252200),
(22,2,9901,'Núñez C.','Interino','M',221000);
TRUNCATE plantilla;

-- Insertar datos en la tabla Enfermo
INSERT INTO Enfermo(Inscripcion,Apellido,Direccion,Fecha_Nac,S,NSS)
VALUES
(10995,'Laguía M.','Goya 20','16-may-56','M',280862422),
(14024,'Fernández M.','Recoletos 50','21-may-60','F',284991452),
(18004,'Serrano V.','Alcalá 12','23-jun-67','F',321790059),
(36658,'Domin S.','Mayor 71','01-ene-42','M',160654471),
(38702,'Neal R.','Orense 11','18-jun-40','F',380010217),
(39217,'Cervantes M.','Perón 38','29-feb-52','M',440294390),
(59076,'Miller B.','López de Hoyos 2','16-sep-45','F',311969044),
(63827,'Ruiz P.','Ezquerdo 103','26-dic-80','M',100973253),
(64823,'Fraiser A.','Soto 3','10-jul-80','F',285201776),
(74835,'Benítez E.','Argentina','05-oct-57','M',154811767);

/*1) Crear un Trigger que borre en cascada sobre la tabla relacionada cuando borremos una sala.
Mostrar el registro borrado al ejecutar el Trigger.	*/
delimiter $$
drop trigger if exists borrado$$
create trigger borrado after delete on sala 
for each row
begin
	declare emp_no int;
	declare done int default false;

	declare cursor1 cursor for 
	select Empleado_No from plantilla where Sala_Cod = old.Sala_Cod;

	declare continue handler for not found set done = true;

	open cursor1;

		loop_empleado: LOOP
			fetch cursor1 into emp_no;
			if done then
				leave loop_empleado;
			end if;

			insert into registro_borrado(descripcion)
			values (concat('Se ha eliminado la sala con codigo:' , old.sala_cod, '. Numero de empleado afectado: ', emp_no));
		end loop loop_empleado;
	close cursor1;

	DELETE FROM plantilla WHERE sala_cod = old.sala_cod;
end $$
delimiter ;

DELETE FROM Sala WHERE sala_cod = 2;



/*2) Crear un Trigger que se active cuando Actualicemos alguna sala del hospital, modificando sus
tablas relacionadas. Mostrar el registro Actualizado.	*/
DELIMITER $$
CREATE TRIGGER mostrarRegistroSalaActualizado AFTER UPDATE ON sala
FOR EACH ROW
BEGIN
	UPDATE plantilla set plantilla.Sala_cod = NEW.Sala_cod WHERE plantilla.Sala_cod = OLD.Sala_cod;
END$$
DELIMITER ;

UPDATE sala set Nombre = "infaltil" WHERE Sala_cod = 1;


/*3) Crear un Trigger que se active al eliminar un registro en la tabla hospital y modifique las tablas
correspondientes.	*/
DELIMITER $$
CREATE TRIGGER eliminarRegistroEnHospital AFTER DELETE ON sala
FOR EACH ROW
BEGIN
	DELETE FROM Plantilla  WHERE Hospital_Cod = OLD.Hospital_Cod;
    DELETE FROM Doctor WHERE Hospital_Cod = OLD.Hospital_Cod;
    DELETE FROM Sala WHERE Hospital_Cod = OLD.Hospital_Cod;
END$$
DELIMITER ;

DELETE FROM hopital WHERE Nombre = "Provincial";


/*4) Crear un Trigger para controlar la inserción de empleados, cuando insertemos un empleado se
copiarán datos sobre la inserción en una tabla llamada Control_BD. Los datos que se copiarán son el
Número de empleado, El usuario que está realizando la operación, la fecha y el tipo de operación.	*/
CREATE TABLE Control_BD (
id INT AUTO_INCREMENT,
emp_no INT,
usuario VARCHAR(50),
fecha DATE,
tipo_op VARCHAR(100)
);

DELIMITER $$
CREATE TRIGGER insertConControl AFTER INSERT ON Emp
FOR EACH ROW
BEGIN
	INSERT INTO Control_BD (emp_no, usuario, fecha, tipo_op) VALUES 
    (NEW.Emp_no, USER(), curdate(),'INSEERT');
END$$
DELIMITER ;

INSERT INTO Emp VALUES (10,'MAGRO','empleado',7902,curdate(),10.0000,0,22);

/*5) Crear un Trigger que actúe cuando se modifique la tabla hospital y sobre todas las tablas con las
que esté relacionadas.	*/
DELIMITER $$
CREATE TRIGGER actualizarHopital AFTER UPDATE ON Hospital
FOR EACH ROW
BEGIN
	UPDATE Plantilla SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
    UPDATE Doctor SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
    UPDATE Sala SET Hospital_Cod = NEW.Hospital_Cod WHERE Hospital_Cod = OLD.Hospital_Cod;
END$$
DELIMITER ;

UPDATE Hospital SET Hospital_Cod = 20 WHERE Hospital_Cod = 19;

/*6) Crear un Trigger en la tabla plantilla. Cuando actualicemos la tabla plantilla, debemos comprobar
que el hospital que actualizamos existe, si intentamos actualizar el código de hospital, no podremos
hacerlo si no existe relación con algún código de hospital. Realizar el mismo Trigger para las tablas
relacionadas con Hospital.	*/
DELIMITER $$
CREATE TRIGGER actualizarPlantilla BEFORE UPDATE ON Plantilla
FOR EACH ROW
BEGIN
	DECLARE CodHospitalExist INT DEFAULT (SELECT COUNT(*) FROM Hospital 
    WHERE Hospital_Cod = NEW.Hospital_Cod);
    
    IF CodHospitalExist = 0 THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El codigo del hospital no existe';
    END IF;
END$$
DELIMITER ;

UPDATE Plantilla SET Hospital_Cod = 1 WHERE Hospital_Cod = 20;


/*7) Modificar el Trigger del ejercicio 4, utilizando transacciones y control de errores, si la operación
es correcta, mostrará un mensaje positivo, si la operación no es correcta mostrará el error y un
mensaje que indique que no se ha llevado a cabo la operación.	*/
DELIMITER $$
CREATE TRIGGER borrarEnCascada BEFORE DELETE ON sala
FOR EACH ROW
BEGIN
	
END$$
DELIMITER ;



/*8) Crear un Trigger que guarde los datos en la tabla controlTrigger cuando se realice la baja de un
empleado.	*/
CREATE TABLE controlTrigger (
id INT AUTO_INCREMENT,
emp_no INT,
usuario VARCHAR(50),
fecha DATE,
tipo_op VARCHAR(100)
);

DELIMITER $$
CREATE TRIGGER bajaEmpleado AFTER DELETE ON sala
FOR EACH ROW
BEGIN
	INSERT INTO controlTrigger (emp_no, usuario, fecha, tipo_op) VALUES 
    (OLD.Emp_no, USER(), curdate(),'DELETE');
END$$
DELIMITER ;

DELETE FROM Emp WHERE emp_no =20;

/*9) Crear un Trigger que guarde los datos en la tabla ControlTrigger cuando se realice una
modificación en un empleado. Guardar la hora de la actualización en un campo aparte en la tabla
ControlTrigger. (Añadir un campo)	*/
ALTER TABLE controlTrigger ADD COLUMN hora TIME;

DELIMITER $$
CREATE TRIGGER modificarEmpleado BEFORE UPDATE ON Plantilla
FOR EACH ROW
BEGIN
	INSERT INTO controlTrigger (emp_no, usuario, fecha, tipo_op, hora) 
    VALUES (OLD.Emp_no, USER(), curdate(),'UPDATE', CURTIME());
END$$
DELIMITER ;

UPDATE sala SET puesto = 'Auxiliar Enfermeria' WHERE emp_no = 10;
