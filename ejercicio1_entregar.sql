
1. Crea una base de datos llamada cine que contenga dos tablas con las siguientes columnas.
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



Una vez creada la base de datos y las tablas deberá crear un procedimiento llamado
comprar_entrada con las siguientes características. El procedimiento recibe 3 parámetros de
entrada (nif, id_cuenta, id_butaca) y devolverá como salida un parámetro llamado error que
tendrá un valor igual a 0 si la compra de la entrada se ha podido realizar con éxito y un valor igual
a 1 en caso contrario.



El procedimiento de compra realiza los siguientes pasos:
• Inicia una transacción.
• Actualiza la columna saldo de la tabla cuentas cobrando 5 euros a la cuenta con el id_cuenta
adecuado.
• Inserta una fila en la tabla entradas indicando la butaca (id_butaca) que acaba de comprar el
usuario (nif).
• Comprueba si ha ocurrido algún error en las operaciones anteriores. Si no ocurre ningún
error entonces aplica un COMMIT a la transacción y si ha ocurrido algún error aplica un
ROLLBACK.

Deberá manejar los siguientes errores que puedan ocurrir durante el proceso.
• ERROR 1264 (Out of range value)
• ERROR 1062 (Duplicate entry for PRIMARY KEY)


delimiter $$
drop procedure if exists comprar_entrada $$
create procedure comprar_entrada(nif VARCHAR(9),idCuenta INT UNSIGNED,idButaca INT UNSIGNED,out errorProcedimiento int)
BEGIN
	
	DECLARE EXIT HANDLER FOR SQLSTATE '23000' -- '1062'
	BEGIN
    
		SET errorProcedimiento = 1;
		ROLLBACK;
        END ;
	DECLARE EXIT HANDLER FOR SQLSTATE '22003'-- '1264'
	BEGIN
		SET  errorProcedimiento = 1;
		ROLLBACK;
	END;
   
    START TRANSACTION;
   		SET errorProcedimiento = 0;
		UPDATE cuentas SET cuentas.saldo = cuentas.saldo - 5 WHERE cuentas.id_cuenta = idCuenta;
		INSERT INTO entradas VALUES (idButaca, nif);
	COMMIT;
END $$
delimiter ;

INSERT INTO cuentas VALUES (1,50);
INSERT INTO cuentas VALUES (2,5);

-- llamada
call comprar_entrada('12345678Q', 1, 2,@errorProc);
select @errorProc;
call comprar_entrada('12345678P', 2, 3,@errorProc);
select @errorProc;


2. ¿Qué ocurre cuando intentamos comprar una entrada y le pasamos como parámetro un
número de cuenta que no existe en la tabla cuentas? ¿Ocurre algún error o podemos comprar la
entrada?
call comprar_entrada('12345678K', 3, 5,@errorProc);
select @errorProc;

-- No , no ocurre ningun error.
-- Se crea en la tabla entradas una fila para : comprar_entrada('12345678K', 3, 5,@errorProc);



En caso de que exista algún error, ¿cómo podríamos resolverlo?.
-- Para poder solucionar un error , debemos de cambiar el procedimiento a :

delimiter $$
drop procedure if exists comprar_entrada $$
create procedure comprar_entrada(nif VARCHAR(9), idCuenta INT UNSIGNED, idButaca INT UNSIGNED, out errorProcedimiento int)
BEGIN
    
    DECLARE cuenta_existente INT DEFAULT 0;
    
    -- select para verificar si la cuenta existe
    SELECT COUNT(*) INTO cuenta_existente FROM cuentas WHERE cuentas.id_cuenta = idCuenta;
    
    -- Si la cuenta existe, proceder con el procedimiento
    IF cuenta_existente = 1 THEN
        BEGIN
            DECLARE EXIT HANDLER FOR SQLSTATE '23000' -- '1062'
            BEGIN
                SET errorProcedimiento = 1;
                ROLLBACK;
            END;
            
            DECLARE EXIT HANDLER FOR SQLSTATE '22003'-- '1264'
            BEGIN
                SET  errorProcedimiento = 1;
                ROLLBACK;
            END;
            
            START TRANSACTION;
				SET errorProcedimiento = 0;
				UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = idCuenta;
				INSERT INTO entradas VALUES (idButaca, nif);
				COMMIT;
        END;
    ELSE
        -- si la cuenta no existe o hay mas de una : error 1
        SET errorProcedimiento = 1;
    END IF;
END $$
delimiter ;

call comprar_entrada('12345678Y', 4, 11,@errorProc);
select @errorProc;

-- version 2 para ver si tiene dinero en la cuenta:

delimiter $$
drop procedure if exists comprar_entrada $$
create procedure comprar_entrada(nif VARCHAR(9), idCuenta INT UNSIGNED, idButaca INT UNSIGNED, out errorProcedimiento int)
BEGIN
    
    DECLARE cuenta_existente INT DEFAULT 0;
    
    -- select para verificar si la cuenta existe y si tiene saldo 
    select COUNT(*) into cuenta_existente from cuentas where cuentas.id_cuenta = idCuenta and cuentas.saldo >= 5;
    
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
                SET  errorProcedimiento = 1;
                ROLLBACK;
            END;
            
            START TRANSACTION;
				SET errorProcedimiento = 0;
				UPDATE cuentas SET saldo = saldo - 5 WHERE cuentas.id_cuenta = idCuenta;
				INSERT INTO entradas VALUES (idButaca, nif);
				COMMIT;
        END;
    ELSE
        -- si la cuenta no existe o hay mas de una : error 1
        SET errorProcedimiento = 1;
    END IF;
END $$
delimiter ;

call comprar_entrada('12345678Y', 2, 11,@errorProc);
select @errorProc;

