-- Cambiar el delimitador para definir el procedimiento
DELIMITER $$

-- Creación del procedimiento almacenado
CREATE PROCEDURE comprar_entrada(
    -- Parámetro de entrada: NIF del usuario
    IN p_nif CHAR(9),
    -- Parámetro de entrada: ID de la cuenta
    IN p_id_cuenta INT UNSIGNED,
    -- Parámetro de entrada: ID de la butaca
    IN p_id_butaca INT UNSIGNED,
    -- Parámetro de salida: indicador de error
    OUT p_error INT
)
BEGIN
    -- Definición del manejador de excepciones
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Obtener información del diagnóstico de la excepción
        GET DIAGNOSTICS CONDITION 1
        @p1 = RETURNED_SQLSTATE, 
        @p2 = MYSQL_ERRNO, 
        @p3 = MESSAGE_TEXT;
        -- Hacer un ROLLBACK en caso de error
        ROLLBACK;
        -- Asignar el código de error correspondiente
        IF @p2 = 1264 THEN
            -- Error de valor fuera de rango
            SET p_error = 2;
        ELSEIF @p2 = 1062 THEN
            -- Error de entrada duplicada para clave primaria
            SET p_error = 1;
        ELSE
            -- Otro error
            SET p_error = -1;
        END IF;
    END;

    -- Iniciar una transacción
    START TRANSACTION;
    
    -- Actualizar el saldo de la cuenta restando 5 euros
    UPDATE cuentas 
    SET saldo = saldo - 5 
    WHERE id_cuenta = p_id_cuenta;
    
    -- Insertar una nueva fila en la tabla entradas con el ID de la butaca y el NIF del usuario
    INSERT INTO entradas (id_butaca, nif) 
    VALUES (p_id_butaca, p_nif);
    
    -- Confirmar la transacción si no hay errores
    COMMIT;
    
    -- Si todo se ejecuta correctamente, establecer el valor de p_error en 0
    SET p_error = 0;
END $$

-- Restaurar el delimitador
DELIMITER ;
