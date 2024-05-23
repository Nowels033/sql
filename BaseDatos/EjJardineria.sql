-- 1.8.1 Procedimientos sin sentencias SQL
-- -> (quiere decir sin usar )
-- 1. Escribe un procedimiento que no tenga ningún parámetro de entrada ni de salida y que muestre el texto ¡Hola mundo!.
DELIMITER $$
DROP PROCEDURE IF EXISTS hola_mundo$$
CREATE PROCEDURE hola_mundo()
BEGIN
SELECT '¡Hola mundo!' as mensaje;
END
$$

DELIMITER ;
CALL hola_mundo();
$$

-- 2. Escribe un procedimiento que reciba un número real de entrada y muestre un mensaje indicando si el número es positivo, negativo o cero.
DELIMITER $$
DROP PROCEDURE IF EXISTS positivo_negativo$$
CREATE PROCEDURE positivo_negativo(IN numero REAL)
BEGIN
	IF numero >0 then
		SELECT "El número es positivo";
	ELSEIF numero =0 then
    SELECT "El número es cero"
		
END
$$

DELIMITER $$
CALL positivo_negativo(1);
$$

-- 3. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor un número real,
-- y un parámetro de salida, con una cadena de caracteres indicando si el número es positivo, negativo o cero.


-- 4. Escribe un procedimiento que reciba un número real de entrada, que representa el valor de la nota de un alumno, 
-- y muestre un mensaje indicando qué nota ha obtenido teniendo en cuenta las siguientes condiciones:
-- • [0,5) = Insuficiente
-- • [5,6) = Aprobado
-- • [7, 9) = Notable
-- • [9, 10] = Sobresaliente
-- • En cualquier otro caso la nota no será válida.
delimiter $$
CREATE PROCEDURE notas_Alumno (IN notas DOUBLE, OUT mensajeNotas VARCHAR(50))
BEGIN
	IF notas >=0 && notas <5 then
    set mensajeNotas = "Suspenso";
    ELSEIF notas >=5 && notas <6 then
    set mensajeNotas = "Aprobado";
    ELSEIF notas >=6 && notas <7 then
    set mensajeNotas = "Bien";
    ELSEIF notas >=7 && notas <9 then
    set mensajeNotas = "Notable";
    ELSEIF notas >=9 && notas <=10 then
    set mensajeNotas = "Sobresaliente";
    ELSE
    set mensajeNotas = "Nota invalida";
    END IF;
END
$$

delimiter ;
CALL notas_Alumno(4.5);
CALL notas_Alumno(5);
CALL notas_Alumno(6.5);
CALL notas_Alumno(7.5);
CALL notas_Alumno(9.5);

-- 5. Modifique el procedimiento diseñado en el ejercicio anterior para que tenga un parámetro de entrada, con el valor de la nota en formato numérico y un parámetro de salida, con una cadena de texto indicando la nota correspondiente.


-- 6. Resuelva el procedimiento diseñado en el ejercicio anterior haciendo uso de la estructura de control CASE.
delimiter $$ 
CREATE PROCEDURE verificarNotaCase(in nota REAL)
BEGIN
DECLARE mensaje VARCHAR(50);
SET mensaje = CASE
WHEN nota >=0 and nota <5 THEN 'Insuficiente'
WHEN nota >=5 AND nota < 6 THEN 'Aprobado'
WHEN nota >=6 and nota < 7 THEN 'Bien'
WHEN nota >=7 and nota <9 THEN 'Notable'
WHEN nota >=9 and nota <= 10 THEN 'Sobresaliente'
ELSE 'Nota invalida'
END;
SELECT mensaje AS Nota;
END
$$
delimiter ;
CALL verificarNotaCase(1);

-- 7. Escribe un procedimiento que reciba como parámetro de entrada un valor numérico que represente un día de la semana y que devuelva una cadena de caracteres con el nombre del día de la semana correspondiente.
-- Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.
DELIMITER $$
CREATE PROCEDURE obtenerNombreDia(in numeroDia int)
begin 
case numeroDia
WHEN 1 THEN SELECT 'Lunes';
WHEN 2 THEN SELECT 'Martes';
WHEN 3 THEN SELECT 'Miercoles';
WHEN 4 THEN SELECT 'Jueves';
WHEN 5 THEN SELECT 'Viernes';
WHEN 6 THEN SELECT 'Sabado';
WHEN 7 THEN SELECT 'Domingo';
END CASE;
END
$$
delimiter ;
CALL obtenerNombreDia(3);


-- 1.8.2 Procedimientos con sentencias SQL
-- 1. Escribe un procedimiento que reciba el nombre de un país como parámetro de entrada y realice una consulta sobre la tabla cliente para obtener todos los clientes que existen en la tabla de ese país.
DELIMITER $$
CREATE PROCEDURE consulta_pais(IN pais_param VARCHAR(50))
BEGIN
	SELECT *
    FROM cliente
    WHERE pais = pais_param;
END $$
DELIMITER ;

CALL consulta_pais ("UK");

-- 2. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc).
-- Y devuelva como salida el pago de máximo valor realizado para esa forma de pago. Deberá hacer uso de la tabla pago de la base de datos jardinería.
DELIMITER $$
CREATE PROCEDURE comprobar_forma_pago(IN forma_pago_introducida VARCHAR(50))
BEGIN
	SELECT max(total)
    FROM pago
    WHERE forma_pago = forma_pago_introducida;
END $$
DELIMITER ;

CALL comprobar_forma_pago("PayPal");

-- 3. Escribe un procedimiento que reciba como parámetro de entrada una forma de pago, que será una cadena de caracteres (Ejemplo: PayPal, Transferencia, etc). 
-- Y devuelva como salida los siguientes valores teniendo en cuenta la forma de pago seleccionada como parámetro de entrada:
-- • el pago de máximo valor,
-- • el pago de mínimo valor,
-- • el valor medio de los pagos realizados,
-- • la suma de todos los pagos,
-- • el número de pagos realizados para esa forma de pago.
-- Deberá hacer uso de la tabla pago de la base de datos jardineria.
DELIMITER $$
CREATE PROCEDURE comprobar_max_min_media_sum_nPagos(IN forma_pago_introducida VARCHAR(50), OUT max_pago Decimal(15,2),min_pago Decimal(15,2))
BEGIN
	(SELECT max(total),min(total), avg(total),sum(total),count(*)
    INTO max_pago, min_pago, promedio_pago, suma_total, total_pagos
    FROM pago
    WHERE forma_pago = forma_pago_introducida) into @pagoMax;
END $$
DELIMITER ;

CALL comprobar_forma_pago("PayPal", @max,@min,@media,@suma,@cuenta);
SELECT @max,@min,@media,@suma,@cuenta;

/* 4. Crea una base de datos llamada procedimientos que contenga una tabla llamada cuadrados. La tabla cuadrados debe tener dos columnas de tipo INT UNSIGNED,
 una columna llamada número y otra columna llamada cuadrado.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_cuadrados con las siguientes características.
 El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y 
 calculará el valor de los cuadrados de los primeros números naturales hasta el valor introducido como parámetro. El valor del números
 y de sus cuadrados deberán ser almacenados en la tabla cuadrados que hemos creado previamente.
 Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de la tabla antes de insertar los nuevos valores de los cuadrados que va a calcular.
Utilice un bucle WHILE para resolver el procedimiento.*/
CREATE DATABASE ejerciciosProcedimientos;
USE ejerciciosProcedimientos;

CREATE TABLE if not EXISTS cuadrado
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados (IN tope INT UNSIGNED)
BEGIN
	DECLARE i INT UNSIGNED DEFAULT 1;
	DECLARE cuadrado INT UNSIGNED;
	
    TRUNCATE cuadrados;
    
	WHILE i <= tope DO
		SET cuadrado = i*i;
		INSERT INTO cuadrados (numero, cuadrado) VALUES (i, cuadrado);
		SET i = i+i;
	END WHILE;
END $$
DELIMITER ;

-- 5. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
CREATE TABLE if not EXISTS cuadrado
DELIMITER $$
CREATE PROCEDURE calcular_cuadrados (IN tope INT UNSIGNED)
BEGIN
	DECLARE i INT UNSIGNED DEFAULT 1;
	DECLARE cuadrado INT UNSIGNED;
	
    TRUNCATE cuadrados;
    
	WHILE i <= tope DO
		SET cuadrado = i*i;
		INSERT INTO cuadrados (numero, cuadrado) VALUES (i, cuadrado);
		SET i = i+i;
	END WHILE;
END $$
DELIMITER ;

-- 6. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.


/*7. Crea una base de datos llamada procedimientos que contenga una tabla llamada ejercicio. La tabla debe tener una única columna llamada número 
y el tipo de dato de esta columna debe ser INT UNSIGNED.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado calcular_números con las siguientes características. 
El procedimiento recibe un parámetro de entrada llamado valor_inicial de tipo INT UNSIGNED y deberá almacenar en la tabla ejercicio toda la secuencia de números
 desde el valor inicial pasado como entrada hasta el 1.*/
 CREATE TABLE ejercicios (
    numero INT UNSIGNED
);

DROP PROCEDURE IF EXISTS calcular_numeros;
delimiter $$
CREATE PROCEDURE calcular_numeros(valor_inicial INT UNSIGNED)
BEGIN
	DECLARE contador INT DEFAULT valor_inicial;
	DELETE FROM ejercicios;
	WHILE (contador >= 1) DO
		INSERT INTO  ejercicios VALUES (contador);
		SET contador = contador - 1;
	END WHILE;
END
$$
delimiter ; 

CALL calcular_numeros(15);
SELECT * FROM ejercicios;

-- 8. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
DELIMITER $$
CREATE PROCEDURE calcular_numeros_repeat (IN valor_inicial INT UNSIGNED)
BEGIN
	DECLARE i INT UNSIGNED;
    
    TRUNCATE TABLE ejercicio;
    
    SET i = valor_inicial;
    REPEAT
		INSERT INTO ejercicio
        set i = i -1;
END $$
-- 9. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
drop procedure if exists calcularNumerosLoop;
delimiter $$
create procedure calcularNumerosLoop(valor_inicial int unsigned)
begin
declare contador int default valor_inicial;
truncate ejercicios;
inicio_Loop:loop
IF (contador < 1) THEN
			LEAVE inicio_Loop;
		END IF;
		INSERT INTO  ejercicios VALUES (contador);
		SET contador = contador - 1;
	END LOOP;
end
$$
DELIMITER ;

CALL calcularNumerosLoop(5);

/*10. Crea una base de datos llamada procedimientos que contenga una tabla llamada pares y otra tabla llamada impares. Las dos tablas deben tener única columna llamada número 
y el tipo de dato de esta columna debe ser INT UNSIGNED.
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado calcular_pares_impares con las siguientes características.
 El procedimiento recibe un parámetro de entrada llamado tope de tipo INT UNSIGNED y deberá almacenar en la tabla pares aquellos números 
 pares que existan entre el número 1 el valor introducido como parámetro. Habrá que realizar la misma operación para almacenar los números impares en la tabla impares.
Tenga en cuenta que el procedimiento deberá eliminar el contenido actual de las tablas antes de insertar los nuevos valores.
Utilice un bucle WHILE para resolver el procedimiento.*/
CREATE TABLE pares (
    numero INT UNSIGNED
);

CREATE TABLE impares (
    numero INT UNSIGNED
);
drop table pares,impares;
DELIMITER $$
DROP procedure if exists calcular_pares_impares_WHILE$$
create procedure calcular_pares_impares_WHILE(tope INT UNSIGNED)
begin
	DECLARE i int default 1 ;
   
	Truncate  pares;
    truncate impares;
    
	while (i <= tope) DO
    
    if i%2=0 then
		INSERT INTO  pares VALUES (i);
        else
        INSERT INTO  impares VALUES (i);
        end if;
		SET i = i+1;
	end while;
end$$
DELIMITER ;

call calcular_pares_impares_WHILE(10);


-- 11. Utilice un bucle REPEAT para resolver el procedimiento del ejercicio anterior.
delimiter $$
drop procedure if exists calcular_pares_impares_repeat$$
create procedure calcular_pares_impares_repeat(tope INT UNSIGNED)
begin
	DECLARE i int default 1 ;
   
	Truncate  pares;
    truncate impares;
    
	REPEAT
		IF(i%2 = 0) THEN
			INSERT INTO  pares VALUES (i);
		ELSE
			INSERT INTO  impares VALUES (i);
		END IF;
		SET i = i + 1;
	UNTIL (i > tope)
	END REPEAT;
end$$
DELIMITER ;

call calcular_pares_impares_repeat(100);


-- 12. Utilice un bucle LOOP para resolver el procedimiento del ejercicio anterior.
delimiter $$
drop procedure if exists calcular_pares_impares_loop$$
create procedure calcular_pares_impares_loop(in tope INT UNSIGNED)
begin
	DECLARE i int default 1 ;
   
	Truncate  pares;
    truncate impares;
    
	ins_loop: LOOP
		IF(i > tope) THEN
			LEAVE ins_loop;
		END IF;
		IF(i%2 = 0) THEN
			INSERT INTO  pares VALUES (i);
		ELSE
			INSERT INTO  impares VALUES (i);
		END IF;
		SET i = i + 1;
	END LOOP;
end$$
DELIMITER ;

call calcular_pares_impares_loop(50);



/*1. Escribe una función que reciba un número entero de entrada y devuelva TRUE si el número
es par o FALSE en caso contrario.*/
delimiter $$
drop FUNCTION if exists calcular_pares_impares$$
create FUNCTION calcular_pares_impares(tope INT UNSIGNED)
returns boolean 
begin

	if tope%2=0 then
    return true;
    else RETURN false;
    end if;
	
end$$
DELIMITER ;

select calcular_pares_impares(3);

-- cambiar sql function
set global log_bin_trust_function_creators = 1


/*2. Escribe una función que devuelva el valor de la hipotenusa de un triángulo a partir de los
valores de sus lados.	*/
delimiter $$
drop FUNCTION IF EXISTS hipotenusa $$
CREATE FUNCTION hipotenusa(hipotenusa1 INT UNSIGNED, hipotenusa2 INT UNSIGNED)
RETURNS DOUBLE 
BEGIN

	RETURN sqrt((hipotenusa1*hipotenusa1) + (hipotenusa2*hipotenusa2));    
	
END$$
DELIMITER ;

SELECT hipotenusa(3,6);


/*3. Escribe una función que reciba como parámetro de entrada un valor numérico que
represente un día de la semana y que devuelva una cadena de caracteres con el nombre del
día de la semana correspondiente.
Por ejemplo, para el valor de entrada 1 debería devolver la cadena lunes.*/
DROP FUNCTION IF EXISTS diaDeLaSemana $$ 
delimiter $$
CREATE FUNCTION diaDeLaSemana (dia_numero INT UNSIGNED)
RETURNS VARCHAR (20)
BEGIN
	/*DECLARE dia_semana VARCHAR(20) DEFAULT "Valor";
    

    IF dia_numero < 1 && dia_numero > 7 THEN
		set dia_semana = "Valor incorrecto";
    ELSEIF dia_numero = 1 THEN
		set dia_semana = "Lunes";
    ELSEIF dia_numero = 2 THEN
		set dia_semana = "Martes";
	ELSEIF dia_numero = 3 THEN
		set dia_semana = "Miércoles";
	ELSEIF dia_numero = 4 THEN
		set dia_semana = "Jueves";
	ELSEIF dia_numero = 5 THEN
		set dia_semana = "Viernes";
	ELSEIF dia_numero = 6 THEN
		set dia_semana = "Sábado";
	ELSEIF dia_numero = 7 THEN
		set dia_semana = "Domingo";
	END IF;
    
	RETURN dia_semana;
    */
    
    -- hacer con CASE
    CASE dia_semana
		WHEN 1 THEN RETURN 'lunes';
        WHEN 2 THEN RETURN 'martes';
        WHEN 3 THEN RETURN 'miercoles';
        WHEN 4 THEN RETURN 'jueves';
        WHEN 5 THEN RETURN 'viernes';
        WHEN 6 THEN RETURN 'sábado';
        WHEN 7 THEN RETURN 'domingo';
        else RETURN 'valor incorrecto';
	END CASE;
    
END$$
DELIMITER ;

SELECT dia_numero(5);


/*4. Escribe una función que reciba tres números reales como parámetros de entrada y
devuelva el mayor de los tres.*/
DELIMITER $$
CREATE FUNCTION mayor_de_tres(a FLOAT, b FLOAT, c FLOAT)
RETURNS FLOAT
BEGIN
	DECLARE mayor FLOAT;
    SET mayor = a;
    IF b > mayor THEN
		SET mayor = b;
	END IF;
    IF c > mayor THEN
		SET mayor = c;
	END IF;
    RETURN mayor;
END $$
DELIMITER ;



/*5. Escribe una función que devuelva el valor del área de un círculo a partir del valor del radio
que se recibirá como parámetro de entrada.
Triggers, procedimientos y funciones en
MySQL1.8.3 Funciones sin sentencias SQL*/
DELIMITER $$
CREATE FUNCTION area_circulo(radio FLOAT)
RETURNS FLOAT
BEGIN
	DECLARE area FLOAT;
		SET area = PI() * POW(radio, 2);
        RETURN area;
END$$
DELIMITER ;
    

/*6. Escribe una función que devuelva como salida el número de años que han transcurrido
entre dos fechas que se reciben como parámetros de entrada. Por ejemplo, si pasamos como
parámetros de entrada las fechas 2018-01-01 y 2008-01-01 la función tiene que devolver que
han pasado 10 años.
Para realizar esta función puede hacer uso de las siguientes funciones que nos proporciona
MySQL:
• DATEDIFF
• TRUNCATE	*/
DELIMITER $$
CREATE FUNCTION calcular_diferencia_anios(fecha_inicio DATE, fecha_fin DATE)
RETURNS INT
BEGIN
	DECLARE diferencia INT;
    
    SET diferencia = 


/*7. Escribe una función que reciba una cadena de entrada y devuelva la misma cadena pero
sin acentos. La función tendrá que reemplazar todas las vocales que tengan acento por la
misma vocal pero sin acento.
Por ejemplo, si la función recibe como parámetro de entrada la cadena María la función debe
devolver la cadena Maria.	*/
DELIMITER $$
DROP FUNCTION IF EXISTS sin_acentos $$
CREATE FUNCTION sin_acentos(cadena VARCHAR(50))
RETURNS VARCHAR(50)
BEGIN
	DECLARE texto VARCHAR(50);
    SET texto = cadena;
    SET texto = replace(texto, 'á', 'a');
	SET texto = replace(texto, 'é', 'e');
	SET texto = replace(texto, 'í', 'i');
	SET texto = replace(texto, 'ó', 'o');
	SET texto = replace(texto, 'ú', 'u');
    -- MAYUSCULAS
    SET texto = replace(texto, 'Á', 'A');
	SET texto = replace(texto, 'É', 'E');
	SET texto = replace(texto, 'Í', 'I');
	SET texto = replace(texto, 'Ó', 'O');
	SET texto = replace(texto, 'Ú', 'U');
    
	RETURN texto;
    
    -- profe
    SET cadena = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cadena,'á','a'),'é','e'),'í','i'),'ó','o'),'ú','u');
    SET cadena = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(cadena,'Á','A'),'É','E'),'Í','I'),'Ó','O'),'Ú','U');
   
end$$
DELIMITER ;

select sin_acentos("ÁéÍóÚ");


-- 1.8.4 Funciones con sentencias SQL
use tienda;
-- 1. Escribe una función para la base de datos tienda que devuelva el número total de productos que hay en la tabla productos.
DELIMITER $$
CREATE FUNCTION total_productos()
RETURNS INT
BEGIN
	DECLARE total INT;
    SET total = (SELECT COUNT(*) FROM producto);
     -- otra forma de hacerlo
    /*
    SELECT COUNT(*) INTO total from producto;
    */
    RETURN total ;
END $$
DELIMITER ;

SELECT total_productos();


/*2. Escribe una función para la base de datos tienda que devuelva el valor medio del precio de los productos de un determinado fabricante
 que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.*/
 DELIMITER $$
CREATE FUNCTION valor_medio(fabricanteIntro VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE media INT;
    SET media = (SELECT AVG(precio) FROM producto, fabricante where producto.codigo_fabricante = fabricante.codigo 
    and fabricante.nombre = fabricanteIntro);
   
    RETURN media ;
END $$
DELIMITER ;

SELECT valor_medio("Asus");
 
 
/*3. Escribe una función para la base de datos tienda que devuelva el valor máximo del precio de los productos de un determinado fabricante
 que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.	*/
 DELIMITER $$
CREATE FUNCTION valor_maximo(fabricanteIntro VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE maximo INT;
    SET maximo = (SELECT MAX(precio) FROM producto, fabricante where producto.codigo_fabricante = fabricante.codigo 
    and fabricante.nombre = fabricanteIntro);
   
    RETURN maximo ;
END $$
DELIMITER ;

SELECT valor_maximo("Asus");
 
 
/*4. Escribe una función para la base de datos tienda que devuelva el valor mínimo del precio de los productos de un determinado fabricante
 que se recibirá como parámetro de entrada. El parámetro de entrada será el nombre del fabricante.	*/
 DELIMITER $$
CREATE FUNCTION valor_minimo(fabricanteIntro VARCHAR(50))
RETURNS INT
BEGIN
	DECLARE minimo INT;
    SET minimo = (SELECT MIN(precio) FROM producto, fabricante where producto.codigo_fabricante = fabricante.codigo 
    and fabricante.nombre = fabricanteIntro);
   
    RETURN minimo ;
END $$
DELIMITER ;

SELECT valor_minimo("Asus");


/*1.8.5 Manejo de errores en MySQL
1. Crea una base de datos llamada test que contenga una tabla llamada alumno. La tabla debe tener cuatro columnas:
• id: entero sin signo (clave primaria).
• nombre: cadena de 50 caracteres.
• apellido1: cadena de 50 caracteres.
• apellido2: cadena de 50 caracteres.
Una vez creada la base de datos y la tabla deberá crear un procedimiento llamado insertar_alumno con las siguientes características.
 El procedimiento recibe cuatro parámetros de entrada (id, nombre, apellido1, apellido2) y los insertará en la tabla alumno. 
 El procedimiento devolverá como salida un parámetro llamado error que tendrá un valor igual a 0 si la operación se ha podido 
 realizar con éxito y un valor igual a 1 en caso contrario.
Deberá manejar los errores que puedan ocurrir cuando se intenta insertar una fila que contiene una clave primaria repetida.	*/
CREATE DATABASE test;
USE test;

CREATE TABLE alumno (
    id INT UNSIGNED,
    nombre VARCHAR(50),
    apellido1 VARCHAR(50),
    apellido2 VARCHAR(50)
);

DELIMITER $$
CREATE PROCEDURE insertar_alumno (IN idIntro INT UNSIGNED, IN nombreIntro VARCHAR(50), IN apellido1Intro VARCHAR(50), IN apellido2Intro VARCHAR(50), OUT p_error INT)
BEGIN
	DECLARE duplicate_key CONDITION FOR SQLSTATE '23000';
    DECLARE EXIT HANDLER FOR duplicate_key
    BEGIN
		SET p_error = 1;
	END ;
    SET p_error = 0;
    INSERT INTO alumno (id, nombre, apellido1, apellido2) VALUES (idIntro, nombreIntro, apellido1Intro, apellido2Intro);
END $$
DELIMITER ;

CALL insertar_alumno(2,'Alfredo', 'Diaz','Gomez');

/*1.8.6 Transacciones con procedimientos almacenados
1. Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
Tabla cuentas:
• id_cuenta: entero sin signo (clave primaria).
• saldo: real sin signo.
Tabla entradas:
• id_butaca: entero sin signo (clave primaria).
• nif: cadena de 9 caracteres.
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada con las siguientes características.
 El procedimiento recibe 3 parámetros de entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error 
 que tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.	
 1. Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
Tabla cuentas:
• id_cuenta: entero sin signo (clave primaria).
• saldo: real sin signo.
Tabla entradas:
• id_butaca: entero sin signo (clave primaria).
• nif: cadena de 9 caracteres.
Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado comprar_entrada con las siguientes características.
 El procedimiento recibe 3 parámetros de entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que 
 tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual a 1 en caso contrario.
 El procedimiento de compra realiza los siguientes pasos:
• Inicia una transacción.
• Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta adecuado.
• Inserta una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el usuario (nif).
• Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún error entonces aplica un COMMIT a la transacción 
y si ha ocurrido algún error aplica un ROLLBACK.
Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.
• ERROR 1264 (Out of range value)
• ERROR 1062 (Duplicate entry for PRIMARY KEY)*/
 CREATE DATABASE cine;
USE cine;

CREATE TABLE Cuentas (
    id_cuenta INT UNSIGNED,
    nombre VARCHAR(50) ,
    primary key (id_cuenta)
);
CREATE TABLE Entradas (
    id_butaca INT UNSIGNED ,
    nif VARCHAR(9),
    PRIMARY KEY (id_butaca)
);

DELIMITER $$
CREATE PROCEDURE comprar_entrada(
    IN p_nif CHAR(9),
    IN p_id_cuenta INT UNSIGNED,
    IN p_id_butaca INT UNSIGNED,
    OUT p_error INT
)
BEGIN
	-- DECLARE
	
END $$
 
 
 /*2. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número de cuenta que no existe en la tabla cuentas?
 ¿Ocurre algún error o podemos comprar la entrada?
En caso de que exista algún error, ¿cómo podríamos resolverlo?.	*/




/*1.8.7 Cursores
1. Escribe las sentencias SQL necesarias para crear una base de datos llamada test, una tabla llamada alumnos y
 4 sentencias de inserción para inicializar la tabla. La tabla alumnos está formada por las siguientes columnas:
• id (entero sin signo y clave primaria)
• nombre (cadena de caracteres)
• apellido1 (cadena de caracteres)
• apellido2 (cadena de caracteres
• fecha_nacimiento (fecha)
Una vez creada la tabla se decide añadir una nueva columna a la tabla llamada edad que será un valor calculado a partir 
de la columna fecha_nacimiento. Escriba la sentencia SQL necesaria para modificar la tabla y añadir la nueva columna.
Escriba una función llamada calcular_edad que reciba una fecha y devuelva el número de años que han pasado desde la fecha actual hasta la fecha pasada como parámetro:
• Función: calcular_edad
• Entrada: Fecha
• Salida: Número de años (entero)
Ahora escriba un procedimiento que permita calcular la edad de todos los alumnos que ya existen en la tabla.
Para esto será necesario crear un procedimiento llamado actualizar_columna_edad que calcule la edad de cada alumno y actualice la tabla.
 Este procedimiento hará uso de la función calcular_edad que hemos creado en el paso anterior.*/
DROP DATABASE test ;
CREATE DATABASE test ;
USE test ;

CREATE TABLE alumnos(
 id INT UNSIGNED ,
 nombre VARCHAR (50),
 apellido1 VARCHAR (50),
 apellido2 VARCHAR (50),
 fecha_nacimiento DATE,
PRIMARY KEY (id)
);

INSERT INTO alumnos VALUES (1, 'Pablo', 'Magro', 'Sanchez', '1996-01-10');
INSERT INTO alumnos VALUES (2, 'Brayan', 'Ochoa', 'Botero', '2002-02-10');
ALTER TABLE alumnos ADD edad INT;
ALTER TABLE alumnos DROP edad;

DELIMITER $$
CREATE FUNCTION calcular_edad (fechaNac DATE)
RETURNS INT
BEGIN
	RETURN TRUNCATE(DATEDIFF(CURRENT_DATE(),fechaNac)/365,25);
END $$
DELIMITER ;

SELECT calcular_edad('2000-01-01');

CREATE PROCEDURE actualizar_columna_edad()

/*noel*/
DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_columna_edad $$
CREATE PROCEDURE actualizar_alumnos_edad()
BEGIN
  DECLARE done INT DEFAULT FALSE;
  DECLARE i_fecha DATE;
  DECLARE aux_id INT;
  DECLARE cur1 CURSOR FOR SELECT id, fecha_nacimiento FROM alumnos;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP
    FETCH cur1 INTO aux_id, i_fecha;
    /*el fetch va leyendo uno a uno el puntero */
    IF done THEN
      LEAVE read_loop;
    END IF;
   	UPDATE alumnos SET edad = calcular_edad(i_fecha)
   	WHERE aux_id = id;
  END LOOP;
  CLOSE cur1;
END$$
delimiter ;

CALL actualizar_alumnos_edad();
/*noel*/

/*2. Modifica la tabla alumnos del ejercicio anterior para añadir una nueva columna email. Una vez que hemos modificado la tabla necesitamos 
asignarle una dirección de correo electrónico de forma automática.
Escriba un procedimiento llamado crear_email que dados los parámetros de entrada: nombre, apellido1, apellido2 y dominio, 
cree una dirección de email y la devuelva como salida.
• Procedimiento: crear_email
• Entrada:
– nombre (cadena de caracteres)
– apellido1 (cadena de caracteres)
– apellido2 (cadena de caracteres)
– dominio (cadena de caracteres)
Salida:
– email (cadena de caracteres)
devuelva una dirección de correo electrónico con el siguiente formato:
• El primer carácter del parámetro nombre.
• Los tres primeros caracteres del parámetro apellido1.
• Los tres primeros caracteres del parámetro apellido2.
• El carácter @.
• El dominio pasado como parámetro.
Ahora escriba un procedimiento que permita crear un email para todos los alumnos que ya existen en la tabla.
Para esto será necesario crear un procedimiento llamado actualizar_columna_email que actualice la columna email de la tabla alumnos. 
Este procedimiento hará uso del procedimiento crear_email que hemos creado en el paso anterior.	*/
DELIMITER $$
/*INCOMPLETO*/
CREATE PROCEDURE crearEmail(
IN nombre VARCHAR(50),
IN apellido1 VARCHAR(50),
IN apellido2 VARCHAR(50),
IN dominio VARCHAR(50),
OUT P_email VARCHAR(50)
)
BEGIN
	SELECT concat('NOMBRE','APELLIDO1','APELLIDO2') ;
END $$
DELIMITER ;

ALTER TABLE alumnos ADD email VARCHAR(100);

DELIMITER $$
CREATE PROCEDURE crear_email()
BEGIN
	DECLARE done INT DEFAULT FALSE;
	DECLARE i_fecha DATE;
	DECLARE aux_id INT;
    DECLARE aux_nombre INT;
    DECLARE aux_apellido1 INT;
    DECLARE aux_apellido2 INT;
	DECLARE cur1 CURSOR FOR SELECT concat(aux_nombre,aux_apellido1,aux_apellido2) FROM alumnos;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

	OPEN cur1;

	read_loop: LOOP
    FETCH cur1 INTO aux_id, aux_nombre, aux_apellido1, aux_apellido2;
		IF done THEN
			LEAVE read_loop;
		END IF;
   	UPDATE alumnos SET email = crearEmail(aux_nombre,aux_apellido1,aux_apellido2,)
		WHERE aux_id = id;
	END LOOP;
	CLOSE cur1;
	
END $$
DELIMITER ;


/*3. Escribe un procedimiento llamado crear_lista_emails_alumnos que devuelva la lista de emails de la tabla alumnos separados por un punto y coma.
 Ejemplo: juan@ccc.org; maria@ccc.org; pepe@ccc.org; lucia@ccc.org .	*/
 
 delimiter $$
DROP PROCEDURE IF EXISTS crear_lista_emails_alumnos $$
CREATE PROCEDURE crear_lista_emails_alumnos()
BEGIN
	DECLARE done INT DEFAULT FALSE;
  	DECLARE aux_email VARCHAR(50);
  	DECLARE lista VARCHAR(1000) DEFAULT "";
	DECLARE cur1 CURSOR FOR SELECT email FROM alumnos;	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
  	OPEN cur1;

  	read_loop: LOOP
	    FETCH cur1 INTO aux_email; 
	    IF done THEN
	      LEAVE read_loop;
	    END IF;
	   	SET lista = CONCAT(lista, aux_email, ";");
	END LOOP;
	/* para quitar el ; del final*/
	SET lista = SUBSTRING(lista, 1, LENGTH(lista)-1); 
  	CLOSE cur1;
  	SELECT lista;
END;

CALL crear_lista_emails_alumnos();
 
 