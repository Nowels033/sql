DELIMITER //

CREATE FUNCTION contarEmpleados() 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE totalEmpleados INT;
    
    SELECT COUNT(*) INTO totalEmpleados FROM empleados;
    
    RETURN totalEmpleados;
END //

DELIMITER ;

 SELECT contarEmpleados();
 
 -- ----------------------------------------------------
 
 DELIMITER //

CREATE FUNCTION obtenerSalarioEmpleado(empID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE salario DECIMAL(10,2);
    
    SELECT salario INTO salario FROM empleados WHERE id = empID;
    
    RETURN salario;
END //

DELIMITER ;

SELECT obtenerSalarioEmpleado(5);

-- ------------------------------------------------------------

DELIMITER //

CREATE FUNCTION calcularNuevoSalario(empID INT, incremento DECIMAL(5,2)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE salarioActual DECIMAL(10,2);
    DECLARE nuevoSalario DECIMAL(10,2);
    
    SELECT salario INTO salarioActual FROM empleados WHERE id = empID;
    
    SET nuevoSalario = salarioActual + (salarioActual * incremento / 100);
    
    RETURN nuevoSalario;
END //

DELIMITER ;


SELECT calcularNuevoSalario(5, 10);


-- -----------------------------------------------------------

DELIMITER //

CREATE FUNCTION obtenerMensajeEmpleado(empID INT) 
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE nombre VARCHAR(100);
    DECLARE salario DECIMAL(10,2);
    DECLARE mensaje VARCHAR(255);
    
    SET nombre = obtenerNombreEmpleado(empID);
    SET salario = obtenerSalarioEmpleado(empID);
    
    SET mensaje = CONCAT('El empleado ', nombre, ' tiene un salario de ', salario);
    
    RETURN mensaje;
END //

DELIMITER ;

SELECT obtenerMensajeEmpleado(5);


-- ---------------------------------------------------------------------


DELIMITER //

CREATE FUNCTION salarioPromedioDepartamento(departamentoID INT) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE salarioPromedio DECIMAL(10,2);
    
    SELECT AVG(salario) INTO salarioPromedio FROM empleados WHERE departamento_id = departamentoID;
    
    RETURN salarioPromedio;
END //

DELIMITER ;


SELECT salarioPromedioDepartamento(3);


-- ---------------------------------------------------------------------------


DELIMITER //

CREATE FUNCTION calcularFactorial(n INT) 
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE resultado BIGINT DEFAULT 1;
    DECLARE contador INT DEFAULT 1;
    
    WHILE contador <= n DO
        SET resultado = resultado * contador;
        SET contador = contador + 1;
    END WHILE;
    
    RETURN resultado;
END //

DELIMITER ;


SELECT calcularFactorial(5) AS Factorial;


-- ----------------------------------------------------------------


DELIMITER //

CREATE FUNCTION calcularFactorial(n INT) 
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE resultado BIGINT DEFAULT 1;
    DECLARE contador INT DEFAULT 1;
    
    factorial_loop: LOOP
        IF contador > n THEN
            LEAVE factorial_loop;
        END IF;
        
        SET resultado = resultado * contador;
        SET contador = contador + 1;
    END LOOP factorial_loop;
    
    RETURN resultado;
END //

DELIMITER ;



SELECT calcularFactorial(5) AS Factorial;


-- -------------------------------------------------------------------

DELIMITER //

CREATE FUNCTION calcularFactorial(n INT) 
RETURNS BIGINT
DETERMINISTIC
BEGIN
    DECLARE resultado BIGINT DEFAULT 1;
    DECLARE contador INT DEFAULT 1;
    
    factorial_repeat: REPEAT
        SET resultado = resultado * contador;
        SET contador = contador + 1;
    UNTIL contador > n
    END REPEAT factorial_repeat;
    
    RETURN resultado;
END //

DELIMITER ;


SELECT calcularFactorial(5) AS Factorial;
