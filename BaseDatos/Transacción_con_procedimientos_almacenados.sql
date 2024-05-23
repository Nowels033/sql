/* 1. Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
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


    DECLARE continue_handler INT DEFAULT 0;
    DECLARE exit handler for sqlexception
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 @sqlstate = RETURNED_SQLSTATE, @errno = MYSQL_ERRNO, @text = MESSAGE_TEXT;
        IF @errno = 1264 THEN
            SET p_error = 2;
        ELSEIF @errno = 1062 THEN
            SET p_error = 1;
        END IF;
    END;

    START TRANSACTION;
    
    UPDATE cuentas SET saldo = saldo - 5 WHERE id_cuenta = p_id_cuenta;
    INSERT INTO entradas (id_butaca, nif) VALUES (p_id_butaca, p_nif);
    COMMIT;
	
    SET p_error = 0;
END &&

DELIMITER ;
 
 CALL comprar_entrada('12345678a',1,2,@@error);
 SELECT p_error;
 
 
 /*2. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un número de cuenta que no existe en la tabla cuentas?
 ¿Ocurre algún error o podemos comprar la entrada?
En caso de que exista algún error, ¿cómo podríamos resolverlo?*/

----------------------
-- 1)
-- Creación de la base de datos
CREATE DATABASE cine;
USE cine;

-- Creación de la tabla cuentas
CREATE TABLE cuentas (
    id_cuenta INT UNSIGNED PRIMARY KEY,
    saldo DECIMAL(10, 2) UNSIGNED
);

-- Creación de la tabla entradas
CREATE TABLE entradas (
    id_butaca INT UNSIGNED PRIMARY KEY,
    nif CHAR(9)
);
DELIMITER $$

CREATE PROCEDURE comprar_entrada(
    IN p_nif CHAR(9),
    IN p_id_cuenta INT UNSIGNED,
    IN p_id_butaca INT UNSIGNED,
    OUT p_error INT
)
BEGIN
    -- Manejador de excepciones
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
        @p1 = RETURNED_SQLSTATE, 
        @p2 = MYSQL_ERRNO, 
        @p3 = MESSAGE_TEXT;
        -- Rollback en caso de error
        ROLLBACK;
        -- Asignar el código de error correspondiente
        IF @p2 = 1264 THEN
            SET p_error = 2;
        ELSEIF @p2 = 1062 THEN
            SET p_error = 1;
        ELSE
            SET p_error = -1; -- Otro error
        END IF;
    END;

    -- Iniciar transacción
    START TRANSACTION;
    
    -- Actualizar saldo de la cuenta
    UPDATE cuentas 
    SET saldo = saldo - 5 
    WHERE id_cuenta = p_id_cuenta;
    
    -- Insertar nueva entrada
    INSERT INTO entradas (id_butaca, nif) 
    VALUES (p_id_butaca, p_nif);
    
    -- Confirmar transacción
    COMMIT;
    
    -- Si todo va bien, error es 0
    SET p_error = 0;
END $$
DELIMITER ;

-- Llamada al procedimiento
CALL comprar_entrada('12345678A', 1, 2, @error);
-- Seleccionar el valor del error para verificar el resultado
SELECT @error;

