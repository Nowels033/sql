DELIMITER //

CREATE PROCEDURE obtenerEmpleados()
BEGIN
    SELECT * FROM empleados;
END //

DELIMITER ;

CALL obtenerEmpleados();


-- -------------------------------------------------------

DELIMITER //

CREATE PROCEDURE obtenerEmpleadosPorDepartamento(IN departamentoID INT)
BEGIN
    SELECT * FROM empleados WHERE departamento_id = departamentoID;
END //

DELIMITER ;

CALL obtenerEmpleadosPorDepartamento(3);


-- ------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE obtenerNombreEmpleado(IN empleadoID INT, OUT nombreEmpleado VARCHAR(100))
BEGIN
    SELECT nombre INTO nombreEmpleado FROM empleados WHERE id = empleadoID;
END //

DELIMITER ;

CALL obtenerNombreEmpleado(5, @nombre);
SELECT @nombre;


-- ------------------------------------------------------------------- 

DELIMITER //

CREATE PROCEDURE actualizarSalarioEmpleado(IN empleadoID INT, IN nuevoSalario DECIMAL(10,2))
BEGIN
    DECLARE salarioActual DECIMAL(10,2);
    
    SELECT salario INTO salarioActual FROM empleados WHERE id = empleadoID;
    
    IF nuevoSalario > salarioActual THEN
        UPDATE empleados SET salario = nuevoSalario WHERE id = empleadoID;
    END IF;
END //

DELIMITER ;

CALL actualizarSalarioEmpleado(5, 75000.00);
 
 
 -- ------------------------------------------------------
 
 
 DELIMITER //

CREATE PROCEDURE incrementarSalarios()
BEGIN
    DECLARE fin BOOLEAN DEFAULT FALSE;
    DECLARE empID INT;
    DECLARE cursorEmpleados CURSOR FOR SELECT id FROM empleados;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = TRUE;

    OPEN cursorEmpleados;
    
    leerEmpleados: LOOP
        FETCH cursorEmpleados INTO empID;
        IF fin THEN
            LEAVE leerEmpleados;
        END IF;
        
        UPDATE empleados SET salario = salario * 1.10 WHERE id = empID;
    END LOOP leerEmpleados;
    
    CLOSE cursorEmpleados;
END //

DELIMITER ;


CALL incrementarSalarios();

-- ----------------------------------------------------------



delimiter $$
CREATE PROCEDURE SumaHastaDiez()
BEGIN
    DECLARE total INT DEFAULT 0; -- Inicializamos el total en 0
    DECLARE numero INT DEFAULT 1; -- Empezamos con el número 1

    WHILE numero <= 10 DO
        SET total = total + numero; -- Sumamos el número actual al total
        SET numero = numero + 1; -- Incrementamos el número actual
    END WHILE;

    SELECT total AS Suma; -- Imprimimos el resultado
END
Delimiter $$


-- -----------------------------------------------------------------

CREATE PROCEDURE SumaHastaDiez()
BEGIN
    DECLARE total INT DEFAULT 0; -- Inicializamos el total en 0
    DECLARE numero INT DEFAULT 1; -- Empezamos con el número 1

    mi_loop: LOOP
        SET total = total + numero; -- Sumamos el número actual al total
        SET numero = numero + 1; -- Incrementamos el número actual

        IF numero > 10 THEN
            LEAVE mi_loop; -- Salimos del bucle cuando el número es mayor que 10
        END IF;
    END LOOP mi_loop;

    SELECT total AS Suma; -- Imprimimos el resultado
END;


-- ------------------------------------------------------------------------


CREATE PROCEDURE SumaHastaDiez()
BEGIN
    DECLARE total INT DEFAULT 0; -- Inicializamos el total en 0
    DECLARE numero INT DEFAULT 1; -- Empezamos con el número 1

    REPEAT
        SET total = total + numero; -- Sumamos el número actual al total
        SET numero = numero + 1; -- Incrementamos el número actual
    UNTIL numero > 10 END REPEAT;

    SELECT total AS Suma; -- Imprimimos el resultado
END;







