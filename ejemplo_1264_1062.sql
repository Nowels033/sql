1. Crea una base de datos llamada cine que contenga dos tablas con las
siguientes columnas.
Tabla cuentas:
• id_cuenta: entero sin signo (clave primaria).
• saldo: real sin signo.
Tabla entradas:
• id_butaca: entero sin signo (clave primaria).
• nif: cadena de 9 caracteres.
DROP DATABASE IF EXISTS cine;
CREATE DATABASE cine;
USE cine;
CREATE TABLE cuentas (
id_cuenta INT UNSIGNED,
saldo REAL UNSIGNED,
PRIMARY KEY(id_cuenta)
);
CREATE TABLE entradas (
id_butaca INT UNSIGNED,
nif VARCHAR(9),
PRIMARY KEY(id_butaca)
);
Una vez creada la base de datos y las tablas deberá crear un procedimiento
llamado
comprar_entrada con las siguientes características. El procedimiento
recibe 3 parámetros de
entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro
llamado error que
tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar
con éxito y un valor igual
a 1 en caso contrario.
El procedimiento de compra realiza los siguientes pasos:
• Inicia una transacción.
• Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la
cuenta con el id_cuenta
adecuado.
• Inserta una fila en la tabla entradas indicando la butaca (id_butaca)
que acaba de comprar el
usuario (nif).
• Comprueba si ha ocurrido algún error en las operaciones anteriores. Si
no ocurre ningún
error entonces aplica un COMMIT a la transacción y si ha ocurrido algún
error aplica un
ROLLBACK.

----------------------
Deberá manejar los siguientes errores que puedan ocurrir durante el
proceso.
• ERROR 1264 (Out of range value)
• ERROR 1062 (Duplicate entry for PRIMARY KEY)
delimiter $$
drop procedure if exists comprar_entrada $$
create procedure comprar_entrada(nif VARCHAR(9),idCuenta INT
UNSIGNED,idButaca INT UNSIGNED,out errorProcedimiento int)
BEGIN
DECLARE EXIT HANDLER FOR SQLSTATE '23000' -- '1062'
BEGIN
SET errorProcedimiento = 1;
ROLLBACK;
END ;
DECLARE EXIT HANDLER FOR SQLSTATE '22003'-- '1264'
BEGIN
SET errorProcedimiento = 1;
ROLLBACK;
END;
START TRANSACTION;
SET errorProcedimiento = 0;
UPDATE cuentas SET cuentas.saldo = cuentas.saldo - 5
WHERE cuentas.id_cuenta = idCuenta;
INSERT INTO entradas VALUES (idButaca, nif);
COMMIT;
END $$
delimiter ;
INSERT INTO cuentas VALUES (1,200);
INSERT INTO cuentas VALUES (2,6);
-- llamada
call comprar_entrada('12345678Q', 1, 2,@errorProc);
select @errorProc;
call comprar_entrada('12345678P', 2, 3,@errorProc);
select @errorProc;
2. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como
parámetro un
número de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o
podemos comprar la
entrada?
call comprar_entrada('12345678K', 3, 5,@errorProc);
select @errorProc;
-- No , no ocurre ningun error.
-- Se crea en la tabla entradas una fila para :
comprar_entrada('12345678K', 3, 5,@errorProc);
delimiter $$
drop procedure if exists comprar_entrada $$
create procedure comprar_entrada(nif VARCHAR(9), idCuenta INT UNSIGNED,
idButaca INT UNSIGNED, out errorProcedimiento int)
BEGIN
DECLARE cuenta_existente INT DEFAULT 0;
-- select para verificar si la cuenta existe y si tiene saldo
select COUNT(*) into cuenta_existente from cuentas where
cuentas.id_cuenta = idCuenta and cuentas.saldo >= 5;
-- Si la cuenta existe, proceder con el procedimiento
IF cuenta_existente = 1 then
BEGIN
DECLARE EXIT HANDLER FOR SQLSTATE '23000' -- '1062'
BEGIN
SET errorProcedimiento = 1;
ROLLBACK;
END;
DECLARE EXIT HANDLER FOR SQLSTATE '22003'-- '1264'
BEGIN
SET errorProcedimiento = 1;
ROLLBACK;
END;
START TRANSACTION;
SET errorProcedimiento = 0;
UPDATE cuentas SET saldo = saldo - 5
WHERE cuentas.id_cuenta = idCuenta;
INSERT INTO entradas VALUES (idButaca,
nif);
COMMIT;
END;
ELSE
-- si la cuenta no existe o hay mas de una : error 1
SET errorProcedimiento = 1;
END IF;
END $$
delimiter ;
call comprar_entrada('12345678Y', 2, 11,@errorProc);
SELECT @errorProc;


-----------------------------------------------------------


DELIMITER $$

CREATE FUNCTION CalcularTotalesClientes() 
RETURNS TEXT
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE cliente_id INT;
    DECLARE cliente_nombre VARCHAR(255);
    DECLARE total_pedidos DECIMAL(10, 2);
    DECLARE resultado TEXT DEFAULT '';

    -- Declarar el cursor para recorrer la tabla clientes
    DECLARE cliente_cursor CURSOR FOR 
    SELECT id, nombre FROM clientes;

    -- Handlers para errores específicos
    DECLARE CONTINUE HANDLER FOR 1264 
    BEGIN
        SET resultado = CONCAT(resultado, 'Error 1264: Valor fuera de rango detectado.\n');
    END;

    DECLARE CONTINUE HANDLER FOR 1062 
    BEGIN
        SET resultado = CONCAT(resultado, 'Error 1062: Entrada duplicada detectada.\n');
    END;

    -- Declarar un handler para el final del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Abrir el cursor
    OPEN cliente_cursor;

    -- Bucle para recorrer los registros del cursor
    leer_clientes: LOOP
        -- Obtener el siguiente registro del cursor
        FETCH cliente_cursor INTO cliente_id, cliente_nombre;
        
        -- Si no hay más registros, salir del bucle
        IF done THEN
            LEAVE leer_clientes;
        END IF;
        
        -- Calcular el total de pedidos para el cliente actual
        BEGIN
            DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
            BEGIN
                SET resultado = CONCAT(resultado, 'Error detectado al calcular total de pedidos para el cliente: ', cliente_nombre, '.\n');
            END;

            SELECT SUM(monto) INTO total_pedidos
            FROM pedidos
            WHERE cliente_id = cliente_id;

            -- Si el cliente no tiene pedidos, establecer total_pedidos a 0
            IF total_pedidos IS NULL THEN
                SET total_pedidos = 0;
            END IF;

            -- Concatenar el resultado en la variable 'resultado'
            SET resultado = CONCAT(resultado, 'Cliente: ', cliente_nombre, ' Total de pedidos: ', total_pedidos, '\n');
        END;
    END LOOP leer_clientes;

    -- Cerrar el cursor
    CLOSE cliente_cursor;
    
    -- Devolver el resultado concatenado
    RETURN resultado;
END $$

DELIMITER ;

------------------------
DELIMITER $$
CREATE PROCEDURE transaccion_en_mysql()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
-- ERROR
ROLLBACK;
END;
DECLARE EXIT HANDLER FOR SQLWARNING
BEGIN
-- WARNING
ROLLBACK;
END;
START TRANSACTION;
-- Sentencias SQL
COMMIT;
END
$$

---------------------------------

DELIMITER $$
CREATE PROCEDURE transaccion_en_mysql()
BEGIN
DECLARE EXIT HANDLER FOR SQLEXCEPTION, SQLWARNING
BEGIN
-- ERROR, WARNING
ROLLBACK;
END;
START TRANSACTION;
-- Sentencias SQL
COMMIT;
END
$$

------------------------

-- Paso 1
DROP DATABASE IF EXISTS test;
CREATE DATABASE test;
USE test;
-- Paso 2
CREATE TABLE test.t (s1 INT, PRIMARY KEY (s1));
-- Paso 3
DELIMITER $$
CREATE PROCEDURE handlerdemo ()
BEGIN
DECLARE CONTINUE HANDLER FOR SQLSTATE '23000' SET @x = 1;
SET @x = 1;
INSERT INTO test.t VALUES (1);
SET @x = 2;
INSERT INTO test.t VALUES (1);
SET @x = 3;
END
$$
DELIMITER ;
CALL handlerdemo();
SELECT @x;
-----------------------

DELIMITER $$
CREATE PROCEDURE transaccion_en_mysql()
BEGIN
	DECLARE EXIT HANDLER FOR SQLEXCEPTION
	BEGIN
		-- ERROR
		ROLLBACK;
	END;
	DECLARE EXIT HANDLER FOR SQLWARNING
	BEGIN
		-- WARNING
		ROLLBACK;
	END;
	START TRANSACTION;
		-- Sentencias SQL
	COMMIT;
END
$$
-----------------

DELIMITER $$
DROP PROCEDURE IF EXISTS curdemo$$
CREATE PROCEDURE curdemo()
BEGIN
DECLARE done INT DEFAULT FALSE;
DECLARE a CHAR(16);
DECLARE b, c INT;
DECLARE cur1 CURSOR FOR SELECT id,data FROM test.t1;
DECLARE cur2 CURSOR FOR SELECT i FROM test.t2;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
OPEN cur1;
OPEN cur2;
WHILE done = FALSE DO
FETCH cur1 INTO b, a;
FETCH cur2 INTO c;
IF done = FALSE THEN
IF b < c THEN
INSERT INTO test.t3 VALUES (a,b);
ELSE
INSERT INTO test.t3 VALUES (a,c);
END IF;
END IF;
END WHILE;
CLOSE cur1;
CLOSE cur2;
END
$$
----------------------

-- Paso 1
DROP DATABASE IF EXISTS test1;
CREATE DATABASE test1;
USE test1;
-- Paso 2
CREATE TABLE alumnos (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido1 VARCHAR(50) NOT NULL,
apellido2 VARCHAR(50),
nota FLOAT
);
-- Paso 3
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_insert$$
CREATE TRIGGER trigger_check_nota_before_insert
BEFORE INSERT
ON alumnos FOR EACH ROW
BEGIN
IF NEW.nota < 0 THEN
set NEW.nota = 0;
ELSEIF NEW.nota > 10 THEN
set NEW.nota = 10;
END IF;
END
$$
DELIMITER ;
DELIMITER $$
DROP TRIGGER IF EXISTS trigger_check_nota_before_update$$
CREATE TRIGGER trigger_check_nota_before_update
BEFORE UPDATE
ON alumnos FOR EACH ROW
BEGIN
IF NEW.nota < 0 THEN
set NEW.nota = 0;
ELSEIF NEW.nota > 10 THEN
set NEW.nota = 10;
END IF;
END
$$
DELIMITER ;
-- Paso 4
INSERT INTO alumnos VALUES (1, 'Pepe', 'López', 'López', -1);
INSERT INTO alumnos VALUES (2, 'María', 'Sánchez', 'Sánchez', 11);
INSERT INTO alumnos VALUES (3, 'Juan', 'Pérez', 'Pérez', 8.5);
-- Paso 5
SELECT * FROM alumnos;
-- Paso 6
UPDATE alumnos SET nota = -4 WHERE id = 1;
UPDATE alumnos SET nota = 14 WHERE id = 2;
UPDATE alumnos SET nota = 9.5 WHERE id = 3;
-- Paso 7
SELECT * FROM alumnos;

--------------------

select curdate();