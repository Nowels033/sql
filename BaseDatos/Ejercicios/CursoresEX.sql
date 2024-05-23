DELIMITER //

CREATE PROCEDURE recorrerEmpleados()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE empNombre VARCHAR(100);
    
    -- Declarar el cursor
    DECLARE cursorEmpleados CURSOR FOR 
    SELECT nombre FROM empleados;
    
    -- Handler para el fin de los resultados del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abrir el cursor
    OPEN cursorEmpleados;
    
    leerEmpleados: LOOP
        -- Obtener la siguiente fila
        FETCH cursorEmpleados INTO empNombre;
        
        -- Salir del bucle si no hay más filas
        IF done THEN
            LEAVE leerEmpleados;
        END IF;
        
        -- Aquí puedes realizar alguna operación con empNombre
        SELECT empNombre;
    END LOOP leerEmpleados;
    
    -- Cerrar el cursor
    CLOSE cursorEmpleados;
END //

DELIMITER ;



CALL recorrerEmpleados();


-- ------------------------------------------------------------------------------------------------------


DELIMITER //

CREATE PROCEDURE incrementarSalarios()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE empID INT;
    DECLARE empSalario DECIMAL(10,2);
    
    -- Declarar el cursor
    DECLARE cursorEmpleados CURSOR FOR 
    SELECT id, salario FROM empleados;
    
    -- Handler para el fin de los resultados del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abrir el cursor
    OPEN cursorEmpleados;
    
    leerEmpleados: LOOP
        -- Obtener la siguiente fila
        FETCH cursorEmpleados INTO empID, empSalario;
        
        -- Salir del bucle si no hay más filas
        IF done THEN
            LEAVE leerEmpleados;
        END IF;
        
        -- Actualizar el salario
        UPDATE empleados SET salario = empSalario * 1.10 WHERE id = empID;
    END LOOP leerEmpleados;
    
    -- Cerrar el cursor
    CLOSE cursorEmpleados;
END //

DELIMITER ;


CALL incrementarSalarios();
 
 
 -- ------------------------------------------------------------------------------
 
 
 DELIMITER //

CREATE PROCEDURE calcularSalarioTotalPorDepartamento()
BEGIN
    DECLARE done BOOLEAN DEFAULT FALSE;
    DECLARE depID INT;
    DECLARE salarioTotal DECIMAL(10,2);
    
    -- Declarar el cursor
    DECLARE cursorDepartamentos CURSOR FOR 
    SELECT id FROM departamentos;
    
    -- Handler para el fin de los resultados del cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- Abrir el cursor
    OPEN cursorDepartamentos;
    
    leerDepartamentos: LOOP
        -- Obtener la siguiente fila
        FETCH cursorDepartamentos INTO depID;
        
        -- Salir del bucle si no hay más filas
        IF done THEN
            LEAVE leerDepartamentos;
        END IF;
        
        -- Calcular el salario total para el departamento actual
        SELECT SUM(salario) INTO salarioTotal FROM empleados WHERE departamento_id = depID;
        
        -- Insertar el resultado en la tabla de resumen
        INSERT INTO resumen_salarios (departamento_id, salario_total) VALUES (depID, salarioTotal);
    END LOOP leerDepartamentos;
    
    -- Cerrar el cursor
    CLOSE cursorDepartamentos;
END //

DELIMITER ;


CALL calcularSalarioTotalPorDepartamento();


