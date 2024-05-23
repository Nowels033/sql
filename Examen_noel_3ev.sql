-- EXAMEN 3:  TRIMESTRE BASE DE DATOS

-- Ejercicio 1: Valor del ejercicio 3 puntos

-- Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos, 
-- los datos de dichos alumnos se cargaran a través de la tabla incorporada al final del ejercicio, 
-- usando la función load. La tabla alumnos está formada por las siguientes columnas:

-- id (entero sin signo y clave primaria)
 -- nombre (cadena de caracteres)
-- apellido1 (cadena de caracteres)
-- apellido2 (cadena de caracteres
-- fecha_nacimiento (fecha)
-- Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado a partir de la columna fecha_nacimiento.
-- Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.

-- A continuación escribe una función llamada calcular_edad que reciba una fecha y 
-- devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:

-- Función: calcular_edad
-- Entrada: Fecha
-- Salida: Número de años (entero)
-- Para completar la tabla ahora debemos generar un procedimiento que permita calcular la edad de todos los alumnos que ya existen en la tabla.

-- Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno y actualice la tabla.
-- Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.

1.

create database test;
use test;
set global log_bin_trust_function_creators = 1;
create table alumnos (id int unsigned primary key,nombre varchar(50),apellido1 varchar(60),apellido2 varchar(60),fecha_nacimiento date);

delimiter $$

drop FUNCTION if exists añadirAlumnos$$ -- no puedo llarmarla load porque es un comando de mysql
CREATE FUNCTION añadirAlumnos() 
RETURNS INT

BEGIN
    declare salida int default 0;
    
    insert into alumnos (id,nombre,apellido1,apellido2,fecha_nacimiento) values
    (1,"Sara","Gómez","Pérez","1990-10-12"),
    (2,"Maria","Ruiz","González","1988-12-03"),
    (3,"Luis","Lopez","Sanchez","2000-04-14"),
    (4,"Carlos","Sanchez","Fernandez","1987-02-28"),
    (5,"Javier","Lopez","Ruiz","2001-05-24"),
    (6,"Lucia","Sanchez","Perez","1997-01-05"),
    (7,"Marta","Fernandez","Lopez","1996-03-06"),
    (8,"Felix","Fernandez","Fernandez","1985-11-08"),
    (9,"Jose","Gonzalez","Lopez","1995-10-30"),
    (10,"Mercedes","Perez","Sanchez","1996-08-09");
    
    RETURN salida;
END $$

DELIMITER ;

select añadirAlumnos();

-- añadir columna

alter table alumnos add column edad int;

-- CREAR FUNCION CALCULAR EDAD

delimiter $$

drop FUNCTION if exists calcular_edad$$ 
CREATE FUNCTION calcular_edad( fecha date) 
RETURNS INT

BEGIN
    declare edad int default 0;
    
    RETURN TRUNCATE(DATEDIFF(CURRENT_DATE(),fecha)/365,25);
    
END $$

DELIMITER ;

-- procedimiento para rellenar la edad

delimiter $$
DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actualizar_columna_edad()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE i_fecha DATE;
  DECLARE aux_id INT;
  DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM alumnos;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO aux_id, i_fecha;
    IF done THEN
      LEAVE read_loop;
    END IF;
   	UPDATE alumnos SET edad = calcular_edad(i_fecha)
   	WHERE aux_id = id;
  END LOOP;
  CLOSE cur1;
END$$
delimiter ;

-- llamar al procedimiento
CALL actualizar_alumnos_edad();
-- ------------------------------------------


-- Ejercicio 2: Valor del ejercicio 4 puntos

-- Modifica la tabla anterior incluyendo el campo email y escribe un procedimiento que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, cree una dirección de email y la devuelva como salida.

-- Procedimiento: crear_email
-- Entrada:
-- – nombre (cadena de caracteres)

-- – apellido1 (cadena de caracteres)

-- – apellido2 (cadena de caracteres)

-- – dominio (cadena de caracteres)

-- Salida:
-- – email (cadena de caracteres)

 

-- Devuelva una dirección de correo electrónico con el siguiente formato:

-- El primer carácter del parámetro nombre.
-- Los tres primeros caracteres del parámetro apellido1.
-- Los tres primeros caracteres del parámetro apellido2.
-- El carácter @.
-- El dominio pasado como parámetro.
-- Una vez creada la tabla escriba un trigger con las siguientes características:

-- Trigger: trigger_crear_email_before_insert
-- – Se ejecuta sobre la tabla alumnos.

-- – Se ejecuta antes de una operación de inserción.

-- – Si el nuevo valor del email que se quiere insertar es NULL, entonces se le creará automáticamente una dirección de email y se insertará en la tabla.

-- – Si el nuevo valor del email no es NULL se guardará en la tabla el valor del email.

-- Nota: Para crear la nueva dirección de email se deberá hacer uso del procedimiento anterior crear_email.

-- Modifica el ejercicio anterior y añade un nuevo trigger que las siguientes características:

-- Trigger: trigger_guardar_email_after_update:

-- e ejecuta sobre la tabla alumnos.
-- Se ejecuta después de una operación de actualización.
-- Cada vez que un alumno modifique su dirección de email se deberá insertar un nuevo registro en una tabla llamada log_cambios_email.
-- La tabla log_cambios_email contiene los siguientes campos:

-- id: clave primaria (entero autonumérico)
-- id_alumno: id del alumno (entero)
-- fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
-- old_email: valor anterior del email (cadena de caracteres)
-- new_email: nuevo valor con el que se ha actualizado


-- Trigger: trigger_guardar_alumnos_eliminados:

-- Se ejecuta sobre la tabla alumnos.
-- Se ejecuta después de una operación de borrado.
-- Cada vez que se elimine un alumno de la tabla alumnos se deberá insertar un nuevo registro en una tabla llamada log_alumnos_eliminados.
-- La tabla log_alumnos_eliminados contiene los siguientes campos:

-- id: clave primaria (entero autonumérico)
-- id_alumno: id del alumno (entero)
-- fecha_hora: marca de tiempo con el instante del cambio (fecha y hora)
-- nombre: nombre del alumno eliminado (cadena de caracteres)
-- apellido1: primer apellido del alumno eliminado (cadena de caracteres)
-- apellido2: segundo apellido del alumno eliminado (cadena de caracteres)
-- email: email del alumno eliminado (cadena de caracteres)
 


-- solucion ejercicio2

 -- añadir el campo email
 
 alter table alumnos add column email varchar(60) ;
 
 -- procedimiento crear email
 
 delimiter $$
DROP PROCEDURE IF EXISTS crear_email $$
CREATE PROCEDURE crear_email(in nombre VARCHAR(50),in apellido1 VARCHAR(50),in apellido2 VARCHAR(50),in dominio VARCHAR(20),out email VARCHAR(50))
BEGIN 
	SET email = CONCAT(SUBSTRING(nombre, 1, 1), SUBSTRING(apellido1, 1, 3), SUBSTRING(apellido2, 1, 3),"@", dominio);
END$$
delimiter ;

-- Trigger: trigger_crear_email_before_insert
drop trigger trigger_crear_email_before_insert;
DELIMITER $$

CREATE TRIGGER trigger_crear_email_before_insert BEFORE INSERT ON alumnos
FOR EACH ROW
BEGIN
    declare email varchar(50);
    
    if new.email is null then
		call crear_email(new.nombre,new.apellido1,new.apellido2,"ccc.es",@email);
      set new.email=@email;
        
	end if;
    
END $$

DELIMITER ;

insert into alumnos (id,nombre,apellido1,apellido2,fecha_nacimiento,edad) values (11,"noel","dominguez","serrano","1992-03-04",32);



-- Trigger: trigger_guardar_email_after_update:


-- crear tabla

create table log_cambios_email (id int AUTO_INCREMENT PRIMARY KEY,id_alumno int,fecha_hora time,old_email varchar(60),new_email varchar(60));

 drop trigger trigger_guardar_email_after_update;
DELIMITER  $$
CREATE TRIGGER trigger_guardar_email_after_update AFTER UPDATE ON alumnos
FOR EACH ROW
BEGIN
  
  if new.email != old.email  then
  
	INSERT INTO log_cambios_email (id_alumno,fecha_hora,old_email,new_email) values (NEW.id,curtime(),old.email,new.email);
        
        end if;
        
	
    
END $$

DELIMITER ;

UPDATE alumnos SET email = 'ejemplo@jujajhkgjaauju.es' WHERE id = 2;
 
-- Trigger: trigger_guardar_alumnos_eliminados:



-- creacion de tabla alumnos eliminados

create table log_alumnos_eliminados (id int AUTO_INCREMENT PRIMARY KEY,id_alumno int,fecha_hora time,nombre varchar(60),apellido1 varchar(60),apellido2 varchar(60),email varchar(60));


DELIMITER  $$
drop trigger if exists trigger_guardar_alumnos_eliminados$$
CREATE TRIGGER trigger_guardar_alumnos_eliminados AFTER DELETE ON alumnos
FOR EACH ROW
BEGIN
  
  
  
	INSERT INTO log_alumnos_eliminados (id_alumno,fecha_hora,nombre,apellido1,apellido2,email) values (old.id,curtime(),old.nombre,old.apellido1,old.apellido2,old.email);
        
        
        
	
    
END $$

DELIMITER ;

delete from alumnos where id = 11;




-- Ejercicio 3: Valor del ejercicio 1 punto

-- Realizar los siguientes procedimientos y funciones sobre la base de datos jardinería.

-- Escriba una función llamada cantidad_total_de_productos_vendidos que reciba como parámetro de entrada el código de un producto y devuelva la cantidad total de productos que se han vendido con ese código


-- funcion cantidad_total_de_productos_vendidos

DELIMITER $$
drop FUNCTION if exists cantidad_total_de_productos_vendidos$$
CREATE FUNCTION cantidad_total_de_productos_vendidos(codigo_proc varchar(50)) 
RETURNS INT

BEGIN
    declare total int default (select sum(cantidad) from detalle_pedido join producto on detalle_pedido.codigo_producto=producto.codigo_producto where producto.codigo_producto = codigo_proc);
    
    RETURN total;
END $$

DELIMITER ;


select cantidad_total_de_productos_vendidos("OR-127") as totalProductosVendidos;



-- Ejercicio 4: Valor del ejercicio 2 puntos

-- Crea una tabla que se llame productos_vendidos que tenga las siguientes columnas:

-- id (entero sin signo, auto incremental y clave primaria)
-- codigo_producto (cadena de caracteres)
-- cantidad_total (entero)
-- Escribe un procedimiento llamado estadísticas_productos_vendidos que para cada uno de los productos de la tabla producto calcule la cantidad total de unidades que se han vendido y almacene esta información en la tabla productos_vendidos.

-- El procedimiento tendrá que realizar las siguientes acciones:

-- Borrar el contenido de la tabla productos_vendidos.
-- Recorrer cada uno de los productos de la tabla producto. Será necesario usar un cursor.
-- Calcular la cantidad total de productos vendidos. En este paso será necesario utilizar la función cantidad_total_de_productos_vendidos desarrollada en el ejercicio 3.
-- Insertar en la tabla productos_vendidos los valores del código de producto y la cantidad total de unidades que se han vendido para ese producto en concreto.


-- crear tabla
create table productos_vendidos (id int AUTO_INCREMENT PRIMARY KEY,codigo_producto varchar(50),cantidad_total int);


-- procedimiento

DELIMITER $$
drop procedure if exists  estadisticas_productos_vendidos$$
CREATE PROCEDURE estadisticas_productos_vendidos ()
BEGIN
	DECLARE total_proc INT;
    declare codigo_proc varchar(50);
	DECLARE done INT DEFAULT FALSE;
    
	
	DECLARE cur_pro CURSOR FOR
	SELECT producto.codigo_producto FROM producto ;
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
	OPEN cur_pro;
		truncate productos_vendidos;
		producto_loop: LOOP
		FETCH cur_pro INTO codigo_proc;
		IF done THEN
			LEAVE producto_loop;
		END IF;
		set total_proc =(select cantidad_total_de_productos_vendidos(codigo_proc));
		INSERT INTO productos_vendidos (codigo_producto,cantidad_total)
		VALUES (codigo_proc,total_proc);
		END LOOP producto_loop;
	CLOSE cur_pro;
	
END $$
DELIMITER ;

call estadisticas_productos_vendidos();

select * from productos_vendidos;






 
 